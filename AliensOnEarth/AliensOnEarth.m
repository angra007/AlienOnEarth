//
//  AliensOnEarthRootClass.m
//  AliensOnEarth
//
//  Created by Ankit Angra on 20/07/15.
//  Copyright (c) 2015 Ankit Angra. All rights reserved.
//

#import "AliensOnEarth.h"
#import "AlienRegistration.h"
#import "AlienDetailsFetcher.h"

@implementation AliensOnEarth

/**
 This method initilize the registration process
 */
- (void)initilizeRegistration
{
    char codeName[100];
    NSLog(@"*************  WELCOME TO PLANET EARTH  *****************");
    char option[3];
    NSLog(@"Have you already registered?(YES/NO)");
    scanf("%s", option);
    
    if ([[NSString stringWithUTF8String:option] caseInsensitiveCompare:@"YES"] == NSOrderedSame) {
        NSLog(@"Enter your Code Name");
        scanf("%s", codeName);
        AlienDetailsFetcher* detailsFetcher = [[AlienDetailsFetcher alloc] init];
        [detailsFetcher viewRegisteredAlienWithCodeName:[NSString stringWithUTF8String:codeName]];
    }
    else {
        AlienRegistration* alieRegistration = [[AlienRegistration alloc] init];
        [alieRegistration startRegistration];
    }
}

@end
