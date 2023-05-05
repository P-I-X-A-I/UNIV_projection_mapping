#import "mainController.h"


@implementation mainController ( GLES )

- (void)setOpenGLES
{
	NSLog(@"set openGLES ");
	
		// Create Context
	context_OBJ = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
	[EAGLContext setCurrentContext:context_OBJ];
	
	
	
		// Set OpenGLES status
	glEnable(GL_BLEND);
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
	glLineWidth( 2.0 );
	
	glEnableVertexAttribArray(0); // vertex
	glEnableVertexAttribArray(1); //color
	glEnableVertexAttribArray(2); //normal
	glEnableVertexAttribArray(3);// and so on
	glEnableVertexAttribArray(4);
	glEnableVertexAttribArray(5);
	glEnableVertexAttribArray(6);
	glEnableVertexAttribArray(7);

	
	
	
	
		// Set Layer Property
	CAEAGLLayer* eaglLayer = (CAEAGLLayer*)glesView_OBJ.layer;
	eaglLayer.opaque = TRUE;
	eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
									[NSNumber numberWithBool:FALSE], kEAGLDrawablePropertyRetainedBacking,
									kEAGLColorFormatRGBA8,
									kEAGLDrawablePropertyColorFormat,
									nil];
	
	
	[self createShader];
	[self createFBO];
	[self createTexture];
}


- (void)createShader
{
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	
		// read Projector Shader
	NSString* shaderPath;
	
	
		///////// PROJECTOR SHADER //////////////////////////////
	shaderPath = [[NSBundle mainBundle] pathForResource:@"projector" ofType:@"vfsh"];
	
		// read, create shader object
	[self readShader:shaderPath
		vertexShader:&projector_VS_OBJ
		  fragShader:&projector_FS_OBJ
			 progObj:&projector_POBJ];
	
		// bind attrib location
	glBindAttribLocation( projector_POBJ, 0, "position" );
	glBindAttribLocation( projector_POBJ, 1, "color" );
	glBindAttribLocation( projector_POBJ, 2, "texCoord");
	
		// Link Program
	[self linkProgram:&projector_POBJ];
	
	
		// Get Uniform Location
	UNF_mvp_Matrix = glGetUniformLocation( projector_POBJ, "mvp_Matrix");
	NSLog(@"UNF_mvp_Matrix %d", UNF_mvp_Matrix);
	
	UNF_TEXTURE_CONTENTS = glGetUniformLocation( projector_POBJ, "TEXTURE_CONTENTS");
	NSLog(@"UNF_TEXTURE_CONTENTS %d", UNF_TEXTURE_CONTENTS );
	
	
		// validate  and delete shader
	[self validateProgram_vertexShader:&projector_VS_OBJ fragShader:&projector_FS_OBJ progObject:&projector_POBJ];
	
		///////// PROJECTOR SHADER //////////////////////////////
	
	
		//////// CONTENTS SHADER ////////////////////////////////
	shaderPath = [[NSBundle mainBundle] pathForResource:@"contents" ofType:@"vfsh"];
	
		// read create shader object
	[self readShader:shaderPath
		vertexShader:&contents_1_VS_OBJ
		  fragShader:&contents_1_FS_OBJ
			 progObj:&contents_1_POBJ];
	
	
		// bind attrib location
	glBindAttribLocation( contents_1_POBJ, 0, "position");
	glBindAttribLocation( contents_1_POBJ, 1, "color");
	glBindAttribLocation( contents_1_POBJ, 2, "texCoord");
	
		// link Program
	[self linkProgram:&contents_1_POBJ];
	
		// Get Uniform Location
	UNF_mvp_Matrix_Contents = glGetUniformLocation(contents_1_POBJ, "mvp_Matrix_Contents");
	NSLog(@"UNF_mvp_Matrix_Contents %d", UNF_mvp_Matrix_Contents );
	UNF_contentsTexture = glGetUniformLocation( contents_1_POBJ, "contentsTexture");
	NSLog(@"UNF_contentsTexture %d", UNF_contentsTexture );
	
		// validate and delete shader
	[self validateProgram_vertexShader:&contents_1_VS_OBJ fragShader:&contents_1_FS_OBJ progObject:&contents_1_POBJ];
	
		//////// CONTENTS SHADER ////////////////////////////////

	
	
	
	
	
		//////// FILTRATION SHADER ////////////////////////////////
	shaderPath = [[NSBundle mainBundle] pathForResource:@"filtration" ofType:@"vfsh"];
	
		// read Create shader object
	[self readShader:shaderPath
		vertexShader:&filt_VS_OBJ
		  fragShader:&filt_FS_OBJ
			 progObj:&filt_POBJ];
	
	glBindAttribLocation(filt_POBJ, 0, "position" );
	glBindAttribLocation(filt_POBJ, 1, "color" );
	glBindAttribLocation(filt_POBJ, 2, "texCoord");
	
	[self linkProgram:&filt_POBJ];
	
	UNF_mvp_Matrix_Filt = glGetUniformLocation( filt_POBJ, "mvp_Matrix_Filt");
	UNF_FiltTexture = glGetUniformLocation( filt_POBJ, "filtrationTexture");
	UNF_Filt_Texture_Alpha = glGetUniformLocation( filt_POBJ, "textureAlpha");
	
	NSLog(@"UNF_mvp_Matrix_Filt %d", UNF_mvp_Matrix_Filt );
	NSLog(@"UNF_FiltTexture %d", UNF_FiltTexture );
	NSLog(@"UNF_Filt_Texture_Alpha %d", UNF_Filt_Texture_Alpha );
	
	[self validateProgram_vertexShader:&filt_VS_OBJ fragShader:&filt_FS_OBJ progObject:&filt_POBJ];
	
		//////// FILTRATION SHADER ////////////////////////////////

	
	
	
	
		//////// RAIN GARDEN SHADER ////////////////////////////////
	shaderPath = [[NSBundle mainBundle] pathForResource:@"rainGarden" ofType:@"vfsh"];
	
	[self readShader:shaderPath
		vertexShader:&rainGarden_VS_OBJ
		  fragShader:&rainGarden_FS_OBJ
			 progObj:&rainGarden_POBJ];
	
	glBindAttribLocation( rainGarden_POBJ, 0, "position");
	glBindAttribLocation( rainGarden_POBJ, 1, "color");
	glBindAttribLocation( rainGarden_POBJ, 2, "texCoord");
	
	[self linkProgram:&rainGarden_POBJ];
	
	UNF_mvp_Matrix_RainGarden = glGetUniformLocation( rainGarden_POBJ, "mvp_Matrix_RainGarden");
	UNF_RainGarden_Texture = glGetUniformLocation( rainGarden_POBJ, "raingardenTexture");
	NSLog(@"UNF_mvp_Matrix_RainGarden %d", UNF_mvp_Matrix_RainGarden );
	NSLog(@"UNF_RainGarden_Texture %d", UNF_RainGarden_Texture );
	
	[self validateProgram_vertexShader:&rainGarden_VS_OBJ fragShader:&rainGarden_FS_OBJ progObject:&rainGarden_POBJ];
		//////// RAIN GARDEN SHADER ////////////////////////////////

	
	
	
	
		//////// WATERDROP SHADER ////////////////////////////////
	shaderPath = [[NSBundle mainBundle] pathForResource:@"waterdrop" ofType:@"vfsh"];
	
		// read create shader object
	[self readShader:shaderPath
		vertexShader:&waterdrop_VS_OBJ
		  fragShader:&waterdrop_FS_OBJ
			 progObj:&waterdrop_POBJ];
	
	
		// bind attrib location
	glBindAttribLocation( waterdrop_POBJ, 0, "position");
	glBindAttribLocation( waterdrop_POBJ, 1, "color");
	glBindAttribLocation( waterdrop_POBJ, 2, "texCoord");
	
	
		// link Program
	[self linkProgram:&waterdrop_POBJ];
	
	
		// Get Uniform Location
	UNF_mvp_Matrix_waterdrop = glGetUniformLocation(waterdrop_POBJ, "mvp_Matrix_waterdrop");
	NSLog(@"UNF_mvp_Matrix_waterdrop %d", UNF_mvp_Matrix_waterdrop );
	UNF_waterdropTexture = glGetUniformLocation( waterdrop_POBJ, "waterdropTexture");
	NSLog(@"UNF_waterdropTexture %d", UNF_waterdropTexture );
	
	
		// validate and delete shader
	[self validateProgram_vertexShader:&waterdrop_VS_OBJ fragShader:&waterdrop_FS_OBJ progObject:&waterdrop_POBJ];
	
		//////// WATERDROP SHADER ////////////////////////////////

	
	
		//////// MIZUBUNE SHADER ///////////////////////////////////
	shaderPath = [[NSBundle mainBundle] pathForResource:@"mizubune" ofType:@"vfsh"];
	
		// read create shader object
	[self readShader:shaderPath
		vertexShader:&mizubune_VS_OBJ
		  fragShader:&mizubune_FS_OBJ
			 progObj:&mizubune_POBJ];
	
		// bind attrib location
	glBindAttribLocation( mizubune_POBJ, 0, "position");
	glBindAttribLocation( mizubune_POBJ, 1, "color");
	
		// link Program
	[self linkProgram:&mizubune_POBJ];
	
		// get Uniform location
	UNF_mvp_Matrix_mizubune = glGetUniformLocation( mizubune_POBJ, "mvp_Matrix");
	NSLog(@"UNF_mvp_Matrix_mizubune %d", UNF_mvp_Matrix_mizubune );
	
		// Valiate and delete shader
	[self validateProgram_vertexShader:&mizubune_VS_OBJ fragShader:&mizubune_FS_OBJ progObject:&mizubune_POBJ];
		//////// MIZUBUNE SHADER ///////////////////////////////////
	
	
	
	
	
		//// FLOOD SHADER
	
	shaderPath = [[NSBundle mainBundle] pathForResource:@"Flood" ofType:@"vfsh"];
	
		// read Shader Object
	[self readShader:shaderPath
		vertexShader:&flood_VS_OBJ
		  fragShader:&flood_FS_OBJ
			 progObj:&flood_POBJ];
	
		// bind attrib location
	glBindAttribLocation( flood_POBJ, 0, "position");
	glBindAttribLocation( flood_POBJ, 1, "color");
	glBindAttribLocation( flood_POBJ, 2, "texCoord");
	
		// link program
	[self linkProgram:&flood_POBJ];
	
		// getUniform
	UNF_mvp_Matrix_Flood = glGetUniformLocation( flood_POBJ, "mvp_Matrix_Flood");
	UNF_floodTexture = glGetUniformLocation( flood_POBJ, "floodTexture");
	UNF_floodAlpha = glGetUniformLocation( flood_POBJ, "floodAlpha");
	NSLog(@"UNF_mvp_Matrix_Flood %d", UNF_mvp_Matrix_Flood );
	NSLog(@"UNF_floodTexture %d", UNF_floodTexture );
	NSLog(@"UNF_floodAlpha %d", UNF_floodAlpha);
	
		// Validate and delete shader
	[self validateProgram_vertexShader:&flood_VS_OBJ fragShader:&flood_FS_OBJ progObject:&flood_POBJ];
	
	[pool release];
}



- (void)createFBO
{
		// Create FBO, RBO ( final image )
	glGenFramebuffers(1, &FBO_projector );
	glGenRenderbuffers(1, &RBO_projector );
	
	glBindFramebuffer(GL_FRAMEBUFFER, FBO_projector );
	glBindRenderbuffer(GL_RENDERBUFFER, RBO_projector);
    [context_OBJ renderbufferStorage:GL_RENDERBUFFER fromDrawable:(CAEAGLLayer*)glesView_OBJ.layer];

	glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, RBO_projector );
	
	
	NSLog(@"FBO : projector status %x(8cd5)", glCheckFramebufferStatus(GL_FRAMEBUFFER ) );

	
	
	
		// Create Contents FBO
	glGenFramebuffers(1, &FBO_Contents );
	glGenTextures(1, &TEX_Contents );
	glGenTextures(1, &TEX_Contents_Depth );
	
	glBindFramebuffer(GL_FRAMEBUFFER, FBO_Contents);
	
		// Color Attachment point texture
	glActiveTexture( GL_TEXTURE6 );
	glBindTexture(GL_TEXTURE_2D, TEX_Contents );
	
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR );
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE );
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE );

	glTexImage2D(
				 GL_TEXTURE_2D, 
				 0, 
				 GL_RGBA, 
				 TEXTURE_WIDTH, 
				 TEXTURE_HEIGHT, 
				 0, 
				 GL_RGBA, 
				 GL_UNSIGNED_BYTE, 
				 NULL 
				 );
	
	glFramebufferTexture2D(
						   GL_FRAMEBUFFER, 
						   GL_COLOR_ATTACHMENT0, 
						   GL_TEXTURE_2D, 
						   TEX_Contents, 
						   0
						   );
	
	glActiveTexture(GL_TEXTURE7);
	glBindTexture(GL_TEXTURE_2D, TEX_Contents_Depth );
	
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR );
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE );
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE );

	glTexImage2D(
				 GL_TEXTURE_2D, 
				 0, 
				 GL_DEPTH_COMPONENT, 
				 TEXTURE_WIDTH, 
				 TEXTURE_HEIGHT, 
				 0, 
				 GL_DEPTH_COMPONENT, 
				 GL_UNSIGNED_SHORT, 
				 NULL
				 );
	
	glFramebufferTexture2D(
						   GL_FRAMEBUFFER, 
						   GL_DEPTH_ATTACHMENT, 
						   GL_TEXTURE_2D, 
						   TEX_Contents_Depth, 
						   0
						   );
	
	NSLog(@"FBO Contents status %x", glCheckFramebufferStatus(GL_FRAMEBUFFER));
	
	glBindFramebuffer(GL_FRAMEBUFFER, 0);
	
}




- (void)createTexture
{
		//board Texture ///////////////////////////////////////////////////////////////////////////////////////
	NSInteger ImgWidth;
	NSInteger ImgHeight;
	CGContextRef textureContext;
	GLubyte* texPointer;
	
	CGImageRef boardTexture = [UIImage imageNamed:@"board980x550"].CGImage;
	
	ImgWidth = CGImageGetWidth( boardTexture );
	ImgHeight = CGImageGetHeight( boardTexture );
	
	texPointer = (GLubyte*)malloc( ImgWidth*ImgHeight*4 );
	
	textureContext = CGBitmapContextCreate(
										   texPointer, 
										   ImgWidth, 
										   ImgHeight, 
										   8, 
										   ImgWidth*4, 
										   CGImageGetColorSpace(boardTexture), 
										   kCGImageAlphaPremultipliedLast
										   );
	
	CGContextDrawImage(textureContext, CGRectMake(0.0, 0.0, ImgWidth, ImgHeight), boardTexture);
	CGContextRelease( textureContext );
	
	
	glGenTextures(1, &TEX_board );
	glActiveTexture(GL_TEXTURE0);
	glEnable(GL_TEXTURE_2D);
	glBindTexture(GL_TEXTURE_2D, TEX_board);
	
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
	
	glTexImage2D(
				 GL_TEXTURE_2D, 
				 0, 
				 GL_RGBA, 
				 ImgWidth, 
				 ImgHeight, 
				 0, 
				 GL_RGBA, 
				 GL_UNSIGNED_BYTE, 
				 texPointer
				 );
	
	free(texPointer);
		//board Texture ///////////////////////////////////////////////////////////////////////////////////////

	
	
		//waterdrop Texture ///////////////////////////////////////////////////////////////////////////////////////
	CGImageRef waterdropTexture = [UIImage imageNamed:@"waterdrop"].CGImage;
	
	ImgWidth = CGImageGetWidth( waterdropTexture );
	ImgHeight = CGImageGetHeight( waterdropTexture );
	
	texPointer = (GLubyte*)malloc( ImgWidth*ImgHeight*4 );
	
	textureContext = CGBitmapContextCreate(
										   texPointer, 
										   ImgWidth, 
										   ImgHeight, 
										   8, 
										   ImgWidth*4, 
										   CGImageGetColorSpace(waterdropTexture), 
										   kCGImageAlphaPremultipliedLast
										   );

	CGContextDrawImage( textureContext, CGRectMake(0.0, 0.0, ImgWidth, ImgHeight), waterdropTexture);
	CGContextRelease( textureContext );
	
	
	glGenTextures(1, &TEX_waterdrop );
	glActiveTexture(GL_TEXTURE1);
	glEnable(GL_TEXTURE_2D);
	glBindTexture(GL_TEXTURE_2D, TEX_waterdrop);
	
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
	
	glTexImage2D(
				 GL_TEXTURE_2D, 
				 0, 
				 GL_RGBA, 
				 ImgWidth, 
				 ImgHeight, 
				 0, 
				 GL_RGBA, 
				 GL_UNSIGNED_BYTE, 
				 texPointer
				 );
	
	free(texPointer);
	
	
	
		/////////////  Infiltrate Log Image
	glGenTextures(1, &TEX_infiltrateLog );
	glActiveTexture( GL_TEXTURE2 );
	glEnable( GL_TEXTURE_2D );
	glBindTexture( GL_TEXTURE_2D, TEX_infiltrateLog );

	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
	
	glTexImage2D(
				 GL_TEXTURE_2D, 
				 0, 
				 GL_RGBA, 
				 TEXTURE_WIDTH/2, 
				 TEXTURE_HEIGHT/2, 
				 0, 
				 GL_RGBA, 
				 GL_UNSIGNED_BYTE, 
				 INFILTRATION_TEXTURE
				 );
	
	
	
	
	
	
	
		//// RainGarden Texture
	CGImageRef RainGarden_Texture = [UIImage imageNamed:@"RainGarden_980"].CGImage;
	
	ImgWidth = CGImageGetWidth( RainGarden_Texture );
	ImgHeight = CGImageGetHeight( RainGarden_Texture );
	
	texPointer = (GLubyte*)malloc( ImgWidth * ImgHeight * 4 );
	
	textureContext = CGBitmapContextCreate(
										   texPointer, 
										   ImgWidth, 
										   ImgHeight, 
										   8, 
										   ImgWidth*4, 
										   CGImageGetColorSpace( RainGarden_Texture ), 
										   kCGImageAlphaPremultipliedLast
										   );
	
	CGContextDrawImage(
					   textureContext, 
					   CGRectMake( 0.0, 0.0, ImgWidth, ImgHeight), 
					   RainGarden_Texture
					   );
	
	CGContextRelease( textureContext );
	
	
	glGenTextures(1, &TEX_rainGarden );
	glActiveTexture( GL_TEXTURE3 );
	glEnable( GL_TEXTURE_2D );
	glBindTexture( GL_TEXTURE_2D, TEX_rainGarden );
	
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
	
	glTexImage2D(
				 GL_TEXTURE_2D, 
				 0, 
				 GL_RGBA, 
				 ImgWidth, 
				 ImgHeight, 
				 0, 
				 GL_RGBA, 
				 GL_UNSIGNED_BYTE, 
				 texPointer
				 );
	
	free( texPointer );
	
	
	
		/////// YOTSUYA texture
	CGImageRef Yotsuya_Texture = [UIImage imageNamed:@"yotsuya_texture"].CGImage;
	
	ImgWidth = CGImageGetWidth( Yotsuya_Texture );
	ImgHeight = CGImageGetHeight( Yotsuya_Texture );
	
	texPointer = (GLubyte*)malloc( ImgWidth * ImgHeight * 4 );
	
	textureContext = CGBitmapContextCreate(
										   texPointer, 
										   ImgWidth, 
										   ImgHeight, 
										   8, 
										   ImgWidth*4, 
										   CGImageGetColorSpace( Yotsuya_Texture ), 
										   kCGImageAlphaPremultipliedLast
										   );
	
	CGContextDrawImage(
					   textureContext, 
					   CGRectMake(0.0, 0.0, ImgWidth, ImgHeight), 
					   Yotsuya_Texture
					   );
	
	CGContextRelease( textureContext );
	
	
	glGenTextures(1, &TEX_yotsuya );
	glActiveTexture( GL_TEXTURE4 );
	glEnable( GL_TEXTURE_2D );
	glBindTexture( GL_TEXTURE_2D, TEX_yotsuya );
	
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);

	glTexImage2D(
				 GL_TEXTURE_2D, 
				 0, 
				 GL_RGBA, 
				 ImgWidth, 
				 ImgHeight, 
				 0, 
				 GL_RGBA, 
				 GL_UNSIGNED_BYTE, 
				 texPointer
				 );
	
	free( texPointer );
	

	
		// Info Texture
	
	CGImageRef Info_Texture = [UIImage imageNamed:@"Info"].CGImage;
	
	ImgWidth = CGImageGetWidth( Info_Texture );
	ImgHeight = CGImageGetHeight( Info_Texture );
	
	texPointer = (GLubyte*)malloc( ImgWidth * ImgHeight * 4 );
	
	textureContext = CGBitmapContextCreate(
										   texPointer, 
										   ImgWidth, 
										   ImgHeight, 
										   8, 
										   ImgWidth*4, 
										   CGImageGetColorSpace( Info_Texture ), 
										   kCGImageAlphaPremultipliedLast
										   );
	
	CGContextDrawImage(
					   textureContext, 
					   CGRectMake(0.0, 0.0, ImgWidth, ImgHeight), 
					   Info_Texture
					   );
	
	CGContextRelease( textureContext );
	
		//glGenTextures( 1, &TEX_Info );
	glActiveTexture( GL_TEXTURE5 );
	glEnable( GL_TEXTURE_2D );
		//glBindTexture( GL_TEXTURE_2D, TEX_Info );

	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
	
	glTexImage2D(
				 GL_TEXTURE_2D, 
				 0, 
				 GL_RGBA, 
				 ImgWidth, 
				 ImgHeight, 
				 0, 
				 GL_RGBA, 
				 GL_UNSIGNED_BYTE, 
				 texPointer
				 );
	
	free(texPointer);
}




- (void)readShader:(NSString*)vfshPath vertexShader:(GLuint*)vsObj fragShader:(GLuint*)fsObj progObj:(GLuint*)pObj
{
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	GLint logLength;
	
	
	NSString* shaderSource_String = [NSString stringWithContentsOfFile:vfshPath
															  encoding:NSUTF8StringEncoding
																 error:nil];
	
	NSArray* separated_Source_Array = [shaderSource_String componentsSeparatedByString:@"%"];
	NSString* vs_String = [separated_Source_Array objectAtIndex:0];
	NSString* fs_String = [separated_Source_Array objectAtIndex:1];
	
	const GLchar* vs_Source = (GLchar*)[vs_String UTF8String];
	const GLchar* fs_Source = (GLchar*)[fs_String UTF8String];
	
	*vsObj = glCreateShader( GL_VERTEX_SHADER );
	*fsObj = glCreateShader( GL_FRAGMENT_SHADER );
	
	glShaderSource( *vsObj, 1, &vs_Source, NULL );
	glShaderSource( *fsObj, 1, &fs_Source, NULL );
	
	glCompileShader( *vsObj );
	glCompileShader( *fsObj );
	
	
	glGetShaderiv( *vsObj, GL_INFO_LOG_LENGTH, &logLength );
	if( logLength > 0 )
		{
		GLchar* log = (GLchar*)malloc(logLength);
		glGetShaderInfoLog( *vsObj, logLength, &logLength, log );
		NSLog(@"\n\n VS compile error : \n%s\n\n", log );
		free(log);
		}
	else
		{
		NSLog(@"%@ compile success", vfshPath );
		}
		
	
	glGetShaderiv(*fsObj, GL_INFO_LOG_LENGTH, &logLength );
	if( logLength > 0 )
		{
		GLchar* log = (GLchar*)malloc( logLength );
		glGetShaderInfoLog( *fsObj, logLength, &logLength, log );
		NSLog(@"\n\n FS compile error : \n%s\n\n", log );
		free(log);
		}
	else
		{
		NSLog(@"%@ compile success", vfshPath );
		}
	
	
	*pObj = glCreateProgram();
	
	glAttachShader( *pObj, *vsObj );
	glAttachShader( *pObj, *fsObj );
	
	[pool release];
}




- (void)linkProgram:(GLuint*)pObj
{
	GLint logLenght;
	
	glLinkProgram( *pObj );
	
	glGetProgramiv( *pObj, GL_INFO_LOG_LENGTH, &logLenght );
	if( logLenght > 0 )
		{
		GLchar* log = (GLchar*)malloc( logLenght );
		glGetProgramInfoLog( *pObj, logLenght, &logLenght, log );
		NSLog(@"\n\n link error : \n%s\n\n", log );
		free( log );
		}
	else
		{
		NSLog(@"link success");
		}
}



- (void)validateProgram_vertexShader:(GLuint*)vObj fragShader:(GLuint*)fObj progObject:(GLuint*)pObj
{
	GLint logLength;
	
	glValidateProgram( *pObj );
	
	glGetProgramiv( *pObj, GL_INFO_LOG_LENGTH, &logLength );
	if( logLength > 0 )
		{
		GLchar* log = (GLchar*)malloc( logLength );
		glGetProgramInfoLog( *pObj, logLength, &logLength, log);
		NSLog(@"\n validate error : \n%s\n\n", log );
		free(log);
		}
	else
		{
		NSLog(@"validate success");
		}
	
	glDeleteShader(*vObj);
	glDeleteShader(*fObj);
	
	glUseProgram(0);
}

@end
