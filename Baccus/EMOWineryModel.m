//
//  EMOWineryModel.m
//  Baccus
//
//  Created by Charles Moncada on 1/03/16.
//  Copyright © 2016 Emoshiapps. All rights reserved.
//

#import "EMOWineryModel.h"

@interface EMOWineryModel ()

@property (strong,nonatomic) NSMutableArray *redWines;
@property (strong, nonatomic) NSMutableArray *whiteWines;
@property (strong,nonatomic) NSMutableArray *roseWines;
@property (strong,nonatomic) NSMutableArray *cavaWines;
@end


@implementation EMOWineryModel

#pragma mark - Properties

-(NSUInteger) redWineCount {
    return [self.redWines count];
    
}

-(NSUInteger) whiteWineCount {
    return [self.whiteWines count];
    
}

-(NSUInteger) roseWineCount {
    return [self.roseWines count];
    
}

-(NSUInteger) cavaWineCount {
    return [self.cavaWines count];
    
}


#pragma mark - Init

-(id) init {
    if(self = [super init]){
    
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://static.keepcoding.io/baccus/wines.json"]];
        NSURLResponse *response = [[NSURLResponse alloc]init];
        NSError *error;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        /*NSURLSession *session = [NSURLSession sharedSession];
        [[session dataTaskWithRequest:request
                    completionHandler:^(NSData *_Nullable data, NSURLResponse *_Nullable response, NSError *_Nullable error) {*/
                        if (data != nil){
                            // No hubo error
                            
                            NSArray *JSONObjects = [NSJSONSerialization JSONObjectWithData:data
                                                                                   options:kNilOptions
                                                                                     error:&error];
                            if (JSONObjects != nil) {
                                // No ha habido error
                                for(NSDictionary *dict in JSONObjects){
                                    EMOWineModel *wine = [[EMOWineModel alloc]initWithDictionary:dict];
                                    
                                    // Anadimos al tipo adecuado
                                    if([wine.type isEqualToString:RED_WINE_KEY]){
                                        if(!self.redWines){
                                            self.redWines = [NSMutableArray arrayWithObject:wine];
                                        } else {
                                            [self.redWines addObject:wine];
                                        }
                                    } else if([wine.type isEqualToString:WHITE_WINE_KEY]){
                                        if(!self.whiteWines){
                                            self.whiteWines = [NSMutableArray arrayWithObject:wine];
                                        } else {
                                            [self.whiteWines addObject:wine];
                                        }
                                    } else if([wine.type isEqualToString:ROSE_WINE_KEY] ){
                                        if(!self.roseWines){
                                            self.roseWines = [NSMutableArray arrayWithObject:wine];
                                        } else {
                                            [self.roseWines addObject:wine];
                                        }
                                    } else if([wine.type isEqualToString:CAVA_WINE_KEY]){
                                        if(!self.cavaWines){
                                            self.cavaWines = [NSMutableArray arrayWithObject:wine];
                                        } else {
                                            [self.cavaWines addObject:wine];
                                        }
                                    }
                                    
                                }
                            } else{
                                // Se ha producido un error al parsear el JSON
                                NSLog(@"Error al parsear JSON %@", error.localizedDescription);
                            }
                        } else {
                            // Error al descargar los datos del servidor
                            NSLog(@"Error al descargar datos del servidor: %@",error.localizedDescription);
                        }
                   // }] resume];
        //Revisar porque esta deprecado
        
        
        
    }
    return self;
}

#pragma mark - Other

-(EMOWineModel *) redWineAtIndex: (NSUInteger) index {
    return [self.redWines objectAtIndex:index];
}

-(EMOWineModel *) whiteWineAtIndex: (NSUInteger) index {
    return [self.whiteWines objectAtIndex:index];
}

-(EMOWineModel *) roseWineAtIndex: (NSUInteger) index {
    return [self.roseWines objectAtIndex:index];
}

-(EMOWineModel *) cavaWineAtIndex: (NSUInteger) index {
    return [self.cavaWines objectAtIndex:index];
}

@end
