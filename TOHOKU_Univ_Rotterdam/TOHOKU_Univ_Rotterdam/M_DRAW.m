
#import "mainController.h"

@implementation mainController (DRAW)
- (void)draw:(CADisplayLink *)dispLink
{	
		// set FBO to texture FBO
	glBindFramebuffer(GL_FRAMEBUFFER, FBO_Contents);
	
	
	
		//// Draw to Texture FBO
	
	[self draw_Texture_FBO];
	
	
//	AUTO_TAP_TIMER++;
//	if( AUTO_TAP_TIMER > 10000 )
//		{
//		if( AUTO_TAP_TIMER%3 == 0 )
//			{
//			float randomX = (random()%2000 - 1000)*0.001*RATIO;
//			float randomY = ( random()%2000 - 1000 )*0.001;
//			[self makeWaterDrop_X:randomX Y:randomY Color:1.0];
//			}
//			
//		if( AUTO_TAP_TIMER > 15000 )
//			{
//			AUTO_TAP_TIMER = 0;
//			}
//		}
	
	
	
	
	
		// set FBO to projector FBO
	glBindFramebuffer(GL_FRAMEBUFFER, FBO_projector );
	glUseProgram(projector_POBJ);
	glViewport(0, 0, (int)glesView_OBJ.frame.size.width, (int)glesView_OBJ.frame.size.height );
	
	glClearColor(0.0, 0.0, 0.0, 1.0);
	glClear( GL_COLOR_BUFFER_BIT );
	
	
		// draw projector Board
	float aspect = (glesView_OBJ.frame.size.width / glesView_OBJ.frame.size.height);
	float HeadY;
	if( is_Rotate ){ HeadY = -1.0; }
	else{ HeadY = 1.0; }
	
	
	[matrix_OBJ initMatrix];
	[matrix_OBJ lookAt_Ex:0.0 Ey:0.0 Ez:1.0
					   Vx:0.0 Vy:0.0 Vz:0.0
					   Hx:0.0 Hy:HeadY Hz:0.0];
	
	[matrix_OBJ perspective_fovy:90.0
						  aspect:aspect
							near:0.1 
							 far:4.0];
	
	glUniformMatrix4fv(UNF_mvp_Matrix, 1, GL_FALSE, [matrix_OBJ getMatrix] );
	glUniform1i(UNF_TEXTURE_CONTENTS, 6);
	
	GLfloat board_Vertex[4][4];
	GLfloat board_Color[4][4];
	GLfloat board_TexCoord[4][2];
	
	
	for( int i = 0 ; i < 4 ; i++ )
		{
		board_Vertex[i][2] = 0.0;
		board_Vertex[i][3] = 1.0 / ScaleValue;
		
		board_Color[i][0] = board_Color[i][1] = board_Color[i][2] = 0.0;
		board_Color[i][3] = 1.0;
		}
	
	float inverse_RATIO = 1.0 / RATIO;
	
	board_Vertex[0][0] = -aspect*adjust1450*Scale_X_Value;		board_Vertex[0][1] = aspect*inverse_RATIO;	
	board_Vertex[1][0] = -aspect*adjust1450*Scale_X_Value;		board_Vertex[1][1] = -aspect*inverse_RATIO;
	board_Vertex[2][0] = aspect*adjust1450*Scale_X_Value;		board_Vertex[2][1] = aspect*inverse_RATIO;
	board_Vertex[3][0] = aspect*adjust1450*Scale_X_Value;		board_Vertex[3][1] = -aspect*inverse_RATIO;

	board_TexCoord[0][0] = 0.0;	board_TexCoord[0][1] = 1.0;
	board_TexCoord[1][0] = 0.0;	board_TexCoord[1][1] = 0.0;
	board_TexCoord[2][0] = adjust1450;	board_TexCoord[2][1] = 1.0;
	board_TexCoord[3][0] = adjust1450;	board_TexCoord[3][1] = 0.0;
	
	
	
	glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, board_Vertex );
	glVertexAttribPointer(1, 4, GL_FLOAT, GL_FALSE, 0, board_Color );
	glVertexAttribPointer(2, 2, GL_FLOAT, GL_FALSE, 0, board_TexCoord );
	
	glDrawArrays( GL_TRIANGLE_STRIP, 0, 4);
	
	
	
	
	
		//////// Draw Information
	glUniform1i(UNF_TEXTURE_CONTENTS, 5);
	
	GLfloat infoBoard_V[4][4];
	GLfloat infoBoard_C[4][4];
	GLfloat infoBoard_T[4][2];
	
	GLfloat INFO_SCALE = 1.0;
	GLfloat Dokomade_Tukauka = 0.9;
	GLfloat sizeX = 1.0 * INFO_SCALE * Dokomade_Tukauka;
	GLfloat sizeY = 1.0 / 32.0 * INFO_SCALE;
	GLfloat Base = -aspect*inverse_RATIO + 0.07*INFO_SCALE*6;
	
	for( int K = 0 ; K <6 ; K++ )
		{
	
		GLfloat info_Alpha;
		
		if((K+1) == DRAW_MODE )
			{
			info_Alpha = 0.75;
			}
		else {
			info_Alpha = 0.15;
		}
		
	for( int i = 0 ; i < 4 ; i++ )
		{
		infoBoard_V[i][2] = 0.01;
		infoBoard_V[i][3] = 1.0 / ScaleValue;
		
		infoBoard_C[i][0] = 0.0;
		infoBoard_C[i][1] = 0.0;
		infoBoard_C[i][2] = 0.0;
		infoBoard_C[i][3] = info_Alpha;
		}
	
	infoBoard_V[0][0] = aspect*adjust1450*Scale_X_Value-sizeX;		infoBoard_V[0][1] = Base - K*0.07*INFO_SCALE + sizeY;
	infoBoard_V[1][0] = aspect*adjust1450*Scale_X_Value-sizeX;		infoBoard_V[1][1] =Base - K*0.07*INFO_SCALE - sizeY;
	infoBoard_V[2][0] = aspect*adjust1450*Scale_X_Value;				infoBoard_V[2][1] =Base - K*0.07*INFO_SCALE + sizeY;
	infoBoard_V[3][0] = aspect*adjust1450*Scale_X_Value;				infoBoard_V[3][1] =Base - K*0.07*INFO_SCALE - sizeY;

	infoBoard_T[0][0] = 0.0;		infoBoard_T[0][1] = K*(1.0/16.0);
	infoBoard_T[1][0] = 0.0;		infoBoard_T[1][1] = (K+1)*(1.0/16.0);
	infoBoard_T[2][0] = Dokomade_Tukauka;		infoBoard_T[2][1] = K*(1.0/16.0);
	infoBoard_T[3][0] = Dokomade_Tukauka;		infoBoard_T[3][1] = (K+1)*(1.0/16.0);
	
		
		if(DRAW_MODE != 0)
			{
			glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, infoBoard_V);
			glVertexAttribPointer(1, 4, GL_FLOAT, GL_FALSE, 0, infoBoard_C);
			glVertexAttribPointer(2, 2, GL_FLOAT, GL_FALSE, 0, infoBoard_T);
	
			glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
			}
		}// K
		
	
		// Please Tap Info
	
	GLfloat TapInfo_V[4][4];
	GLfloat TapInfo_C[4][4];
	GLfloat TapInfo_T[4][2];

	for( int i = 0 ; i < 4 ; i++ )
		{
		TapInfo_V[i][2] = 0.0;
		TapInfo_V[i][3] = 1.0 / ScaleValue;
		
		TapInfo_C[i][0] = TapInfo_C[i][1] = TapInfo_C[i][2] = 0.0;
		TapInfo_C[i][3] = 0.75*sinf(tapInfo_Counter);
		}
	
	TapInfo_V[0][0] = aspect*adjust1450*Scale_X_Value - INFO_SCALE*Dokomade_Tukauka;			TapInfo_V[0][1] = aspect*inverse_RATIO-0.1;
	TapInfo_V[1][0] = aspect*adjust1450*Scale_X_Value - INFO_SCALE*Dokomade_Tukauka;			TapInfo_V[1][1] = aspect*inverse_RATIO-0.1 - INFO_SCALE/16.0;
	TapInfo_V[2][0] = aspect*adjust1450*Scale_X_Value;					TapInfo_V[2][1] =  aspect*inverse_RATIO-0.1;
	TapInfo_V[3][0] = aspect*adjust1450*Scale_X_Value;					TapInfo_V[3][1] = aspect*inverse_RATIO-0.1 - INFO_SCALE/16.0;
	
	TapInfo_T[0][0] = 0.0;		TapInfo_T[0][1] = (1.0 / 16.0) * 6;
	TapInfo_T[1][0] = 0.0;		TapInfo_T[1][1] = (1.0 / 16.0) * 7;
	TapInfo_T[2][0] = Dokomade_Tukauka;		TapInfo_T[2][1] = (1.0 / 16.0) * 6;
	TapInfo_T[3][0] = Dokomade_Tukauka;		TapInfo_T[3][1] = (1.0 / 16.0) * 7;
	
	
	if( DRAW_MODE == 1 || DRAW_MODE == 2 || DRAW_MODE == 4 || DRAW_MODE == 5 || DRAW_MODE == 6 )
		{
		glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, TapInfo_V);
		glVertexAttribPointer(1, 4, GL_FLOAT, GL_FALSE, 0, TapInfo_C);
		glVertexAttribPointer(2, 2, GL_FLOAT, GL_FALSE, 0, TapInfo_T);
	
		glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
		}
	
	
	
	tapInfo_Counter += 0.01;
	if(tapInfo_Counter > M_PI )
		{
		tapInfo_Counter -= M_PI;
		}
	
	
	
	
	
	
	
	
	
	
	if( is_OptionMode )
		{
		glUniform1i(UNF_TEXTURE_CONTENTS, 1); // Waterdrop texture
		
		float Alphabet[7][4];
		float Alphabet_Color[7][4];
		float Alphabet_Texcoord[7][2];
		
		for(int i = 0 ; i < 7 ; i++ )
			{
			Alphabet[i][2] = 0.001;
			Alphabet[i][3] = 1.0 / ScaleValue;
			
			Alphabet_Color[i][0] = 0.0;
			Alphabet_Color[i][1] = 0.0;
			Alphabet_Color[i][2] = 0.0;
			Alphabet_Color[i][3] = 1.0;
			
			Alphabet_Texcoord[i][0] = 0.5;
			Alphabet_Texcoord[i][1] = 0.5;
			}
		
			// N
		Alphabet[0][0] = -0.05;	Alphabet[0][1] = 0.55;
		Alphabet[1][0] = -0.05;	Alphabet[1][1] = 0.65;
		Alphabet[2][0] = 0.05;	Alphabet[2][1] = 0.55;
		Alphabet[3][0] = 0.05;	Alphabet[3][1] = 0.65;
		
		glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, Alphabet  );
		glVertexAttribPointer(1, 4, GL_FLOAT, GL_FALSE, 0, Alphabet_Color );
		glVertexAttribPointer(2, 2, GL_FLOAT, GL_FALSE, 0, Alphabet_Texcoord );
		glDrawArrays(GL_LINE_STRIP, 0, 4 );
		
		
		
			// S
		Alphabet[0][0] = 0.05;		Alphabet[0][1] = -0.55;
		Alphabet[1][0] = -0.05;		Alphabet[1][1] = -0.55;
		Alphabet[2][0] = -0.05;		Alphabet[2][1] = -0.6;
		Alphabet[3][0] = 0.05;		Alphabet[3][1] = -0.6;
		Alphabet[4][0] = 0.05;		Alphabet[4][1] = -0.65;
		Alphabet[5][0] = -0.05;		Alphabet[5][1] = -0.65;
		
		glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, Alphabet );
		glDrawArrays( GL_LINE_STRIP, 0, 6);
		
		
			// E
		Alphabet[0][0] = 1.1;		Alphabet[0][1] = 0.05;
		Alphabet[1][0] = 1.0;		Alphabet[1][1] = 0.05;
		Alphabet[2][0] = 1.0;		Alphabet[2][1] = 0.0;
		Alphabet[3][0] = 1.1;		Alphabet[3][1] = 0.0;
		Alphabet[4][0] = 1.0;		Alphabet[4][1] = 0.0;
		Alphabet[5][0] = 1.0;		Alphabet[5][1] = -0.05;
		Alphabet[6][0] = 1.1;		Alphabet[6][1] = -0.05;
		
		glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, Alphabet );
		glDrawArrays( GL_LINE_STRIP, 0, 7 );
		
		
		
			// W
		Alphabet[0][0] = -1.0;		Alphabet[0][1] = 0.05;
		Alphabet[1][0] = -1.025;		Alphabet[1][1] = -0.05;
		Alphabet[2][0] = -1.05;		Alphabet[2][1] = 0.05;
		Alphabet[3][0] = -1.075;		Alphabet[3][1] = -0.05;
		Alphabet[4][0] = -1.1;		Alphabet[4][1] = 0.05;
		
		glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 0, Alphabet );
		glDrawArrays(GL_LINE_STRIP, 0, 5 );
		}
	
	
		// present renderbuffer
	[context_OBJ presentRenderbuffer:GL_RENDERBUFFER];

}
@end