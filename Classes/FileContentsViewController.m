//
//  FileContentsViewController.m
//  FilesystemExplorer
//
//  Created by Steve Baker on 12/22/09.
//  Copyright 2009 Beepscore LLC. All rights reserved.
//

#import "FileContentsViewController.h"


@implementation FileContentsViewController

#pragma mark -
#pragma mark properties
@synthesize filePath;

#pragma mark -
- (void)dealloc {
    self.filePath = nil;
    
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
    [self setupAsynchronousContentLoad];
}

// ref Dudney sec 8.5
- (void)setupAsynchronousContentLoad {
    // open a stream to filePath
    NSInputStream *inputStream = [[NSInputStream alloc] initWithFileAtPath:filePath];
    [inputStream setDelegate:self];
    [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop]
                           forMode:NSDefaultRunLoopMode];
    [inputStream open];
    [inputStream release];
}

- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode {
    
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
