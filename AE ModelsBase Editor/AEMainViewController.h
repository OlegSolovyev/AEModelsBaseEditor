//
//  AEMainViewController.h
//  AE ModelsBase Editor
//
//  Created by Oleg Solovyev on 03/06/14.
//  Copyright (c) 2014 Oleg Solovyev. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AEMainViewController : NSViewController

@property (unsafe_unretained) IBOutlet NSTextView *dbView;
@property (nonatomic, retain) NSWindow *window;
@property (nonatomic, retain) NSString *dbPath;
@end
