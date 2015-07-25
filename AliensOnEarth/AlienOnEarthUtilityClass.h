//
//  AlienOnEarthUtilityClass.h
//  AliensOnEarth
//
//  Created by Ankit Angra on 21/07/15.
//  Copyright (c) 2015 Ankit Angra. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlienOnEarthUtilityClass : NSObject

+ (AlienOnEarthUtilityClass*)sharedInstance;
- (NSString*)getPathOfDocumentDirectory;

@end
