//
//  AlienDetailsFetcher.m
//  AliensOnEarth
//
//  Created by Ankit Angra on 01/08/15.
//  Copyright (c) 2015 Ankit Angra. All rights reserved.
//

#import "AlienDetailsFetcher.h"
#import "AlienRegistration.h"
#import "AlienOnEarthUtilityClass.h"
#import "AlienOnEarthModel.h"
#import "ExportManager.h"

@implementation AlienDetailsFetcher

- (void)viewRegisteredAlienWithCodeName:(NSString*)codeName
{
    char option[3];
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
        
        // Export it
        
        NSLog(@"Do You Want to export ?");
        scanf("%s", option);
        if ([[NSString stringWithUTF8String:option] caseInsensitiveCompare:@"YES"] == NSOrderedSame) {
            ExportManager* exportManager = [[ExportManager alloc] init];
            [exportManager startExportWithData:alienDetails];
        }
        else {
            // Display a meaage and quit the application
            NSLog(@"Your Data is Safe with us... Visit Us when ever you want to export");
            NSLog(@"Have a nice day");
        }
    }
}

@end
