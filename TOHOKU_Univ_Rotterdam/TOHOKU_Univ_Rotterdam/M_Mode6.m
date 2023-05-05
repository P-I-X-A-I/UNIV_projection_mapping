#import "mainController.h"

@implementation mainController ( MODE_6 )

- (void)goto_mode6:(NSString*)animationID
{
	[self process_Infiltration_Log_RG];
	COMMON_TIMER = 0;
	DRAW_MODE = 6;
	AUTO_TAP_TIMER = 0;
	
	filtration_Alpha = 0.0;
	filtration_Alpha_dist = 0.0;
	
	glBindFramebuffer(GL_FRAMEBUFFER, FBO_Contents );
	glClear(GL_COLOR_BUFFER_BIT);
	
	[UIView beginAnimations:@"" context:nil];
	[UIView setAnimationDuration:2.0];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(mode6_start:)];
	
	overlay_ImageView_OBJ.alpha = 0.0;
	overlay_WhiteView_OBJ.alpha = 0.0;
	TapExplanation_ImageView.alpha = 1.0;

	[UIView commitAnimations];
}
- (void)mode6_start:(NSString*)animationID
{
	filtration_Alpha_dist = 1.0;
	[self enableGUI:YES];
}

@end