//
//  AEAddModelWindow.m
//  AE ModelsBase Editor
//
//  Created by Oleg Solovyev on 03/06/14.
//  Copyright (c) 2014 Oleg Solovyev. All rights reserved.
//

#import "AEAddModelWindow.h"

@interface AEAddModelWindow () 
@property (nonatomic, retain) NSMutableArray *brandNames;
@property (nonatomic, retain) NSMutableArray *modelNames;
@property (nonatomic, retain) NSMutableArray *modelComboBoxSource;
@end

@implementation AEAddModelWindow

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    
    self.brandNames = [[NSMutableArray alloc] init];
    self.modelNames = [[NSMutableArray alloc] init];
    self.modelComboBoxSource = [[NSMutableArray alloc] init];
    
    NSFileManager *filemgr;
    filemgr = [NSFileManager defaultManager];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"allModels" ofType:@"txt"];
    if ([filemgr fileExistsAtPath: path ] == YES)
        //        NSLog (@"File exists %@", path );
        ;
    else
        NSLog (@"File not found");
    
    NSString *allModels = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSArray *models = [allModels componentsSeparatedByString:@"\n"];
    for(NSString *str in models){
        NSString *brandName = [[str componentsSeparatedByString:@":"] objectAtIndex:0];
        NSString *modelName = [[str componentsSeparatedByString:@":"] objectAtIndex:1];
        
        if(![self.brandNames containsObject:brandName]){
            [self.brandNames addObject:brandName];
            NSMutableArray *models = [[NSMutableArray alloc] initWithObjects:modelName, nil];
            [self.modelNames addObject:models];
        } else{
            [[self.modelNames objectAtIndex:[self.brandNames indexOfObject:brandName]] addObject:modelName];
            NSLog(@"Add model %lu", (unsigned long)[[self.modelNames objectAtIndex:[self.brandNames indexOfObject:brandName]] count]);
        }
    }    
}

-(NSInteger)numberOfItemsInComboBox:(NSComboBox *)aComboBox{
    if([aComboBox isEqual:self.brandComboBox]){
        return self.brandNames.count;
    } else if([aComboBox isEqual:self.modelComboBox]){
        if([self.brandComboBox.stringValue isEqualToString:@""]){
            return 0;
        } else{
            return self.modelComboBoxSource.count;
        }
    } else return -1;
}

-(id)comboBox:(NSComboBox *)aComboBox objectValueForItemAtIndex:(NSInteger)loc{
    if([aComboBox isEqual:self.brandComboBox]){
        return [self.brandNames objectAtIndex:loc];
    } else if([aComboBox isEqual:self.modelComboBox]){
        return [self.modelComboBoxSource objectAtIndex:loc];
    } else return nil;
}
- (IBAction)brandBoxValueChanged:(id)sender {
    self.modelComboBoxSource = [self.modelNames objectAtIndex:[self.brandNames indexOfObject:self.brandComboBox.stringValue]];
    [self.modelComboBox reloadData];
}

- (IBAction)automaticValueChanged:(id)sender {
    if([sender state] == NSOnState){
        [self.DSGBox setHidden:NO];
        [self.hydroBox setHidden:NO];
        [self.variatorBox setHidden:NO];
        [self.DSGYearField setHidden:NO];
        [self.hydroYearField setHidden:NO];
        [self.variatorYearField setHidden:NO];
    } else{
        [self.DSGBox setHidden:YES];
        [self.hydroBox setHidden:YES];
        [self.variatorBox setHidden:YES];
        [self.DSGYearField setHidden:YES];
        [self.hydroYearField setHidden:YES];
        [self.variatorYearField setHidden:YES];
    }
}

- (void)alert:(NSString *)message text:(NSString *)text{
    NSAlert *alert = [[NSAlert alloc]init];
    [alert setMessageText:message];
    [alert setAlertStyle:NSInformationalAlertStyle];
    [alert setInformativeText:text];
    [alert beginSheetModalForWindow:self.window
                      modalDelegate:self didEndSelector:nil contextInfo:nil];
}

- (IBAction)addModelButtonPressed:(id)sender {
    
    if([self.maxYearField.stringValue isEqualToString:@""])[self.maxYearField setStringValue: @"0"];
    if([self.dieselYearField.stringValue isEqualToString:@""])[self.dieselYearField setStringValue: @"0"];
    if([self.gasYearField.stringValue isEqualToString:@""])[self.gasYearField setStringValue: @"0"];
    if([self.injectorYearField.stringValue isEqualToString:@""])[self.injectorYearField setStringValue: @"0"];
    if([self.carburetorYearField.stringValue isEqualToString:@""])[self.carburetorYearField setStringValue: @"0"];
    if([self.manualYearField.stringValue isEqualToString:@""])[self.manualYearField setStringValue: @"0"];
    if([self.DSGYearField.stringValue isEqualToString:@""])[self.DSGYearField setStringValue: @"0"];
    if([self.hydroYearField.stringValue isEqualToString:@""])[self.hydroYearField setStringValue: @"0"];
    if([self.variatorYearField.stringValue isEqualToString:@""])[self.variatorYearField setStringValue: @"0"];
    
    if([self.brandComboBox.stringValue isEqualToString:@""]){
        [self alert:@"Error" text:@"Please enter brand name"];
    } else if([self.modelComboBox.stringValue isEqualToString:@""]){
        [self alert:@"Error" text:@"Please enter model name"];
    } else if([self.minYearField.stringValue isEqualToString:@""]){
        [self alert:@"Error" text:@"Please enter start year"];
    } else if(self.maxYearField.intValue < self.minYearField.intValue && self.maxYearField.intValue != 0){
        [self alert:@"Error" text:@"End year is earlier than start year"];
    } else if(self.dieselBox.state == NSOffState && self.gasBox.state == NSOffState){
        [self alert:@"Error" text:@"Engine type not set"];
    } else if(self.injectorBox.state == NSOffState && self.carburetorBox.state == NSOffState){
        [self alert:@"Error" text:@"Injection type not set"];
    } else if(self.manualBox.state == NSOffState && self.automaticBox.state == NSOffState){
        [self alert:@"Error" text:@"Transmission type not set"];
    } else if(self.automaticBox.state == NSOnState && self.DSGBox.state == NSOffState && self.hydroBox.state == NSOffState && self.variatorBox.state == NSOffState){
        [self alert:@"Error" text:@"Automatic transmission type not set"];
    } else{
        int index;
        if([self.dbView.string rangeOfString:@"Index:"].location == NSNotFound){
            index = 0;
        } else{
            NSArray *strings = [self.dbView.string componentsSeparatedByString:@"\n"];
            for(int i = (int)strings.count - 1; i >= 0; i--){
                NSString *str = [strings objectAtIndex:i];
                if ([str isEqualToString:@"Index:"]) {
                    index = [[strings objectAtIndex:i + 1] intValue] + 1;
                    break;
                }
            }
        }
        
        NSString *result = [NSString stringWithFormat:@"\nModel\nIndex:\n%d\nBrand:\n%@\nName:\n%@\nMin Year:\n%d\nMax Year:\n%d\nDiesel:\n%d;%d\nGas:\n%d;%d\nInjector:\n%d;%d\nCarburetor:\n%d;%d\nManual Transmission:\n%d;%d\nDSG:\n%d;%d\nHydro:\n%d;%d\nVariator:\n%d;%d\n", index,self.brandComboBox.stringValue, self.modelComboBox.stringValue, self.minYearField.intValue, self.maxYearField.intValue, (self.dieselBox.state == NSOnState) ? 1 : 0, self.dieselYearField.intValue, (self.gasBox.state == NSOnState) ? 1 : 0, self.gasYearField.intValue, (self.injectorBox.state == NSOnState) ? 1 : 0, self.injectorYearField.intValue, (self.carburetorBox.state == NSOnState) ? 1 : 0, self.carburetorYearField.intValue, (self.manualBox.state == NSOnState) ? 1 : 0, self.manualYearField.intValue, (self.DSGBox.state == NSOnState && self.automaticBox.state == NSOnState) ? 1 : 0, self.DSGYearField.intValue, (self.hydroBox.state == NSOnState && self.automaticBox.state == NSOnState) ? 1 : 0, self.hydroYearField.intValue, (self.variatorBox.state == NSOnState && self.automaticBox.state == NSOnState) ? 1 : 0, self.variatorYearField.intValue];
        [self.dbView setString:[self.dbView.string stringByAppendingString:result]];
        [self.window performClose:self];

        
        
        
    }
    
}
@end
