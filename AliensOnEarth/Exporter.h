//
//  ExportDataSuperClass.h
//  AliensOnEarth
//
//  Created by Ankit Angra on 30/07/15.
//  Copyright (c) 2015 Ankit Angra. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AlienOnEarthModel;
@interface Exporter : NSObject

@property (nonatomic, strong) NSMutableDictionary* dataDictionary;
@property (nonatomic, strong) NSString* pathToDocumentDirectory;

- (void)dataFetcherForObject:(AlienOnEarthModel*)alienObject;
- (BOOL)fileCreaterAtPath:(NSString*)filePath;
- (void)fileFormatterWithData:(AlienOnEarthModel*)aleanData;

@end
