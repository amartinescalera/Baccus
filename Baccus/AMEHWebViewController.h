//
//  AMEHWebViewController.h
//  Baccus
//
//  Created by Antonio Martin on 23/09/13.
//  Copyright (c) 2013 Antonio Martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMEHWineModel.h"

@interface AMEHWebViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) AMEHWineModel *model;
@property (weak, nonatomic) IBOutlet UIWebView *browser;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;

-(id) initWithModel: (AMEHWineModel *) aModel;

@end
