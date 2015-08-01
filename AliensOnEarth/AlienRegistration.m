//
//  AlienRegistration.m
//  AliensOnEarth
//
//  Created by Ankit Angra on 01/08/15.
//  Copyright (c) 2015 Ankit Angra. All rights reserved.
//

#import "AlienRegistration.h"
#import "AlienOnEarthUtilityClass.h"
#import "AlienOnEarthModel.h"
#import "ExportManager.h"

@interface AlienRegistration ()

@property (nonatomic, strong) NSMutableDictionary* alienDetails;
@property (nonatomic, strong) AlienOnEarthModel* aliensOnEarth;

@end

@implementation AlienRegistration

- (NSMutableDictionary*)alienDetails
{
    if (!_alienDetails) {
        _alienDetails = [[NSMutableDictionary alloc] init];
    }
    return _alienDetails;
}

#pragma mark - Registration Related Method
#pragma mark -

/**
 This method is responsible to register Alien while checking all the error conditions
 */
- (void)startRegistration
{
    char option[3];
    NSLog(@"Please Answer the following question");
    do {
        // Take the input
        [self takeInputFromTheUser];
        
        // Check if it is in proper format
        if ([self validateInputString]) {
            
            // Check if data with same code name is already saved or not
            if ([self isDataAlreadySaved]) {
                // If YES break the program
                break;
            }
            else {
                
                // Display The Data
                [self displayRegisteredAlien];
                
                // Check if data entried is correct
                // If YES then continue with execution
                
                NSLog(@"Are You Sure You want to save the data?(YES/NO)");
                scanf("%s", option);
                
                if ([[NSString stringWithUTF8String:option] caseInsensitiveCompare:@"YES"] == NSOrderedSame) {
                    
                    // Set the model object
                    self.aliensOnEarth = [[AlienOnEarthModel alloc] initWithDictinory:self.alienDetails];
                    
                    // Save the data locally
                    if ([self saveDetailsLocally]) {
                        NSLog(@"Your Data has been Saved Sucessfully.......");
                    }
                    else {
                        NSLog(@"We were not able to save the data... Please try after some time");
                        self.alienDetails = nil;
                        
                        NSLog(@"Do yo want to continue?(YES/NO)");
                        scanf("%s", option);
                        
                        if ([[NSString stringWithUTF8String:option] caseInsensitiveCompare:@"NO"] == NSOrderedSame) {
                            NSLog(@"Thank You.... Have a nice day");
                            break;
                        }
                    }
                    
                    // Export THe data
                    NSLog(@"Do You Want to export ?");
                    scanf("%s", option);
                    if ([[NSString stringWithUTF8String:option] caseInsensitiveCompare:@"YES"] == NSOrderedSame) {
                        ExportManager* exportManager = [[ExportManager alloc] init];
                        [exportManager startExportWithData:self.aliensOnEarth];
                    }
                    else {
                        // Display a meaage and quit the application
                        NSLog(@"Your Data is Safe with us... Visit Us when ever you want to export");
                        NSLog(@"Have a nice day");
                    }
                    
                    break;
                }
                else {
                    self.alienDetails = nil;
                    break;
                }
            }
        }
        else {
            // If input was not valid display a error message and ask for entries which were not correct
            
            NSLog(@"OOPS... Some of the details were incorrect... ");
            NSLog(@"Please try again");
        }
        
    } while (1);
}

#pragma mark - Input Related Methods
#pragma mark -

/**
 This method is responsible to take input from the console
 */
- (void)takeInputFromTheUser
{
    char codeName[100], bloodColor[100], homePlanet[100];
    char numberOfAntennas[100], numberOfLegs[100]; // These are made character because if in case user tries to enter non-numeric value compiler will not allow to do so
    
    // Assuming Code Name Will only be a string and unique for every alien
    
    // Code Name
    if (![self.alienDetails objectForKey:@"codeName"]) {
        NSLog(@"What is your code name?");
        scanf("%s", codeName);
        [self.alienDetails setValue:[NSString stringWithUTF8String:codeName] forKey:@"codeName"];
    }
    
    // Blood Color
    if (![self.alienDetails objectForKey:@"bloodColor"]) {
        NSLog(@"What is your blood color?");
        scanf("%s", bloodColor);
        [self.alienDetails setValue:[NSString stringWithUTF8String:bloodColor] forKey:@"bloodColor"];
    }
    
    // Number of antennas
    if (![self.alienDetails objectForKey:@"numberOfAntennas"]) {
        NSLog(@"How many Antennas do you have?");
        scanf("%s", numberOfAntennas);
        [self.alienDetails setValue:[NSString stringWithUTF8String:numberOfAntennas] forKey:@"numberOfAntennas"];
    }
    
    // Number of legs
    if (![self.alienDetails objectForKey:@"numberOfLegs"]) {
        NSLog(@"How many legs do you have?");
        scanf("%s", numberOfLegs);
        [self.alienDetails setValue:[NSString stringWithUTF8String:numberOfLegs] forKey:@"numberOfLegs"];
    }
    
    // Home Planet
    if (![self.alienDetails objectForKey:@"homePlanet"]) {
        NSLog(@"Enter Home Planet?");
        scanf("%s", homePlanet);
        [self.alienDetails setValue:[NSString stringWithUTF8String:homePlanet] forKey:@"homePlanet"];
    }
}

#pragma mark - Validate Input String Related Method
#pragma mark -

/**
 This methos checks if the input which was given is correct or not.
 It input is not correct then delete that particular entry from the dictinory, so that
 user has to enter only those entries which were not correct
 
 @return BOOL: YES if entries are correct , NO if entries are not correct
 */
- (BOOL)validateInputString
{
    BOOL isValid = NO;
    BOOL wasItemRemoved = NO;
    
    NSMutableDictionary* tempAlienDetils = [self.alienDetails copy];
    for (NSString* key in tempAlienDetils) {
        if ([key isEqualToString:@"numberOfAntennas"] || [key isEqualToString:@"numberOfLegs"]) {
            isValid = [self isAValidInput:[self.alienDetails objectForKey:key] valueType:YES];
        }
        else {
            isValid = [self isAValidInput:[self.alienDetails objectForKey:key] valueType:NO];
        }
        
        if (isValid == NO) {
            [self.alienDetails removeObjectForKey:key];
            wasItemRemoved = YES;
        }
    }
    tempAlienDetils = nil;
    
    if (wasItemRemoved) {
        return NO;
    }
    else {
        return YES;
    }
}

/**
 This method checks if the data with the same code name is already available or not
 */
- (BOOL)isDataAlreadySaved
{
    NSError* error;
    NSString* alreadySavedDetailsPath = [[AlienOnEarthUtilityClass sharedInstance] getPathOfDocumentDirectory];
    NSArray* savedDetails = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:alreadySavedDetailsPath error:&error];
    
    NSString* fileName = [NSString stringWithFormat:@"%@.plist", [self.alienDetails objectForKey:@"codeName"]];
    
    if ([savedDetails containsObject:fileName]) {
        NSLog(@"Data with same code name is saved in our record.. If you have not saved it please contact help desk ");
        return YES;
    }
    return NO;
}

/**
 This method will display the entries to the console , if all the entries are correct
 */
- (void)displayRegisteredAlien
{
    NSLog(@"%@", self.alienDetails);
}

#pragma mark - Condition Checks Related Methods
#pragma mark -

- (BOOL)isAValidInput:(NSString*)inputString valueType:(BOOL)shouldBeANumericalValue
{
    
    BOOL isValid = YES;
    NSCharacterSet* set;
    if (shouldBeANumericalValue) {
        set = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    }
    else {
        set = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ"] invertedSet];
    }
    
    if ([inputString rangeOfCharacterFromSet:set].location != NSNotFound) {
        isValid = NO;
    }
    return isValid;
}

#pragma mark - Save Details Related Methods
#pragma mark -

/**
 This method will save the details locally as a .plist file using CODENAME as the name of the file
 */
- (BOOL)saveDetailsLocally
{
    NSString* pathToDocumentDirectory = [[AlienOnEarthUtilityClass sharedInstance] getPathOfDocumentDirectory];
    NSMutableDictionary* detailDictinory = [[NSMutableDictionary alloc] init];
    [detailDictinory setValue:self.aliensOnEarth.bloodColor forKey:@"bloodColor"];
    [detailDictinory setValue:self.aliensOnEarth.numberOfAntennas forKey:@"numberOfAntennas"];
    [detailDictinory setValue:self.aliensOnEarth.numberOfLegs forKey:@"numberOfLegs"];
    [detailDictinory setValue:self.aliensOnEarth.homePlanet forKey:@"homePlanet"];
    if ([detailDictinory writeToFile:[NSString stringWithFormat:@"%@/%@.plist", pathToDocumentDirectory,
                                      self.aliensOnEarth.codeName]
                          atomically:YES]) {
        return YES;
    }
    return NO;
}

@end
