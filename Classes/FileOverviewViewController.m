//
//  FileOverviewViewController.m
//  FilesystemExplorer
//
//  Created by Steve Baker on 12/22/09.
//  Copyright 2009 Beepscore LLC. All rights reserved.
//

#import "FileOverviewViewController.h"


@implementation FileOverviewViewController
@synthesize fileNameLabel;
@synthesize fileSizeLabel;
@synthesize fileModifiedLabel;    


- (NSString *)filePath {
    return filePath;
}

- (void)setFilePath:(NSString *) aFilePath {
    if (filePath != aFilePath) {
        [filePath release];
        filePath = [aFilePath retain];
    }
    [self updateFileOverview];
    // also set title of nav controller with last path element
    NSString *pathTitle = [filePath lastPathComponent];
    self.title = pathTitle;    
}

- (void)dealloc {
    self.filePath = nil;
    self.fileNameLabel = nil;
    self.fileSizeLabel = nil;
    self.fileModifiedLabel = nil;
    [super dealloc];
}

- (IBAction)readFileContents {
    
}

// ref Dudney pg 142
- (void) updateFileOverview {
   if (self.filePath != NULL) {
       NSString *fileName = [self.filePath lastPathComponent];
       self.fileNameLabel.text = fileName;
       
       NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
       [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
       [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
       
       NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
       [numberFormatter setPositiveFormat:@"#,##0.## bytes"];
       
       NSDictionary *fileAttributes = [[NSFileManager defaultManager]
                                       fileAttributesAtPath:self.filePath
                                       traverseLink:YES];
       NSDate *modificationDate = (NSDate *) [fileAttributes objectForKey:NSFileModificationDate];
       NSNumber *fileSize = (NSNumber *) [fileAttributes objectForKey:NSFileSize];
       self.fileSizeLabel.text = [numberFormatter stringFromNumber:fileSize];
       self.fileModifiedLabel.text = [dateFormatter stringFromDate:modificationDate];
       [numberFormatter release];
       [dateFormatter release];                                       
   } 
}

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
    return self;
}
*/

/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

@end

