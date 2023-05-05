
#import "mainController.h"

@implementation mainController ( MODE_2 )

- (void)goto_mode2:(NSString *)animationID
{
	NSLog(@"goto mode2 ");
	
	glBindFramebuffer(GL_FRAMEBUFFER, FBO_Contents);
	glClear( GL_COLOR_BUFFER_BIT );

	
	COMMON_TIMER = 0;
	AUTO_TAP_TIMER = 0;
	DRAW_MODE = 2;
	
	[UIView beginAnimations:@"" context:nil];
	[UIView setAnimationDuration:CAPTION_TIME];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(mode2_start:)];
	
	overlay_WhiteView_OBJ.alpha = 0.0;
	overlay_ImageView_OBJ.alpha = 0.0;
	TapExplanation_ImageView.alpha = 1.0;

	[UIView commitAnimations];
}


- (void)mode2_start:(NSString *)animationID
{
	NSLog(@"mode2 start");
	int i;
	for( i = 0 ; i < 1000 ; i++ )
		{
		float random_X = (random()%200-100)*0.01*RATIO;
		float random_Y = (random()%200-100)*0.01;
		[self makeWaterDrop_X:random_X Y:random_Y Color:1.0];
		}
	
	[self enableGUI:YES];
//	isTap600 = YES;
//	Tap600_COUNTER = 0;
}


- (void)backToNormal_from_mode2
{
	NSLog(@"back to normal from mode2");
	int i;
	
	for( i = 0 ; i < DROP_NUM ; i++ )
		{
		[self deleteWaterDrop:i];
		}
	
	overlay_WhiteView_OBJ.image = [overlay_WhiteView_ARRAY objectAtIndex:0];
	
	[UIView beginAnimations:@"" context:nil];
	[UIView setAnimationDuration:4.0];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(backToNormal_from_mode2_Finish:)];
	
	overlay_WhiteView_OBJ.alpha = 1.0;
	
	[UIView commitAnimations];
}


- (void)backToNormal_from_mode2_Finish:(NSString*)animationID
{
	DRAW_MODE = 0;
	COMMON_TIMER = 0;
	AUTO_TAP_TIMER = 0;

	NSLog(@"back to normal from mode2 Finish");
	

	[self enableGUI:YES];
	
	
	[UIView beginAnimations:@"" context:nil];
	[UIView setAnimationDuration:4.0];
	
	overlay_WhiteView_OBJ.alpha = 0.0;
	overlay_ImageView_OBJ.alpha = 0.0;
	
	[UIView commitAnimations];
}

@end