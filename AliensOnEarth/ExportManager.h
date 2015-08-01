//
//  ExportManager.h
//  AliensOnEarth
//
//  Created by Ankit Angra on 30/07/15.
//  Copyright (c) 2015 Ankit Angra. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AlienOnEarthModel.h"

@interface ExportManager : NSObject

- (void)startExportWithData:(AlienOnEarthModel*)alienDetails;

@end
