//
//  AMEHWineryModel.m
//  Baccus
//
//  Created by Antonio Martin on 25/09/13.
//  Copyright (c) 2013 Antonio Martin. All rights reserved.
//

#import "AMEHWineryModel.h"


@interface AMEHWineryModel ()

@property (strong, nonatomic) NSMutableArray *redWines;
@property (strong, nonatomic) NSMutableArray *whiteWines;
@property (strong, nonatomic) NSMutableArray *otherWines;

@end

@implementation AMEHWineryModel

#pragma mark - properties

-(NSUInteger) redWineCount {
    return [self.redWines count];
}

-(NSUInteger) whiteWineCount {
    return [self.whiteWines count];
}


-(NSUInteger) otherWineCount {
    return [self.otherWines count];
}
//Vamos a sobreescribir el metodo init de NSObject;
-(id) init {
    if (self = [super init]) {
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://baccusapp.herokuapp.com/wines"]];
        NSURLResponse *response = [[NSURLResponse alloc] init];
        NSError *error;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        if (data != nil) {
            // No ha habido error
            NSArray * JSONObjects = [NSJSONSerialization JSONObjectWithData:data
                                                                    options:kNilOptions
                                                                      error:&error];
            
            if (JSONObjects != nil) {
                // No ha habido error
                for(NSDictionary *dict in JSONObjects){
                    AMEHWineModel *wine = [[AMEHWineModel alloc] initWithDictionary:dict];
                    
                    // Añadimos al tipo adecuado
                    if ([wine.type isEqualToString:RED_WINE_KEY]) {
                        if (!self.redWines) {
                            self.redWines = [NSMutableArray arrayWithObject:wine];
                        }
                        else {
                            [self.redWines addObject:wine];
                        }
                    }
                    else if ([wine.type isEqualToString:WHITE_WINE_KEY]) {
                        if (!self.whiteWines) {
                            self.whiteWines = [NSMutableArray arrayWithObject:wine];
                        }
                        else {
                            [self.whiteWines addObject:wine];
                        }                    }
                    else {
                        if (!self.otherWines) {
                            self.otherWines = [NSMutableArray arrayWithObject:wine]; //fix/11a
                        }
                        else {
                            [self.otherWines addObject:wine]; //fix/11a
                        }
                    }
                }
            }else{
                // Se ha producido un error al parsear el JSON
                NSLog(@"Error al parsear JSON: %@", error.localizedDescription);
            }
        }else{
            // Error al descargar los datos del servidor
            NSLog(@"Error al descargar datos del servidor: %@", error.localizedDescription);
        }
    }
    return self;
}

- (AMEHWineModel *) redWineAtIndex: (int) index {
    return [self.redWines objectAtIndex:index];
}
- (AMEHWineModel *) whiteWineAtIndex: (int) index {
    return [self.whiteWines objectAtIndex:index];
}
- (AMEHWineModel *) otherWineAtIndex: (int) index {
    return [self.otherWines objectAtIndex:index];
}

@end
