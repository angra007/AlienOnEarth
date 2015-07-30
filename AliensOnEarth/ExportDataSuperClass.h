//
//  ExportDataSuperClass.h
//  AliensOnEarth
//
//  Created by Ankit Angra on 30/07/15.
//  Copyright (c) 2015 Ankit Angra. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AliensOnEarthModel;
@interface ExportDataSuperClass : NSObject


@property (nonatomic, strong) NSMutableDictionary* dataDictionary;
@property (nonatomic, strong) NSString* pathToDocumentDirectory;

- (void)loadData:(AliensOnEarthModel*)alienObject;
- (BOOL)fileCreatedAtPath:(NSString*)filePath;
- (void)exportDataForObject:(AliensOnEarthModel*)aleanData;


@end

