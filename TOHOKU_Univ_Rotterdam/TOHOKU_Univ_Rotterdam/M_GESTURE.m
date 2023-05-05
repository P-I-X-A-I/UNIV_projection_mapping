#import "mainController.h"

@implementation mainController (GESTURE)
- (void)gestureTapped:(UITapGestureRecognizer*)GR
{
	AUTO_TAP_TIMER = 0;
	
	float viewWidth = tapArea_View.frame.size.width;
	float viewHeight = tapArea_View.frame.size.height;

	CGPoint tapped_Point = [GR locationInView:tapArea_View];
	float tap_X = tapped_Point.x;
	float tap_Y = tapped_Point.y;
	
	
	
	float convert_X = ( tap_X - (viewWidth*0.5) ) / ( viewWidth*0.5 ) * (viewWidth / viewHeight);
	float convert_Y = -1.0 * ( tap_Y - (viewHeight*0.5) ) / ( viewHeight * 0.5 );

	
	
	
		// limit value range
	
	if( convert_X > RATIO ){ convert_X = RATIO; }
	else if( convert_X < -RATIO ){ convert_X = -RATIO; }
	
	if( convert_Y > 1.0 ){ convert_Y = 1.0; }
	else if( convert_Y < -1.0 ){ convert_Y = -1.0; }

		//	NSLog(@"tap %f %f", convert_X, convert_Y);
	
		// Make waterdrop
	
	for( int i = 0 ; i < NumOf_WD_TAP ; i++ )
		{
		[self makeWaterDrop_X:convert_X Y:convert_Y Color:0.0];
		}
}


- (void)gesturePanned:(UIPanGestureRecognizer*)GR
{
	int i;
	
	AUTO_TAP_TIMER = 0;
	
	float viewWidth = tapArea_View.frame.size.width;
	float viewHeight = tapArea_View.frame.size.height;
	
	CGPoint panned_Point = [GR locationInView:tapArea_View];
	float pan_X = panned_Point.x;
	float pan_Y = panned_Point.y;
	Byte state = GR.state;
	
		//NSLog(@"Pan state %d", state);
	
	float convert_X = ( pan_X - ( viewWidth*0.5 ) ) / (viewWidth *0.5) * (viewWidth / viewHeight );
	float convert_Y = -1.0*( pan_Y - (viewHeight*0.5) ) / ( viewHeight*0.5);

	
	
	
		// limit value range
	if( convert_X > RATIO ){ convert_X = RATIO; }
	else if( convert_X < -RATIO ){ convert_X = -RATIO; }
	
	if( convert_Y > 1.0 ){ convert_Y = 1.0; }
	else if( convert_Y < -1.0 ){ convert_Y = -1.0; }
	
		//		NSLog(@"pan %f %f %d", convert_X, convert_Y, state);
	
	switch ( state ) {
		case 1:
			[self pan_WaterDrop_X:convert_X Y:convert_Y];
			break;
		case 2:
			[self pan_WaterDrop_X:convert_X Y:convert_Y];
			break;
		case 3:
			
			for( i = 0 ; i < NumOf_WD_TAP ; i++ )
				{
				[self makeWaterDrop_X:convert_X Y:convert_Y Color:0.0];
				}// i
			
			break;
		default:
			break;
	}
	
}
@end
