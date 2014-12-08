//
//  AMEHWineryModel.h
//  Baccus
//
//  Created by Antonio Martin on 25/09/13.
//  Copyright (c) 2013 Antonio Martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMEHWineModel.h"

@interface AMEHWineryModel : NSObject

#define RED_WINE_KEY    @"Tinto"
#define WHITE_WINE_KEY  @"Blanco"
#define OTHER_WINE_KEY  @"Rosado"

@property (readonly, readonly) NSUInteger redWineCount; //Solo lectura, lo usamos para crear nuestros setter particulares
@property (readonly, readonly) NSUInteger whiteWineCount; //Solo lectura
@property (readonly, readonly) NSUInteger otherWineCount; //Solo lectura


-(AMEHWineModel *) redWineAtIndex: (int) index;
-(AMEHWineModel *) whiteWineAtIndex: (int) index;
-(AMEHWineModel *) otherWineAtIndex: (int) index;

@end
