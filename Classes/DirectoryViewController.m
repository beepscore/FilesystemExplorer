//
//  RootViewController.m
//  FilesystemExplorer
//
//  Created by Steve Baker on 12/9/09.
//  Copyright Beepscore LLC 2009. All rights reserved.
//

#import "DirectoryViewController.h"
#import "FileOverviewViewController.h"

@implementation DirectoryViewController

#pragma mark Instance variables, properties, accessors
-(NSString *)directoryPath {
    return directoryPath;
}

// override synthesized setter in order to load directory contents
- (void)setDirectoryPath:(NSString *)aDirectoryPath {
    if (directoryPath != aDirectoryPath) {
        [directoryPath release];
        directoryPath = [aDirectoryPath retain];
    }
    [self loadDirectoryContents];
    // also set title of nav controller with last path element
    NSString *pathTitle = [directoryPath lastPathComponent];
    self.title = pathTitle;
}

// ????: where is directoryContents first allocated? in the nib?
// directoryContents is an ivar, not a property. Use this method to set it.
- (void)loadDirectoryContents {
    [directoryContents release];
    directoryContents = [[NSFileManager defaultManager]
                         directoryContentsAtPath:self.directoryPath];
    [directoryContents retain];
}

#pragma mark -
- (void)dealloc {
    [directoryContents release];
    directoryContents = nil;
    self.directoryPath = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *addButton = [[[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                   target:self
                                   action:@selector(showAddOptions)] autorelease];
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)showAddOptions {
    NSString *sheetTitle = [[NSString alloc]
                            initWithFormat:@"Edit \"%@\"",
                            [directoryPath lastPathComponent]];
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:sheetTitle
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:NULL
                                  otherButtonTitles:@"New File", @"New Directory", NULL];
    [actionSheet showInView:self.view];
    [sheetTitle release];
    [actionSheet release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet
clickedButtonAtIndex:(NSInteger) buttonIndex {
    if (0 == buttonIndex)
        [self createNewFile];
    else if (1 == buttonIndex)
        [self createNewDirectory];
}

- (void)createNewFile{
    
}

- (void)createNewDirectory {
    BOOL canWrite = [[NSFileManager defaultManager]
                     isWritableFileAtPath:self.directoryPath];
    if (! canWrite) {
        NSString *alertMessage = @"Cannot write to this direcotry";
        UIAlertView *cantWriteAlert = [[UIAlertView alloc] initWithTitle:@"Not Permitted" 
                                                                 message:alertMessage
                                                                delegate:nil
                                                       cancelButtonTitle:@"OK"
                                                       otherButtonTitles:nil];
        [cantWriteAlert show];
        [cantWriteAlert release];
        return;
    }
    CreateDirectoryViewController *createDirectoryViewController =
    [[CreateDirectoryViewController alloc]
     initWithNibName:@"CreateDirectoryView"
     bundle:nil];
    createDirectoryViewController.parentDirectoryPath = directoryPath;
    createDirectoryViewController.directoryViewController = self;
    createDirectoryViewController.title = @"Create directory";
    [[self navigationController]
     pushViewController:createDirectoryViewController animated:YES];
    [createDirectoryViewController release];
}

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
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release anything that can be recreated in viewDidLoad or on demand.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section {
    return [directoryContents count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.textLabel.text = (NSString *)[directoryContents objectAtIndex:indexPath.row];    
    return cell;
}

// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView 
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // cast return to NSString
    NSString *selectedFile = (NSString *)[directoryContents objectAtIndex:indexPath.row];
    BOOL isDir;
    NSString *selectedPath = [self.directoryPath stringByAppendingPathComponent:selectedFile];
    
    if ([[NSFileManager defaultManager]
         fileExistsAtPath:selectedPath isDirectory:&isDir] && isDir) {
        DirectoryViewController *directoryViewController = 
        [[DirectoryViewController alloc]
         initWithNibName:@"DirectoryViewController"
         bundle:nil];
        
        [[self navigationController]
         pushViewController:directoryViewController animated:YES];
        directoryViewController.directoryPath = selectedPath;
        [directoryViewController release];
    } else {
        FileOverviewViewController *fileOverviewViewController =
        [[FileOverviewViewController alloc] 
         initWithNibName:@"FileOverviewView"
         bundle:nil];
        [[self navigationController] pushViewController:fileOverviewViewController
                                               animated:YES];
        fileOverviewViewController.filePath = selectedPath;
        [fileOverviewViewController release];
    }
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source.
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

@end

