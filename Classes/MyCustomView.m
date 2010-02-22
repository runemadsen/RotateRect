#import "MyCustomView.h"

#define kAccelerometerFrequency 10

@implementation MyCustomView

/* Inits
__________________________________________________________________ */

- (id)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame])
	{
	}
	return self;
}

- (void) awakeFromNib
{
	squareSize = 100.0f;
	twoFingers = NO;
	location = CGPointZero;
	rotation = 0.5f;
	scale = 1.0f;
	
	lastDist = 0.0f;
	
	self.multipleTouchEnabled = YES;
	[self configureAccelerometer];
}

/* Accelerometer
 __________________________________________________________________ */


- (void) configureAccelerometer
{
	UIAccelerometer*  theAccelerometer = [UIAccelerometer sharedAccelerometer];
	
	if(theAccelerometer)
	{
		theAccelerometer.updateInterval = 1 / kAccelerometerFrequency;
		theAccelerometer.delegate = self;
	}
	else
	{
		NSLog(@"Oops we're not running on the device!");
	}
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
	UIAccelerationValue x, y, z;
	x = acceleration.x;
	y = acceleration.y;
	z = acceleration.z;
	
	// Do something with the values.
	xField.text = [NSString stringWithFormat:@"%.5f", x];
	yField.text = [NSString stringWithFormat:@"%.5f", y];
	zField.text = [NSString stringWithFormat:@"%.5f", z];
}

/* Touch Began
 __________________________________________________________________ */


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSLog(@"touches began count %d, %@", [touches count], touches);
	
	if([touches count] > 1)
	{
		twoFingers = YES;
		
		UITouch *tOne = (UITouch*)[[touches allObjects] objectAtIndex:0];
		UITouch *tTwo = (UITouch*)[[touches allObjects] objectAtIndex:1];
		
		CGPoint loc1 = [tOne locationInView:self];
		CGPoint loc2 = [tTwo locationInView:self];
		
		lastDist = sqrt(((loc1.x-loc2.x)*(loc1.x-loc2.x)) + ((loc1.y-loc2.y)*(loc1.y-loc2.y)));
		lastMid = CGPointMake((loc1.x+loc2.x)/2, (loc1.y+loc2.y)/2);
	}
	else 
	{
		twoFingers = NO;
	}

	
	[self setNeedsDisplay];
}


/* Touch Moved
__________________________________________________________________ */

- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
	NSLog(@"touches moved count %d, %@", [touches count], touches);
	
	if(twoFingers && [touches count] == 2)
	{
		UITouch *tOne = (UITouch*)[[touches allObjects] objectAtIndex:0];
		UITouch *tTwo = (UITouch*)[[touches allObjects] objectAtIndex:1];
		
		// update
		CGPoint loc1 = [tOne locationInView:self];
		CGPoint loc2 = [tTwo locationInView:self];
		
		CGFloat dx = loc1.x - loc2.x;
		CGFloat dy = loc1.y - loc2.y;
		
		CGPoint nowMid = CGPointMake((loc1.x+loc2.x) / 2, (loc1.y+loc2.y) / 2);
		
		CGFloat nowRot = atan2f(dy, dx);
		CGFloat deltaRot = nowRot - lastRot;
		
		CGFloat nowDist = sqrt(((loc1.x-loc2.x) * (loc1.x-loc2.x)) + ((loc1.y-loc2.y)*(loc1.y-loc2.y)));
		CGFloat deltaScale = nowDist / lastDist;
		
		if(!newTouch)
		{
			rotation += deltaRot;
			scale = deltaScale;
			location = CGPointMake(location.x + (nowMid.x - lastMid.x), location.y + (nowMid.y - lastMid.y));
		}
		
		lastMid = nowMid;
		lastRot = nowRot;
		
		if(newTouch) newTouch = NO;
	}
	
	[self setNeedsDisplay];
}


/* Touch Ended
 __________________________________________________________________ */

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSLog(@"touches moved count %d, %@", [touches count], touches);
	
	twoFingers = NO;
	
	[self setNeedsDisplay];
}

/* Draw
 __________________________________________________________________ */

- (void) drawRect:(CGRect)rect
{
	NSLog(@"drawRect");
	
	CGFloat centerx = rect.size.width/2;
	CGFloat centery = rect.size.height/2;
	CGFloat half = squareSize/2;
	CGRect theRect = CGRectMake(-half, -half, squareSize, squareSize);
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGContextSaveGState(context); // pushmatrix
	CGContextTranslateCTM(context, centerx, centery); // translate
	
	CGContextTranslateCTM(context, location.x, location.y);
	
	CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
	
	if(!twoFingers)
	{
		CGContextSetRGBFillColor(context, 0.0, 1.0, 0.0, 1.0);
	}
	else
	{
		CGContextSetRGBFillColor(context, 0.0, 1.0, 1.0, 1.0);
	}
	
	CGContextFillRect(context, theRect);
	CGContextStrokeRect(context, theRect);
	
	CGContextRestoreGState(context); // popmatrix
}

/* Dealloc
 __________________________________________________________________ */


- (void) dealloc
{
	[super dealloc];
}

@end