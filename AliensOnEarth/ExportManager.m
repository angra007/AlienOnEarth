//
//  ExportManager.m
//  AliensOnEarth
//
//  Created by Ankit Angra on 30/07/15.
//  Copyright (c) 2015 Ankit Angra. All rights reserved.
//

#import "ExportManager.h"
#import "ExportDataSuperClass.h"
#import <Cocoa/Cocoa.h>
#import <objc/objc-runtime.h>

@interface ExportManager ()

@end

@implementation ExportManager


- (void)startExportWithData:(AliensOnEarthModel *)alienData {
    
    NSArray *allExportType = [self GetSubclassesForClass:[ExportDataSuperClass class]];
    
    if ([allExportType count]) {
        int option;
        NSLog(@"How would You Like Your Data?");
        
        // Display All the format with proper Index
        for (NSInteger index = 0; index < allExportType.count; index++) {
            NSLog(@"%ld. %@",index+1,[[allExportType objectAtIndex:index] className]);
        }
        scanf("%d", &option);
        
        // Create the instance of that class
        Class exportType = NSClassFromString([[allExportType objectAtIndex:option-1] className]);
        ExportDataSuperClass *object = [[exportType alloc] init];
        
        // Perform Selector to perform the draw operation
        if ([object respondsToSelector:@selector(exportDataForObject:)]) {
            [object performSelector:@selector(exportDataForObject:) withObject:alienData];
        }
    }
    else {
        NSLog(@"You Donot Have any Export Type");
    }
}

// This is a very expensive operation . We might have to cache it if this method is called multiple times
- (NSArray *)GetSubclassesForClass:(Class) parentClass {
    // Get the entire list of classes
    int numClasses = objc_getClassList(NULL, 0);
    Class *classes = NULL;
    
    // Allocate memory
    NSMutableData* data = [NSMutableData dataWithLength:sizeof(Class) * numClasses];
    classes = (Class *)[data mutableBytes];
    
    // Put the entire class list in a variable classes
    numClasses = objc_getClassList(classes, numClasses);
    
    NSMutableArray *result = [NSMutableArray array];
    
    // for all the classes available
    for (NSInteger i = 0; i < numClasses; i++) {
        
        // Assign each class as a superclass
        Class superClass = classes[i];
        
        // while we have not got subclass for our provided superclass
        do
        {
            superClass = class_getSuperclass(superClass);
        } while(superClass && superClass != parentClass);
        
        
        if (superClass == nil) {
            continue;
        }
        // If we have for a subclass add it to result array
        [result addObject:classes[i]];
    }
    return result;
    
}


@end
