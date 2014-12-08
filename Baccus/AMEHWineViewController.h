//
//  AMEHWineViewController.h
//  Baccus
//
//  Created by Antonio Martin on 19/09/13.
//  Copyright (c) 2013 Antonio Martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMEHWineModel.h"
#import "AMEHWineryTableViewController.h"

@interface AMEHWineViewController : UIViewController <UISplitViewControllerDelegate, AMEHWineryTableViewControllerDelegate>

@property (strong, nonatomic) AMEHWineModel *model;

//IBoutlet reference to a object in the view
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *wineryNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *originLabel;
@property (weak, nonatomic) IBOutlet UILabel *grapesLabel;
@property (weak, nonatomic) IBOutlet UILabel *notesLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *ratingViews;

- (id) initWithModel: (AMEHWineModel *) aModel;

- (IBAction) displayWeb:(id)sender;

@end
