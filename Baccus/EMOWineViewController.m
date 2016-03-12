//
//  EMOWineViewController.m
//  Baccus
//
//  Created by Charles Moncada on 28/02/16.
//  Copyright © 2016 Emoshiapps. All rights reserved.
//

#import "EMOWineViewController.h"
#import "EMOWebViewController.h"

#define kCustomFontHeader           [UIFont fontWithName:@"Valentina" size:17]
#define kCustomFontSubheader        [UIFont fontWithName:@"Valentina" size:15]
#define kCustomFontRegular          [UIFont fontWithName:@"Valentina" size:12]

@implementation EMOWineViewController

-(id) initWithModel: (EMOWineModel *) aModel{

    if(self = [super initWithNibName:nil
                              bundle:nil]){
        _model = aModel;
        
        self.title = aModel.name;
    }
    return self;
}



// Sincronizamos modelo y vista

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    
    self.edgesForExtendedLayout = UIRectEdgeNone;  // para que la vista no se extienda del todo
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.5
                                                                        green:0
                                                                         blue:0.13
                                                                        alpha:0];
    
    if (self.splitViewController.displayMode == UISplitViewControllerDisplayModePrimaryHidden){
        
        self.navigationItem.rightBarButtonItem = self.splitViewController.displayModeButtonItem;
        
    }
    
    [self syncModelWithView];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.nameLabel.font = kCustomFontHeader;
    self.wineryNameLabel.font = kCustomFontSubheader;
    self.typeLabel.font = kCustomFontSubheader;
    self.originLabel.font = kCustomFontSubheader;
    self.grapesLabel.font = kCustomFontSubheader;
    self.notesLabel.font = kCustomFontRegular;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

-(IBAction)displayWeb:(id)sender{
    
    //Crear un webVC
    
    EMOWebViewController *webVC = [[EMOWebViewController alloc] initWithModel:self.model];
    
    // Hacemos un push
    [self.navigationController pushViewController:webVC
                                         animated:YES];
}

#pragma mark - Utils
-(void) syncModelWithView{
    
    self.nameLabel.text = self.model.name;
    self.typeLabel.text = self.model.type;
    self.originLabel.text = self.model.origin;
    self.notesLabel.text = self.model.notes;
    self.wineryNameLabel.text = self.model.wineCompanyName;
    self.photoView.image = self.model.photo;
    self.grapesLabel.text = [self arrayToString: self.model.grapes];
    
    [self displayRating:self.model.rating];
    
    /*
    CODIGO PARA ACTIVAR EL BOTON DE WEB, HAY QUE DEFINIR EL WEBBUTTON y Enlazarlo para que funcione
    NSLog(@"web: %@", self.model.wineCompanyWeb);
    if (self.model.wineCompanyWeb == nil) {
        self.webButton.enabled = NO;
    }else{
        self.webButton.enabled = YES;
    }
    */
    
    self.title = self.model.name;
    
    // ajustamos los labels según su tamaño o reducimos la fuente en su caso ya que en el iPhone puede ocurrir que no quepa todo el texto
    self.nameLabel.adjustsFontSizeToFitWidth = YES;
    self.wineryNameLabel.adjustsFontSizeToFitWidth = YES;
    self.typeLabel.adjustsFontSizeToFitWidth = YES;
    self.originLabel.adjustsFontSizeToFitWidth = YES;
    [self.grapesLabel sizeToFit];
    
}

-(void) clearRatings{
    for(UIImageView *imgView in self.ratingViews){
        imgView.image = nil;
    }
}


-(void) displayRating: (int) aRating {
    [self clearRatings];
    UIImage *glass = [UIImage imageNamed:@"splitView_score_glass"];
    
    for(int i=0; i < aRating; i++){
        [[self.ratingViews objectAtIndex:i] setImage:glass];
        
    }
}

-(NSString *) arrayToString: (NSArray *) anArray {
    
    NSString *repr = nil;
    
    if([anArray count] == 1){
        repr = [@"100% " stringByAppendingString:[anArray lastObject]];
    } else {
        repr = [[anArray componentsJoinedByString:@", "] stringByAppendingString:@"."];
    }
    return repr;
}

#pragma mark - UISplitViewControllerDelegate

/*
-(void)splitViewController:(UISplitViewController *)svc
    willHideViewController:(UIViewController *)aViewController
         withBarButtonItem:(UIBarButtonItem *)barButtonItem
      forPopoverController:(UIPopoverController *)pc{
    
    self.navigationItem.rightBarButtonItem = barButtonItem;
    
}

-(void)splitViewController:(UISplitViewController *)svc
    willShowViewController:(UIViewController *)aViewController
 invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem{
    
    self.navigationItem.rightBarButtonItem = nil;

    
}
*/


-(void)splitViewController:(UISplitViewController *)svc willChangeToDisplayMode:(UISplitViewControllerDisplayMode)displayMode{
    if(displayMode == UISplitViewControllerDisplayModePrimaryHidden){
        self.navigationItem.rightBarButtonItem = svc.displayModeButtonItem;
    }
    else { if(displayMode == UISplitViewControllerDisplayModeAllVisible){
        self.navigationItem.rightBarButtonItem = nil;
    }
        
    }
    
}


#pragma mark - WineryTableViewControllerDelegate

-(void) wineryTableViewController: (EMOWineryTableViewController *)wineryVC
                    didSelectWine: (EMOWineModel *) aWine{
    
    self.model = aWine;
    self.title = aWine.name;
    [self syncModelWithView];
    
    
}




@end
