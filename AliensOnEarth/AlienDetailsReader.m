//
//  AlienDetailsFetcher.m
//  AliensOnEarth
//
//  Created by Ankit Angra on 01/08/15.
//  Copyright (c) 2015 Ankit Angra. All rights reserved.
//

#import "AlienDetailsReader.h"
#import "AlienRegistration.h"
#import "AlienOnEarthUtilityClass.h"
#import "AlienOnEarthModel.h"
#import "ExportManager.h"

@implementation AlienDetailsReader

- (void)viewRegisteredAlienWithCodeName:(NSString*)codeName
{
    NSString* pathToDocumentDirectory = [[AlienOnEarthUtilityClass sharedInstance] getPathOfDocumentDirectory];
    NSString* filePath = [pathToDocumentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"\%@.plist", codeName]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        
        // If the code name entered was not in the records
        NSLog(@"We Donot have your record");
        AlienRegistration* alieRegistration = [[AlienRegistration alloc] init];
        [alieRegistration startRegistration];
    }
    else {
        
        // Get the saved data
        NSMutableDictionary* dataDictionary = [[NSDictionary dictionaryWithContentsOfFile:filePath] mutableCopy];
        [dataDictionary setObject:codeName forKey:@"codeName"];
        NSLog(@"%@", dataDictionary);
        
        // Set the model object
        AlienOnEarthModel* alienDetails = [[AlienOnEarthModel alloc] initWithDictinory:dataDictionary];
        
        ExportManager* exportManager = [[ExportManager alloc] init];
        [exportManager startExportWithData:alienDetails];
    }
}

@end
