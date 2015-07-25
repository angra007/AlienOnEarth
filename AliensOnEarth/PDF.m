//
//  ExportAsPDF.m
//  AliensOnEarth
//
//  Created by Ankit Angra on 21/07/15.
//  Copyright (c) 2015 Ankit Angra. All rights reserved.
//

#import "PDF.h"
#import "AliensOnEarthModelObject.h"
#import "AlienOnEarthUtilityClass.h"

@interface PDF ()
@property (nonatomic, strong) NSMutableDictionary *dataDictionary;
@property (nonatomic, strong) NSString *filePath;
@end

@implementation PDF

- (void)getDataToExportForAlien:(AliensOnEarthModelObject*)alienObject
{
    NSString *pathToDataDictinory = [[AlienOnEarthUtilityClass sharedInstance] getPathOfDocumentDirectory];
 
    self.filePath = [pathToDataDictinory stringByAppendingPathComponent:[NSString stringWithFormat:@"\%@", alienObject.codeName]];
    
    self.dataDictionary = [[NSDictionary dictionaryWithContentsOfFile:[self.filePath stringByAppendingString:@".plist"] ] mutableCopy];
    [self.dataDictionary setObject:alienObject.codeName forKey:@"codeName"];
}

- (void)createFileToExportData
{
   
    /***********************************************************************************************************************************************************/
    //                                                        NOTE : FOR PDF
    //     This piece of code will create the pdf but we will not be able to open that pdf.The correct way to do this is to draw string in a PDF drawing context.
    //     Please Follow: http://stackoverflow.com/questions/16987716/how-to-write-data-to-a-pdf-file-in-ios
    //
    //     As this is a console based application I have used Command Line Apllication. However, to draw a PDF UIKit framework would be required which
    //     is not available for Command Line Application (cannot be imported).
    /***********************************************************************************************************************************************************/
    
    NSString* content = [NSString stringWithFormat:@"%@", self.dataDictionary];
    if ( [content writeToFile:[self.filePath stringByAppendingString:@".pdf"] atomically:YES encoding:NSStringEncodingConversionAllowLossy error:nil]) {
        NSLog(@"Your file is exported in your documents directory");
    }
}


@end
