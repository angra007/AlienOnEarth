//
//  ExportManager.h
//  AliensOnEarth
//
//  Created by Ankit Angra on 30/07/15.
//  Copyright (c) 2015 Ankit Angra. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AliensOnEarthModel;

@interface ExportManager : NSObject

- (void)startExportWithData:(AliensOnEarthModel *)alienData;

@end
