#import "mainController.h"

@implementation mainController (READ_SAVED )

- (void)loadData
{
	int i;
	NSLog(@"LOAD");
	
	NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
	ScaleValue = [defs doubleForKey:@"ScaleValue"];
	if(ScaleValue < 0.5 || ScaleValue > 1.0 )
		{
		ScaleValue = 1.0;
		}
	
	Scale_X_Value = [defs doubleForKey:@"Scale_X_Value"];
	if( Scale_X_Value < 0.95 || Scale_X_Value > 1.05 )
		{
		Scale_X_Value = 1.0;
		}
	
	
	NumOf_WD_TAP = [defs integerForKey:@"NumOf_WD_TAP"];
	if( NumOf_WD_TAP < 1 || NumOf_WD_TAP > 10 )
		{
		NumOf_WD_TAP = 1;
		}
	
	
	is_Rotate = [defs boolForKey:@"is_Rotate"];
	
	NSArray* loadPathArray = NSSearchPathForDirectoriesInDomains(
																 NSDocumentDirectory, 
																 NSUserDomainMask, 
																 YES
																 );
	
	NSString* loadPath;
	NSData* loadData;
	
	
		// check is load data Exist
	for( i = 0 ; i < [loadPathArray count] ; i++ )
		{
		loadPath = [NSString stringWithFormat:@"%@/saveData.sav", [loadPathArray objectAtIndex:i]];
		loadData = [NSData dataWithContentsOfFile:loadPath];
		
		if( loadData != nil )
			{
			NSLog(@"load data is Exist");
			break;
			}
		else
			{
			NSLog(@"loadable data isn't Exist at path : %@", loadPath );
			}
		}
	
	
	if( loadData != nil )
		{
		
		NSKeyedUnarchiver* unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:loadData];
			//NSUInteger DECODE_LENGTH;
			//int iter;
		
		
		
		
		
			// FILTRATION LOG
//		const uint8_t* INFILTERATION_decodePtr = [unArchiver decodeBytesForKey:@"INFILTRATION_LOG" returnedLength:&DECODE_LENGTH];
//		
//		double* INFILTERATION_Copy = (double*)malloc( sizeof( INFILTRATION_LOG ) );
//		double* INFILTERATION_Free = INFILTERATION_Copy;
//		double* INFILTERATION_Assign = &INFILTRATION_LOG[0][0];
//		iter = sizeof(INFILTRATION_LOG) / sizeof(double);
//		
//		memcpy(INFILTERATION_Copy, INFILTERATION_decodePtr, DECODE_LENGTH );
//		
//		for( i = 0 ; i < iter ; i++ )
//			{
//			*INFILTERATION_Assign = (*INFILTERATION_Copy)*0.5;
//			INFILTERATION_Copy++;
//			INFILTERATION_Assign++;
//			}
//		
//		free(INFILTERATION_Free);
		
		
		
		
		[unArchiver finishDecoding];
		[unArchiver release];
		}// loadData != nil
}




- (void)saveData
{
	NSLog(@"SAVE");
	
	NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
	[defs setInteger:1 forKey:@"isLaunched"];
	[defs setDouble:ScaleValue forKey:@"ScaleValue"];
	[defs setDouble:Scale_X_Value forKey:@"Scale_X_Value"];
	[defs setBool:is_Rotate forKey:@"is_Rotate"];
	[defs setInteger:NumOf_WD_TAP forKey:@"NumOf_WD_TAP"];
	
	NSArray* savePathArray = NSSearchPathForDirectoriesInDomains(
																 NSDocumentDirectory, 
																 NSUserDomainMask, 
																 YES
																 );
	
	NSString* savePath = [NSString stringWithFormat:@"%@/saveData.sav", [savePathArray objectAtIndex:0]];
	NSMutableData* saveData = [NSMutableData dataWithLength:0];
	NSKeyedArchiver* archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:saveData];
	
	
	
		// FILTRATION LOG
//	[archiver encodeBytes:(const uint8_t*)&INFILTRATION_LOG[0][0]
//				   length:(NSUInteger)sizeof(INFILTRATION_LOG)
//				   forKey:@"INFILTRATION_LOG"];
	
	[archiver finishEncoding];
	[archiver release];
	
	BOOL result = [saveData writeToFile:savePath atomically:YES];
	NSLog(@" save : %d", result );
}


@end