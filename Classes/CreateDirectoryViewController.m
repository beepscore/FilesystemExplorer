//
//  CreateDirectoryViewController.m
//  FilesystemExplorer
//
//  Created by Steve Baker on 12/24/09.
//  Copyright 2009 Beepscore LLC. All rights reserved.
//

#import "CreateDirectoryViewController.h"
#import "DirectoryViewController.h"


@implementation CreateDirectoryViewController
#pragma mark -
#pragma mark properties
@synthesize parentDirectoryPath;
@synthesize directoryViewController;
@synthesize directoryNameField;

#pragma mark -
#pragma mark initializers / destructors
- (void)dealloc {
    [parentDirectoryPath release], parentDirectoryPath = nil;
    [directoryViewController release], directoryViewController = nil;
    [directoryNameField release], directoryNameField = nil;
    
    [super dealloc];
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                   target:self
                                   action:@selector(createNewDirectory)];
    self.navigationItem.rightBarButtonItem = saveButton;
    [saveButton release];
}

- (void)createNewDirectory {
    [directoryNameField resignFirstResponder];
    NSString *newDirectoryPath = [parentDirectoryPath 
                                  stringByAppendingPathComponent:directoryNameField.text];
    [[NSFileManager defaultManager]
     createDirectoryAtPath:newDirectoryPath
     attributes:nil];
    
    [directoryViewController loadDirectoryContents];
    [directoryViewController.tableView reloadData];
    [self.navigationController popViewControllerAnimated:YES];
}

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
