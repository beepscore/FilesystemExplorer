//
//  FileContentsViewController.h
//  FilesystemExplorer
//
//  Created by Steve Baker on 12/22/09.
//  Copyright 2009 Beepscore LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FileContentsViewController : UIViewController {
    NSString *filePath;
    UITextView *fileContentsTextView;
}
@property (nonatomic, retain) NSString *filePath;

- (void)setupAsynchronousContentLoad;
- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode;

@end
