#import "mainController.h"

@implementation mainController (SCREEN)

- (void)screenConnected:(NSNotification*)notification
{
	if( projector_Window == nil )
		{
		
	
	NSLog(@"SCREEN : connected");
	NSArray* screenArray = [UIScreen screens];
	UIScreen* mainScreen = [UIScreen mainScreen];
	UIScreen* Ext_Screen;
	
		// check which screen is extra screen
	if( [[screenArray objectAtIndex:0] isEqual:mainScreen] )
		{
		Ext_Screen = [screenArray objectAtIndex:1];
		}
	else
		{
		Ext_Screen = [screenArray objectAtIndex:0];
		}
	
	
		// get avairable screenmode
	NSArray* screenMode_Array = Ext_Screen.availableModes;
	
	
		// Select Screen Mode
	UIScreenMode* projector_ScreenMode = nil;
	
	for( int i = 0 ;  i < [screenMode_Array count] ; i++ )
		{
		UIScreenMode* screenMode = [screenMode_Array objectAtIndex:i];
		short screen_width = (short)screenMode.size.width;
		short screen_height = (short)screenMode.size.height;
		
			if( screen_width == 1280 && screen_height == 720 )
			//if( screen_width == 1024 && screen_height == 768 )
			{
			projector_ScreenMode = screenMode;
			break;
			}
		}
	
		// if can't find screen mode
	if( projector_ScreenMode == nil )
		{
		projector_ScreenMode = [screenMode_Array objectAtIndex:2];
		}
	
		NSLog(@"set screenmode of %d %d", (int)projector_ScreenMode.size.width, (int)projector_ScreenMode.size.height );

		
		
		
	
		// set Extra screenmode to selected one
	Ext_Screen.currentMode = projector_ScreenMode;
	
	
	
		// create projector window
		projector_Window = [[UIWindow alloc] init];
		projector_Window.screen = Ext_Screen;
		
		glesView_OBJ = [[glesView alloc] initWithFrame:CGRectMake(0.0, 0.0, projector_ScreenMode.size.width, projector_ScreenMode.size.height)];
		
		[projector_Window addSubview:glesView_OBJ];
		[projector_Window makeKeyAndVisible];
		
		
		
			//Create WhiteOut View
		float frameWidth = projector_Window.frame.size.width;
		float frameHeight = projector_Window.frame.size.height;
		float frameCenter_X = frameWidth * 0.5;
		float frameCenter_Y = frameHeight * 0.5;
		CGRect tempRect = CGRectMake(
									 frameCenter_X - frameWidth*0.5*adjust1450, 
									 frameCenter_Y - frameHeight*0.5*adjust1450, 
									 frameWidth*adjust1450, 
									 frameHeight*adjust1450
									 );
		
		
		overlay_WhiteView_OBJ = [[UIImageView alloc] initWithFrame:tempRect];
		overlay_WhiteView_OBJ.contentMode = UIViewContentModeScaleAspectFit;
		overlay_WhiteView_OBJ.image = nil;
		overlay_WhiteView_OBJ.backgroundColor = [UIColor clearColor];
		overlay_WhiteView_OBJ.alpha = 0.0;
		[projector_Window addSubview:overlay_WhiteView_OBJ];
		
		NSLog(@"temp %@", overlay_WhiteView_OBJ);
		
		[self setOpenGLES];
		
				
		[dispLink_OBJ setPaused:NO];
		} // if projector_window is nil
	
	
	else
		{
		NSLog(@"projector window is already exist");
		}
}





- (void)screenDisconnected:(NSNotification*)notification
{
	NSLog(@"SCREEN : disconnected");
	
	
	[dispLink_OBJ setPaused:YES];
	
	if( glesView_OBJ != nil )
		{
		[glesView_OBJ removeFromSuperview];
		[glesView_OBJ release];
		glesView_OBJ = nil;
		}
	
	if( projector_Window != nil )
		{
		[projector_Window release];
		projector_Window = nil;
		}
	
	glDeleteFramebuffers(1, &FBO_projector);
	glDeleteRenderbuffers(1, &RBO_projector);
	glDeleteFramebuffers(1, &FBO_Contents);
	glDeleteTextures(1, &TEX_Contents);
	glDeleteTextures(1, &TEX_Contents_Depth);
	
	glDeleteProgram(projector_POBJ);
	glDeleteProgram(contents_1_POBJ);
}




- (void)screenModeChanged:(NSNotification*)notification
{
	NSLog(@"SCREEN : mode changed");
}

@end