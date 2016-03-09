//
//  AppDelegate.h
//  Baccus
//
//  Created by Charles Moncada on 27/02/16.
//  Copyright © 2016 Emoshiapps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Availability.h>

#define IS_PHONE UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

