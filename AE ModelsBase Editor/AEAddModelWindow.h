//
//  AEAddModelWindow.h
//  AE ModelsBase Editor
//
//  Created by Oleg Solovyev on 03/06/14.
//  Copyright (c) 2014 Oleg Solovyev. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AEAddModelWindow : NSWindowController <NSComboBoxDelegate, NSComboBoxDataSource>
@property (weak) IBOutlet NSComboBox *brandComboBox;
@property (weak) IBOutlet NSComboBox *modelComboBox;

@property (weak) IBOutlet NSTextField *minYearField;
@property (weak) IBOutlet NSTextField *maxYearField;

@property (weak) IBOutlet NSButton *dieselBox;
@property (weak) IBOutlet NSButton *gasBox;
@property (weak) IBOutlet NSButton *injectorBox;
@property (weak) IBOutlet NSButton *carburetorBox;
@property (weak) IBOutlet NSButton *manualBox;
@property (weak) IBOutlet NSButton *automaticBox;
@property (weak) IBOutlet NSButton *DSGBox;
@property (weak) IBOutlet NSButton *hydroBox;
@property (weak) IBOutlet NSButton *variatorBox;

@property (weak) IBOutlet NSTextField *dieselYearField;
@property (weak) IBOutlet NSTextField *gasYearField;
@property (weak) IBOutlet NSTextField *injectorYearField;
@property (weak) IBOutlet NSTextField *carburetorYearField;
@property (weak) IBOutlet NSTextField *manualYearField;
@property (weak) IBOutlet NSTextField *DSGYearField;
@property (weak) IBOutlet NSTextField *hydroYearField;
@property (weak) IBOutlet NSTextField *variatorYearField;

@property (nonatomic, retain) NSTextView *dbView;


@end
