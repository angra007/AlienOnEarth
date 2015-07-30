//
//  ExportDataSuperClass.m
//  AliensOnEarth
//
//  Created by Ankit Angra on 30/07/15.
//  Copyright (c) 2015 Ankit Angra. All rights reserved.
//

#import "ExportDataSuperClass.h"
#import "ExportManager.h"
#import "AliensOnEarthModel.h"
#import "AlienOnEarthUtilityClass.h"

@implementation ExportDataSuperClass

- (void)loadData:(AliensOnEarthModel*)alienObject
{
    self.pathToDocumentDirectory = [[AlienOnEarthUtilityClass sharedInstance] getPathOfDocumentDirectory];
    NSString* filePath = [self.pathToDocumentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"\%@.plist", alienObject.codeName]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSLog(@"Error... Please Try after some time");
    }
    else {
        self.dataDictionary = [[NSDictionary dictionaryWithContentsOfFile:filePath] mutableCopy];
        [self.dataDictionary setObject:alienObject.codeName forKey:@"codeName"];
    }
}

- (BOOL)fileCreatedAtPath:(NSString*)filePath
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
    if ([content writeToFile:filePath atomically:YES encoding:NSStringEncodingConversionAllowLossy error:nil]) {
        return YES;
    }
    return NO;
}

- (void)exportDataForObject:(AliensOnEarthModel*)aleanData
{
    // Implemented in Base Class
}

@end
