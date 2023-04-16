@echo off
SET path_name=%~dp0
SET dir_name=%~n1
SET "complete_path=%path_name%%dir_name%"
SET "png_path=%complete_path%\%dir_name%.png"
md "%complete_path%"

BLPConverter.exe %1 "%png_path%"

SET crop_names[0]=left_ball
SET crop_dims[0]=128x128+160+84
SET crop_names[1]=left_connector
SET crop_dims[1]=8x128+302+84
SET crop_names[2]=left_connector_no_icon
SET crop_dims[2]=8x128+602+84
SET crop_names[3]=top_background
SET crop_dims[3]=512x128+160+228
SET crop_names[4]=right_ball
SET crop_dims[4]=128x128+323+84
SET crop_names[5]=left_ball_no_icon
SET crop_dims[5]=128x128+460+84
SET crop_names[6]=left_side_bar
SET crop_dims[6]=64x512+784+2
SET crop_names[7]=right_side_bar
SET crop_dims[7]=64x512+717+2
SET crop_names[8]=bottom_side_bar
SET crop_dims[8]=512x64+336+517
SET crop_names[9]=slider_top
SET crop_dims[9]=32x32+1+2
SET crop_names[10]=slider_middle
SET crop_dims[10]=32x64+1+40
SET crop_names[11]=slider_down
SET crop_dims[11]=32x32+1+112
SET crop_names[12]=stretch
SET crop_dims[12]=32x16+1+219
SET crop_names[13]=resize_right
SET crop_dims[13]=16x16+1+251
SET crop_names[14]=resize_left
SET crop_dims[14]=16x16+20+251
SET crop_names[15]=unlock_button
SET crop_dims[15]=16x16+1+278
SET crop_names[16]=bottom_background
SET crop_dims[16]=512x128+160+362
SET crop_names[17]=pin_left
SET crop_dims[17]=32x32+1+308
SET crop_names[18]=pin_right
SET crop_dims[18]=32x32+36+308
SET crop_names[19]=damage_done
SET crop_dims[19]=32x32+6+371
SET crop_names[20]=healing_done
SET crop_dims[20]=32x32+38+371

setlocal enableDelayedExpansion
SET len=20
for /l %%x in (0, 1, %len%) do (
    magick convert "%png_path%" -crop !crop_dims[%%x]! "png32:%complete_path%\!crop_names[%%x]!.png"
)
:: It breaks if magick is not done saving, so we do it in 2 separate loops
for /l %%x in (0, 1, %len%) do (
    BLPConverter.exe "%complete_path%\!crop_names[%%x]!.png" "%complete_path%\!crop_names[%%x]!.blp"
)