
#import "mainController.h"

@implementation mainController (DRAW_WD)
- (void)draw_Texture_FBO
{
	int i;
	glViewport(0, 0, TEXTURE_WIDTH, TEXTURE_HEIGHT);
	
		// draw contents
	glClearColor(0.0, 0.0, 0.0, 1.0);
	glClear( GL_DEPTH_BUFFER_BIT );
	
	
		// Set Matrix
	[matrix_OBJ initMatrix];
	[matrix_OBJ lookAt_Ex:0.0 Ey:0.0 Ez:1.0
					   Vx:0.0 Vy:0.0 Vz:0.0
					   Hx:0.0 Hy:1.0 Hz:0.0];
	
	[matrix_OBJ perspective_fovy:90.0
						  aspect:RATIO
							near:0.1
							 far:2.0];
	
	
		// draw baseBoard;
	
	
		// Select BG Texture and Alpha
		/////////////////////////////////////////////////////////////////////////////////////////
	switch ( DRAW_MODE ) {
		case 0:
			glUseProgram(contents_1_POBJ);
			glUniform1i(UNF_contentsTexture, 0 );
			glUniformMatrix4fv(UNF_mvp_Matrix_Contents, 1, GL_FALSE, [matrix_OBJ getMatrix]);
			break;
			
		case 1:
			glUseProgram(rainGarden_POBJ);
			glUniform1i(UNF_RainGarden_Texture, 4 );
			glUniformMatrix4fv(UNF_mvp_Matrix_RainGarden, 1, GL_FALSE, [matrix_OBJ getMatrix]);
			break;
			
		case 2:
			glUseProgram(contents_1_POBJ);
			glUniform1i(UNF_contentsTexture, 0 );
			glUniformMatrix4fv(UNF_mvp_Matrix_Contents, 1, GL_FALSE, [matrix_OBJ getMatrix]);
			break;
			
		case 3:
			glUseProgram(flood_POBJ);
			glUniform1i(UNF_floodTexture, 0 );
			glUniformMatrix4fv(UNF_mvp_Matrix_Flood, 1, GL_FALSE, [matrix_OBJ getMatrix]);
			glUniform1f( UNF_floodAlpha, 0.5*sinf(tapInfo_Counter));
			break;
			
		case 4:
			glUseProgram(rainGarden_POBJ);
			glUniform1i(UNF_RainGarden_Texture, 3 );
			glUniformMatrix4fv(UNF_mvp_Matrix_RainGarden, 1, GL_FALSE, [matrix_OBJ getMatrix]);
			break;
			
		case 5:
			glUseProgram( filt_POBJ );
			glUniform1i( UNF_FiltTexture, 2 );
			glUniform1f( UNF_Filt_Texture_Alpha, filtration_Alpha );
			glUniformMatrix4fv( UNF_mvp_Matrix_Filt, 1, GL_FALSE, [matrix_OBJ getMatrix]); 
			break;
		case 6:
			glUseProgram( filt_POBJ );
			glUniform1i( UNF_FiltTexture, 2 );
			glUniform1f( UNF_Filt_Texture_Alpha, filtration_Alpha );
			glUniformMatrix4fv( UNF_mvp_Matrix_Filt, 1, GL_FALSE, [matrix_OBJ getMatrix]); 
			break;
		default:
			break;
	}
		/////////////////////////////////////////////////////////////////////////////////////////
	
	GLfloat baseBoard_Vertex[4][4];
	GLfloat baseBoard_Color[4][4];
	GLfloat baseBoard_TexCoord[4][2];
	
	GLfloat COLOR = ((float)is_OptionMode)*0.3;
	
	for( i = 0 ; i < 4 ; i++ )
		{
		baseBoard_Vertex[i][2] = 0.0;
		baseBoard_Vertex[i][3] = 1.0;
		
			// Board Alpha
		baseBoard_Color[i][0] = COLOR;
		baseBoard_Color[i][1] = COLOR;
		baseBoard_Color[i][2] = COLOR;
		baseBoard_Color[i][3] = 1.0;
		}
	
	baseBoard_Vertex[0][0] = -RATIO;			baseBoard_Vertex[0][1] = 1.0;
	baseBoard_Vertex[1][0] = -RATIO;			baseBoard_Vertex[1][1] = -1.0;
	baseBoard_Vertex[2][0] = RATIO;			baseBoard_Vertex[2][1] = 1.0;
	baseBoard_Vertex[3][0] = RATIO;			baseBoard_Vertex[3][1] = -1.0;
	
	baseBoard_TexCoord[0][0] = 0.0;	baseBoard_TexCoord[0][1] = 0.0;
	baseBoard_TexCoord[1][0] = 0.0;	baseBoard_TexCoord[1][1] = 1.0;
	baseBoard_TexCoord[2][0] = 1.0;	baseBoard_TexCoord[2][1] = 0.0;
	baseBoard_TexCoord[3][0] = 1.0;	baseBoard_TexCoord[3][1] = 1.0;	
	
	glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, baseBoard_Vertex);
	glVertexAttribPointer(1, 4, GL_FLOAT, GL_FALSE, 0, baseBoard_Color);
	glVertexAttribPointer(2, 2, GL_FLOAT, GL_FALSE, 0, baseBoard_TexCoord);
	
	glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
	
	
	
	
	
	
	
	
	
	
	
	
	
		// draw Mizubune
	if( DRAW_MODE == 4 )
		{
	
	glUseProgram( mizubune_POBJ );
	glUniformMatrix4fv(UNF_mvp_Matrix_mizubune, 1, GL_FALSE, [matrix_OBJ getMatrix]);

		
	GLfloat Mizubune_Vertex[164][20][4];
	GLfloat Mizubune_Color[164][20][4];
		
		glLineWidth( 2.0 );

	for( i = 0 ; i < 164 ; i++ )
		{
		
		
//		for(int K = 0 ; K < 19 ; K++ )
//			{
//			Mizubune_Vertex[i][K][0] = Mizubune_XY[i][0] + Mizubune_Radian_Table[K][0] * Mizubune_Add[i];
//			Mizubune_Vertex[i][K][1] = Mizubune_XY[i][1] + Mizubune_Radian_Table[K][1] * Mizubune_Add[i];
//			Mizubune_Vertex[i][K][2] = 0.001;
//			Mizubune_Vertex[i][K][3] = 1.0;
//			
//			Mizubune_Color[i][K][0] = 0.0;
//			Mizubune_Color[i][K][1] = 1.0;
//			Mizubune_Color[i][K][2] = 1.0;
//			Mizubune_Color[i][K][3] = 1.0;
//			}
		
		Mizubune_Add[i] *= 0.99;
		
//		glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, &Mizubune_Vertex[i][0][0] );
//		glVertexAttribPointer(1, 4, GL_FLOAT, GL_FALSE, 0, &Mizubune_Color[i][0][0] );
//		
//		glDrawArrays(GL_LINE_STRIP, 0, 19 );
		
		} // i
		
		
		
		
		
		
		glLineWidth( 2.0 );

		float SCALE_VALUE;
		float ALPHA_VALUE;
		
		
		for( i = 0 ; i < 164 ; i++ )
			{

			if( Mizubune_Radian[i] < M_PI_2 )
				{
				SCALE_VALUE = sinf(Mizubune_Radian[i])*(Mizubune_Add[i])*1.25;
				ALPHA_VALUE = Mizubune_Add[i];
				}
			else
				{
				SCALE_VALUE = Mizubune_Add[i]*1.25;
				ALPHA_VALUE = pow( sinf(Mizubune_Radian[i])*Mizubune_Add[i], 2.0 );
				}
			
			
			
			
			Mizubune_Radian[i] += 0.02*(Mizubune_Add[i]*0.4 + 0.6);
			if(Mizubune_Radian[i] > M_PI )
				{ Mizubune_Radian[i] = 0.0;}
			
			
			Mizubune_Vertex[i][0][0] = Mizubune_XY[i][0];
			Mizubune_Vertex[i][0][1] = Mizubune_XY[i][1];
			Mizubune_Vertex[i][0][2] = 0.001;
			Mizubune_Vertex[i][0][3] = 1.0;
			
			Mizubune_Color[i][0][0] = 0.75;
			Mizubune_Color[i][0][1] = 1.0;
			Mizubune_Color[i][0][2] = 1.0;
			Mizubune_Color[i][0][3] = ALPHA_VALUE * 0.15;
			
			for(int K = 1 ; K < 20 ; K++ )
				{
				Mizubune_Vertex[i][K][0] = Mizubune_XY[i][0] + Mizubune_Radian_Table[K-1][0] * SCALE_VALUE;
				Mizubune_Vertex[i][K][1] = Mizubune_XY[i][1] + Mizubune_Radian_Table[K-1][1] * SCALE_VALUE;
				Mizubune_Vertex[i][K][2] = 0.001;
				Mizubune_Vertex[i][K][3] = 1.0;
				
				Mizubune_Color[i][K][0] = 0.5;
				Mizubune_Color[i][K][1] = 1.0;
				Mizubune_Color[i][K][2] = 1.0;
				Mizubune_Color[i][K][3] = ALPHA_VALUE * 0.15;
				}
			
			glVertexAttribPointer( 0, 4, GL_FLOAT, GL_FALSE, 0, &Mizubune_Vertex[i][0][0] );
			glVertexAttribPointer( 1, 4, GL_FLOAT, GL_FALSE, 0, &Mizubune_Color[i][0][0] );
			glDrawArrays( GL_TRIANGLE_FAN, 0, 20 );
			
			
			
			for( int K = 1 ; K < 20 ; K++ )
				{
				Mizubune_Color[i][K][3] = ALPHA_VALUE;
				}
			
			
			glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, &Mizubune_Vertex[i][1][0] );
			glVertexAttribPointer(1, 4, GL_FLOAT, GL_FALSE, 0, &Mizubune_Color[i][1][0] );
			
			glDrawArrays(GL_LINE_STRIP, 0, 19 );
						
			} // i 2nd


		} // DRAW MODE = 4
	
	
	
	
//	if( DRAW_MODE == 3)
//		{
//			// Overflow Alert area
//		
//		GLfloat Alert_V[4][4];
//		GLfloat Alert_C[4][4];
//			
//		for( i = 0 ; i < 4 ; i++ )
//			{
//			Alert_V[i][2] = 0.0;
//			Alert_V[i][3] = 1.0;
//			
//			Alert_C[i][0] = 1.0;
//			Alert_C[i][1] = 0.0;
//			Alert_C[i][2] = 0.0;
//			Alert_C[i][3] = 0.25*sinf(tapInfo_Counter);
//			}
//
//		
//		Alert_V[0][0] = 0.2;	Alert_V[0][1] = 0.7;
//		Alert_V[1][0] = 0.2;	Alert_V[1][1] = 0.5;
//		Alert_V[2][0] = 0.5;	Alert_V[2][1] = 0.7;
//		Alert_V[3][0] = 0.5;	Alert_V[3][1] = 0.5;
//		
//		
//		glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, Alert_V);
//		glVertexAttribPointer(1, 4, GL_FLOAT, GL_FALSE, 0, Alert_C );
//		
//		glDrawArrays(GL_TRIANGLE_STRIP, 0, 4 );
//
//		
//		}// if Drawmode 3   Alert Area
	
	
	
	
	
	
	
		///// select draw mode
		/////////////////////////////////////////////////////////////////////////////////////////

	
	switch (DRAW_MODE) {
		case 0:
			[self draw_WaterDrop];
			break;
			
			
			
				//////////////////////////////////////////// Yotsuya 1000
		case 1: 
			[self draw_WaterDrop];
			break;
			
			
			
				////////////////////////////////////////////  asphalt 1000
		case 2:	
			[self draw_WaterDrop];
			break;
			
			
			
			
			
				//////////////////////////////////////////// asphalt 2000
		case 3:
			[self draw_WaterDrop];
			break;
			
			
			
			
			
				////////////////////////////////////////////  raingarden
		case 4:
			[self draw_WaterDrop];
			break;
			
			
			
			
			
			
				////////////////////////////////////////////  filtration		
		case 5:
			[self draw_WaterDrop];
			filtration_Alpha += ( filtration_Alpha_dist - filtration_Alpha )*0.02;
			break;
			
			
				////////////////////////////////////////////  filtration		
		case 6:
			[self draw_WaterDrop];
			filtration_Alpha += ( filtration_Alpha_dist - filtration_Alpha )*0.02;
			break;
			
			
		default:
			break;
	}
		/////////////////////////////////////////////////////////////////////////////////////////
	
	glFlush();

}




- (void)draw_WaterDrop
{
	int i;
	
	glUseProgram( waterdrop_POBJ );
	glUniformMatrix4fv(UNF_mvp_Matrix_waterdrop, 1, GL_FALSE, [matrix_OBJ getMatrix] );
	glUniform1i(UNF_waterdropTexture, 1);
	
	
	for( i = 0 ; i < DROP_NUM ; i++ )
		{
		
		GLfloat corner[4][2];
		GLfloat DropSize = WD_Size[i]*WD_Life[i];
		
		corner[0][0] = WD_Center[i][0] - DropSize;
		corner[0][1] = WD_Center[i][1] + DropSize;
		
		corner[1][0] = WD_Center[i][0] - DropSize;
		corner[1][1] = WD_Center[i][1] - DropSize;
		
		corner[2][0] = WD_Center[i][0] + DropSize;
		corner[2][1] = WD_Center[i][1] + DropSize;
		
		corner[3][0] = WD_Center[i][0] + DropSize;
		corner[3][1] = WD_Center[i][1] - DropSize;
		
			// calculate waterdrop corner
		for( int j = 0 ; j < 4 ; j++ )
			{
			WD_Corner_vel[i][j][0] = WD_Corner_vel[i][j][0]*0.9 + ( corner[j][0] - WD_Vertex[i][j+1][0] ) * 0.2;
			WD_Corner_vel[i][j][1] = WD_Corner_vel[i][j][1]*0.9 + ( corner[j][1] - WD_Vertex[i][j+1][1] ) * 0.2;
			
			WD_Vertex[i][j+1][0] += WD_Corner_vel[i][j][0];
			WD_Vertex[i][j+1][1] += WD_Corner_vel[i][j][1];
			}
		
		WD_Vertex[i][0][0] = WD_Vertex[i][1][0];
		WD_Vertex[i][0][1] = WD_Vertex[i][1][1];
		WD_Vertex[i][5][0] = WD_Vertex[i][4][0];
		WD_Vertex[i][5][1] = WD_Vertex[i][4][1];

		
		
		
			// Calculate Center point
		if( WD_isCalc_Center[i] )
			{
				// convert [WD_Center] -> [HEIGHT MAP point]
			short X_INDEX = (short)(( WD_Center[i][0] + RATIO ) * (TEXTURE_HEIGHT/2) ) + 20;
			short Y_INDEX = (short)( (-WD_Center[i][1] + 1.0 ) *(TEXTURE_HEIGHT/2) ) + 20;
			
			
			Byte RIVER_VALUE[3];
			float VELOCITY_VALUE[2];
			float VelocityWeight, FrictionWeight;
			
			switch (DRAW_MODE) {
				case 0:// normal
					RIVER_VALUE[0] = RIVER_MAP[X_INDEX][Y_INDEX][0];
					RIVER_VALUE[1] = RIVER_MAP[X_INDEX][Y_INDEX][1];
					RIVER_VALUE[2] = RIVER_MAP[X_INDEX][Y_INDEX][2];
					VELOCITY_VALUE[0] = VELOCITY_MAP[X_INDEX][Y_INDEX][0];
					VELOCITY_VALUE[1] = VELOCITY_MAP[X_INDEX][Y_INDEX][1];
					VelocityWeight = 1.0;
					FrictionWeight = 1.0;
					break;
					
				case 1:// yotsuya
					RIVER_VALUE[0] = RIVER_MAP_YOTSUYA[X_INDEX][Y_INDEX][0];
					RIVER_VALUE[1] = RIVER_MAP_YOTSUYA[X_INDEX][Y_INDEX][1];
					RIVER_VALUE[2] = RIVER_MAP_YOTSUYA[X_INDEX][Y_INDEX][2];
					VELOCITY_VALUE[0] = VELOCITY_MAP_YOTSUYA[X_INDEX][Y_INDEX][0];
					VELOCITY_VALUE[1] = VELOCITY_MAP_YOTSUYA[X_INDEX][Y_INDEX][1];
					VelocityWeight = 1.0;
					FrictionWeight = 1.0;
					break;
					
				case 2://asphalt 1000
					RIVER_VALUE[0] = RIVER_MAP[X_INDEX][Y_INDEX][0];
					RIVER_VALUE[1] = RIVER_MAP[X_INDEX][Y_INDEX][1];
					RIVER_VALUE[2] = RIVER_MAP[X_INDEX][Y_INDEX][2];
					VELOCITY_VALUE[0] = VELOCITY_MAP[X_INDEX][Y_INDEX][0];
					VELOCITY_VALUE[1] = VELOCITY_MAP[X_INDEX][Y_INDEX][1];
					VelocityWeight = 1.0;
					FrictionWeight = 1.0;
					break;
					
				case 3: //  asphalt 2000 
					RIVER_VALUE[0] = RIVER_MAP[X_INDEX][Y_INDEX][0];
					RIVER_VALUE[1] = RIVER_MAP[X_INDEX][Y_INDEX][1];
					RIVER_VALUE[2] = RIVER_MAP[X_INDEX][Y_INDEX][2];
					VELOCITY_VALUE[0] = VELOCITY_MAP_OVERFLOW[X_INDEX][Y_INDEX][0];
					VELOCITY_VALUE[1] = VELOCITY_MAP_OVERFLOW[X_INDEX][Y_INDEX][1];
					VelocityWeight = 1.0;
					FrictionWeight = 1.0;
					break;
					
				case 4: // RainGarden
					RIVER_VALUE[0] = RIVER_MAP[X_INDEX][Y_INDEX][0];
					RIVER_VALUE[1] = RIVER_MAP[X_INDEX][Y_INDEX][1];
					RIVER_VALUE[2] = RIVER_MAP[X_INDEX][Y_INDEX][2];
					VELOCITY_VALUE[0] = VELOCITY_MAP[X_INDEX][Y_INDEX][0];
					VELOCITY_VALUE[1] = VELOCITY_MAP[X_INDEX][Y_INDEX][1];
					VelocityWeight = RAIN_GARDEN_MAP[X_INDEX][Y_INDEX][0];
					FrictionWeight = RAIN_GARDEN_MAP[X_INDEX][Y_INDEX][0];
					
					if( RAIN_GARDEN_INDEX[X_INDEX][Y_INDEX] != 255 )
						{
						Mizubune_Add[RAIN_GARDEN_INDEX[X_INDEX][Y_INDEX] -1] += 0.001;
						
						if( Mizubune_Add[RAIN_GARDEN_INDEX[X_INDEX][Y_INDEX] -1] > 1.0 )
							{
							Mizubune_Add[RAIN_GARDEN_INDEX[X_INDEX][Y_INDEX] -1] = 1.0;
							}
						}
					
					
					break;
					
				case 5: // filtration
					RIVER_VALUE[0] = RIVER_MAP[X_INDEX][Y_INDEX][0];
					RIVER_VALUE[1] = RIVER_MAP[X_INDEX][Y_INDEX][1];
					RIVER_VALUE[2] = RIVER_MAP[X_INDEX][Y_INDEX][2];
					VELOCITY_VALUE[0] = VELOCITY_MAP[X_INDEX][Y_INDEX][0];
					VELOCITY_VALUE[1] = VELOCITY_MAP[X_INDEX][Y_INDEX][1];
					VelocityWeight = 1.0;
					FrictionWeight = 1.0;
					break;
					
				case 6: // filtration
					RIVER_VALUE[0] = RIVER_MAP[X_INDEX][Y_INDEX][0];
					RIVER_VALUE[1] = RIVER_MAP[X_INDEX][Y_INDEX][1];
					RIVER_VALUE[2] = RIVER_MAP[X_INDEX][Y_INDEX][2];
					VELOCITY_VALUE[0] = VELOCITY_MAP[X_INDEX][Y_INDEX][0];
					VELOCITY_VALUE[1] = VELOCITY_MAP[X_INDEX][Y_INDEX][1];
					VelocityWeight = RAIN_GARDEN_MAP[X_INDEX][Y_INDEX][0];
					FrictionWeight = RAIN_GARDEN_MAP[X_INDEX][Y_INDEX][0];
					
					if( RAIN_GARDEN_INDEX[X_INDEX][Y_INDEX] != 255 )
						{
						Mizubune_Add[RAIN_GARDEN_INDEX[X_INDEX][Y_INDEX] -1] += 0.001;
						
						if( Mizubune_Add[RAIN_GARDEN_INDEX[X_INDEX][Y_INDEX] -1] > 1.0 )
							{
							Mizubune_Add[RAIN_GARDEN_INDEX[X_INDEX][Y_INDEX] -1] = 1.0;
							}
						}
					break;
				default:
					break;
			}
			
			float velocity_X = VELOCITY_VALUE[0];
			float velocity_Y = VELOCITY_VALUE[1];

			
		
			
			
			
			
				// Calculate River flow
			
			GLfloat river_X; 
			GLfloat river_Y;
			
			GLfloat  friction = RIVER_VALUE[2] * 0.00392156862745 * 0.285 * WD_Flicker[i] + 0.7; // min max = 0.25 - 0.99 * Flicker
			friction *= FrictionWeight;
			
			GLfloat infiltrate_value = 0.0005;
			
			float river_Weight_1_0;
			float river_Weight_0_1;
			
			switch ( DRAW_MODE ) {
				case 3:
					river_X = ( RIVER_VALUE[0] - 128) * 0.00001; //   -0.005 ~ 0.005
					river_Y = ( RIVER_VALUE[1] - 128) * 0.00001; //  -0.005 ~ 0.005
					river_Weight_0_1 = RIVER_VALUE[2] * 0.00392156862745 * 0.4 + 0.6;
					river_Weight_1_0 = (255-RIVER_VALUE[2]) * 0.00392156862745; // on river 1.0 - out river 0.0break;
					break;
					
				default:
					river_X = ( RIVER_VALUE[0] - 128) * 0.00001; //   -0.005 ~ 0.005
					river_Y = ( RIVER_VALUE[1] - 128) * 0.00001; //  -0.005 ~ 0.005
					river_Weight_0_1 = RIVER_VALUE[2] * 0.00392156862745 * 0.8 + 0.2; // on river 0.2 - out river 1.0
					river_Weight_1_0 = (255-RIVER_VALUE[2]) * 0.00392156862745; // on river 1.0 - out river 0.0
					break;
			}
			
				velocity_X *= river_Weight_0_1;			velocity_X += (river_X)*river_Weight_1_0;
				velocity_Y *= river_Weight_0_1;			velocity_Y += (river_Y)*river_Weight_1_0;
			
			
			
			WD_Center_Vel[i][0] = WD_Center_Vel[i][0]*friction + velocity_X;
			WD_Center_Vel[i][1] = WD_Center_Vel[i][1]*friction + velocity_Y;
			
			WD_Center[i][0] += WD_Center_Vel[i][0]*VelocityWeight;
			WD_Center[i][1] += WD_Center_Vel[i][1]*VelocityWeight;
			
			
			
			
			
			
			
				////// Increment, Decriment
				// Life
			WD_Life[i] -=(infiltrate_value);
			
				// Infiltrate log
			short F_INDEX_X = X_INDEX/2;
			short F_INDEX_Y = Y_INDEX/2;
			
			double Trace_4 = 0.015;
			double Trace_2 = 0.0075;
			double Trace_1 = 0.0025;
			
			
			switch ( DRAW_MODE ) {
				case 2: // asphalt
					INFILTRATION_LOG[F_INDEX_X-1][F_INDEX_Y-1] += Trace_1;
					INFILTRATION_LOG[F_INDEX_X][F_INDEX_Y-1] += Trace_2;
					INFILTRATION_LOG[F_INDEX_X+1][F_INDEX_Y-1] +=Trace_1;
					
					INFILTRATION_LOG[F_INDEX_X-1][F_INDEX_Y] += Trace_2;
					INFILTRATION_LOG[F_INDEX_X][F_INDEX_Y] += Trace_4;
					INFILTRATION_LOG[F_INDEX_X+1][F_INDEX_Y] += Trace_2;
					
					INFILTRATION_LOG[F_INDEX_X-1][F_INDEX_Y+1] += Trace_1;
					INFILTRATION_LOG[F_INDEX_X][F_INDEX_Y+1] += Trace_2;
					INFILTRATION_LOG[F_INDEX_X+1][F_INDEX_Y+1] += Trace_1;
					break;
				
				case 4: // RainGarden
					INFILTRATION_LOG_RG[F_INDEX_X-1][F_INDEX_Y-1] += Trace_1;
					INFILTRATION_LOG_RG[F_INDEX_X][F_INDEX_Y-1] += Trace_2;
					INFILTRATION_LOG_RG[F_INDEX_X+1][F_INDEX_Y-1] +=Trace_1;
					
					INFILTRATION_LOG_RG[F_INDEX_X-1][F_INDEX_Y] += Trace_2;
					INFILTRATION_LOG_RG[F_INDEX_X][F_INDEX_Y] += Trace_4;
					INFILTRATION_LOG_RG[F_INDEX_X+1][F_INDEX_Y] += Trace_2;
					
					INFILTRATION_LOG_RG[F_INDEX_X-1][F_INDEX_Y+1] += Trace_1;
					INFILTRATION_LOG_RG[F_INDEX_X][F_INDEX_Y+1] += Trace_2;
					INFILTRATION_LOG_RG[F_INDEX_X+1][F_INDEX_Y+1] += Trace_1;
					break;
					
				default:
					break;
			}
			
			
			
				//// delete WaterDrap
				// kill WaterDrop by range
			if(WD_Center[i][0] > RATIO + 0.005 || WD_Center[i][0] < -RATIO-0.005 )
				{
				[self deleteWaterDrop:i];
				}
			
			if( WD_Center[i][1] > 1.005 || WD_Center[i][1] < -1.005 )
				{
				[self deleteWaterDrop:i];
				}
			
			
			if( WD_Life[i] < 0.0 )
				{
				[self deleteWaterDrop:i];
				}
			
			} // isCalc Centerpoint
		
		}// iter
	
	glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, WD_Vertex);
	glVertexAttribPointer(1, 4, GL_FLOAT, GL_FALSE, 0, WD_Color );
	glVertexAttribPointer(2, 2, GL_FLOAT, GL_FALSE, 0, WD_TexCoord );
	
	glDrawArrays(GL_TRIANGLE_STRIP, 0, DROP_NUM*6 );

}
@end