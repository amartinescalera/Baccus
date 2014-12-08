//
//  AMEHWineryTableViewController.m
//  Baccus
//
//  Created by Antonio Martin on 25/09/13.
//  Copyright (c) 2013 Antonio Martin. All rights reserved.
//

#import "AMEHWineryTableViewController.h"
#import "AMEHWineViewController.h"

@interface AMEHWineryTableViewController ()

@end

@implementation AMEHWineryTableViewController

-(id) initWithModel: (AMEHWineryModel *) aModel
              style: (UITableViewStyle) aStyle {
    if (self = [super initWithStyle: aStyle]) {
        _model = aModel;
        self.title = @"VINOTECA DE ANTONIO MARTIN";
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.5
                                                                        green:0
                                                                         blue:0.13
                                                                        alpha:0];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - utils
- (AMEHWineModel *) wineForIndexPath: (NSIndexPath *) indexPath {
    AMEHWineModel *wine = nil;
    
    if (indexPath.section == RED_WINE_SECTION) {
        wine = [self.model redWineAtIndex:indexPath.row];
    } else if (indexPath.section == WHITE_WINE_SECTION) {
        wine = [self.model whiteWineAtIndex:indexPath.row];
    } else {
        wine = [self.model otherWineAtIndex:indexPath.row];
    }
    
    return wine;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (section == RED_WINE_SECTION) {
        return self.model.redWineCount;
    } else if (section == WHITE_WINE_SECTION) {
        return self.model.whiteWineCount;
    } else {
        return self.model.otherWineCount;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    
    //Averiguar de que model (vino) no estan hablando
    AMEHWineModel *wine = [self wineForIndexPath:indexPath];
    
    if (cell == nil) {
        //No hay ninguna celda a mano y tenemos que crearla a Mano
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier: CellIdentifier];
    }
    
    //Debemos sincronizar celda (vista) y model
    cell.imageView.image = wine.photo;
    cell.textLabel.text = wine.name;
    cell.detailTextLabel.text = wine.wineCompanyName;
    
    //Return the cell
    return cell;
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == RED_WINE_SECTION) {
        return @"Red Wines";
    } else if (section == WHITE_WINE_SECTION) {
        return @"White Wines";
    } else {
        return @"Other Wines";
    }
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Suponemos que estamos dentro del navigation controller.
    
    //Averiguamos de que vino se trata
    AMEHWineModel *wine = [self wineForIndexPath:indexPath];
    
    if (IS_IPHONE) {
        AMEHWineViewController *wineVC = [[AMEHWineViewController alloc] initWithModel:wine];
        [self.navigationController pushViewController:wineVC animated:YES];
    } else {
        [self.delegate wineryTableViewController:self
                                 didSelectedWine:wine];
        
        //Notificaciones
        NSNotification *not = [NSNotification notificationWithName:NEW_WINE_NOTIFICATION_NAME
                                                            object: self
                                                          userInfo: @{WINE_KEY: wine}];
        
        [[NSNotificationCenter defaultCenter] postNotification:not];
        
        [self saveLastSelectedWineSection:indexPath.section row:indexPath.row];
    }
}

#pragma mark - AMEHWineryTableViewControllerDelegate
- (void) wineryTableViewController:(AHEHWineryTableViewController *)aWineryVC
                   didSelectedWine:(AMEHWineModel *)aWine {
    AMEHWineViewController *wineVC = [[AMEHWineViewController alloc] initWithModel: aWine];
    
    //Hacemos un push
    [self.navigationController pushViewController:wineVC
                                         animated:YES];
            
}
        
        
#pragma mark - Persistencia

- (NSDictionary * ) setDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //Por defecto, mostramos el primero de los tintos
    NSDictionary *defaultWineCoords = @{SECTION_KEY : @(RED_WINE_SECTION), ROW_KEY:@0};
    
    //Lo asignamos
    [defaults setObject:defaultWineCoords forKey:LAST_WINE_KEY];
    
    [defaults synchronize];
    
    return defaultWineCoords;
}

- (void) saveLastSelectedWineSection: (NSUInteger) section row:(NSUInteger) row
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //Comprobamos si hay o no hay algo escritoç
    [defaults setObject:@{SECTION_KEY : @(section),
                          ROW_KEY: @(row)} forKey: LAST_WINE_KEY];
    [defaults synchronize]; //Por si acaso que murphy puede aparecer en cualquier momento.
}

- (AMEHWineModel *) lastSelectedWine {
    NSIndexPath *indexPath = nil;
    NSDictionary *coords = nil;
    
    coords = [[NSUserDefaults standardUserDefaults] objectForKey:LAST_WINE_KEY];
    
    if (coords == nil) {
        //No hay nada guardado en el NSDefaults
        coords = [self setDefaults];
    } else {
        //Ya hay algo en algun momento se guardó
    }
    
    indexPath = [NSIndexPath indexPathForItem:[[coords objectForKey: ROW_KEY] integerValue]
                                    inSection:[[coords objectForKey: SECTION_KEY] integerValue]];
    
    return [self wineForIndexPath: indexPath];
}


@end
