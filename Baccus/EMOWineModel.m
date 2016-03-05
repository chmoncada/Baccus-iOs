//
//  EMOWineModel.m
//  Baccus
//
//  Created by Charles Moncada on 28/02/16.
//  Copyright © 2016 Emoshiapps. All rights reserved.
//

#import "EMOWineModel.h"



@implementation EMOWineModel



//se usa cuando se crea una propiedad de solo lectura y se implementa un getter personalizado, el compilador piensa
//que no se necesita una variable de instancia, se le tiene que obligar a que lo incluya
// mas info buscar en cocoaosx.com

@synthesize photo = _photo;

#pragma mark - Propiedades

-(UIImage *) photo{
    // Esto va a bloquear y se deberia dehacer en segundo plano
    // Sin embargo, aun no sabemos hacer eso, asi que de momento lo dejamos asi
    
    if (_photo == nil) {
        _photo = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.photoURL]];
    }
    return _photo;
}

#pragma mark - Class methods

+(id) wineWithName: (NSString *) aName
   wineCompanyName: (NSString *) aWineCompanyName
              type: (NSString *) aType
            origin: (NSString *) anOrigin
            grapes: (NSArray *) arrayOfGrapes
    wineCompanyWeb: (NSURL *) aURL
             notes: (NSString *) aNotes
            rating: (int) aRating
          photoURL: (NSURL *) aPhotoURL{
    
    return [[self alloc] initWithName:aName
                      wineCompanyName:aWineCompanyName
                                 type:aType
                               origin:anOrigin
                               grapes:arrayOfGrapes
                       wineCompanyWeb:aURL
                                notes:aNotes
                               rating:aRating
                             photoURL:aPhotoURL];
}

+(id) wineWithName: (NSString *) aName
   wineCompanyName: (NSString *) aWineCompanyName
              type: (NSString *) aType
            origin: (NSString *) anOrigin{
    return [[self alloc] initWithName:aName
                      wineCompanyName:aWineCompanyName
                                 type:aType
                               origin:anOrigin];
}

#pragma mark - JSON

-(id) initWithDictionary: (NSDictionary *)aDict{
    return [self initWithName:[aDict objectForKey:@"name"]
              wineCompanyName:[aDict objectForKey:@"wineCompanyName"]
                         type:[aDict objectForKey:@"type"]
                       origin:[aDict objectForKey:@"origin"]
                       grapes:[self extractGrapesFromJSONArray:[aDict objectForKey:@"grapes"]]
               wineCompanyWeb:[aDict objectForKey:@"wineCompanyWeb"]
                        notes:[aDict objectForKey:@"notes"]
                       rating:[[aDict objectForKey:@"rating"] intValue]
                     photoURL:[NSURL URLWithString:[aDict objectForKey:@"picture"]]];
}


// para ejercicio de hacer el jSON
-(NSDictionary *)proxyForJSON{
    return @{@"name"                : self.name,
             @"wineCompanyName"     : self.wineCompanyName,
             @"wineCompanyWeb"      : self.wineCompanyWeb,
             @"type"                : self.type,
             @"origin"              : self.origin,
             @"grapes"              : self.grapes,
             @"notes"               : self.notes,
             @"rating"              : @(self.rating),
             @"picture"             : [self.photoURL path]};
}

#pragma mark - Init

-(id) initWithName: (NSString *) aName
   wineCompanyName: (NSString *) aWineCompanyName
              type: (NSString *) aType
            origin: (NSString *) anOrigin
            grapes: (NSArray *) arrayOfGrapes
    wineCompanyWeb: (NSURL *) aURL
             notes: (NSString *) aNotes
            rating: (int) aRating
             photoURL: (NSURL *) aPhotoURL{
    
    if(self = [super init]){
        // Asignamos los parametros a las variables de instancia
        _name = aName;
        _wineCompanyName = aWineCompanyName;
        _type = aType;
        _origin = anOrigin;
        _grapes = arrayOfGrapes;
        _wineCompanyWeb = aURL;
        _notes = aNotes;
        _rating = aRating;
        _photoURL = aPhotoURL;
    
    }
    return self;
}

-(id) initWithName: (NSString *) aName
   wineCompanyName: (NSString *) aWineCompanyName
              type: (NSString *) aType
            origin: (NSString *) anOrigin{
    
    return [self initWithName: aName
              wineCompanyName: aWineCompanyName
                         type: aType
                       origin: anOrigin
                       grapes: nil
               wineCompanyWeb: nil
                        notes: nil
                       rating: NO_RATING
                        photoURL: nil];
}

#pragma mark - Utils

-(NSArray*) extractGrapesFromJSONArray: (NSArray*) JSONArray {
    NSMutableArray *grapes = [NSMutableArray arrayWithCapacity:[JSONArray count]];
    for (NSDictionary *dict in JSONArray) {
        [grapes addObject:[dict objectForKey:@"grape"]];
    }
    return grapes;
}



@end
