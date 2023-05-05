//
//  mainController.m
//  TOHOKU_Univ_Rotterdam
//
//  Created by 圭介 渡辺 on 12/02/07.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "mainController.h"

@implementation mainController

- ( id )init
{
	self = [super init];
	
	NSLog(@"mainController init");
	
	NSNotificationCenter* Ncenter = [NSNotificationCenter defaultCenter];
	[Ncenter addObserver:self
				selector:@selector(appLaunchFinished:)
					name:@"appLaunchFinished"
				  object:nil];

	[Ncenter addObserver:self
				selector:@selector(appEnterForeground:)
					name:@"appEnterForeground"
				  object:nil];

	[Ncenter addObserver:self
				selector:@selector(appEnterBackground:)
					name:@"appEnterBackground"
				  object:nil];

	dispLink_OBJ = [CADisplayLink displayLinkWithTarget:self selector:@selector(draw:)];
	[dispLink_OBJ setFrameInterval:1];
	[dispLink_OBJ addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
	[dispLink_OBJ setPaused:YES];

	matrix_OBJ = [[matrixClass alloc] init];
	
	RATIO = (float)TEXTURE_WIDTH / (float)TEXTURE_HEIGHT;
	
	[self initVariables];
	
	return self;
}


- (void)appLaunchFinished:(NSNotification*)notification
{
	
	Scale_Label.hidden = YES;
	Scale_Slider.hidden = YES;
	Scale_X_Label.hidden = YES;
	Scale_X_Slider.hidden = YES;
	Rotate_Label.hidden = YES;
	Rotate_Switch.hidden = YES;
	Exit_Button.hidden = YES;
	Num_WD_Label.hidden = YES;
	Num_WD_Slider.hidden = YES;
	
	NSLog(@"App Launch Finished (from AppDelegate) ");

	int gestureView_Height = 980 * ( 1.0 / RATIO );
	NSLog(@"gestureView height %d", gestureView_Height );
	
	viewController.view.frame = CGRectMake(0, 0, 1024, 768);
		//tapArea_View.frame = CGRectMake(22, (384 - gestureView_Height/2), 980, gestureView_Height);
	mainWindow.rootViewController = viewController;
	
	
		// Set Gesture Recognizer
	Tap_GR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureTapped:)];
	Pan_GR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gesturePanned:)];
	
	Pan_GR.maximumNumberOfTouches = 1;
	[tapArea_View addGestureRecognizer:Tap_GR];
	[tapArea_View addGestureRecognizer:Pan_GR];
	
	
		// set Screen delegate & method
	NSNotificationCenter* Ncenter = [NSNotificationCenter defaultCenter];
	
	[Ncenter addObserver:self
				selector:@selector(screenConnected:)
					name:UIScreenDidConnectNotification
				  object:nil];
	
	[Ncenter addObserver:self
				selector:@selector(screenDisconnected:)
					name:UIScreenDidDisconnectNotification
				  object:nil];
	
	[Ncenter addObserver:self
				selector:@selector(screenModeChanged:)
					name:UIScreenModeDidChangeNotification
				  object:nil];
	
	
	projector_Window = nil;
	glesView_OBJ = nil;
	
	overlay_ImageView_ARRAY = [[NSMutableArray alloc] init];
	overlay_WhiteView_ARRAY = [[NSMutableArray alloc] init];
	ButtonIMG_Array = [[NSMutableArray alloc] init];
	
	[overlay_ImageView_ARRAY addObject:[UIImage imageNamed:@"mode0"]];//0
	[overlay_ImageView_ARRAY addObject:[UIImage imageNamed:@"mode1"]];//1
	[overlay_ImageView_ARRAY addObject:[UIImage imageNamed:@"mode2"]];//2
	[overlay_ImageView_ARRAY addObject:[UIImage imageNamed:@"mode3"]];//3
	[overlay_ImageView_ARRAY addObject:[UIImage imageNamed:@"mode4"]];//4
	[overlay_ImageView_ARRAY addObject:[UIImage imageNamed:@"mode5"]];//5
	[overlay_ImageView_ARRAY addObject:[UIImage imageNamed:@"mode6"]];//6
	[overlay_ImageView_ARRAY addObject:[UIImage imageNamed:@"mode7"]];//7
	[overlay_ImageView_ARRAY addObject:[UIImage imageNamed:@"mode8"]];//8
	[overlay_ImageView_ARRAY addObject:[UIImage imageNamed:@"mode9"]];//9
	[overlay_ImageView_ARRAY addObject:[UIImage imageNamed:@"mode10"]];//10
	[overlay_ImageView_ARRAY addObject:[UIImage imageNamed:@"mode11"]];//11
	[overlay_ImageView_ARRAY addObject:[UIImage imageNamed:@"mode12"]];//11

	[overlay_WhiteView_ARRAY addObject:[UIImage imageNamed:@"mode0_projector"]];
	[overlay_WhiteView_ARRAY addObject:[UIImage imageNamed:@"mode1_projector"]];
	[overlay_WhiteView_ARRAY addObject:[UIImage imageNamed:@"mode2_projector"]];
	[overlay_WhiteView_ARRAY addObject:[UIImage imageNamed:@"mode3_projector"]];
	[overlay_WhiteView_ARRAY addObject:[UIImage imageNamed:@"mode4_projector"]];
	[overlay_WhiteView_ARRAY addObject:[UIImage imageNamed:@"mode5_projector"]];
	[overlay_WhiteView_ARRAY addObject:[UIImage imageNamed:@"mode6_projector"]];
	[overlay_WhiteView_ARRAY addObject:[UIImage imageNamed:@"mode7_projector"]];
	[overlay_WhiteView_ARRAY addObject:[UIImage imageNamed:@"mode8_projector"]];
	[overlay_WhiteView_ARRAY addObject:[UIImage imageNamed:@"mode9_projector"]];
	[overlay_WhiteView_ARRAY addObject:[UIImage imageNamed:@"mode10_projector"]];
	[overlay_WhiteView_ARRAY addObject:[UIImage imageNamed:@"mode11_projector"]];
	[overlay_WhiteView_ARRAY addObject:[UIImage imageNamed:@"mode12_projector"]];
	
	overlay_ImageView_OBJ.alpha = 0.0;
	
	NSLog(@"A%@", [overlay_ImageView_ARRAY objectAtIndex:0]);
	NSLog(@"B%@", [overlay_ImageView_ARRAY objectAtIndex:1]);
	NSLog(@"C%@", [overlay_WhiteView_ARRAY objectAtIndex:0]);
	NSLog(@"D%@", [overlay_WhiteView_ARRAY objectAtIndex:1]);
	
	[ButtonIMG_Array addObject:[UIImage imageNamed:@"BUTTON_Asphalt_off"]];
	[ButtonIMG_Array addObject:[UIImage imageNamed:@"BUTTON_Asphalt_on"]];
	[ButtonIMG_Array addObject:[UIImage imageNamed:@"BUTTON_RG_off"]];
	[ButtonIMG_Array addObject:[UIImage imageNamed:@"BUTTON_RG_on"]];
	[ButtonIMG_Array addObject:[UIImage imageNamed:@"BUTTON_Yotsuya_off"]];
	[ButtonIMG_Array addObject:[UIImage imageNamed:@"BUTTON_Yotsuya_on"]];
	
	
	TapExplanation_ImageView.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"tapHands_1"],
												[UIImage imageNamed:@"tapHands_2"],
												nil];
	TapExplanation_ImageView.animationDuration = 1.0;
	[TapExplanation_ImageView startAnimating];
	
		// if screen is not one, check and create projector_window;	
	NSArray* screenArray = [UIScreen screens];
	if( [screenArray count ] != 1 )
		{
		[self screenConnected:nil];
		}
	
}





- (void)appEnterForeground:(NSNotification*)notification
{
	[dispLink_OBJ setPaused:NO];
	timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerCounter:) userInfo:nil repeats:YES];
	[[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
	
}
- (void)appEnterBackground:(NSNotification*)notification
{
	[dispLink_OBJ setPaused:YES];
	[timer invalidate];
}


- (IBAction)LU:(UIButton*)sender
{
	isLU_Pressed = YES;
}

- (IBAction)LB:(UIButton*)sender
{
	
	if( isLU_Pressed )
		{
		isLB_Pressed = YES;
		}
	else
		{
		isLU_Pressed = NO;
		isLB_Pressed = NO;
		isRU_Pressed = NO;
		isRB_Pressed = NO;
		}
}
- (IBAction)RB:(UIButton*)sender
{
	if( isLU_Pressed && isLB_Pressed )
		{
		isRB_Pressed = YES;
		}
	else
		{
		isLU_Pressed = NO;
		isLB_Pressed = NO;
		isRU_Pressed = NO;
		isRB_Pressed = NO;
		}
}
- (IBAction)RU:(UIButton*)sender
{
	if( isLU_Pressed && isLB_Pressed && isRB_Pressed )
		{
		NSLog(@"success");
		[self enterOption];
		isLU_Pressed = NO;
		isLB_Pressed = NO;
		isRU_Pressed = NO;
		isRB_Pressed = NO;
		}
	else
		{
		isLU_Pressed = NO;
		isLB_Pressed = NO;
		isRU_Pressed = NO;
		isRB_Pressed = NO;
		}
}


- (void)enterOption
{
	overlay_ImageView_OBJ.image = [UIImage imageNamed:@"NEWS"];
	overlay_ImageView_OBJ.alpha = 0.5;
	
	is_OptionMode = YES;
	
	Scale_Label.hidden = NO;
	Scale_Slider.hidden = NO;
	Scale_X_Label.hidden = NO;
	Scale_X_Slider.hidden = NO;
	Rotate_Label.hidden = NO;
	Rotate_Switch.hidden = NO;
	Exit_Button.hidden = NO;
	Num_WD_Label.hidden = NO;
	Num_WD_Slider.hidden = NO;
}


- (IBAction)scaleSlider:(UISlider*)sender
{
	NSLog(@"slider %f", sender.value );
	ScaleValue = sender.value;

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
		}
}

- (IBAction)scale_X_Slider:(UISlider*)sender
{
	Scale_X_Value = sender.value;
}


- (IBAction)numOf_WD:(UISlider*)sender
{
	int NUM = (int)sender.value;
	Num_WD_Label.text = [NSString stringWithFormat:@"WD:%d", NUM];
	NumOf_WD_TAP = NUM;
}



- (IBAction)rotateSwitch:(UISwitch*)sender
{
	NSLog(@"rotate %d", sender.on );
	is_Rotate = sender.on;
	
	if( projector_Window != nil )
		{
		
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
}

- (IBAction)Exit:(UIButton*)sender
{
	[self saveData];
	
	overlay_ImageView_OBJ.image = nil;
	overlay_ImageView_OBJ.alpha = 0.0;
	
	is_OptionMode = NO;
	
	Scale_Slider.hidden = YES;
	Scale_Label.hidden = YES;
	Scale_X_Label.hidden = YES;
	Scale_X_Slider.hidden = YES;
	Rotate_Switch.hidden = YES;
	Rotate_Label.hidden = YES;
	Exit_Button.hidden = YES;
	Num_WD_Slider.hidden = YES;
	Num_WD_Label.hidden = YES;
}



@end
