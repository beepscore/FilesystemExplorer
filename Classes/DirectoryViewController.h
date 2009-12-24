//
//  RootViewController.h
//  FilesystemExplorer
//
//  Created by Steve Baker on 12/9/09.
//  Copyright Beepscore LLC 2009. All rights reserved.
//

@interface DirectoryViewController : UITableViewController <UIActionSheetDelegate> {
    
#pragma mark Instance variables
    // directoryContents is an array of NSStrings representing files or directories
    NSArray *directoryContents;
    NSString *directoryPath;
}
@property (nonatomic, retain) NSString *directoryPath;

- (void)loadDirectoryContents;
- (void)createNewFile;
- (void)createNewDirectory;

@end
