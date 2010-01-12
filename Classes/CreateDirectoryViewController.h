//
//  CreateDirectoryViewController.h
//  FilesystemExplorer
//
//  Created by Steve Baker on 12/24/09.
//  Copyright 2009 Beepscore LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DirectoryViewController;


@interface CreateDirectoryViewController : UIViewController {
    NSString *parentDirectoryPath;
    DirectoryViewController *directoryViewController;
    UITextField *directoryNameField;
}
#pragma mark -
#pragma mark properties
@property(nonatomic,copy)NSString *parentDirectoryPath;
@property(nonatomic,retain)DirectoryViewController *directoryViewController;
@property(nonatomic,retain)IBOutlet UITextField *directoryNameField;

- (void)createNewDirectory;

@end
