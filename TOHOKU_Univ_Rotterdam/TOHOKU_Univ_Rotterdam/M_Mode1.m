#import "mainController.h"

@implementation mainController ( MODE_1 )
- (void)goto_mode1:(NSString*)animationID
{
	COMMON_TIMER = 0;
	AUTO_TAP_TIMER = 0;
	DRAW_MODE = 1;
	
	
	glBindFramebuffer(GL_FRAMEBUFFER, FBO_Contents);
	glClear( GL_COLOR_BUFFER_BIT );

	
	
	NSLog(@"goto mode1");
	[UIView beginAnimations:@"" context:nil];
	[UIView setAnimationDuration:CAPTION_TIME];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(mode1_start:)];
	
	overlay_WhiteView_OBJ.alpha = 0.0;
	overlay_ImageView_OBJ.alpha = 0.0;
	TapExplanation_ImageView.alpha = 1.0;

	[UIView commitAnimations];
}


- (void)mode1_start:(NSString*)animationID
{
	int i;
	for( i = 0 ; i < 1000 ; i++ )
		{
		float random_X = (random()%200-100)*0.01*RATIO;
		float random_Y = (random()%200-100)*0.01;
		[self makeWaterDrop_X:random_X Y:random_Y Color:1.0];
		}
	
	[self enableGUI:YES];
}



- (void)backToNormal_from_mode1
{
	
	
	NSLog(@"back to normal from mode1");
	int i;
	for( i = 0 ; i < DROP_NUM ; i++ )
		{
		[self deleteWaterDrop:i];
		}
	
	overlay_WhiteView_OBJ.image = [overlay_WhiteView_ARRAY objectAtIndex:0];
	
	[UIView beginAnimations:@"" context:nil];
	[UIView setAnimationDuration:4.0];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(backToNormal_from_mode1_Finish:)];
	
	overlay_WhiteView_OBJ.alpha = 1.0;
	
	[UIView commitAnimations];
}


- (void)backToNormal_from_mode1_Finish:(NSString*)animationID
{
	NSLog(@"back to normal from mode1 Finish");
	DRAW_MODE = 0;
	COMMON_TIMER = 0;
	AUTO_TAP_TIMER = 0;


	[self enableGUI:YES];
	
	
	[UIView beginAnimations:@"" context:nil];
	[UIView setAnimationDuration:4.0];
	
	overlay_WhiteView_OBJ.alpha = 0.0;
	overlay_ImageView_OBJ.alpha = 0.0;
	
	[UIView commitAnimations];
}


@end