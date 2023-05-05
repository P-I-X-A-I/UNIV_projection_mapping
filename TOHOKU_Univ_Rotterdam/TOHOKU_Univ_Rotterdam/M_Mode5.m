
#import "mainController.h"

@implementation mainController ( MODE_5 )

- (void)goto_mode5:(NSString *)animationID
{
	[self process_Infiltration_Log];

	COMMON_TIMER = 0;
	DRAW_MODE = 5;
	AUTO_TAP_TIMER = 0;
	
	filtration_Alpha = 0.0;
	filtration_Alpha_dist = 0.0;

	glBindFramebuffer(GL_FRAMEBUFFER, FBO_Contents);
	glClear( GL_COLOR_BUFFER_BIT );

	
	[UIView beginAnimations:@"" context:nil];
	[UIView setAnimationDuration:CAPTION_TIME];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(mode5_start:)];
	
	overlay_WhiteView_OBJ.alpha = 0.0;
	overlay_ImageView_OBJ.alpha = 0.0;
	TapExplanation_ImageView.alpha = 1.0;

	[UIView commitAnimations];
}


- (void)mode5_start:(NSString *)animationID
{
	NSLog(@"Infiltration Log animation start");
	filtration_Alpha_dist = 1.0;
	[self enableGUI:YES];
}



- (void)backToNormal_from_mode5
{

	overlay_WhiteView_OBJ.image = [overlay_WhiteView_ARRAY objectAtIndex:0];
	
	[UIView beginAnimations:@"" context:nil];
	[UIView setAnimationDuration:4.0];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(backToNormal_from_mode5_Finish:)];
	
	overlay_WhiteView_OBJ.alpha = 1.0;
	
	[UIView commitAnimations];
}


- (void)backToNormal_from_mode5_Finish:(NSString *)animationID
{
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