//
//  AppDelegate.m
//  Baccus
//
//  Created by Charles Moncada on 27/02/16.
//  Copyright © 2016 Emoshiapps. All rights reserved.
//

#import "AppDelegate.h"
#import "EMOWineModel.h"
#import "EMOWineViewController.h"
#import "EMOWebViewController.h"
#import "EMOWineryModel.h"
#import "EMOWineryTableViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [self customizeAppearance];
    
    // Creamos el modelo
    EMOWineryModel *winery = [[EMOWineryModel alloc]init];
    
    // Creamos los controladores
    UIViewController *rootVC = nil;
    if(!(IS_PHONE)){
        //Tablet
        rootVC = [self rootViewControllerForPadWithModel:winery];
    }
    else {
        rootVC = [self rootViewControllerForPhoneWithModel:winery];
    }
    
    // Lo asignamos como controlador raiz
    self.window.rootViewController = rootVC;
    
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - rootViewController para dispositivos

-(UIViewController *)rootViewControllerForPadWithModel:(EMOWineryModel *) winery {
  
    
    EMOWineryTableViewController *wineryVC = [[EMOWineryTableViewController alloc] initWithModel:winery style:UITableViewStylePlain];
    EMOWineViewController *wineVC = [[EMOWineViewController alloc] initWithModel:[wineryVC lastSelectedWine]];
    
    
    // Creamos los Navigation
    UINavigationController *wineryNav = [[UINavigationController alloc] initWithRootViewController:wineryVC];
    UINavigationController *wineNav = [[UINavigationController alloc]initWithRootViewController:wineVC];
    
    // Creamos el combinador: SplitView
    
    UISplitViewController *splitVC = [[UISplitViewController alloc] init];
    splitVC.viewControllers = @[wineryNav,wineNav];
    
    //Asignamos delegado
    
    splitVC.delegate = wineVC;
    wineryVC.delegate = wineVC;
    
    return splitVC;
}

-(UIViewController *)rootViewControllerForPhoneWithModel:(EMOWineryModel *) winery {
    
        
    EMOWineryTableViewController *wineryVC = [[EMOWineryTableViewController alloc] initWithModel:winery style:UITableViewStylePlain];
    
    // Creamos el combinador
    UINavigationController *wineryNav = [[UINavigationController alloc] initWithRootViewController:wineryVC];
    
    //Asignamos delegado
    
    wineryVC.delegate = wineryVC;
    
    return wineryNav;
}

#pragma mark - Customization

-(void) customizeAppearance{
    UIColor *oldBurgundy = [UIColor colorWithRed:0.624
                                        green:0.271
                                         blue:0.271
                                        alpha:1.0];
    
    
    
    //Fondo de la barra de navegacion
    if(IS_PHONE){
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navBarBackgroundPortrait"] forBarMetrics:UIBarMetricsDefault];
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navBarBackgroundLandscape"] forBarMetrics:UIBarMetricsCompact];
    }
    else {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navBarBackgroundPortraitiPad"] forBarMetrics:UIBarMetricsDefault];
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navBarBackgroundLandscapeiPad"] forBarMetrics:UIBarMetricsCompact];
    }
    
    //Apariencia de texto del Navigation Bar (Fuente y color)
    NSShadow *shadow = [[NSShadow alloc]init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(0.0f,1.0f);
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                           NSFontAttributeName: [UIFont fontWithName:@"Valentina" size:20],
                                                           NSShadowAttributeName:shadow }];
    
    //Aparienvia del texto del boton de retroceso
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                           NSShadowAttributeName: shadow,
                                                           NSFontAttributeName: [UIFont fontWithName:@"Valentina" size:12]} forState:UIControlStateNormal];
    
    //Color de los separadores de seccion de las tablas
    [[UITableViewHeaderFooterView appearance] setTintColor: oldBurgundy];
    [[UILabel appearanceWhenContainedInInstancesOfClasses:@[[UITableViewHeaderFooterView class]]] setTextColor:[UIColor whiteColor]];

    // Botón de hacia atrás personalizado
    UIImage *backBtn = [UIImage imageNamed:@"backBtn"];
    backBtn = [backBtn resizableImageWithCapInsets:UIEdgeInsetsMake(0, 13, 0, 5)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backBtn
                                                      forState:UIControlStateNormal
                                                    barMetrics:UIBarMetricsDefault];
    
}


@end
