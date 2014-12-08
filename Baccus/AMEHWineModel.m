//
//  AMEHWineModel.m
//  Baccus
//
//  Created by Antonio Martin on 18/09/13.
//  Copyright (c) 2013 Antonio Martin. All rights reserved.
//

#import "AMEHWineModel.h"

@implementation AMEHWineModel
@synthesize photo = _photo; //Se hacia esto antes de la 6.0 pero era un coñazo para ver más
//htt://www.cocoaosx.com/2012/12/04/auto-synthesize-property-reglas-excepciones

#pragma mark - propiedades 
- (UIImage *) photo {
    //Esto va a bloquear y se debería de hacer en segundo plano
    //Sim embargo aun no sabemos hacer eso,
    
    //Carga perezosa:
    if (_photo == nil) {
        _photo = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.photoURL]];
    }
    
    return _photo;
}

#pragma mark - Class Method

+ (id) wineWithName: (NSString *) aName
    wineCompanyName: (NSString *) aWineCompanyName
               type: (NSString *) aType
             origin: (NSString *) anOrigin
             grapes: (NSArray *) arrayOfGrapes
     wineCompanyWeb: (NSURL *) aURL
              notes: (NSString *) aNotes
             rating: (int) aRating
              photoURL: (NSURL *) aPhotoURL {
    return [[self alloc] initWithName: aName
                      wineCompanyName: aWineCompanyName
                                 type: aType
                               origin: anOrigin
                               grapes: arrayOfGrapes
                       wineCompanyWeb: aURL
                                notes: aNotes
                               rating: aRating
                                photoURL: aPhotoURL];
}

+ (id) wineWithName: (NSString *) aName
    wineCompanyName: (NSString *) aWineCompanyName
               type: (NSString *) aType
             origin: (NSString *) anOrigin {
    return [[self alloc] initWithName: aName
                      wineCompanyName: aWineCompanyName
                                 type: aType
                               origin: anOrigin];
}


#pragma mark - Init

//init designado
- (id) initWithName: (NSString *) aName
    wineCompanyName: (NSString *) aWineCompanyName
               type: (NSString *) aType
             origin: (NSString *) anOrigin
             grapes: (NSArray *) arrayOfGrapes
     wineCompanyWeb: (NSURL *) aURL
              notes: (NSString *) aNotes
             rating: (int) aRating
              photoURL: (NSURL *) aPhotoURL {
    
    if (self = [super init]) {
        _name = aName;
        _wineCompanyName = aWineCompanyName;
        _type = aType;
        _origin = anOrigin;
        _grapes = arrayOfGrapes;
        _wineCompanyWeb = aURL;
        _notes = aNotes;
        _rating = aRating;
        _photoURL = aPhotoURL;
    }
    
    return self;
}

- (id) initWithName: (NSString *) aName
   wineCompanyName:(NSString *)aWineCompanyName
              type:(NSString *)aType
            origin:(NSString *)anOrigin {
    
    return [self initWithName: aName
              wineCompanyName: aWineCompanyName
                         type: aType
                       origin: anOrigin
                       grapes: nil
               wineCompanyWeb: nil
                        notes: nil
                       rating: NO_RATING
                        photoURL: nil];
    
}

- (id) initWithDictionary: (NSDictionary *) aDict {
    
    return [self initWithName:[aDict objectForKey:@"name"]
              wineCompanyName:[aDict objectForKey:@"wineCompanyName"]
                         type:[aDict objectForKey:@"type"]
                       origin:[aDict objectForKey:@"origin"]
                       grapes:[self extractGrapesFromJSONArray:[aDict objectForKey:@"grapes"]]
               wineCompanyWeb:[aDict objectForKey:@"wineCompanyWeb"]
                        notes:[aDict objectForKey:@"notes"]
                       rating:[[aDict objectForKey:@"rating"] intValue]
                        photoURL:[NSURL URLWithString:[aDict objectForKey:@"picture"]]];
}

-(NSDictionary *)proxyForJSON{
    
    return @{@"name"            : self.name,
             @"wineCompanyName" : self.wineCompanyName,
             @"wine_web"        : [self.wineCompanyWeb path], //fix/11a
             @"type"            : self.type,
             @"origin"          : self.origin,
             @"grapes"          : self.grapes,
             @"notes"           : self.notes,
             @"rating"          : @(self.rating),
             @"picture"        : [self.photoURL path]};
}

#pragma mark - Utils
- (NSArray*)extractGrapesFromJSONArray: (NSArray*)JSONArray{
    NSMutableArray *grapes = [NSMutableArray arrayWithCapacity:[JSONArray count]];
    
    for (NSDictionary *dict in JSONArray) {
        [grapes addObject:[dict objectForKey:@"grape"]];
    }

    return grapes;
}
      
- (NSArray *)packGrapesIntoJSONArray{
                
    NSMutableArray *jsonArray = [NSMutableArray arrayWithCapacity:[self.grapes count]];
    
    for (NSString *grape in self.grapes) {
        [jsonArray addObject:@{@"grape": grape}];
    }
    
    return jsonArray;
}

@end
