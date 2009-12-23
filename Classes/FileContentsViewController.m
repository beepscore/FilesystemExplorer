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

- (void)appendTextToView:(NSString *)textToAppend {
    fileContentsTextView.text = [NSString stringWithFormat:@"%@%@",
                                 fileContentsTextView.text, textToAppend];
}

// ref Dudney sec 8.5
- (void)setupAsynchronousContentLoad {
    [asynchInputStream release];
    // open a stream to filePath
    asynchInputStream = [[NSInputStream alloc] initWithFileAtPath:filePath];
    [asynchInputStream setDelegate:self];
    [asynchInputStream scheduleInRunLoop:[NSRunLoop currentRunLoop]
                                 forMode:NSDefaultRunLoopMode];
    [asynchInputStream open];
}

- (void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent {
    NSInputStream *inputStream = (NSInputStream *) theStream;
    switch (streamEvent) {
        case NSStreamEventHasBytesAvailable: {
            NSInteger maxLength = 128;
            uint8_t readBuffer[maxLength];
            NSInteger bytesRead = [inputStream read:readBuffer maxLength:maxLength];
            if (bytesRead > 0) {
                NSString *bufferString = [[NSString alloc]
                                          initWithBytesNoCopy:readBuffer
                                          length:bytesRead
                                          encoding:NSUTF8StringEncoding
                                          freeWhenDone:NO];
                [self appendTextToView:bufferString];
                [bufferString release];
            }
            break;
        } // case: bytes available
            
        case NSStreamEventErrorOccurred: {
            // dialog the error
            NSError *error = [theStream streamError];
            if (error != NULL) {
                UIAlertView *errorAlert = [[UIAlertView alloc]
                                           initWithTitle:[error localizedDescription]
                                           message:[error localizedFailureReason]
                                           delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];
                [errorAlert show];
                [errorAlert release];
            }
            [inputStream removeFromRunLoop:[NSRunLoop currentRunLoop]
                                   forMode:NSDefaultRunLoopMode];
            [theStream close];
            break;
        }
        case NSStreamEventEndEncountered: {
            [inputStream removeFromRunLoop:[NSRunLoop currentRunLoop]
                                   forMode:NSDefaultRunLoopMode];
            [theStream close];
        }
    }
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

- (void)viewWillDisappear: (BOOL) animated {
    [asynchInputStream removeFromRunLoop:[NSRunLoop mainRunLoop]
                                 forMode:NSDefaultRunLoopMode];
    [asynchInputStream close];
    [super viewWillDisappear:animated];
}

@end
