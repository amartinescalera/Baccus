//
//  AMEHWineViewController.m
//  Baccus
//
//  Created by Antonio Martin on 19/09/13.
//  Copyright (c) 2013 Antonio Martin. All rights reserved.
//

#import "AMEHWineViewController.h"
#import "AMEHWebViewController.h"

@implementation AMEHWineViewController

- (id) initWithModel: (AMEHWineModel *) aModel {
    if (self = [super initWithNibName: nil
                               bundle: nil]) { //Indicate the default view
        _model = aModel;
        
        self.title = self.model.name;
    }
    
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

//To be sincronized model and wiew
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [self syncWithModel];
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.5
                                                                        green:0
                                                                         blue:0.13
                                                                        alpha:0];
    
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewDidDisappear: animated];
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Actions
- (IBAction) displayWeb:(id)sender {
    
    //creamos un webView Controller
    AMEHWebViewController *webVC = [[AMEHWebViewController alloc] initWithModel:self.model];
    
    //Hacemos un push
    [self.navigationController pushViewController:webVC animated:YES];
    
}


#pragma mark - Utils

- (void) syncWithModel {
    self.nameLabel.text = self.model.name;
    self.typeLabel.text = self.model.type;
    self.originLabel.text = self.model.origin;
    self.notesLabel.text = self.model.notes;
    self.wineryNameLabel.text = self.model.wineCompanyName;
    self.photoView.image = self.model.photo;
    self.grapesLabel.text = [self arrayToString: self.model.grapes];
    
    [self displayRating: self.model.rating];
    [self.notesLabel setNumberOfLines:0];
}

- (void) displayRating: (int) aRating {
    
    [self clearRating];
    
    UIImage *glass = [UIImage imageNamed: @"splitView_score_glass"];
    
    for (int i=0; i< aRating; i++) {
        [[self.ratingViews objectAtIndex:i] setImage:glass];
    }
}

- (void) clearRating {
    
    for (UIImageView *imgView in self.ratingViews) {
        imgView.image = nil;
    }
}


- (NSString *) arrayToString: (NSArray *) anArray {
    
    NSString * repr = nil;
    
    if ([anArray count] == 1) {
        repr = [@"100% " stringByAppendingString:[anArray lastObject]];
    } else {
        repr = [[anArray componentsJoinedByString:@", "] stringByAppendingString:@"."];
    }
    
    return repr;
    
}


#pragma mark - UISplitViewControllerDelegate

- (void) splitViewController:(UISplitViewController *)svc
      willHideViewController:(UIViewController *)aViewController
           withBarButtonItem:(UIBarButtonItem *)barButtonItem
        forPopoverController:(UIPopoverController *)pc {
    
    self.navigationItem.rightBarButtonItem = barButtonItem;
    
}

- (void) splitViewController:(UISplitViewController *)svc
      willShowViewController:(UIViewController *)aViewController
   invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
    
    self.navigationItem.rightBarButtonItem = nil;
}

-(void) wineryTableViewController: (AHEHWineryTableViewController *) aWineryVC
                  didSelectedWine: (AMEHWineModel *) aWine {
    self.model = aWine;
    self.title = aWine.name;
    [self syncWithModel];
}

@end








