//
//  RotateRectAppDelegate.h
//  RotateRect
//
//  Created by Rune Madsen on 2/21/10.
//  Copyright New York University 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RotateRectViewController;

@interface RotateRectAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    RotateRectViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet RotateRectViewController *viewController;

@end

