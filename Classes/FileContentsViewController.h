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
    IBOutlet UITextView *fileContentsTextView;
    NSInputStream *asynchInputStream;
}
@property (nonatomic, retain) NSString *filePath;

- (void)appendTextToView:(NSString *)textToAppend;
- (void)setupAsynchronousContentLoad;
- (void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent;

@end
