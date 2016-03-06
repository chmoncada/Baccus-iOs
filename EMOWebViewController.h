//
//  EMOWebViewController.h
//  Baccus
//
//  Created by Charles Moncada on 29/02/16.
//  Copyright © 2016 Emoshiapps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMOWineModel.h"
@interface EMOWebViewController : UIViewController <UIWebViewDelegate>

@property (strong,nonatomic) EMOWineModel *model;
@property (weak, nonatomic) IBOutlet UIWebView *browser;
@property (weak,nonatomic) IBOutlet UIActivityIndicatorView *activityView;

-(id) initWithModel: (EMOWineModel *) aModel;


@end
