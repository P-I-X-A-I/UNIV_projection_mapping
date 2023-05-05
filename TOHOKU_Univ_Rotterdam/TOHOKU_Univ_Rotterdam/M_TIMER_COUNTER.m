#import "mainController.h"

@implementation mainController ( TIMER_COUNTER )

- (void)timerCounter:(NSTimer *)timer
{
	NSDate* date = [NSDate dateWithTimeIntervalSinceNow:[[NSTimeZone systemTimeZone] secondsFromGMT]];
	timerCount++;
		NSLog(@"timer %d %@", timerCount, date );

	
	
	switch ( timerCount ) {
		case 10: // Yotsuya Yosui
				 	[self transition_to:1];
			break;
		
		case 70:	// asphalt 1200
						[self transition_to:2];
			break;
			
			
		case 130: // asphalt overflowy
			[self transition_to:3];
			break;
		
			
		case 160: //RainGarden
				 	[self transition_to:4];
			break;

			
			
		case 220: // Filtration Log
			[self transition_to:5];
			break;
			
			
		case 250:// Filtration Log Raingarden
			[self transition_to:6];
			break;
			
		case 280:
			[self transition_to:7];
			break;
			
		default:
			break;
	}
	
	if( timerCount > 500 )
		{
		timerCount = 0;
		}
}

@end