//
//  EMOWineryModel.h
//  Baccus
//
//  Created by Charles Moncada on 1/03/16.
//  Copyright © 2016 Emoshiapps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMOWineModel.h"


#define RED_WINE_KEY @"Tinto"
#define WHITE_WINE_KEY @"Blanco"
#define ROSE_WINE_KEY @"Rosado"
#define CAVA_WINE_KEY @"Cava"


@interface EMOWineryModel : NSObject <NSURLSessionDownloadDelegate>

@property (readonly, nonatomic) NSUInteger redWineCount;
@property (readonly, nonatomic) NSUInteger whiteWineCount;
@property (readonly, nonatomic) NSUInteger roseWineCount;
@property (readonly, nonatomic) NSUInteger cavaWineCount;

-(EMOWineModel *) redWineAtIndex: (NSUInteger) index;

-(EMOWineModel *) whiteWineAtIndex: (NSUInteger) index;

-(EMOWineModel *) roseWineAtIndex: (NSUInteger) index;

-(EMOWineModel *) cavaWineAtIndex: (NSUInteger) index;

@end
