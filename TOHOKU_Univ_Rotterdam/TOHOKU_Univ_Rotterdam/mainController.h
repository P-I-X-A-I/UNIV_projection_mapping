//
//  mainController.h
//  TOHOKU_Univ_Rotterdam
//
//  Created by 圭介 渡辺 on 12/02/07.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

#import "glesView.h"
#import "matrixClass.h"

#define TEXTURE_WIDTH 980
#define TEXTURE_HEIGHT 550
#define DROP_NUM 3000

#define TAPLOG_NUM 1000

#define CAPTION_TIME 5.0

@interface mainController : NSObject

{
	
	IBOutlet UIWindow* mainWindow;
	IBOutlet UIViewController* viewController;
	IBOutlet UIView* tapArea_View;
	
	IBOutlet UILabel* Scale_Label;
	IBOutlet UISlider* Scale_Slider;
	IBOutlet UILabel* Scale_X_Label;
	IBOutlet UISlider* Scale_X_Slider;
	IBOutlet UILabel* Rotate_Label;
	IBOutlet UISwitch* Rotate_Switch;
	IBOutlet UIButton* Exit_Button;
	IBOutlet UISlider* Num_WD_Slider;
	IBOutlet UILabel* Num_WD_Label;
	
	IBOutlet UIButton* Asphalt_BUTTON;
	IBOutlet UIButton* RainGarden_BUTTON;
	IBOutlet UIButton* Yotsuya_BUTTON;
	
	IBOutlet UIImageView* TapExplanation_ImageView;
	
	NSMutableArray* ButtonIMG_Array;
	
	
	UITapGestureRecognizer* Tap_GR;
	UIPanGestureRecognizer* Pan_GR;
	
	UIWindow* projector_Window;
	glesView* glesView_OBJ;
	
	EAGLContext* context_OBJ;
	CADisplayLink* dispLink_OBJ;
	
	matrixClass* matrix_OBJ;
	
	IBOutlet UIImageView* overlay_ImageView_OBJ;
	UIImageView* overlay_WhiteView_OBJ;
	NSMutableArray* overlay_ImageView_ARRAY;
	NSMutableArray* overlay_WhiteView_ARRAY;
	
	
	float RATIO;
	
	Byte DRAW_MODE;
	Byte PREVIOUS_MODE;
	
	int COMMON_TIMER;
	int AUTO_TAP_TIMER;
	
	Byte NumOf_WD_TAP;
	
	
	double filtration_Alpha;
	double filtration_Alpha_dist;
	
	double kernel[25];
	double adjust1450;
	
	
		// FBO
	GLuint FBO_projector;
	GLuint RBO_projector;
	
	GLuint FBO_Contents;
	GLuint TEX_Contents;
	GLuint TEX_Contents_Depth;
	
		// Shader
	GLuint projector_VS_OBJ;
	GLuint projector_FS_OBJ;
	GLuint projector_POBJ;
	GLuint UNF_mvp_Matrix;
	GLuint UNF_TEXTURE_CONTENTS;
	
	
	GLuint contents_1_VS_OBJ;
	GLuint contents_1_FS_OBJ;
	GLuint contents_1_POBJ;
	GLuint UNF_mvp_Matrix_Contents;
	GLuint UNF_contentsTexture;
	
	GLuint flood_VS_OBJ;
	GLuint flood_FS_OBJ;
	GLuint flood_POBJ;
	GLuint UNF_mvp_Matrix_Flood;
	GLuint UNF_floodTexture;
	GLuint UNF_floodAlpha;
	
	GLuint filt_VS_OBJ;
	GLuint filt_FS_OBJ;
	GLuint filt_POBJ;
	GLuint UNF_mvp_Matrix_Filt;
	GLuint UNF_FiltTexture;
	GLuint UNF_Filt_Texture_Alpha;
	
	GLuint rainGarden_VS_OBJ;
	GLuint rainGarden_FS_OBJ;
	GLuint rainGarden_POBJ;
	GLuint UNF_mvp_Matrix_RainGarden;
	GLuint UNF_RainGarden_Texture;
	
	GLuint waterdrop_VS_OBJ;
	GLuint waterdrop_FS_OBJ;
	GLuint waterdrop_POBJ;
	GLuint UNF_mvp_Matrix_waterdrop;
	GLuint UNF_waterdropTexture;
	
	GLuint mizubune_VS_OBJ;
	GLuint mizubune_FS_OBJ;
	GLuint mizubune_POBJ;
	GLuint UNF_mvp_Matrix_mizubune;
	
		/// Draw Variables
	GLfloat WD_Center[DROP_NUM][2];
	GLfloat WD_Center_Vel[DROP_NUM][2];
	GLfloat WD_Vertex[DROP_NUM][6][4];
	GLfloat WD_Color[DROP_NUM][6][4];
	GLfloat WD_TexCoord[DROP_NUM][6][2];
	GLfloat WD_Size[DROP_NUM];
	BOOL WD_isCalc_Center[DROP_NUM];
	GLfloat WD_Life[DROP_NUM];
	GLfloat WD_Flicker[DROP_NUM];
	short WD_INDEX;
	
	GLfloat WD_Corner_vel[DROP_NUM][4][2];
	
	GLubyte HEIGHT_MAP_RGBA[TEXTURE_WIDTH+40][TEXTURE_HEIGHT+40][4];
	float VELOCITY_MAP[TEXTURE_WIDTH+40][TEXTURE_HEIGHT+40][2]; // Culculated from HEIGHT_MAP
	float VELOCITY_MAP_YOTSUYA[TEXTURE_WIDTH+40][TEXTURE_HEIGHT+40][2];
	float VELOCITY_MAP_OVERFLOW[TEXTURE_WIDTH+40][TEXTURE_HEIGHT+40][2];
	
	Byte RIVER_MAP[TEXTURE_WIDTH+40][TEXTURE_HEIGHT+40][4];
	Byte RIVER_MAP_YOTSUYA[TEXTURE_WIDTH+40][TEXTURE_HEIGHT+40][4];
	
	
	double INFILTRATION_LOG[TEXTURE_WIDTH/2+20][TEXTURE_HEIGHT/2+20];
	double INFILTRATION_LOG_RG[TEXTURE_WIDTH/2+20][TEXTURE_HEIGHT/2+20];
	double INFILTRATION_COPY[TEXTURE_WIDTH/2+20][TEXTURE_HEIGHT/2+20];
	GLubyte INFILTRATION_TEXTURE[TEXTURE_HEIGHT/2][TEXTURE_WIDTH/2][4];
	
	BOOL isPanned;
	
	GLfloat Mizubune_XY[164][2];
	GLfloat Mizubune_Add[164];
	GLfloat Mizubune_Radian[164];

	
		/// Texture Name
	GLuint TEX_board;
	GLuint TEX_waterdrop;
	GLuint TEX_infiltrateLog;
	GLuint TEX_rainGarden;
	GLuint TEX_yotsuya;
	GLuint TEX_Info;
	
	NSTimer* timer;
	int timerCount;
	
	BOOL isLB_Pressed;
	BOOL isLU_Pressed;
	BOOL isRB_Pressed;
	BOOL isRU_Pressed;
	
	double ScaleValue;
	double Scale_X_Value;
	BOOL is_Rotate;
	BOOL is_OptionMode;
	
	
		// Value for Mizubune
	
	

		// Value for RainGarden
	GLfloat RAIN_GARDEN_MAP[TEXTURE_WIDTH + 40][TEXTURE_HEIGHT + 40][2];
	GLubyte RAIN_GARDEN_INDEX[TEXTURE_WIDTH+40][TEXTURE_HEIGHT+40];


	GLfloat Mizubune_Radian_Table[19][2];

	Byte saveImage_COUNTER_ASPHALT;
	Byte saveImage_COUNTER_RG;
	
	
		// Value for TapInfo
	GLfloat tapInfo_Counter;
}


- (void)appLaunchFinished:(NSNotification*)notification;
- (void)appEnterForeground:(NSNotification*)notification;
- (void)appEnterBackground:(NSNotification*)notification;

- (IBAction)LB:(UIButton*)sender;
- (IBAction)RB:(UIButton*)sender;
- (IBAction)LU:(UIButton*)sender;
- (IBAction)RU:(UIButton*)sender;

- (void)enterOption;

- (IBAction)scaleSlider:(UISlider*)sender;
- (IBAction)scale_X_Slider:(UISlider*)sender;
- (IBAction)rotateSwitch:(UISwitch*)sender;
- (IBAction)numOf_WD:(UISlider*)sender;
- (IBAction)Exit:(UIButton*)sender;

@end

@interface mainController (INIT_VARIABLES)
- (void)initVariables;
@end


@interface mainController ( READ_SAVED )
- (void)loadData;
- (void)saveData;
@end


@interface mainController ( IMAGE_PROCESSING )
- (void)process_Infiltration_Log;
- (void)process_Infiltration_Log_RG;
@end

@interface mainController ( GESTURE )
- (void)gestureTapped:(UITapGestureRecognizer*)GR;
- (void)gesturePanned:(UIPanGestureRecognizer*)GR;
@end

@interface mainController ( SCREEN )
- (void)screenConnected:(NSNotification*)notification;
- (void)screenDisconnected:(NSNotification*)notification;
- (void)screenModeChanged:(NSNotification*)notification;
@end


@interface mainController (GLES)
- (void)setOpenGLES;
- (void)createShader;
- (void)createFBO;
- (void)createTexture;

- (void)readShader:(NSString*)vfshPath vertexShader:(GLuint*)vsObj fragShader:(GLuint*)fsObj progObj:(GLuint*)pObj;
- (void)linkProgram:(GLuint*)pObj;
- (void)validateProgram_vertexShader:(GLuint*)vObj fragShader:(GLuint*)fObj progObject:(GLuint*)pObj;
@end

@interface mainController ( FOR_ANIMATION )
- (void)makeWaterDrop_X:(GLfloat)x Y:(GLfloat)y Color:(GLfloat)col;
- (void)pan_WaterDrop_X:(GLfloat)x Y:(GLfloat)y;
- (void)deleteWaterDrop:(int)index;
@end


@interface mainController ( TIMER_COUNTER )
- (void)timerCounter:(NSTimer*)timer;
@end

	//// TRANSITION////////
@interface mainController ( TRANTSITION )
- (void)transition_to:(Byte)num;
- (void)enableGUI:(BOOL)yn;
@end

	//// mode 1 (Water Flow 2000 mode )
@interface mainController ( MODE_1 )
- (void)goto_mode1:(NSString*)animationID; // 1
- (void)mode1_start:(NSString*)animationID;
- (void)backToNormal_from_mode1;
- (void)backToNormal_from_mode1_Finish:(NSString*)animationID;
@end

@interface mainController ( MODE_2 ) /// ( Tap Logs )
- (void)goto_mode2:(NSString*)animationID;//2
- (void)mode2_start:(NSString*)animationID;
- (void)backToNormal_from_mode2;
- (void)backToNormal_from_mode2_Finish:(NSString*)animationID;
@end


@interface mainController ( MODE_3 )///( INFILTRATION LOG )
- (void)goto_mode3:(NSString*)animationID;
- (void)infiltrationLog_Animation_Start:(NSString*)animationID;
- (void)backToNormal_from_mode3;
- (void)backToNormal_from_mode3_Finish:(NSString*)animationID;
@end


@interface mainController ( MODE_4)
- (void)goto_mode4:(NSString*)animationID;
- (void)mode4_start:(NSString*)animationID;
- (void)backToNormal_from_mode4;
- (void)backToNormal_from_mode4_Finish:(NSString*)animationID;
@end

@interface mainController ( MODE_5 )
- (void)goto_mode5:(NSString*)animationID;
- (void)mode5_start:(NSString*)animationID;
- (void)backToNormal_from_mode5;
- (void)backToNormal_from_mode5_Finish:(NSString*)animationID;
@end


@interface mainController ( MODE_6 )
- (void)goto_mode6:(NSString*)animationID;
- (void)mode6_start:(NSString*)animationID;
@end


@interface mainController ( MODE_7 )
- (void)goto_mode7:(NSString*)animationID;
- (void)caption_1_start:(NSString*)animationID;
- (void)caption_1_end:(NSString*)animationID;
- (void)caption_2_start:(NSString*)animationID;
- (void)caption_2_end:(NSString*)animationID;
- (void)caption_3_start:(NSString*)animationID;
- (void)caption_3_end:(NSString*)animationID;
- (void)caption_4_start:(NSString*)animationID;
- (void)caption_4_end:(NSString*)animationID;
- (void)caption_5_start:(NSString*)animationID;
@end

	/// Drawing

@interface mainController ( DRAW )
- (void)draw:(CADisplayLink*)dispLink;
@end

@interface mainController ( DRAW_WD )
- (void)draw_Texture_FBO;

- (void)draw_WaterDrop; // normal mode
@end


@interface mainController ( BUTTON_ACTION )
- (IBAction)asphalt_button:(UIButton*)sender;
- (IBAction)raingarden:(UIButton*)sender;
- (IBAction)yotsuya:(UIButton*)sender;
@end