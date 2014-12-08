//
//  AMEHWineModel.h
//  Baccus
//
//  Created by Antonio Martin on 18/09/13.
//  Copyright (c) 2013 Antonio Martin. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NO_RATING -1

@interface AMEHWineModel : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *wineCompanyName;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *origin;
@property (strong, nonatomic) NSArray *grapes;
@property (strong, nonatomic) NSURL *wineCompanyWeb;
@property (strong, nonatomic, readonly) UIImage *photo;
@property (strong, nonatomic) NSURL *photoURL;
@property (strong, nonatomic) NSString *notes;
@property (nonatomic) int rating; //In this case, is going from 0 to 5

// Class method
+ (id) wineWithName: (NSString *) aName
    wineCompanyName: (NSString *) aWineCompanyName
               type: (NSString *) aType
             origin: (NSString *) anOrigin
             grapes: (NSArray *) arrayOfGrapes
     wineCompanyWeb: (NSURL *) aURL
              notes: (NSString *) aNotes
             rating: (int) aRating
              photoURL: (NSURL *) aPhotoURL;

+ (id) wineWithName: (NSString *) aName
    wineCompanyName: (NSString *) aWineCompanyName
               type: (NSString *) aType
             origin: (NSString *) anOrigin;

//init designado
- (id) initWithName: (NSString *) aName
    wineCompanyName: (NSString *) aWineCompanyName
               type: (NSString *) aType
             origin: (NSString *) anOrigin
             grapes: (NSArray *) arrayOfGrapes
     wineCompanyWeb: (NSURL *) aURL
              notes: (NSString *) aNotes
             rating: (int) aRating
              photoURL: (NSURL *) aPhotoURL;


- (id) initWithName: (NSString *) aName
    wineCompanyName: (NSString *) aWineCompanyName
               type: (NSString *) aType
             origin: (NSString *) anOrigin;

//Nuevo inicializador para inicalizar con URL
- (id) initWithDictionary: (NSDictionary *) aDict;

@end
