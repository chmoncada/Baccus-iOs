//
//  EMOWineryTableViewController.h
//  Baccus
//
//  Created by Charles Moncada on 1/03/16.
//  Copyright © 2016 Emoshiapps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMOWineryModel.h"

#define RED_WINE_SECTION 0
#define WHITE_WINE_SECTION 1
#define ROSE_WINE_SECTION 2
#define CAVA_WINE_SECTION 3
#define NEW_WINE_NOTIFICACION_NAME @"newWine"
#define WINE_KEY @"wine"

@class EMOWineryTableViewController;

@protocol WineryTableViewControllerDelegate <NSObject>

-(void) wineryTableViewController: (EMOWineryTableViewController *)wineryVC didSelectWine: (EMOWineModel *) aWine;

@end


@interface EMOWineryTableViewController : UITableViewController <WineryTableViewControllerDelegate>

@property (nonatomic, strong) EMOWineryModel *model;
@property (nonatomic,weak) id<WineryTableViewControllerDelegate> delegate;

-(id)  initWithModel: (EMOWineryModel *) aModel
               style:(UITableViewStyle) aStyle;

-(EMOWineModel *)lastSelectedWine;

@end

