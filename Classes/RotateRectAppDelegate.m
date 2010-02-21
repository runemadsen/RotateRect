//
//  RotateRectAppDelegate.m
//  RotateRect
//
//  Created by Rune Madsen on 2/21/10.
//  Copyright New York University 2010. All rights reserved.
//

#import "RotateRectAppDelegate.h"
#import "RotateRectViewController.h"

@implementation RotateRectAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
