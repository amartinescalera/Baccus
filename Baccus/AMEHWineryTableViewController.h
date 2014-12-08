//
//  AMEHWineryTableViewController.h
//  Baccus
//
//  Created by Antonio Martin on 25/09/13.
//  Copyright (c) 2013 Antonio Martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMEHWineryModel.h"

#define RED_WINE_SECTION 0
#define WHITE_WINE_SECTION 1
#define OTHER_WINE_SECTION 2

#define NEW_WINE_NOTIFICATION_NAME @"newWine"
#define WINE_KEY @"wine"

#define SECTION_KEY @"section"
#define ROW_KEY @"row"
#define LAST_WINE_KEY @"lastWine"


@class AHEHWineryTableViewController;

@protocol AMEHWineryTableViewControllerDelegate <NSObject>

-(void) wineryTableViewController: (AHEHWineryTableViewController *) aWineryVC
                  didSelectedWine: (AMEHWineModel *) aWine;

@end

@interface AMEHWineryTableViewController : UITableViewController <AMEHWineryTableViewControllerDelegate>

@property (nonatomic, strong) AMEHWineryModel *model;
@property (nonatomic, weak) id<AMEHWineryTableViewControllerDelegate> delegate;

-(id) initWithModel: (AMEHWineryModel *) aModel
              style: (UITableViewStyle) aStyle;

@end