//
//  AlienOnEarthUtilityClass.m
//  AliensOnEarth
//
//  Created by Ankit Angra on 21/07/15.
//  Copyright (c) 2015 Ankit Angra. All rights reserved.
//

#import "AlienOnEarthUtilityClass.h"

static AlienOnEarthUtilityClass* sharedInstance = nil;
@implementation AlienOnEarthUtilityClass

+ (AlienOnEarthUtilityClass*)sharedInstance
{
    if (!sharedInstance) {
        sharedInstance = [[AlienOnEarthUtilityClass alloc] init];
    }
    return sharedInstance;
}

/**
 This method will return path of the Documents Directory
 */
- (NSString*)getPathOfDocumentDirectory
{
    NSError* error;
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectoryPath = [paths objectAtIndex:0];
    NSString* dataPath = [documentsDirectoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/Alien Registration"]];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:&error]; // Create folder
    }
    return dataPath;
}

@end
