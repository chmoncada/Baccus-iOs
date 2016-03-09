//
//  EMOWebViewController.m
//  Baccus
//
//  Created by Charles Moncada on 29/02/16.
//  Copyright © 2016 Emoshiapps. All rights reserved.
//

#import "EMOWebViewController.h"
#import "EMOWineryTableViewController.h"

@interface EMOWebViewController ()

@end

@implementation EMOWebViewController

#pragma mark - Init

-(id) initWithModel: (EMOWineModel *) aModel {

    if(self = [super initWithNibName:nil
                              bundle:nil]) {
        _model=aModel;
        
        self.title = aModel.wineCompanyName;
    }
    return self;
}

#pragma mark - View Lifecycle

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (IS_PHONE) {
        self.browser.scalesPageToFit = YES;
    }
    
    
    // Alta en notificacion
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(wineDidChange:)
                   name:NEW_WINE_NOTIFICACION_NAME
                 object:nil];
    
    [self displayURL]; // sincroniza la vista
    
}


-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Notificaciones

-(void) wineDidChange: (NSNotification *) notificacion {
    NSDictionary *dict = [notificacion userInfo];
    EMOWineModel *newWine = [dict objectForKey:WINE_KEY];
    
    //Actualizar el modelo
    
    self.model = newWine;
    [self displayURL];
    
}



#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.activityView setHidden:NO];
    [self.activityView startAnimating];
}

-(void) webViewDidFinishLoad:(UIWebView *)webView{
    [self.activityView stopAnimating];
    [self.activityView setHidden:YES];
}

#pragma mark - Utilities

-(void) displayURL{
    
    self.browser.delegate = self;
    //self.activityView.hidden = NO;
    // [self.activityView startAnimating];
    
    [self.browser loadRequest:[NSURLRequest requestWithURL:self.model.wineCompanyWeb]];
}


@end
