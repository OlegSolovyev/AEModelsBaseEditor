//
//  AEMainViewController.m
//  AE ModelsBase Editor
//
//  Created by Oleg Solovyev on 03/06/14.
//  Copyright (c) 2014 Oleg Solovyev. All rights reserved.
//

#import "AEMainViewController.h"
#import "AEAddModelWindow.h"

@interface AEMainViewController ()
@property (nonatomic, retain) AEAddModelWindow *addModelWindow;
@end

@implementation AEMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSLog(@"Init");
        self.dbPath = @"";
    }
    return self;
}
- (IBAction)openButtonPressed:(id)sender {
    NSOpenPanel* openDlg = [NSOpenPanel openPanel];
    
    [openDlg setPrompt:@"Select"];
    
    NSArray* txtType = [NSArray arrayWithObject:[NSString stringWithFormat:@"%@",kUTTypeText]];
    NSLog(@"%@",txtType[0]);
    [openDlg setAllowedFileTypes:@[@"txt"]];
    
    [openDlg beginWithCompletionHandler:^(NSInteger result){
        NSArray* files = [openDlg filenames];
        for(NSString* filePath in files)
        {
            NSURL *url = [[NSURL alloc]initFileURLWithPath:filePath];
            NSString *text;
            if(url)
            {
                text = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
            }
            if(text){
                [self.dbView setString:text];
                [self.dbView setEditable:NO];
            }
            
            self.dbPath = filePath;
            NSLog(@"%@",filePath);
            //do something with the file at filePath
        }
    }];

}

- (void)alert:(NSString *)message text:(NSString *)text{
    NSAlert *alert = [[NSAlert alloc]init];
    [alert setMessageText:message];
    [alert setAlertStyle:NSInformationalAlertStyle];
    [alert setInformativeText:text];
    [alert beginSheetModalForWindow:self.window
                      modalDelegate:self didEndSelector:nil contextInfo:nil];
}

- (IBAction)saveButtonpressed:(id)sender {
    if([self.dbPath isEqualToString:@""]){
        NSSavePanel*    panel = [NSSavePanel savePanel];
        [panel setAllowedFileTypes:@[@"txt"]];
        [panel beginSheetModalForWindow:self.window completionHandler:^(NSInteger result){
            if (result == NSFileHandlingPanelOKButton)
            {
                NSURL*  theFile = [panel URL];
                [self.dbView.string writeToURL:theFile atomically:NO encoding:NSUTF8StringEncoding error:nil];
                // Write the contents in the new format.
            }
        }];
    } else{
        [self.dbView.string writeToFile:self.dbPath
                             atomically:NO
                               encoding:NSUTF8StringEncoding
                                  error:nil];
        [self alert:@"Success" text:[NSString stringWithFormat:@"Saved to %@", self.dbPath]];
        
    }

}
- (IBAction)addModelButtonPressed:(id)sender {
    self.addModelWindow = [[AEAddModelWindow alloc] initWithWindowNibName:@"AEAddModelWindow"];
    [self.addModelWindow setDbView:self.dbView];
    [self.addModelWindow showWindow:self];
}
- (IBAction)checkValidButtonPressed:(id)sender {
}

@end
