//
//  CreateFileViewController.m
//  FilesystemExplorer
//
//  Created by Steve Baker on 12/24/09.
//  Copyright 2009 Beepscore LLC. All rights reserved.
//

#import "CreateFileViewController.h"


@implementation CreateFileViewController

#pragma mark -
#pragma mark properties
@synthesize fileNameField;
@synthesize fileContentsView;
@synthesize parentDirectoryPath;
@synthesize directoryViewController;

#pragma mark -
#pragma mark initializers / destructors
- (void)dealloc {
    self.fileNameField = nil;
    self.fileContentsView = nil;
    self.parentDirectoryPath = nil;
    self.directoryViewController = nil;
    
    [super dealloc];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                   target:self
                                   action:@selector(setupAsynchronousContentSave)];
    self.navigationItem.rightBarButtonItem = saveButton;
}

- (void)setupAsynchronousContentSave {
    [asyncOutputStream release];
    [outputData release];
    // convert text view NSString to an NSData block of bytes for use with stream APIs
    outputData = [[fileContentsView.text
                   dataUsingEncoding:NSUTF8StringEncoding] retain];
    outputRange.location = 0;
    NSString *newFilePath = [parentDirectoryPath
                             stringByAppendingPathComponent:fileNameField.text];
    [[NSFileManager defaultManager] createFileAtPath:newFilePath
                                            contents:nil
                                          attributes:nil];
    asyncOutputStream = [[NSOutputStream alloc]
                         initToFileAtPath:newFilePath
                         append:NO];
    // set delegate to receive callbacks from stream
    [asyncOutputStream setDelegate:self];
    [asyncOutputStream scheduleInRunLoop:[NSRunLoop currentRunLoop]
                                 forMode:NSDefaultRunLoopMode];
    [asyncOutputStream open];
}

// ref Dudney sec 8.7
- (void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent {
    //NSOutputStream *outputStream = (NSOutputStream*) theStream;
}

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
