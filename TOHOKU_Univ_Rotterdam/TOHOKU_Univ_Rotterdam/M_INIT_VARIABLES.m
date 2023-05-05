
#import "mainController.h"

@implementation mainController ( INIT_VARIABLES )

- (void)initVariables
{
	int i, j;
	tapInfo_Counter = 0.0;
	
	saveImage_COUNTER_RG = 0;
	saveImage_COUNTER_ASPHALT = 0;
	
	adjust1450 = 1450.0 / 1500.0;
	
	ScaleValue = 1.0;
	Scale_X_Value = 1.0;
	
	is_Rotate = NO;
	is_OptionMode = NO;
	
	isRB_Pressed = NO;
	isRU_Pressed = NO;
	isLB_Pressed = NO;
	isLU_Pressed = NO;
	
	NumOf_WD_TAP = 1;
	
	isPanned = NO;
	
	overlay_WhiteView_OBJ = nil;
	
	DRAW_MODE = 1;
	PREVIOUS_MODE = 1;
	COMMON_TIMER = 0;
	AUTO_TAP_TIMER = 0;
	
	filtration_Alpha = 0.0;
	filtration_Alpha_dist = 0.0;
	
	timerCount = 0;
	timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerCounter:) userInfo:nil repeats:YES];
	[[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
	
	
	
	WD_INDEX = 0;
	
	for( i = 0 ; i < DROP_NUM ; i++ )
		{
		WD_Size[i] = 0.015;
		WD_Center[i][0] = WD_Center[i][1] = -10.0;
		WD_Center_Vel[i][0] = WD_Center_Vel[i][1] = 0.0;
		
		WD_Vertex[i][0][0] = WD_Center[i][0] - WD_Size[i];
		WD_Vertex[i][0][1] = WD_Center[i][1] + WD_Size[i];
		WD_Vertex[i][0][2] = 0.02f;
		WD_Vertex[i][0][3] = 1.0f;
		
		WD_Vertex[i][1][0] =WD_Vertex[i][0][0];
		WD_Vertex[i][1][1] = WD_Vertex[i][0][1];
		WD_Vertex[i][1][2] = 0.02f;
		WD_Vertex[i][1][3] = 1.0f;
		
		WD_Vertex[i][2][0] = WD_Center[i][0] - WD_Size[i];
		WD_Vertex[i][2][1] = WD_Center[i][1] -+ WD_Size[i];
		WD_Vertex[i][2][2] = 0.02f;
		WD_Vertex[i][2][3] = 1.0f;
		
		WD_Vertex[i][3][0] = WD_Center[i][0] + WD_Size[i];
		WD_Vertex[i][3][1] = WD_Center[i][1] + WD_Size[i];
		WD_Vertex[i][3][2] = 0.02f;
		WD_Vertex[i][3][3] = 1.0f;
		
		WD_Vertex[i][4][0] = WD_Center[i][0] + WD_Size[i];
		WD_Vertex[i][4][1] = WD_Center[i][1] - WD_Size[i];
		WD_Vertex[i][4][2] = 0.02f;
		WD_Vertex[i][4][3] = 1.0f;
		
		WD_Vertex[i][5][0] =WD_Vertex[i][4][0];
		WD_Vertex[i][5][1] = WD_Vertex[i][4][1];
		WD_Vertex[i][5][2] = 0.02f;
		WD_Vertex[i][5][3] = 1.0f;
		
		for( j = 0 ; j < 6 ; j++ )
			{
			WD_Color[i][j][0] = 1.0f;
			WD_Color[i][j][1] = 1.0f;
			WD_Color[i][j][2] = 1.0f;
			WD_Color[i][j][3] = 1.0f;
			}
		
		WD_TexCoord[i][0][0] = 0.0f;			WD_TexCoord[i][0][1] = 0.0f;
		WD_TexCoord[i][1][0] = 0.0f;			WD_TexCoord[i][1][1] = 0.0f;
		WD_TexCoord[i][2][0] = 0.0f;			WD_TexCoord[i][2][1] = 1.0f;
		WD_TexCoord[i][3][0] = 1.0f;			WD_TexCoord[i][3][1] = 0.0f;
		WD_TexCoord[i][4][0] = 1.0f;			WD_TexCoord[i][4][1] = 1.0f;
		WD_TexCoord[i][5][0] = 1.0f;			WD_TexCoord[i][5][1] = 1.0f;
		
		for( j = 0 ; j < 4 ; j++ )
			{
			WD_Corner_vel[i][j][0] = WD_Corner_vel[i][j][1] = 0.0;
			}
		
		WD_isCalc_Center[i] = NO;
		
		
		WD_Flicker[i] = random()%1000 * 0.00005 + 0.95;
		}// DROP NUM
	
	
	
	
	
	
	
	
		//
	Mizubune_XY[0][0] =192.0;		Mizubune_XY[0][1] = 44.0;
	Mizubune_XY[1][0] =226.0;		Mizubune_XY[1][1] = 66.0;
	Mizubune_XY[2][0] =264.0;		Mizubune_XY[2][1] = 47.0;
	Mizubune_XY[3][0] =292.0;		Mizubune_XY[3][1] = 45.0;
	Mizubune_XY[4][0] =316.0;		Mizubune_XY[4][1] = 44.0;
	Mizubune_XY[5][0] =324.0;		Mizubune_XY[5][1] = 66.0;
	Mizubune_XY[6][0] =294.0;		Mizubune_XY[6][1] = 84.0;
	Mizubune_XY[7][0] =243.0;		Mizubune_XY[7][1] = 86.0;
	Mizubune_XY[8][0] =202.0;		Mizubune_XY[8][1] = 109.0;
	Mizubune_XY[9][0] =280.0;		Mizubune_XY[9][1] = 114.0;
	Mizubune_XY[10][0] =317.0;		Mizubune_XY[10][1] = 118.0;
	Mizubune_XY[11][0] =255.0;		Mizubune_XY[11][1] = 134.0;
	Mizubune_XY[12][0] =237.0;		Mizubune_XY[12][1] = 138.0;
	
	Mizubune_XY[13][0] =270.0;		Mizubune_XY[13][1] = 160.0;
	Mizubune_XY[14][0] =309.0;		Mizubune_XY[14][1] = 156.0;
	Mizubune_XY[15][0] =189.0;		Mizubune_XY[15][1] = 152.0;
	Mizubune_XY[16][0] =193.0;		Mizubune_XY[16][1] = 183.0;
	Mizubune_XY[17][0] =219.0;		Mizubune_XY[17][1] = 183.0;
	Mizubune_XY[18][0] =324.0;		Mizubune_XY[18][1] = 182.0;
	Mizubune_XY[19][0] =347.0;		Mizubune_XY[19][1] = 153.0;
	Mizubune_XY[20][0] =352.0;		Mizubune_XY[20][1] = 119.0;
	Mizubune_XY[21][0] =369.0;		Mizubune_XY[21][1] = 92.0;
	Mizubune_XY[22][0] =343.0;		Mizubune_XY[22][1] = 80.0;
	Mizubune_XY[23][0] =363.0;		Mizubune_XY[23][1] = 43.0;
	Mizubune_XY[24][0] =375.0;		Mizubune_XY[24][1] = 70.0;
	Mizubune_XY[25][0] =380.0;		Mizubune_XY[25][1] = 113.0;
	
	
	Mizubune_XY[26][0] =364.0;		Mizubune_XY[26][1] = 142.0;
	Mizubune_XY[27][0] =395.0;		Mizubune_XY[27][1] = 139.0;
	Mizubune_XY[28][0] =384.0;		Mizubune_XY[28][1] = 184.0;
	Mizubune_XY[29][0] =177.0;		Mizubune_XY[29][1] = 230.0;
	Mizubune_XY[30][0] =209.0;		Mizubune_XY[30][1] = 130.0;
	Mizubune_XY[31][0] =271.0;		Mizubune_XY[31][1] = 209.0 ;
	Mizubune_XY[32][0] =310.0;		Mizubune_XY[32][1] = 210.0;
	Mizubune_XY[33][0] =350.0;		Mizubune_XY[33][1] = 210.0;
	Mizubune_XY[34][0] =376.0;		Mizubune_XY[34][1] = 219.0;
	Mizubune_XY[35][0] =253.0;		Mizubune_XY[35][1] = 230.0;
	Mizubune_XY[36][0] =246.0;		Mizubune_XY[36][1] = 255.0;
	Mizubune_XY[37][0] =201.0;		Mizubune_XY[37][1] = 271.0;
	Mizubune_XY[38][0] =199.0;		Mizubune_XY[38][1] = 318.0;

	Mizubune_XY[39][0] =232.0;		Mizubune_XY[39][1] = 304.0;
	Mizubune_XY[40][0] =237.0;		Mizubune_XY[40][1] = 295.0;
	Mizubune_XY[41][0] =210.0;		Mizubune_XY[41][1] = 340.0;
	Mizubune_XY[42][0] =242.0;		Mizubune_XY[42][1] = 335.0;
	Mizubune_XY[43][0] =273.0;		Mizubune_XY[43][1] = 325.0;
	Mizubune_XY[44][0] =273.0;		Mizubune_XY[44][1] = 363.0;
	Mizubune_XY[45][0] =317.0;		Mizubune_XY[45][1] = 235.0;
	Mizubune_XY[46][0] =146.0;		Mizubune_XY[46][1] = 375.0;
	Mizubune_XY[47][0] =178.0;		Mizubune_XY[47][1] = 390.0;
	Mizubune_XY[48][0] =215.0;		Mizubune_XY[48][1] = 377.0;
	Mizubune_XY[49][0] =207.0;		Mizubune_XY[49][1] = 410.0;
	Mizubune_XY[50][0] =244.0;		Mizubune_XY[50][1] = 411.0;
	Mizubune_XY[51][0] =284.0;		Mizubune_XY[51][1] = 428.0;

	Mizubune_XY[52][0] =300.0;		Mizubune_XY[52][1] = 448.0;
	Mizubune_XY[53][0] =245.0;		Mizubune_XY[53][1] = 471.0;
	Mizubune_XY[54][0] =210.0;		Mizubune_XY[54][1] = 476.0;
	Mizubune_XY[55][0] =183.0;		Mizubune_XY[55][1] = 509.0;
	Mizubune_XY[56][0] =225.0;		Mizubune_XY[56][1] = 512.0;
	Mizubune_XY[57][0] =278.0;		Mizubune_XY[57][1] = 481.0;
	Mizubune_XY[58][0] =268.0;		Mizubune_XY[58][1] = 510.0;
	Mizubune_XY[59][0] =300.0;		Mizubune_XY[59][1] = 511.0;
	Mizubune_XY[60][0] =324.0;		Mizubune_XY[60][1] = 494.0;
	Mizubune_XY[61][0] =330.0;		Mizubune_XY[61][1] = 394.0;
	Mizubune_XY[62][0] =308.0;		Mizubune_XY[62][1] = 251.0;
	Mizubune_XY[63][0] =324.0;		Mizubune_XY[63][1] = 276.0;
	Mizubune_XY[64][0] =364.0;		Mizubune_XY[64][1] = 249.0;

	Mizubune_XY[65][0] =357.0;		Mizubune_XY[65][1] = 322.0;
	Mizubune_XY[66][0] =381.0;		Mizubune_XY[66][1] = 327.0;
	Mizubune_XY[67][0] =385.0;		Mizubune_XY[67][1] = 381.0;
	Mizubune_XY[68][0] =375.0;		Mizubune_XY[68][1] = 413.0;
	Mizubune_XY[69][0] =416.0;		Mizubune_XY[69][1] = 403.0;
	Mizubune_XY[70][0] =388.0;		Mizubune_XY[70][1] = 450.0;
	Mizubune_XY[71][0] =352.0;		Mizubune_XY[71][1] = 506.0;
	Mizubune_XY[72][0] =377.0;		Mizubune_XY[72][1] = 500.0;
	Mizubune_XY[73][0] =411.0;		Mizubune_XY[73][1] = 467.0;
	Mizubune_XY[74][0] =410.0;		Mizubune_XY[74][1] = 510.0;
	Mizubune_XY[75][0] =440.0;		Mizubune_XY[75][1] = 491.0;
	Mizubune_XY[76][0] =384.0;		Mizubune_XY[76][1] = 289.0;
	Mizubune_XY[77][0] =409.0;		Mizubune_XY[77][1] = 242.0;
                                                                           
	
	Mizubune_XY[78][0] =444.0;		Mizubune_XY[78][1] = 226.0;
	Mizubune_XY[79][0] =431.0;		Mizubune_XY[79][1] = 169.0;
	Mizubune_XY[80][0] =417.0;		Mizubune_XY[80][1] = 162.0;
	Mizubune_XY[81][0] =438.0;		Mizubune_XY[81][1] = 131.0;
	Mizubune_XY[82][0] =433.0;		Mizubune_XY[82][1] = 81.0;
	Mizubune_XY[83][0] =414.0;		Mizubune_XY[83][1] = 62.0;
	Mizubune_XY[84][0] =476.0;		Mizubune_XY[84][1] = 80.0;
	Mizubune_XY[85][0] =495.0;		Mizubune_XY[85][1] = 106.0;
	Mizubune_XY[86][0] =486.0;		Mizubune_XY[86][1] = 145.0;
	Mizubune_XY[87][0] =470.0;		Mizubune_XY[87][1] = 227.0;
	Mizubune_XY[88][0] =411.0;		Mizubune_XY[88][1] = 285.0;
	Mizubune_XY[89][0] =441.0;		Mizubune_XY[89][1] = 287.0;
	Mizubune_XY[90][0] =435.0;		Mizubune_XY[90][1] = 331.0;

	Mizubune_XY[91][0] =480.0;		Mizubune_XY[91][1] = 327.0;
	Mizubune_XY[92][0] =463.0;		Mizubune_XY[92][1] = 364.0;
	Mizubune_XY[93][0] =478.0;		Mizubune_XY[93][1] = 430.0;
	Mizubune_XY[94][0] =482.0;		Mizubune_XY[94][1] = 494.0;
	Mizubune_XY[95][0] =513.0;		Mizubune_XY[95][1] = 519.0;
	Mizubune_XY[96][0] =545.0;		Mizubune_XY[96][1] = 486.0;
	Mizubune_XY[97][0] =533.0;		Mizubune_XY[97][1] = 436.0;
	Mizubune_XY[98][0] =498.0;		Mizubune_XY[98][1] = 400.0;
	Mizubune_XY[99][0] =553.0;		Mizubune_XY[99][1] = 403.0;
	Mizubune_XY[100][0] =527.0;		Mizubune_XY[100][1] = 373.0;
	Mizubune_XY[101][0] =543.0;		Mizubune_XY[101][1] = 335.0;
	Mizubune_XY[102][0] =512.0;		Mizubune_XY[102][1] = 294.0;
	Mizubune_XY[103][0] =495.0;		Mizubune_XY[103][1] = 265.0;

	Mizubune_XY[104][0] =547.0;		Mizubune_XY[104][1] = 276.0;
	Mizubune_XY[105][0] =528.0;		Mizubune_XY[105][1] = 239.0;
	Mizubune_XY[106][0] =510.0;		Mizubune_XY[106][1] = 207.0;
	Mizubune_XY[107][0] =538.0;		Mizubune_XY[107][1] = 159.0;
	Mizubune_XY[108][0] =536.0;		Mizubune_XY[108][1] = 123.0;
	Mizubune_XY[109][0] =535.0;		Mizubune_XY[109][1] = 64.0;
	Mizubune_XY[110][0] =514.0;		Mizubune_XY[110][1] = 39.0;

	Mizubune_XY[111][0] =574.0;		Mizubune_XY[111][1] = 50.0;
	Mizubune_XY[112][0] =572.0;		Mizubune_XY[112][1] = 109.0;
	Mizubune_XY[113][0] =609.0;		Mizubune_XY[113][1] = 55.0;
	Mizubune_XY[114][0] =627.0;		Mizubune_XY[114][1] = 118.0;
	Mizubune_XY[115][0] =602.0;		Mizubune_XY[115][1] = 162.0;
	Mizubune_XY[116][0] =575.0;		Mizubune_XY[116][1] = 175.0;
	Mizubune_XY[117][0] =544.0;		Mizubune_XY[117][1] = 202.0;
	Mizubune_XY[118][0] =539.0;		Mizubune_XY[118][1] = 212.0;
	Mizubune_XY[119][0] =568.0;		Mizubune_XY[119][1] = 237.0;
	Mizubune_XY[120][0] =584.0;		Mizubune_XY[120][1] = 262.0;
	Mizubune_XY[121][0] =625.0;		Mizubune_XY[121][1] = 285.0;
	Mizubune_XY[122][0] =588.0;		Mizubune_XY[122][1] = 312.0;
	Mizubune_XY[123][0] =567.0;		Mizubune_XY[123][1] = 360.0;
	Mizubune_XY[124][0] =599.0;		Mizubune_XY[124][1] = 352.0;
	Mizubune_XY[125][0] =606.0;		Mizubune_XY[125][1] = 397.0;
	Mizubune_XY[126][0] =584.0;		Mizubune_XY[126][1] = 441.0;
	Mizubune_XY[127][0] =594.0;		Mizubune_XY[127][1] = 478.0;
	Mizubune_XY[128][0] =640.0;		Mizubune_XY[128][1] = 486.0;
	Mizubune_XY[129][0] =649.0;		Mizubune_XY[129][1] = 423.0;
	Mizubune_XY[130][0] =665.0;		Mizubune_XY[130][1] = 372.0;

	Mizubune_XY[131][0] =629.0;		Mizubune_XY[131][1] = 347.0;
	Mizubune_XY[132][0] =664.0;		Mizubune_XY[132][1] = 319.0;
	Mizubune_XY[133][0] =666.0;		Mizubune_XY[133][1] = 628.0;
	Mizubune_XY[134][0] =615.0;		Mizubune_XY[134][1] = 219.0;
	Mizubune_XY[135][0] =640.0;		Mizubune_XY[135][1] = 236.0;
	Mizubune_XY[136][0] =666.0;		Mizubune_XY[136][1] = 232.0;
	Mizubune_XY[137][0] =661.0;		Mizubune_XY[137][1] = 194.0;
	Mizubune_XY[138][0] =705.0;		Mizubune_XY[138][1] = 177.0;
	Mizubune_XY[139][0] =705.0;		Mizubune_XY[139][1] = 129.0;
	Mizubune_XY[140][0] =659.0;		Mizubune_XY[140][1] = 77.0;
	Mizubune_XY[141][0] =683.0;		Mizubune_XY[141][1] = 55.0;
	Mizubune_XY[142][0] =715.0;		Mizubune_XY[142][1] = 72.0;
	Mizubune_XY[143][0] =732.0;		Mizubune_XY[143][1] = 106.0;
	Mizubune_XY[144][0] =764.0;		Mizubune_XY[144][1] = 77.0;
	Mizubune_XY[145][0] =770.0;		Mizubune_XY[145][1] = 103.0;
	Mizubune_XY[146][0] =763.0;		Mizubune_XY[146][1] = 140.0;
	Mizubune_XY[147][0] =759.0;		Mizubune_XY[147][1] = 176.0;
	Mizubune_XY[148][0] =713.0;		Mizubune_XY[148][1] = 238.0;
	Mizubune_XY[149][0] =756.0;		Mizubune_XY[149][1] = 228.0;
	Mizubune_XY[150][0] =706.0;		Mizubune_XY[150][1] = 275.0;

	Mizubune_XY[151][0] =754.0;		Mizubune_XY[151][1] = 266.0;
	Mizubune_XY[152][0] =767.0;		Mizubune_XY[152][1] = 290.0;
	Mizubune_XY[153][0] =713.0;		Mizubune_XY[153][1] = 326.0;
	Mizubune_XY[154][0] =760.0;		Mizubune_XY[154][1] = 315.0;
	Mizubune_XY[155][0] =754.0;		Mizubune_XY[155][1] = 353.0;
	Mizubune_XY[156][0] =714.0;		Mizubune_XY[156][1] = 380.0;
	Mizubune_XY[157][0] =688.0;		Mizubune_XY[157][1] = 400.0;
	Mizubune_XY[158][0] =760.0;		Mizubune_XY[158][1] = 398.0;
	Mizubune_XY[159][0] =739.0;		Mizubune_XY[159][1] = 446.0;
	Mizubune_XY[160][0] =704.0;		Mizubune_XY[160][1] = 444.0;
	Mizubune_XY[161][0] =767.0;		Mizubune_XY[161][1] = 471.0;
	Mizubune_XY[162][0] =704.0;		Mizubune_XY[162][1] = 501.0;
	Mizubune_XY[163][0] =748.0;		Mizubune_XY[163][1] = 510.0;

	
	double coeff = 1.0 / 275.0;
	for( i = 0 ; i < 164 ; i++ )
		{
		double cv_X = (Mizubune_XY[i][0] - 490.0)*coeff;
		double cv_Y = (275.0 - Mizubune_XY[i][1])*coeff;
		
		Mizubune_XY[i][0] = cv_X;
		Mizubune_XY[i][1] = cv_Y;
		
		Mizubune_Add[i] = 0.0;
		
		Mizubune_Radian[i] = (float)i / 164.0;
		}
	
	for( i = 0 ; i <19 ; i++ )
		{
		float deg = i * 20.0;
		float radian = deg * 0.0174532925;
		
		Mizubune_Radian_Table[i][0] = cosf( radian )*0.1;
		Mizubune_Radian_Table[i][1] = sinf( radian )*0.1;
		NSLog(@"rad%d %f %f", i, Mizubune_Radian_Table[i][0], Mizubune_Radian_Table[i][1] );
		}
	
	
		// Read Height Map for Height Calculation
	/////// Height map RGB
	
	CGImageRef heightMap_RGB_IMG = [UIImage imageNamed:@"height_mapRGB1020x590"].CGImage;
	NSInteger ImgWidth;
	NSInteger ImgHeight;
	CGContextRef ImgContext;
	GLubyte* ImgPointer;
	GLubyte* tempPointer;
	
	ImgWidth = CGImageGetWidth( heightMap_RGB_IMG );
	ImgHeight = CGImageGetHeight( heightMap_RGB_IMG );
	
	ImgPointer = (GLubyte*)malloc( ImgWidth * ImgHeight * 4 );
	
	ImgContext = CGBitmapContextCreate(
									   ImgPointer, 
									   ImgWidth, 
									   ImgHeight, 
									   8, 
									   ImgWidth*4, 
									   CGImageGetColorSpace( heightMap_RGB_IMG ), 
									   kCGImageAlphaPremultipliedLast
									   );
	
	CGContextDrawImage(
					   ImgContext, 
					   CGRectMake(0.0, 0.0, ImgWidth, ImgHeight), 
					   heightMap_RGB_IMG
					   );
	
	CGContextRelease( ImgContext );
	
	tempPointer = ImgPointer;
	
	NSLog(@"HEIGHT MAP RGBA COPY start");
	
	for( i = 0 ; i < ImgHeight ; i++ )
		{
		for( j = 0 ; j < ImgWidth ; j++ )
			{
			HEIGHT_MAP_RGBA[j][i][0]  = *tempPointer;
			tempPointer++;
			HEIGHT_MAP_RGBA[j][i][1] = *tempPointer;
			tempPointer++;
			HEIGHT_MAP_RGBA[j][i][2] = *tempPointer;
			tempPointer++;
			HEIGHT_MAP_RGBA[j][i][3] = *tempPointer;
			tempPointer++;
			}
		}
	
	NSLog(@"HEIGHT MAP RGBA COPY finish");
	
	free(ImgPointer);
	
	
	
	
	
	
	
		// calculate Velocity map
	float velocity_X = 0.0;
	float velocity_Y = 0.0;
	Byte Slope[8];
	Byte Center;
	float Coeff = 0.00005;
	float Coeff_s = 0.000035;
	float k_Weight = 0.0;
	
	for( int RGB = 0 ; RGB < 3 ; RGB ++ )
		{
	
	for( i = 20 ; i < TEXTURE_WIDTH +20 ; i++ )
		{
		for( j = 20 ; j < TEXTURE_HEIGHT + 20 ; j++ )
			{
			velocity_X = 0.0;
			velocity_Y = 0.0;
			for( int k = 1 ; k <= 9 ; k = k+2 )
				{
				k_Weight = 1.0 - k*0.1;
				
				Center = HEIGHT_MAP_RGBA[i][j][RGB];
				
				Slope[0] = HEIGHT_MAP_RGBA[ i - k ][ j - k ][RGB];		// 0 1 2
				Slope[1] = HEIGHT_MAP_RGBA[ i ][ j - k][RGB];				// 3  - 4
				Slope[2] = HEIGHT_MAP_RGBA[ i+k ][ j - k ][RGB];		// 5 6 7
				
				Slope[3] = HEIGHT_MAP_RGBA[ i -k ][ j ][RGB];
				Slope[4] = HEIGHT_MAP_RGBA[ i+k ][ j ][RGB];
				
				Slope[5] = HEIGHT_MAP_RGBA[ i-k ][ j+k][RGB];
				Slope[6] = HEIGHT_MAP_RGBA[ i ][ j+k ][RGB];
				Slope[7] = HEIGHT_MAP_RGBA[ i+k ][ j+k][RGB];
				
				velocity_X += ( Slope[3] - Center )*Coeff*k_Weight;
				velocity_X += ( Center - Slope[4] )*Coeff*k_Weight;
				
				velocity_Y += ( Slope[6] - Center )*Coeff*k_Weight;
				velocity_Y += ( Center - Slope[1] )*Coeff*k_Weight;
				
				velocity_X += ( Slope[0] - Center )*Coeff_s*k_Weight;
				velocity_Y += ( Center - Slope[0] )*Coeff_s*k_Weight;
				
				velocity_X += ( Center - Slope[2] )*Coeff_s*k_Weight;
				velocity_Y += ( Center - Slope[2] )*Coeff_s*k_Weight;
				
				velocity_X += ( Slope[5] - Center )*Coeff_s*k_Weight;
				velocity_Y += ( Slope[5] - Center )*Coeff_s*k_Weight;
				
				velocity_X += (Center - Slope[7])*Coeff_s*k_Weight;
				velocity_Y +=( Slope[7] - Center )*Coeff_s*k_Weight;
				}
			
			if( velocity_X > 0.00015 )
				{ velocity_X = 0.00015; }
			else if( velocity_X < -0.00015 )
				{ velocity_X = -0.00015; }
			
			if( velocity_Y > 0.00015 )
				{ velocity_Y = 0.00015; }
			else if( velocity_Y < -0.00015 )
				{ velocity_Y = -0.00015; }
			
			
			switch (RGB) {
				case 0:
					VELOCITY_MAP[i][j][0] = velocity_X;
					VELOCITY_MAP[i][j][1] = velocity_Y;
					break;
				
				case 1:
					VELOCITY_MAP_YOTSUYA[i][j][0] = velocity_X;
					VELOCITY_MAP_YOTSUYA[i][j][1] = velocity_Y;
					break;
				
				case 2:
					VELOCITY_MAP_OVERFLOW[i][j][0] = velocity_X;
					VELOCITY_MAP_OVERFLOW[i][j][1] = velocity_Y;
					break;
					
				case 3:
						// N/A
					break;
				default:
					break;
			}
			
			}//j
		}//i
		}//RGB
	
	
	
	
		// Read River map for flow Calculation
	
	CGImageRef RiverMap_IMG = [UIImage imageNamed:@"river_map1020x590"].CGImage;
	
	ImgWidth = CGImageGetWidth( RiverMap_IMG );
	ImgHeight = CGImageGetHeight( RiverMap_IMG );
	
	ImgPointer = (GLubyte*)malloc( ImgWidth * ImgHeight * 4 );
	
	ImgContext = CGBitmapContextCreate(
									   ImgPointer, 
									   ImgWidth, 
									   ImgHeight, 
									   8, 
									   ImgWidth*4, 
									   CGImageGetColorSpace(RiverMap_IMG), 
									   kCGImageAlphaPremultipliedLast
									   );
	
	CGContextDrawImage(
					   ImgContext, 
					   CGRectMake(0.0, 0.0, ImgWidth, ImgHeight), 
					   RiverMap_IMG
					   );
	
	CGContextRelease( ImgContext );
	
	tempPointer = ImgPointer;
	
	NSLog(@"RIVER MAP COPY start");
	for( i = 0 ; i < ImgHeight ; i++ )
		{
		for( j = 0 ; j < ImgWidth ; j++ )
			{
			Byte value = *tempPointer;
			RIVER_MAP[j][i][0] = value;
			tempPointer++;
			
			value = *tempPointer;
			RIVER_MAP[j][i][1] = value;
			tempPointer++;
			
			value = *tempPointer;
			RIVER_MAP[j][i][2] = value;
			tempPointer++;
			
			value = *tempPointer;
			RIVER_MAP[j][i][3] = value;
			tempPointer++;			
			}
		}
	NSLog(@"RIVER MAP COPY end");
	free(ImgPointer);
	
	
	
	
	
	
	
	
	
		// Yotuya Yosui River Map
	CGImageRef YotsuyaMap_IMG = [UIImage imageNamed:@"yotuya_river"].CGImage;
	
	ImgWidth = CGImageGetWidth( YotsuyaMap_IMG );
	ImgHeight = CGImageGetHeight( YotsuyaMap_IMG );
	
	ImgPointer = (GLubyte*)malloc( ImgWidth * ImgHeight * 4 );
	
	ImgContext = CGBitmapContextCreate(
									   ImgPointer, 
									   ImgWidth, 
									   ImgHeight, 
									   8, 
									   ImgWidth*4, 
									   CGImageGetColorSpace( YotsuyaMap_IMG ), 
									   kCGImageAlphaPremultipliedLast
									   );
	
	CGContextDrawImage(
					   ImgContext, 
					   CGRectMake(0.0, 0.0, ImgWidth, ImgHeight), 
					   YotsuyaMap_IMG
					   );
	
	CGContextRelease( ImgContext );
	
	tempPointer = ImgPointer;
	
	
	NSLog(@"YOTSUYA MAP COPY start");
	
	for( i = 0 ; i < ImgHeight ; i++ )
		{
		for( j = 0 ; j < ImgWidth ; j++ )
			{
			Byte value = *tempPointer;
			RIVER_MAP_YOTSUYA[j][i][0] = value;
			tempPointer++;
			
			value = *tempPointer;
			RIVER_MAP_YOTSUYA[j][i][1] = value;
			tempPointer++;
			
			value = *tempPointer;
			RIVER_MAP_YOTSUYA[j][i][2] = value;
			tempPointer++;
			
			value = *tempPointer;
			RIVER_MAP_YOTSUYA[j][i][3] = value;
			tempPointer++;
			}
		}
	
	NSLog(@"YOTSUYA MAP COPY end");
	free(ImgPointer);
	
	
	
	
	
	
		// RainGarden Map
	CGImageRef RainGarden_IMG = [UIImage imageNamed:@"RainGarden1020x590"].CGImage;
	
	ImgWidth = CGImageGetWidth( RainGarden_IMG );
	ImgHeight = CGImageGetHeight( RainGarden_IMG );
	
	ImgPointer = (GLubyte*)malloc( ImgWidth * ImgHeight * 4 );
	
	ImgContext = CGBitmapContextCreate(
									   ImgPointer, 
									   ImgWidth, 
									   ImgHeight, 
									   8, 
									   ImgWidth*4, 
									   CGImageGetColorSpace( RainGarden_IMG ), 
									   kCGImageAlphaPremultipliedLast
									   );
	
	CGContextDrawImage(
					   ImgContext, 
					   CGRectMake( 0.0, 0.0, ImgWidth, ImgHeight), 
					   RainGarden_IMG
					   );
	
	CGContextRelease( ImgContext );
	
	
	tempPointer = ImgPointer;
	
	NSLog(@"RAINGARDEN MAP COPY start");
	
	for( i = 0 ; i < ImgHeight ; i++ )
		{
		for( j = 0 ; j < ImgWidth ; j++ )
			{
			float Red, Green;
			GLubyte Blue, Alpha;
			
			Red = (*tempPointer)/255.0;
			tempPointer++;
			
			Green = (*tempPointer)/ 255.0;
			tempPointer++;
			
			Blue = *tempPointer;
			tempPointer++;
			
			Alpha = *tempPointer;
			tempPointer++;
			
			
			RAIN_GARDEN_MAP[j][i][0] = Red*0.6 + 0.4;
			RAIN_GARDEN_MAP[j][i][1] = Green;
			RAIN_GARDEN_INDEX[j][i] = Blue;
			
			}
		}
	
	NSLog(@"RAINGARDEN MAP COPY end");
	free( ImgPointer );
	
	
	
	
	
	
	
	
	
	
	
		// Infiltration memory init;
	for( i = 0 ; i < TEXTURE_WIDTH/2+20 ; i++)
		{
		for( j = 0 ; j < TEXTURE_HEIGHT/2+20 ; j++ )
			{	
				INFILTRATION_LOG[i][j] = 0.0;
				INFILTRATION_LOG_RG[i][j] = 0.0;
				INFILTRATION_COPY[i][j] = 0.0;
			}
		}
	
	for( int W = 0 ; W < TEXTURE_WIDTH/2 ; W++ ) // 980
		{
		for( int H = 0 ; H < TEXTURE_HEIGHT/2 ; H++ ) // 550
			{
			INFILTRATION_TEXTURE[H][W][0] = 0;
			INFILTRATION_TEXTURE[H][W][1] = 0;
			INFILTRATION_TEXTURE[H][W][2] = 0;
			INFILTRATION_TEXTURE[H][W][3] = 255;
			}
		}
	
	
	NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
	
	int isLaunchedFirstTime = [defs integerForKey:@"isLaunched"];
	
	if( isLaunchedFirstTime == 0 ) // this app is launched first time
		{
		NSLog(@"This App is Launched First Time.");
		}// if
	else
		{
		NSLog(@"This App have already Launched.");
		
		[self loadData];
		}	
	
	
	
	
	for( i = -2 ; i <=2 ; i++ )
		{
		for( j = -2 ; j <=2 ; j++ )
			{
			int index = (j+2) + (i+2)*5;
			
			double X = (double)i;
			double Y = (double)j;
			
			double length = sqrt( (X*X) + (Y*Y) );
			double maxLength = sqrt( (2.0*2.0 + 2.0*2.0) );
			double normWeight = 1.0 / maxLength;
			length *= normWeight;
			
			kernel[index] = ( 1.0 - length*length )+0.1; 
			}
		}
	
	double kernelSum = 0.0;
	for( i = -2 ; i <=2 ; i++ )
		{
		for( j = -2 ; j <= 2 ; j++ )
			{
			int index = (j+2) + (i+2)*5;
			kernelSum += kernel[index];
			}
		}
	
	
	double kernelCoeff = 1.0 / kernelSum;
	
	for( i = -2 ; i <= 2 ; i++ )
		{
		for( j = -2 ; j <=2 ; j++ )
			{
			int index = (j+2) + (i+2)*5;
			kernel[index] *= kernelCoeff;
			}
		}

	
}

@end