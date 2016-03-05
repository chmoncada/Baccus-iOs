//
//  EMOWebViewController.m
//  Baccus
//
//  Created by Charles Moncada on 29/02/16.
//  Copyright © 2016 Emoshiapps. All rights reserved.
//

#import "EMOWebViewController.h"
#import "EMOWineryTableViewController.h"

@implementation EMOWebViewController

-(id) initWIthModel: (EMOWineModel *) aModel {

    if(self = [super initWithNibName:nil
                              bundle:nil]) {
        _model=aModel;
        
        self.title = @"Web";
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self displayURL: self.model.wineCompanyWeb];
    
    // Alta en notificacion
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(wineDidChange:)
                   name:NEW_WINE_NOTIFICACION_NAME
                 object:nil];
    
    
}

-(void) wineDidChange: (NSNotification *) notificacion {
    NSDictionary *dict = [notificacion userInfo];
    EMOWineModel *newWine = [dict objectForKey:WINE_KEY];
    
    //Actualizar el modelo
    
    self.model = newWine;
    [self displayURL:self.model.wineCompanyWeb];
    
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UIWebViewDelegate
-(void) webViewDidFinishLoad:(UIWebView *)webView{
    [self.activityView stopAnimating];
    [self.activityView setHidden:YES];
}

#pragma mark - Utilities

-(void) displayURL: (NSURL *) aURL{
    
    self.browser.delegate = self;
    self.activityView.hidden = NO;
    [self.activityView startAnimating];
    
    [self.browser loadRequest:[NSURLRequest requestWithURL:aURL]];
}


@end
