#import <UIKit/UIKit.h>

@interface MyCustomView : UIView <UIAccelerometerDelegate>
{
	CGFloat squareSize;
	
	CGFloat scale;
	CGPoint location;
	CGFloat rotation;
	
	CGFloat lastDist;
	CGPoint lastMid;
	CGFloat lastRot;
	
	CGColorRef aColor;
	
	BOOL twoFingers;
	BOOL newTouch;
	
	IBOutlet UILabel *xField;
	IBOutlet UILabel *yField;
	IBOutlet UILabel *zField;
}

@end