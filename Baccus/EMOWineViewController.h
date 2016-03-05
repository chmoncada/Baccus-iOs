//
//  EMOWineViewController.h
//  Baccus
//
//  Created by Charles Moncada on 28/02/16.
//  Copyright © 2016 Emoshiapps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMOWineModel.h"
#import "EMOWineryTableViewController.h"

@interface EMOWineViewController : UIViewController <UISplitViewControllerDelegate, WineryTableViewControllerDelegate>

@property (weak,nonatomic) IBOutlet UILabel *nameLabel;
@property (weak,nonatomic) IBOutlet UILabel *wineryNameLabel;
@property (weak,nonatomic) IBOutlet UILabel *typeLabel;
@property (weak,nonatomic) IBOutlet UILabel *originLabel;
@property (weak,nonatomic) IBOutlet UILabel *grapesLabel;
@property (weak,nonatomic) IBOutlet UILabel *notesLabel;
@property (weak,nonatomic) IBOutlet UIImageView *photoView;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *ratingViews;


@property (strong,nonatomic) EMOWineModel *model;

-(id) initWithModel: (EMOWineModel *) aModel;

-(IBAction)displayWeb:(id)sender;

@end
