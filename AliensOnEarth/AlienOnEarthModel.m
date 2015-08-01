//
//  AliensOnEarthObject.m
//  AliensOnEarth
//
//  Created by Ankit Angra on 20/07/15.
//  Copyright (c) 2015 Ankit Angra. All rights reserved.
//

#import "AlienOnEarthModel.h"

@implementation AlienOnEarthModel

- (instancetype)initWithDictinory:(NSDictionary*)dictinory
{
    if (self = [super init]) {
        self.codeName = [dictinory objectForKey:@"codeName"];
        self.bloodColor = [dictinory objectForKey:@"bloodColor"];
        self.numberOfAntennas = [dictinory objectForKey:@"numberOfAntennas"];
        self.numberOfLegs = [dictinory objectForKey:@"numberOfLegs"];
        self.homePlanet = [dictinory objectForKey:@"homePlanet"];
    }
    return self;
}

@end
