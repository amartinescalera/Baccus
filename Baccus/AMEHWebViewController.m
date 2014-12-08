//
//  AMEHWebViewController.m
//  Baccus
//
//  Created by Antonio Martin on 23/09/13.
//  Copyright (c) 2013 Antonio Martin. All rights reserved.
//

#import "AMEHWebViewController.h"
#import "AMEHWineryTableViewController.h"


@implementation AMEHWebViewController


-(id) initWithModel: (AMEHWineModel *) aModel {
    if (self = [super initWithNibName:nil
                               bundle:nil]) {
        _model = aModel;
        
        self.title = @"Web";
    }
    
    return self;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self displayURL: self.model.wineCompanyWeb];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(wineDidChange:)
                   name:NEW_WINE_NOTIFICATION_NAME
                 object:nil];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];
}

- (void) wineDidChange: (NSNotification *) notification {
    NSDictionary *dict = [notification userInfo];
    AMEHWineModel *newWine = [dict objectForKey:WINE_KEY];
    
    self.model = newWine;
    [self displayURL:self.model.wineCompanyWeb];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Utils
- (void) displayURL: (NSURL *) aURL {
    
    [self.browser setDelegate:self];
    [self.activityView setHidden:NO];
    [self.activityView startAnimating];
    
    [self.browser loadRequest:[NSURLRequest requestWithURL:aURL]];
}

#pragma mark - UIWebViewDelegate

- (void) webViewDidFinishLoad:(UIWebView *)webView {
    [self.activityView stopAnimating];
    [self.activityView setHidden:YES];
}



@end
