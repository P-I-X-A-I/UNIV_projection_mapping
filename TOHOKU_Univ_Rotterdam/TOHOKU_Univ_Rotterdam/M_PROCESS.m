
#import "mainController.h"

@implementation mainController ( IMAGE_PROCESSING )

- (void)process_Infiltration_Log
{
	int i, j;
	int A, B;
	
	double attenuation = 0.9;
	
	double ProcessValue[25];
	
	for( i = 0 ; i < TEXTURE_WIDTH/2 + 20 ; i++ )
		{
		for( j = 0 ; j < TEXTURE_HEIGHT/2 + 20 ; j++ )
			{
			INFILTRATION_LOG[i][j] = MIN(INFILTRATION_LOG[i][j], 255.0 );
			
			INFILTRATION_COPY[i][j] = INFILTRATION_LOG[i][j];
			}
		}
	
	for( i = 10 ; i < TEXTURE_WIDTH/2 + 10 ; i++ )
		{
		for( j = 10 ; j < TEXTURE_HEIGHT/2+10 ; j++ )
			{
			
			for( A = -2 ; A <=2 ; A++ )
				{
				for( B = -2 ; B <=2 ; B++ )
					{
					int index = (B+2) + (A+2)*5;
					
					ProcessValue[index] = INFILTRATION_COPY[i+A][j+B] * attenuation * kernel[index];
					}
				}
			
			double processSum = 0.0;
			
			for( A = 0 ; A < 25 ; A++ )
				{
				processSum += ProcessValue[A];
				}

			INFILTRATION_LOG[i][j] = processSum;
			}
		}
	
	
		// Update Texture
	for( int W = 0 ; W < TEXTURE_WIDTH/2 ; W++ )
		{
		for( int H = 0 ; H < TEXTURE_HEIGHT/2 ; H++ )
			{
			GLubyte value = (GLubyte)INFILTRATION_LOG[W+10][H+10];
				// Cyan
			INFILTRATION_TEXTURE[H][W][0] = value;
			INFILTRATION_TEXTURE[H][W][1] = value*0.5;
			INFILTRATION_TEXTURE[H][W][2] = value*0.5;
			INFILTRATION_TEXTURE[H][W][3] = 255;
			}
		}
		
	glActiveTexture( GL_TEXTURE2 );
		glBindTexture( GL_TEXTURE_2D, TEX_infiltrateLog );

		glTexSubImage2D(
						GL_TEXTURE_2D, 
						0, 
						0, 
						0, 
						TEXTURE_WIDTH/2, 
						TEXTURE_HEIGHT/2, 
						GL_RGBA, 
						GL_UNSIGNED_BYTE, 
						INFILTRATION_TEXTURE
						);
	
	
	
		//saveImage_COUNTER_ASPHALT++;
	
	if( NO )
		//if( saveImage_COUNTER_ASPHALT == 5)
		{
		saveImage_COUNTER_ASPHALT = 0;
	CFDataRef dataRef = CFDataCreate(NULL, (const UInt8*)INFILTRATION_TEXTURE, sizeof(INFILTRATION_TEXTURE));
	CGDataProviderRef dataProviderRef = CGDataProviderCreateWithCFData( dataRef );
	CGImageRef imageRef = CGImageCreate(
										TEXTURE_WIDTH/2, 
										TEXTURE_HEIGHT/2, 
										8, 
										32, 
										(TEXTURE_WIDTH/2)*4, 
										CGColorSpaceCreateDeviceRGB(),
										kCGBitmapByteOrderDefault, 
										dataProviderRef, 
										nil, 
										FALSE, 
										kCGRenderingIntentDefault
										);
	
	
	UIImage* image = [UIImage imageWithCGImage:imageRef];
	NSLog(@"%@", image );
	UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil );
	
	CGImageRelease( imageRef );
	CGDataProviderRelease( dataProviderRef );
	CFRelease(dataRef );
		}
	
}



- (void)process_Infiltration_Log_RG
{
	int i, j;
	int A, B;
	
	double attenuation = 0.9;
	
	double ProcessValue[25];
	
	for( i = 0 ; i < TEXTURE_WIDTH/2 + 20 ; i++ )
		{
		for( j = 0 ; j < TEXTURE_HEIGHT/2 + 20 ; j++ )
			{
			INFILTRATION_LOG_RG[i][j] = MIN(INFILTRATION_LOG_RG[i][j], 255.0 );
			
			INFILTRATION_COPY[i][j] = INFILTRATION_LOG_RG[i][j];
			}
		}
	
	for( i = 10 ; i < TEXTURE_WIDTH/2 + 10 ; i++ )
		{
		for( j = 10 ; j < TEXTURE_HEIGHT/2+10 ; j++ )
			{
			
			for( A = -2 ; A <=2 ; A++ )
				{
				for( B = -2 ; B <=2 ; B++ )
					{
					int index = (B+2) + (A+2)*5;
					
					ProcessValue[index] = INFILTRATION_COPY[i+A][j+B] * attenuation * kernel[index];
					}
				}
			
			double processSum = 0.0;
			
			for( A = 0 ; A < 25 ; A++ )
				{
				processSum += ProcessValue[A];
				}
			
			INFILTRATION_LOG_RG[i][j] = processSum;
			}
		}
	
	
		// Update Texture
	for( int W = 0 ; W < TEXTURE_WIDTH/2 ; W++ )
		{
		for( int H = 0 ; H < TEXTURE_HEIGHT/2 ; H++ )
			{
			GLubyte value = (GLubyte)INFILTRATION_LOG_RG[W+10][H+10];
				// Cyan
			INFILTRATION_TEXTURE[H][W][0] = value*0.5;
			INFILTRATION_TEXTURE[H][W][1] = value;
			INFILTRATION_TEXTURE[H][W][2] = value;
			INFILTRATION_TEXTURE[H][W][3] = 255;
			}
		}
	
	glActiveTexture( GL_TEXTURE2 );
	glBindTexture( GL_TEXTURE_2D, TEX_infiltrateLog );
	
	glTexSubImage2D(
					GL_TEXTURE_2D, 
					0, 
					0, 
					0, 
					TEXTURE_WIDTH/2, 
					TEXTURE_HEIGHT/2, 
					GL_RGBA, 
					GL_UNSIGNED_BYTE, 
					INFILTRATION_TEXTURE
					);
	
		//saveImage_COUNTER_RG++;
	
		//if(saveImage_COUNTER_RG == 50 )
	if( NO )	
	{
		saveImage_COUNTER_RG = 0;
	CFDataRef dataRef = CFDataCreate(NULL, (const UInt8*)INFILTRATION_TEXTURE, sizeof(INFILTRATION_TEXTURE));
	CGDataProviderRef dataProviderRef = CGDataProviderCreateWithCFData( dataRef );
	CGImageRef imageRef = CGImageCreate(
										TEXTURE_WIDTH/2, 
										TEXTURE_HEIGHT/2, 
										8, 
										32, 
										(TEXTURE_WIDTH/2)*4, 
										CGColorSpaceCreateDeviceRGB(),
										kCGBitmapByteOrderDefault, 
										dataProviderRef, 
										nil, 
										FALSE, 
										kCGRenderingIntentDefault
										);
	
	
	UIImage* image = [UIImage imageWithCGImage:imageRef];
	NSLog(@"%@", image );
	UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil );
	
	CGImageRelease( imageRef );
	CGDataProviderRelease( dataProviderRef );
	CFRelease(dataRef );
	
		}

}

@end