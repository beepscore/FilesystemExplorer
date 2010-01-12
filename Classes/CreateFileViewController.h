//
//  CreateFileViewController.h
//  FilesystemExplorer
//
//  Created by Steve Baker on 12/24/09.
//  Copyright 2009 Beepscore LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DirectoryViewController;

@interface CreateFileViewController : UIViewController {
    UITextField *fileNameField;
    UITextView *fileContentsView;
    NSString *parentDirectoryPath;
    DirectoryViewController *directoryViewController;
    
    NSOutputStream *asyncOutputStream;
    NSData *outputData;
    NSRange outputRange;
}
#pragma mark -
#pragma mark properties
@property(nonatomic,retain)IBOutlet UITextField *fileNameField;
@property(nonatomic,retain)IBOutlet UITextView *fileContentsView;
@property(nonatomic,copy)NSString *parentDirectoryPath;
@property(nonatomic,retain)DirectoryViewController *directoryViewController;

- (void)setupAsynchronousContentSave;
- (void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent;
@end
