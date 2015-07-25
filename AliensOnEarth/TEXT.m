//
//  ExportAsTEXT.m
//  AliensOnEarth
//
//  Created by Ankit Angra on 21/07/15.
//  Copyright (c) 2015 Ankit Angra. All rights reserved.
//

#import "TEXT.h"
#import "AliensOnEarthModelObject.h"
#import "AlienOnEarthUtilityClass.h"


@interface TEXT ()


@property (nonatomic, strong) NSMutableDictionary *dataDictionary;
@property (nonatomic, strong) NSString *filePath;
@end

@implementation TEXT

- (void)getDataToExportForAlien:(AliensOnEarthModelObject *)alienObject
{
    NSString *pathToDataDictinory = [[AlienOnEarthUtilityClass sharedInstance] getPathOfDocumentDirectory];
    self.filePath = [pathToDataDictinory stringByAppendingPathComponent:[NSString stringWithFormat:@"\%@", alienObject.codeName]];
    self.dataDictionary = [[NSDictionary dictionaryWithContentsOfFile:[self.filePath stringByAppendingString:@".plist"]] mutableCopy];
    [self.dataDictionary setObject:alienObject.codeName forKey:@"codeName"];
}

- (void)createFileToExportData
{
    NSString* content = [NSString stringWithFormat:@"%@", self.dataDictionary];
    if ([content writeToFile:[self.filePath stringByAppendingString:@".txt"] atomically:YES encoding:NSStringEncodingConversionAllowLossy error:nil]) {
         NSLog(@"Your file is exported in your documents directory");
    }
}


@end
