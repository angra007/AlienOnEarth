//
//  PDF.h
//  AliensOnEarth
//
//  Created by Ankit Angra on 30/07/15.
//  Copyright (c) 2015 Ankit Angra. All rights reserved.
//

#import "Exporter.h"

@interface PDF : Exporter

- (void)fileFormatterWithData:(AlienOnEarthModel*)aleanData;

@end
