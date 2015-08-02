//
//  TEXT.m
//  AliensOnEarth
//
//  Created by Ankit Angra on 30/07/15.
//  Copyright (c) 2015 Ankit Angra. All rights reserved.
//

#import "TEXT.h"
#import "AlienOnEarthModel.h"

@implementation TEXT

- (void)createFileWithData:(AlienOnEarthModel*)aleanData
{
    [self provideDataForObject:aleanData];
    
    NSString* documentsDirectory = self.pathToDocumentDirectory;
    NSString* textFilePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.txt", aleanData.codeName]];
    
    DataWritterCompletionBlock completionHandler = ^(BOOL success) {
        if (success == YES) {
            NSLog(@"Your data has been exported in your document directory.... Have a Nice Day");
        }
        else {
            NSLog(@"Some Error occured .... Please Try Later");
        }
        
    };
    
    [self writeFileAtPath:textFilePath withCompletionHandler:completionHandler];
  
}

@end
