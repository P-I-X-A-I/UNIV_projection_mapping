
#import "mainController.h"

@implementation mainController ( MODE_7 )

- (void)goto_mode7:(NSString *)animationID
{
	
	COMMON_TIMER = 0;
	DRAW_MODE = 0;
	AUTO_TAP_TIMER = 0;
	
	
	glBindFramebuffer(GL_FRAMEBUFFER, FBO_Contents);
	glClear( GL_COLOR_BUFFER_BIT );
	
	
	
	[UIView beginAnimations:@"" context:nil];
	[UIView setAnimationDuration:4.0];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(caption_1_start:)];
	
	overlay_WhiteView_OBJ.alpha = 0.0;
	overlay_ImageView_OBJ.alpha = 0.0;
	
	[UIView commitAnimations];
	

}


- (void)caption_1_start:(NSString*)animationID
{
	NSLog(@"caption 1 start");
	overlay_WhiteView_OBJ.image = [overlay_WhiteView_ARRAY objectAtIndex:8];
	overlay_ImageView_OBJ.image = [overlay_ImageView_ARRAY objectAtIndex:8];
	
	[UIView beginAnimations:@"" context:nil];
	[UIView setAnimationDuration:4.0];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(timer_1)];
	
	overlay_WhiteView_OBJ.alpha = 1.0;
	overlay_ImageView_OBJ.alpha = 0.75;
	
	[UIView commitAnimations];

}

- (void)timer_1
{
	NSLog(@"timer 1");
	NSTimer* tempTimer = [NSTimer scheduledTimerWithTimeInterval:12.0
														  target:self 
														selector:@selector(caption_1_end:)
														userInfo:nil
														 repeats:NO];
}

- (void)caption_1_end:(NSString*)animationID
{
	[UIView beginAnimations:@"" context:nil];
	[UIView setAnimationDuration:4.0];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(caption_2_start:)];
	
	overlay_WhiteView_OBJ.alpha = 0.0;
	overlay_ImageView_OBJ.alpha = 0.0;
	
	[UIView commitAnimations];

}
- (void)caption_2_start:(NSString*)animationID
{
	overlay_WhiteView_OBJ.image = [overlay_WhiteView_ARRAY objectAtIndex:9];
	overlay_ImageView_OBJ.image = [overlay_ImageView_ARRAY objectAtIndex:9];
	
	[UIView beginAnimations:@"" context:nil];
	[UIView setAnimationDuration:4.0];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(timer_2)];
	
	overlay_WhiteView_OBJ.alpha = 1.0;
	overlay_ImageView_OBJ.alpha = 0.75;
	
	[UIView commitAnimations];

}

- (void)timer_2
{
	NSTimer* tempTimer = [NSTimer scheduledTimerWithTimeInterval:8.0
														  target:self 
														selector:@selector(caption_2_end:)
														userInfo:nil
														 repeats:NO];

}

- (void)caption_2_end:(NSString*)animationID
{
	[UIView beginAnimations:@"" context:nil];
	[UIView setAnimationDuration:4.0];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(caption_3_start:)];
	
	overlay_WhiteView_OBJ.alpha = 0.0;
	overlay_ImageView_OBJ.alpha = 0.0;
	
	[UIView commitAnimations];

}
- (void)caption_3_start:(NSString*)animationID
{
	overlay_WhiteView_OBJ.image = [overlay_WhiteView_ARRAY objectAtIndex:10];
	overlay_ImageView_OBJ.image = [overlay_ImageView_ARRAY objectAtIndex:10];
	
	[UIView beginAnimations:@"" context:nil];
	[UIView setAnimationDuration:4.0];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(timer_3)];
	
	overlay_WhiteView_OBJ.alpha = 1.0;
	overlay_ImageView_OBJ.alpha = 0.75;
	
	[UIView commitAnimations];
	

}

- (void)timer_3
{
	NSTimer* tempTimer = [NSTimer scheduledTimerWithTimeInterval:8.0
														  target:self 
														selector:@selector(caption_3_end:)
														userInfo:nil
														 repeats:NO];
	
}


- (void)caption_3_end:(NSString*)animationID
{
	[UIView beginAnimations:@"" context:nil];
	[UIView setAnimationDuration:4.0];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(caption_4_start:)];
	
	overlay_WhiteView_OBJ.alpha = 0.0;
	overlay_ImageView_OBJ.alpha = 0.0;
	
	[UIView commitAnimations];
	

}
- (void)caption_4_start:(NSString*)animationID
{
	overlay_WhiteView_OBJ.image = [overlay_WhiteView_ARRAY objectAtIndex:11];
	overlay_ImageView_OBJ.image = [overlay_ImageView_ARRAY objectAtIndex:11];
	
	[UIView beginAnimations:@"" context:nil];
	[UIView setAnimationDuration:4.0];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(timer_4)];
	
	overlay_WhiteView_OBJ.alpha = 1.0;
	overlay_ImageView_OBJ.alpha = 0.75;
	
	[UIView commitAnimations];
	

}
- (void)timer_4
{
	NSTimer* tempTimer = [NSTimer scheduledTimerWithTimeInterval:8.0
														  target:self 
														selector:@selector(caption_4_end:)
														userInfo:nil
														 repeats:NO];
	
}

- (void)caption_4_end:(NSString*)animationID
{
	[UIView beginAnimations:@"" context:nil];
	[UIView setAnimationDuration:4.0];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(caption_5_start:)];
	
	overlay_WhiteView_OBJ.alpha = 0.0;
	overlay_ImageView_OBJ.alpha = 0.0;
	
	[UIView commitAnimations];
	

}


- (void)caption_5_start:(NSString*)animationID
{
	overlay_WhiteView_OBJ.image = [overlay_WhiteView_ARRAY objectAtIndex:12];
	overlay_ImageView_OBJ.image = [overlay_ImageView_ARRAY objectAtIndex:12];
	
	[UIView beginAnimations:@"" context:nil];
	[UIView setAnimationDuration:4.0];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(timer_5)];
	
	overlay_WhiteView_OBJ.alpha = 1.0;
	overlay_ImageView_OBJ.alpha = 0.75;
	
	[UIView commitAnimations];
	
	
}
- (void)timer_5
{
	NSTimer* tempTimer = [NSTimer scheduledTimerWithTimeInterval:8.0
														  target:self 
														selector:@selector(caption_5_end:)
														userInfo:nil
														 repeats:NO];
	
}

- (void)caption_5_end:(NSString*)animationID
{
	[UIView beginAnimations:@"" context:nil];
	[UIView setAnimationDuration:4.0];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(caption_6_start:)];
	
	overlay_WhiteView_OBJ.alpha = 0.0;
	overlay_ImageView_OBJ.alpha = 0.0;
	
	[UIView commitAnimations];
	
	
}




- (void)caption_6_start:(NSString*)animationID
{
	timerCount = 5;
}
@end