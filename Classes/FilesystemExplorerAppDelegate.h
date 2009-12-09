//
//  FilesystemExplorerAppDelegate.h
//  FilesystemExplorer
//
//  Created by Steve Baker on 12/9/09.
//  Copyright Beepscore LLC 2009. All rights reserved.
//

@interface FilesystemExplorerAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

