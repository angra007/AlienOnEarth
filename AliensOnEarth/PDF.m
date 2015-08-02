//
//  PDF.m
//  AliensOnEarth
//
//  Created by Ankit Angra on 30/07/15.
//  Copyright (c) 2015 Ankit Angra. All rights reserved.
//

#import "PDF.h"
#import "AlienOnEarthModel.h"

@implementation PDF

- (void)createFileWithData:(AlienOnEarthModel*)aleanData
{
    [self provideDataForObject:aleanData];
    
    NSString* documentsDirectory = self.pathToDocumentDirectory;
    NSString* pdfFilePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.pdf", aleanData.codeName]];
    
    DataWritterCompletionBlock completionHandler = ^(BOOL success) {
        if (success == YES) {
            NSLog(@"Your data has been exported in your document directory.... Have a Nice Day");
        }
        else {
            NSLog(@"Some Error occured .... Please Try Later");
        }
        
    };
    
    [self writeFileAtPath:pdfFilePath withCompletionHandler:completionHandler];
}

@end
