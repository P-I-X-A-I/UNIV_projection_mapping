#import "mainController.h"

@implementation mainController ( BUTTON_ACTION )

- (IBAction)asphalt_button:(UIButton*)sender
{
	[Asphalt_BUTTON setBackgroundImage:[ButtonIMG_Array objectAtIndex:1] forState:UIControlStateNormal];
	[RainGarden_BUTTON setBackgroundImage:[ButtonIMG_Array objectAtIndex:2] forState:UIControlStateNormal];
	[Yotsuya_BUTTON setBackgroundImage:[ButtonIMG_Array objectAtIndex:4] forState:UIControlStateNormal];
	NSLog(@"Asphalt");
	[self transition_to:1];
	
}

- (IBAction)raingarden:(UIButton*)sender
{
	[Asphalt_BUTTON setBackgroundImage:[ButtonIMG_Array objectAtIndex:0] forState:UIControlStateNormal];
	[RainGarden_BUTTON setBackgroundImage:[ButtonIMG_Array objectAtIndex:3] forState:UIControlStateNormal];
	[Yotsuya_BUTTON setBackgroundImage:[ButtonIMG_Array objectAtIndex:4] forState:UIControlStateNormal];
	NSLog(@"raingarden");
	
	[self transition_to:4];
}

- (IBAction)yotsuya:(UIButton*)sender
{
	[Asphalt_BUTTON setBackgroundImage:[ButtonIMG_Array objectAtIndex:0] forState:UIControlStateNormal];
	[RainGarden_BUTTON setBackgroundImage:[ButtonIMG_Array objectAtIndex:2] forState:UIControlStateNormal];
	[Yotsuya_BUTTON setBackgroundImage:[ButtonIMG_Array objectAtIndex:5] forState:UIControlStateNormal];
	NSLog(@"yotsuya");
	[self transition_to:5];
}

@end