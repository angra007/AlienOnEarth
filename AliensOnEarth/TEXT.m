//
//  TEXT.m
//  AliensOnEarth
//
//  Created by Ankit Angra on 30/07/15.
//  Copyright (c) 2015 Ankit Angra. All rights reserved.
//

#import "TEXT.h"
#import "AliensOnEarthObject.h"

@implementation TEXT

- (void)exportDataForObject:(AliensOnEarthObject*)aleanData
{
    [self loadData:aleanData];
    
    NSString* documentsDirectory = self.pathToDocumentDirectory;
    NSString* textFileName = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.txt", aleanData.codeName]];
    
    if ([self fileCreatedAtPath:textFileName]) {
        NSLog(@"Your data has been exported in your document directory.... Have a Nice Day");
    }
    else {
        NSLog(@"Some Error occured .... Please Try Later");
    }
}

@end

