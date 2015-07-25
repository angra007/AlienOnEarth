//
//  AliensOnEarthObject.h
//  AliensOnEarth
//
//  Created by Ankit Angra on 20/07/15.
//  Copyright (c) 2015 Ankit Angra. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AliensOnEarthModelObject : NSObject

@property (nonatomic, strong) NSString* codeName;
@property (nonatomic, strong) NSString* bloodColor;
@property (nonatomic, strong) NSString* numberOfAntennas;
@property (nonatomic, strong) NSString* numberOfLegs;
@property (nonatomic, strong) NSString* homePlanet;

- (instancetype)initWithDictinory:(NSDictionary*)dictinory;
@end
