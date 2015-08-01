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

- (void)fileFormatterWithData:(AlienOnEarthModel*)aleanData
{
    [self dataFetcherForObject:aleanData];
    
    NSString* documentsDirectory = self.pathToDocumentDirectory;
    NSString* pdfFileName = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.pdf", aleanData.codeName]];
    
    if ([self fileCreaterAtPath:pdfFileName]) {
        NSLog(@"Your data has been exported.... Have a Nice Day");
    }
    else {
        NSLog(@"Some Error occured .... Please Try Later");
    }
}

@end
