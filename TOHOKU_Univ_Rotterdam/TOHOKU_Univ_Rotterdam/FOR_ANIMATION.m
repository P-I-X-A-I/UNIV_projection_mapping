
#import "mainController.h"

@implementation mainController (FOR_ANIMATION)

- (void)makeWaterDrop_X:(GLfloat)x Y:(GLfloat)y Color:(GLfloat)col
{
	int j;
	
	WD_Center[WD_INDEX][0] = x;
	WD_Center[WD_INDEX][1] = y;
	WD_Center_Vel[WD_INDEX][0] = (random()%200-100)*0.00001;
	WD_Center_Vel[WD_INDEX][1] = (random()%200-100)*0.00001;
	
	WD_Life[WD_INDEX] = random()%1000 * 0.0001 + 0.9;
	double tempValue = sqrt( random()%1000 * 0.001 ) ; // sqrt ( 0.0 ~ 1.0 )
	WD_Flicker[WD_INDEX] = tempValue * 0.1 + 0.9;

	for( j = 0 ; j < 6 ; j++ )
		{
		WD_Vertex[WD_INDEX][j][0] = x;
		WD_Vertex[WD_INDEX][j][1] = y;
		WD_Color[WD_INDEX][j][0] = col;
		}
	
	
	for( j = 0 ; j < 4 ; j++ )
		{
		WD_Corner_vel[WD_INDEX][j][0] = 0.0;
		WD_Corner_vel[WD_INDEX][j][1] = 0.0;
		}
	
	WD_isCalc_Center[WD_INDEX] = YES;
	
		//  INDEX +1 and Check Range
	WD_INDEX++;
	if( WD_INDEX > DROP_NUM-1 )
		{
		WD_INDEX = 0;
		}
	
	isPanned = NO;
}



- (void)pan_WaterDrop_X:(GLfloat)x Y:(GLfloat)y
{
	int j;
	
	WD_Center[WD_INDEX][0] = x;
	WD_Center[WD_INDEX][1] = y;	
	
	WD_Life[WD_INDEX] = 1.0;
	
	if( !isPanned )
		{
		for( j = 0 ; j < 6 ; j++ )
			{
			WD_Vertex[WD_INDEX][j][0] = x;
			WD_Vertex[WD_INDEX][j][1] = y;
			}
		
		
		for( j = 0 ; j < 4 ; j++ )
			{
			WD_Corner_vel[WD_INDEX][j][0] = 0.0;
			WD_Corner_vel[WD_INDEX][j][1] = 0.0;
			}
			
		isPanned = YES;
		}
	
}


- (void)deleteWaterDrop:(int)index
{
	WD_isCalc_Center[index] = NO;
	WD_Life[index] = 0.0;
	
	for( int i = 0 ; i < 6 ; i++ )
		{
		WD_Color[index][i][0] = 1.0;
		}
}
	





@end