//
//  ExportAlienData.m
//  AliensOnEarth
//
//  Created by Ankit Angra on 20/07/15.
//  Copyright (c) 2015 Ankit Angra. All rights reserved.
//

#import "ExportDataManager.h"
#import "AlienOnEarthUtilityClass.h"
#import "AliensOnEarthModelObject.h"
#import "PDF.h"
#import "TEXT.h"

@interface ExportDataManager ()

@property (nonatomic, strong) PDF *pdf;
@property (nonatomic, strong) TEXT *text;
@end


@implementation ExportDataManager


- (PDF *)pdf {
    if (!_pdf) {
        _pdf = [[PDF alloc] init];
    }
    return _pdf;
}

- (TEXT *)text {
    if (!_text) {
        _text = [[TEXT alloc] init];
    }
    return _text;
}

- (void)initilizeDelegateForType:(ExportDataType)type
{
    if (type == eText) {
        _delegate = _text;
    }
    else if (type == ePDF) {
        _delegate = _pdf;
    }
}


- (void)exportToFileWithData:(AliensOnEarthModelObject *)alienData ofType:(ExportDataType)type
{
    [self initilizeDelegateForType:type];
    
    if ([_delegate respondsToSelector:@selector(getDataToExportForAlien:)]) {
        [_delegate getDataToExportForAlien:alienData];
    }
    
    if ([_delegate respondsToSelector:@selector(createFileToExportData)]) {
         [_delegate createFileToExportData];
    }
}

@end
