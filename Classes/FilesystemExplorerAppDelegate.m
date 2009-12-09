//
//  FilesystemExplorerAppDelegate.m
//  FilesystemExplorer
//
//  Created by Steve Baker on 12/9/09.
//  Copyright Beepscore LLC 2009. All rights reserved.
//

#import "FilesystemExplorerAppDelegate.h"
#import "DirectoryViewController.h"


@implementation FilesystemExplorerAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize directoryViewController;


#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
	
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
    // populate the first fiew
    self.directoryViewController.directoryPath = NSHomeDirectory();
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

