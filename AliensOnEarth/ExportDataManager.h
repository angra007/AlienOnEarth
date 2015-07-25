//
//  ExportAlienData.h
//  AliensOnEarth
//
//  Created by Ankit Angra on 20/07/15.
//  Copyright (c) 2015 Ankit Angra. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ExportDataType) {
    ePDF,
    eText
};

@class AliensOnEarthModelObject;

@protocol ExportDataDelegate <NSObject>

- (void)getDataToExportForAlien:(AliensOnEarthModelObject*)alienObject;
- (void)createFileToExportData;

@end

@interface ExportDataManager : NSObject

@property (nonatomic, weak) id<ExportDataDelegate> delegate;

- (void)exportToFileWithData:(AliensOnEarthModelObject*)alienData ofType:(ExportDataType)type;

@end
