//
//  FileOverviewViewController.h
//  FilesystemExplorer
//
//  Created by Steve Baker on 12/22/09.
//  Copyright 2009 Beepscore LLC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FileOverviewViewController : UIViewController {

#pragma mark Instance variables
NSString *filePath;
UILabel *fileNameLabel;
UILabel *fileSizeLabel;
UILabel *fileModifiedLabel;    
}
@property (nonatomic, retain) NSString *filePath;
@property (nonatomic, retain) IBOutlet UILabel *fileNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *fileSizeLabel;
@property (nonatomic, retain) IBOutlet UILabel *fileModifiedLabel;


- (IBAction)readFileContents;
- (void) updateFileOverview;
@end
