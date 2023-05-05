#import "mainController.h"


@implementation mainController ( TRANTSITION )

- (void)transition_to:(Byte)num
{
	NSLog(@"transition to mode %d", num);
	
	AUTO_TAP_TIMER = 0;
	
	if( projector_Window != nil )
		{
		CGRect windowFrame = projector_Window.frame;
		float width = windowFrame.size.width;
		float height = windowFrame.size.height;
		
		float scaleWidth = width * ScaleValue;
		float scaleHeight = height * ScaleValue;
		
		overlay_WhiteView_OBJ.frame = CGRectMake(
												 width/2.0 - scaleWidth/2.0, 
												 height/2.0 - scaleHeight/2.0, 
												 scaleWidth, 
												 scaleHeight
												 );

		
		
		double theta;
		if( is_Rotate )
			{ theta = M_PI ;}
		else
			{ theta = 0.0;  }
		
		double sinValue = sin(theta);
		double cosValue = cos(theta);
		
		overlay_WhiteView_OBJ.transform = CGAffineTransformMake(
																cosValue, 
																-sinValue, 
																sinValue, 
																cosValue, 
																0.0, 
																0.0
																);
}
	
	
	SEL nextSelector;
	float FadeTime = 12.0;
	switch (num) {
		case 1:
			nextSelector = @selector(goto_mode1:);
			break;
		case 2:
			nextSelector = @selector(goto_mode2:);
			break;
		case 3:
			nextSelector = @selector(goto_mode3:);
			break;
		case 4:
			nextSelector = @selector(goto_mode4:);
			break;
		case 5:
			nextSelector = @selector(goto_mode5:);
			break;
		case 6:
			nextSelector = @selector(goto_mode6:);
			FadeTime = 2.0;
			break;
		case 7:
			nextSelector = @selector(goto_mode7:);
			FadeTime = 8.0;
			break;
		default:
			break;
	}
	
	
		// disable touch
	[self enableGUI:NO];
	
		// kill all waterdrop
	for( int i = 0 ; i < DROP_NUM ; i++ )
		{
		[self deleteWaterDrop:i];
		}
	
	
		// show mode title
	overlay_ImageView_OBJ.image = [overlay_ImageView_ARRAY objectAtIndex:num];
	overlay_WhiteView_OBJ.image = [overlay_WhiteView_ARRAY objectAtIndex:num];
	

	
	[UIView beginAnimations:@"" context:nil];
	[UIView setAnimationDuration:FadeTime];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:nextSelector];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	overlay_ImageView_OBJ.alpha = 0.75;
	overlay_WhiteView_OBJ.alpha = 1.0;
	TapExplanation_ImageView.alpha = 0.0;

	[UIView commitAnimations];
	
}



- (void)enableGUI:(BOOL)yn
{
	Tap_GR.enabled = yn;
	Pan_GR.enabled = yn;
	
	Asphalt_BUTTON.enabled = yn;
	RainGarden_BUTTON.enabled = yn;
	Yotsuya_BUTTON.enabled = yn;
}

@end