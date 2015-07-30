//
//  AliensOnEarthRootClass.m
//  AliensOnEarth
//
//  Created by Ankit Angra on 20/07/15.
//  Copyright (c) 2015 Ankit Angra. All rights reserved.
//

#import "AliensOnEarth.h"
#import "AliensOnEarthModel.h"
#import "AlienOnEarthUtilityClass.h"
#import "ExportManager.h"
@interface AliensOnEarth ()

@property (nonatomic, strong) AliensOnEarthModel* aliensOnEarth;
@property (nonatomic, strong) NSMutableDictionary* alienDetail;
@property (nonatomic, strong) ExportManager* exportManager;

@end

@implementation AliensOnEarth

#pragma mark - Initilizers
#pragma mark -

- (NSMutableDictionary*)alienDetail
{
    if (!_alienDetail) {
        _alienDetail = [[NSMutableDictionary alloc] init];
    }
    return _alienDetail;
}

- (ExportManager*)exportManager
{
    if (!_exportManager) {
        _exportManager = [[ExportManager alloc] init];
    }
    return _exportManager;
}

#pragma mark -  Registration Related Methods
#pragma mark -
/**
 This method start the registration process
 */
- (void)alienRegistration
{
    char codeName[100];
    NSLog(@"*************  WELCOME TO PLANET EARTH  *****************");
    char option[3];
    NSLog(@"Have you already registered?(YES/NO)");
    scanf("%s", option);
    
    if ([[NSString stringWithUTF8String:option] caseInsensitiveCompare:@"YES"] == NSOrderedSame) {
        NSLog(@"Enter your Code Name");
        scanf("%s", codeName);
        [self viewRegisteredAlienWithCodeName:[NSString stringWithUTF8String:codeName]];
    }
    else {
        [self startAlienRegistration];
    }
}

/**
 This method is responsible to register Alien while checking all the error conditions
 */
- (void)startAlienRegistration
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
                    self.aliensOnEarth = [[AliensOnEarthModel alloc] initWithDictinory:self.alienDetail];
                    
                    // Save the data locally
                    if ([self saveDetailsLocally]) {
                        NSLog(@"Your Data has been Saved Sucessfully.......");
                    }
                    else {
                        NSLog(@"We were not able to save the data... Please try after some time");
                        self.alienDetail = nil;
                        
                        NSLog(@"Do yo want to continue?(YES/NO)");
                        scanf("%s", option);
                        
                        if ([[NSString stringWithUTF8String:option] caseInsensitiveCompare:@"NO"] == NSOrderedSame) {
                            NSLog(@"Thank You.... Have a nice day");
                            break;
                        }
                    }
                    
                    // Export THe data
                    [self exportDataToFile];
                    
                    break;
                }
                else {
                    self.alienDetail = nil;
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

/**
 This method is responsible to take input from the console
 */
- (void)takeInputFromTheUser
{
    char codeName[100], bloodColor[100], homePlanet[100];
    char numberOfAntennas[100], numberOfLegs[100]; // These are made character because if in case user tries to enter non-numeric value compiler will not allow to do so
    
    // Assuming Code Name Will only be a string and unique for every alien
    
    // Code Name
    if (![self.alienDetail objectForKey:@"codeName"]) {
        NSLog(@"What is your code name?");
        scanf("%s", codeName);
        [self.alienDetail setValue:[NSString stringWithUTF8String:codeName] forKey:@"codeName"];
    }
    
    // Blood Color
    if (![self.alienDetail objectForKey:@"bloodColor"]) {
        NSLog(@"What is your blood color?");
        scanf("%s", bloodColor);
        [self.alienDetail setValue:[NSString stringWithUTF8String:bloodColor] forKey:@"bloodColor"];
    }
    
    // Number of antennas
    if (![self.alienDetail objectForKey:@"numberOfAntennas"]) {
        NSLog(@"How many Antennas do you have?");
        scanf("%s", numberOfAntennas);
        [self.alienDetail setValue:[NSString stringWithUTF8String:numberOfAntennas] forKey:@"numberOfAntennas"];
    }
    
    // Number of legs
    if (![self.alienDetail objectForKey:@"numberOfLegs"]) {
        NSLog(@"How many legs do you have?");
        scanf("%s", numberOfLegs);
        [self.alienDetail setValue:[NSString stringWithUTF8String:numberOfLegs] forKey:@"numberOfLegs"];
    }
    
    // Home Planet
    if (![self.alienDetail objectForKey:@"homePlanet"]) {
        NSLog(@"Enter Home Planet?");
        scanf("%s", homePlanet);
        [self.alienDetail setValue:[NSString stringWithUTF8String:homePlanet] forKey:@"homePlanet"];
    }
}

/**
 This method will display the entries to the console , if all the entries are correct
 */
- (void)displayRegisteredAlien
{
    NSLog(@"%@", self.alienDetail);
}

#pragma mark -  Saved Detail Related Methods
#pragma mark -

- (void)viewRegisteredAlienWithCodeName:(NSString*)codeName
{
    NSString* pathToDocumentDirectory = [[AlienOnEarthUtilityClass sharedInstance] getPathOfDocumentDirectory];
    NSString* filePath = [pathToDocumentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"\%@.plist", codeName]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        
        // If the code name entered was not in the records
        NSLog(@"We Donot have your record");
        [self startAlienRegistration];
    }
    else {
        
        // Get the saved data
        NSMutableDictionary* dataDictionary = [[NSDictionary dictionaryWithContentsOfFile:filePath] mutableCopy];
        [dataDictionary setObject:codeName forKey:@"codeName"];
        NSLog(@"%@", dataDictionary);
        
        // Set the model object
        self.aliensOnEarth = [[AliensOnEarthModel alloc] initWithDictinory:dataDictionary];
        
        // Export it
        [self exportDataToFile];
    }
}

#pragma mark - Export Related Methods
#pragma mark -

/**
 This methos ask user if they really want to export or pospond it for future
 */
- (void)exportDataToFile
{
    char option[3];
    NSLog(@"Do You Want to export ?");
    scanf("%s", option);
    
    if ([[NSString stringWithUTF8String:option] caseInsensitiveCompare:@"YES"] == NSOrderedSame) {
        [self.exportManager startExportWithData:self.aliensOnEarth];
    }
    else {
        // Display a meaage and quit the application
        NSLog(@"Your Data is Safe with us... Visit Us when ever you want to export");
        NSLog(@"Have a nice day");
    }
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

#pragma mark - Condition Checks Related Methods
#pragma mark -

/**
 This method checks if the data with the same code name is already available or not
 */
- (BOOL)isDataAlreadySaved
{
    NSError* error;
    NSString* alreadySavedDetailsPath = [[AlienOnEarthUtilityClass sharedInstance] getPathOfDocumentDirectory];
    NSArray* savedDetails = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:alreadySavedDetailsPath error:&error];
    
    NSString* fileName = [NSString stringWithFormat:@"%@.plist", [self.alienDetail objectForKey:@"codeName"]];
    
    if ([savedDetails containsObject:fileName]) {
        NSLog(@"Data with same code name is saved in our record.. If you have not saved it please contact help desk ");
        return YES;
    }
    return NO;
}

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
    
    NSMutableDictionary* tempAlienDetils = [self.alienDetail copy];
    for (NSString* key in tempAlienDetils) {
        if ([key isEqualToString:@"numberOfAntennas"] || [key isEqualToString:@"numberOfLegs"]) {
            isValid = [self isAValidInput:[self.alienDetail objectForKey:key] valueType:YES];
        }
        else {
            isValid = [self isAValidInput:[self.alienDetail objectForKey:key] valueType:NO];
        }
        
        if (isValid == NO) {
            [self.alienDetail removeObjectForKey:key];
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
@end
