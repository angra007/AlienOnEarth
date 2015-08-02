//
//  ExportDataSuperClass.h
//  AliensOnEarth
//
//  Created by Ankit Angra on 30/07/15.
//  Copyright (c) 2015 Ankit Angra. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AlienOnEarthModel;

typedef void (^DataWritterCompletionBlock)(BOOL sucess);

@interface Exporter : NSObject

@property (nonatomic, strong) NSMutableDictionary* dataDictionary;
@property (nonatomic, strong) NSString* pathToDocumentDirectory;

- (void)provideDataForObject:(AlienOnEarthModel*)alienObject;
- (void)writeFileAtPath:(NSString*)filePath withCompletionHandler:(DataWritterCompletionBlock)completionBlock;
- (void)createFileWithData:(AlienOnEarthModel*)aleanData;

@end
