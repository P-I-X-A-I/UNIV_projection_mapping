#import "mainController.h"


@implementation mainController ( MODE_3 )

- (void)goto_mode3:(NSString *)animationID
{
	NSLog(@"goto mode3");
		//PREVIOUS_MODE = DRAW_MODE;
	COMMON_TIMER = 0;
	DRAW_MODE = 3;
	AUTO_TAP_TIMER = 0;

	
	glBindFramebuffer(GL_FRAMEBUFFER, FBO_Contents);
	glClear( GL_COLOR_BUFFER_BIT );

	

	[UIView beginAnimations:@"" context:nil];
	[UIView setAnimationDuration:CAPTION_TIME];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(infiltrationLog_Animation_Start:)];
	
	overlay_WhiteView_OBJ.alpha = 0.0;
	overlay_ImageView_OBJ.alpha = 0.0;
		//TapExplanation_ImageView.alpha = 1.0;

	[UIView commitAnimations];

}


- (void)infiltrationLog_Animation_Start:(NSString*)animationID
{
	int i;
	for( i = 0 ; i < DROP_NUM ; i++ )
		{
		float random_X = (random()%200-100)*0.01*RATIO;
		float random_Y = (random()%200-100)*0.01;
		[self makeWaterDrop_X:random_X Y:random_Y Color:1.0];
		}
	
	[self enableGUI:NO];
}




- (void)backToNormal_from_mode3
{
	int i;
	for( i = 0 ; i < DROP_NUM ; i++ )
		{
		[self deleteWaterDrop:i];
		}

	overlay_WhiteView_OBJ.image = [overlay_WhiteView_ARRAY objectAtIndex:0];
	
	[UIView beginAnimations:@"" context:nil];
	[UIView setAnimationDuration:4.0];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector( backToNormal_from_mode3_Finish: )];

	overlay_WhiteView_OBJ.alpha = 1.0;
	
	[UIView commitAnimations];
}




- (void)backToNormal_from_mode3_Finish:(NSString*)animationID
{
	COMMON_TIMER = 0;
	AUTO_TAP_TIMER = 0;
		//DRAW_MODE = PREVIOUS_MODE;
	
	

	[self enableGUI:YES];
	
	
	[UIView beginAnimations:@"" context:nil];
	[UIView setAnimationDuration:4.0];
	
	overlay_WhiteView_OBJ.alpha = 0.0;
	overlay_ImageView_OBJ.alpha = 0.0;
	
	[UIView commitAnimations];
}

@end