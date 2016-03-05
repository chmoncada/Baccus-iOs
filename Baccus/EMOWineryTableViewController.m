//
//  EMOWineryTableViewController.m
//  Baccus
//
//  Created by Charles Moncada on 1/03/16.
//  Copyright © 2016 Emoshiapps. All rights reserved.
//

#import "EMOWineryTableViewController.h"
#import "EMOWineViewController.h"

#define SECTION_KEY @"section"
#define ROW_KEY @"row"
#define LAST_WINE_KEY @"lastWine"

@interface EMOWineryTableViewController ()

@end

@implementation EMOWineryTableViewController

-(id)  initWithModel: (EMOWineryModel *) aModel
               style:(UITableViewStyle) aStyle{
    
    if(self =[super initWithStyle:aStyle]){
        _model = aModel;
        self.title = @"Baccus";
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDefaults];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.5
                                                                           green:0
                                                                            blue:0.13
                                                                           alpha:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section == RED_WINE_SECTION){
        return @"Red Wines";
    } else if (section == WHITE_WINE_SECTION){
        return @"White Wines";
    } else {
        return @"Other Wines";
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
// return the number of sections
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if(section == RED_WINE_SECTION){
        return self.model.redWineCount;
    } else if (section == WHITE_WINE_SECTION){
        return self.model.whiteWineCount;
    } else {
        return self.model.otherWineCount;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        //Tenemos que crearla a mano
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:CellIdentifier];
    }
    
    // Averiguar de que modelo (vino) nos estan hablando
    
    EMOWineModel *wine = [self wineForIndexPath:indexPath];
    
    
    // Sincronizar celda (vista) y modelo (vino)
    
    cell.imageView.image = wine.photo;
    cell.textLabel.text = wine.name;
    cell.detailTextLabel.text = wine.wineCompanyName;
    
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    // Averiguamos de que vino se trata
    EMOWineModel *wine = [self wineForIndexPath:indexPath];
    
    [self.delegate wineryTableViewController:self didSelectWine:wine];
    
    
    
    
    // Crear y enviamos notificacion
    
    NSNotification *n = [NSNotification notificationWithName: NEW_WINE_NOTIFICACION_NAME
                                                      object: self
                                                    userInfo:@{WINE_KEY:wine}];
    
    [[NSNotificationCenter defaultCenter] postNotification:n];
    
    // guardamos el ultimo vino seleccionado
    
    [self saveLastSelectedWineAtSection:indexPath.section
                                    row:indexPath.row];
    
}

#pragma mark - Utils

-(EMOWineModel *)wineForIndexPath:(NSIndexPath *) indexPath {
    EMOWineModel *wine = nil;
    
    if(indexPath.section == RED_WINE_SECTION){
        wine=[self.model redWineAtIndex:indexPath.row];
    } else if (indexPath.section == WHITE_WINE_SECTION){
        wine = [self.model whiteWineAtIndex:indexPath.row];
    } else {
        wine = [self.model otherWineAtIndex:indexPath.row];
    }
    
    return wine;
}


#pragma mark - NSUserDefaults

-(NSDictionary *)setDefaults
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // Por defecto mostramos el primer tinto
    NSDictionary *defaultWineCoords = @{SECTION_KEY : @(RED_WINE_SECTION), ROW_KEY : @0};
    
    //lo asignamos
    [defaults setObject:defaultWineCoords
                 forKey:LAST_WINE_KEY];
    
    [defaults synchronize];
    
    return defaultWineCoords;
}

-(void) saveLastSelectedWineAtSection:(NSUInteger) section
                                  row:(NSUInteger) row {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@{SECTION_KEY : @(section), ROW_KEY : @(row)}
                 forKey: LAST_WINE_KEY];
    // Por si acaso
    [defaults synchronize];
}

-(EMOWineModel *)lastSelectedWine{
    NSIndexPath *indexPath = nil;
    NSDictionary *coord = nil;
    
    coord = [[NSUserDefaults standardUserDefaults] objectForKey:LAST_WINE_KEY];
    
    if(coord ==nil){
        coord = [self setDefaults];
    }
    
    indexPath = [NSIndexPath indexPathForRow:[[coord objectForKey:ROW_KEY] integerValue]
                                   inSection:[[coord objectForKey:SECTION_KEY] integerValue]];
    
    // devolvemos el vino
    return [self wineForIndexPath:indexPath];
}

@end
