setlocal ENABLEDELAYEDEXPANSION ENABLEEXTENSIONS
@ECHO OFF
color 8F
title TF2 Graphics Config Generator
CLS

:folder_check
for %%a in (..) do set currentfolder=%%~na
if /I "%currentfolder%" == "custom" (
    goto :folder_set
) else (
    goto :invalid_folder
)

:folder_set
set root=%cd%
set dev_folder=%root%\_dev
set scripts_folder=%dev_folder%\_scripts
set backup_folder=%dev_folder%\_backups
set quality_folder=%dev_folder%\_qualities
set textures_folder=%quality_folder%\_textures
set models_folder=%quality_folder%\_models
set shadows_folder=%quality_folder%\_shadows
set lighting_folder=%quality_folder%\_lighting
set water_folder=%quality_folder%\_water
set antialias_folder=%quality_folder%\_antialiasing
set facialfeatures_folder=%quality_folder%\_facialfeatures
set ragdoll_folder=%quality_folder%\_ragdolls
set props_folder=%quality_folder%\_props
set decals_folder=%quality_folder%\_decals
set ropes_folder=%quality_folder%\_ropes
cd ..\
set custom_folder=%cd%
cd ..\
set tf_folder=%cd%
cd cfg
set cfg_folder=%cd%
echo %root%
echo %dev_folder%
echo %scripts_folder%
echo %backup_folder%
echo %quality_folder%
echo %textures_folder%
echo %models_folder%
echo %shadows_folder%
echo %lighting_folder%
echo %water_folder%
echo %antialias_folder%
echo %facialfeatures_folder%
echo %ragdoll_folder%
echo %props_folder%
echo %decals_folder%
echo %ropes_folder%
echo %custom_folder%
echo %tf_folder%
echo %cfg_folder%
cd %root%
pause

IF EXIST "%dev_folder%\settings.bat" call "%dev_folder%\settings.bat"
IF NOT DEFINED automatic_backup set automatic_backup=on

:backup
SET backupFile="%backup_folder%\autoexec_backup.txt"
SET autoexecFile="%cfg_folder%\autoexec.cfg"
IF %automatic_backup%==on (
    cd "%backup_folder%"
    mkdir cfg
    robocopy "%cfg_folder%" "%backup_folder%\cfg" 
    cd "%root%"
    goto :main_menu
) ELSE (
    goto :main_menu
)

:main_menu
IF %automatic_backup%==on set toggle_backup=goto :backup_on
IF %automatic_backup%==off set toggle_backup=goto :backup_off

IF %automatic_backup%==on set backup_status=X
IF %automatic_backup%==off set backup_status=
IF %automatic_backup%==on set autoexec_backup_status=ON
IF %automatic_backup%==off set autoexec_backup_status=OFF

IF EXIST "%dev_folder%\settings.bat" del "%dev_folder%\settings.bat" >nul
IF %automatic_backup%==on echo set automatic_backup=on > "%dev_folder%\settings.bat"
IF %automatic_backup%==off echo set automatic_backup=off > "%dev_folder%\settings.bat"

cls
echo.
echo. .-++=:.          .:.          
echo.    .=**=:       :-:           
echo.      .+*+=:     =-:           
echo.   .    =**=:.  .::.           
echo.  =++:  .+++=-:.:...           
echo. .+***+-=++====:...  ...::--=+:
echo.  -**##****+===-:.. :=++++++-. 
echo.    :+***+**+==-:...::==-:.    
echo.     :=+++***++=-. ...         
echo.    :+====+++====-...          
echo.   =*=============-..          
echo. .+*+============++-:          
echo. .:=*=====+====++++=:          
echo.   .======+++=+++++-.          
echo.    .-====-+=:---:.            
echo.       -=:::. ..  Team Fortress 2 Graphics Config Generator
echo.                     Created by LunaXCBN
echo.
echo. 1. See current settings
echo. 2. [%backup_status%] Automatic Backup
echo.
echo. 3. Generate a config
echo. 4. Install scripts
echo.
set CHOICE=none
SET /P CHOICE=Please select an option: 
IF NOT "%CHOICE%"=="0" IF NOT "%CHOICE%"=="1" IF NOT "%CHOICE%"=="2" IF NOT "%CHOICE%"=="3"  IF NOT "%CHOICE%"=="4" IF NOT "%CHOICE%"=="5" IF NOT "%CHOICE%"=="6" IF NOT "%CHOICE%"=="7" IF NOT "%CHOICE%"=="8" goto :main_menu

IF %CHOICE%==1 goto :current_settings
IF %CHOICE%==2 %toggle_backup%
IF %CHOICE%==3 goto :generator
IF %CHOICE%==4 (
    IF EXIST %autoexecFile% (
        goto :new_config_scripts
    ) ELSE (
        goto :no_autoexec_found
    )
)

:no_autoexec_found
cls
color 4F
echo.
echo. No autoexec file found. Try generating a config first?
pause
goto :main_menu

:autoexec_found
cls
color 4F
echo.
echo.- AUTOEXEC FOUND!
echo.- Automatic backup is %autoexec_backup_status%
echo.- Autoexec files are required to be empty.
SET /P Choice=- Would you like to delete it now? (This includes scripts) (Y/N): 
IF NOT "%CHOICE%"=="Y" IF NOT "%CHOICE%"=="N" IF NOT "%CHOICE%"=="y" IF NOT "%CHOICE%"=="n" goto :autoexec_found

IF %CHOICE%==y (
    IF %automatic_backup%==off (
        echo.
        echo.- AUTOMATIC BACKUP IS TURNED OFF. ARE YOU SURE YOU WANT TO DELETE autoexec.cfg?
        del /P %autoexecFile%
        color 8F
        goto :new_config_textures
    ) ELSE (
        del /F %autoexecFile%
        color 8F
        goto :new_config_textures
    )
)
IF %CHOICE%==Y (
    IF %automatic_backup%==off (
        echo.
        echo.- AUTOMATIC BACKUP IS TURNED OFF. ARE YOU SURE YOU WANT TO DELETE autoexec.cfg?
        del /P %autoexecFile%
        color 8F
        goto :new_config_textures
    ) ELSE (
        del /F %autoexecFile%
        color 8F
        goto :new_config_textures
    )
)
IF %CHOICE%==n (
    goto :main_menu
)
IF %CHOICE%==N (
    goto :main_menu
)

:current_settings
cls
echo.
echo. .-++=:.          .:.          
echo.    .=**=:       :-:           
echo.      .+*+=:     =-:           
echo.   .    =**=:.  .::.           
echo.  =++:  .+++=-:.:...           
echo. .+***+-=++====:...  ...::--=+:
echo.  -**##****+===-:.. :=++++++-. 
echo.    :+***+**+==-:...::==-:.    
echo.     :=+++***++=-. ...         
echo.    :+====+++====-...          
echo.   =*=============-..          
echo. .+*+============++-:          
echo. .:=*=====+====++++=:          
echo.   .======+++=+++++-.          
echo.    .-====-+=:---:.            
echo.       -=:::. ..  Current Settings:
echo.
echo. Textures: %textures%
echo. Models: %models%
echo. Shadows: %shadows%
echo. Lighting: %lighting%
echo. Water: %water%
echo. Antialiasing: %antialiasing%
echo. Facial Features: %facial_features%
echo. Ragdolls: %ragdolls%
echo. Props: %props%
echo. Decals: %decals%
echo. Ropes: %ropes%
echo.
echo. Press any key to go back..
pause > nul
goto :main_menu

:generator
cls
echo.
echo. .-++=:.          .:.          
echo.    .=**=:       :-:           
echo.      .+*+=:     =-:           
echo.   .    =**=:.  .::.           
echo.  =++:  .+++=-:.:...           
echo. .+***+-=++====:...  ...::--=+:
echo.  -**##****+===-:.. :=++++++-. 
echo.    :+***+**+==-:...::==-:.    
echo.     :=+++***++=-. ...         
echo.    :+====+++====-...          
echo.   =*=============-..          
echo. .+*+============++-:          
echo. .:=*=====+====++++=:          
echo.   .======+++=+++++-.          
echo.    .-====-+=:---:.            
echo.       -=:::. ..  Config Generator
echo.
echo. 1. Edit current config
echo. 2. Create a new config
echo.
echo. 3. Back
echo.

set CHOICE=none
SET /P CHOICE=Please select an option: 
IF NOT %CHOICE%==1 IF NOT %CHOICE%==2 IF NOT %CHOICE%==3 goto :generator

IF %CHOICE%==1 (
    echo NOT DONE
    pause > nul
    goto :main_menu
)
IF %CHOICE%==2 (
    cd "%cfg_folder%"
    IF EXIST "autoexec.cfg" (
        goto :autoexec_found
    ) ELSE (
        goto :new_config_write_settings
    )
)
IF %CHOICE%==3 (
    goto :main_menu
)

:new_config_write_settings
IF EXIST "%dev_folder%\configvars.bat" del "%dev_folder%\configvars.bat"
echo hi :3 > "%dev_folder%\configvars.bat"
goto :new_config_textures

:new_config_textures
cls
echo.
echo. .-++=:.          .:.          
echo.    .=**=:       :-:           
echo.      .+*+=:     =-:           
echo.   .    =**=:.  .::.           
echo.  =++:  .+++=-:.:...           
echo. .+***+-=++====:...  ...::--=+:
echo.  -**##****+===-:.. :=++++++-. 
echo.    :+***+**+==-:...::==-:.    
echo.     :=+++***++=-. ...         
echo.    :+====+++====-...          
echo.   =*=============-..          
echo. .+*+============++-:          
echo. .:=*=====+====++++=:          
echo.   .======+++=+++++-.          
echo.    .-====-+=:---:.            
echo.       -=:::. ..  Select Texture Quality:
echo.
echo. 1. Very Low
echo. 2. Low
echo. 3. Medium
echo. 4. High
echo. 5. Very High
echo.
echo. 6. Back
echo.
set CHOICE=none
SET /P CHOICE=Please select an option: 
IF NOT %CHOICE%==1 IF NOT %CHOICE%==2 IF NOT %CHOICE%==3 IF NOT %CHOICE%==4 IF NOT %CHOICE%==5 IF NOT %CHOICE%==6 goto :new_config_textures

IF %CHOICE%==1 (
    echo //TEXTURES: VERY LOW >> %autoexecFile%
    type "%textures_folder%\very_low_textures.txt" >> %autoexecFile%
    echo set textures=VERY LOW > "%dev_folder%\configvars.bat"
    goto :new_config_models
)
IF %CHOICE%==2 (
    echo //TEXTURES: LOW >> %autoexecFile%
    type "%textures_folder%\low_textures.txt" >> %autoexecFile%
    echo set textures=LOW > "%dev_folder%\configvars.bat"
    goto :new_config_models
)
IF %CHOICE%==3 (
    echo //TEXTURES: MEDIUM >> %autoexecFile%
    type "%textures_folder%\medium_textures.txt" >> %autoexecFile%
    echo set textures=MEDIUM > "%dev_folder%\configvars.bat"
    goto :new_config_models
)
IF %CHOICE%==4 (
    echo //TEXTURES: HIGH >> %autoexecFile%
    type "%textures_folder%\high_textures.txt" >> %autoexecFile%
    echo set textures=HIGH > "%dev_folder%\configvars.bat"
    goto :new_config_models
)
IF %CHOICE%==5 (
    echo //TEXTURES: VERY HIGH >> %autoexecFile%
    type "%textures_folder%\very_high_textures.txt" >> %autoexecFile%
    echo set textures=VERY HIGH > "%dev_folder%\configvars.bat"
    goto :new_config_models
)
IF %CHOICE%==6 (
    goto :generator
)

:new_config_models
cls
echo.
echo. .-++=:.          .:.          
echo.    .=**=:       :-:           
echo.      .+*+=:     =-:           
echo.   .    =**=:.  .::.           
echo.  =++:  .+++=-:.:...           
echo. .+***+-=++====:...  ...::--=+:
echo.  -**##****+===-:.. :=++++++-. 
echo.    :+***+**+==-:...::==-:.    
echo.     :=+++***++=-. ...         
echo.    :+====+++====-...          
echo.   =*=============-..          
echo. .+*+============++-:          
echo. .:=*=====+====++++=:          
echo.   .======+++=+++++-.          
echo.    .-====-+=:---:.            
echo.       -=:::. ..  Select Model Quality:
echo.
echo. 1. Very Low
echo. 2. Low
echo. 3. Medium
echo. 4. High
echo. 5. Very High
echo.
echo. 6. Back
echo.
set CHOICE=none
SET /P CHOICE=Please select an option: 
IF NOT %CHOICE%==1 IF NOT %CHOICE%==2 IF NOT %CHOICE%==3 IF NOT %CHOICE%==4 IF NOT %CHOICE%==5 IF NOT %CHOICE%==6 goto :new_config_models

IF %CHOICE%==1 (
    echo. >> %autoexecFile%
    echo //MODELS: VERY LOW >> %autoexecFile%
    type "%models_folder%\very_low_models.txt" >> %autoexecFile%
    echo set models=VERY LOW >> "%dev_folder%\configvars.bat"
    goto :new_config_shadows
)
IF %CHOICE%==2 (
    echo. >> %autoexecFile%
    echo //MODELS: LOW >> %autoexecFile%
    type "%models_folder%\low_models.txt" >> %autoexecFile%
    echo set models=LOW >> "%dev_folder%\configvars.bat"
    goto :new_config_shadows
)
IF %CHOICE%==3 (
    echo. >> %autoexecFile%
    echo //MODELS: MEDIUM >> %autoexecFile%
    type "%models_folder%\medium_models.txt" >> %autoexecFile%
    echo set models=MEDIUM >> "%dev_folder%\configvars.bat"
    goto :new_config_shadows
)
IF %CHOICE%==4 (
    echo. >> %autoexecFile%
    echo //MODELS: HIGH >> %autoexecFile%
    type "%models_folder%\high_models.txt" >> %autoexecFile%
    echo set models=HIGH >> "%dev_folder%\configvars.bat"
    goto :new_config_shadows
)
IF %CHOICE%==5 (
    echo. >> %autoexecFile%
    echo //MODELS: VERY HIGH >> %autoexecFile%
    type "%models_folder%\very_high_models.txt" >> %autoexecFile%
    echo set models=VERY HIGH >> "%dev_folder%\configvars.bat"
    goto :new_config_shadows
)
IF %CHOICE%==6 (
    goto :generator
)

:new_config_shadows
cls
echo.
echo. .-++=:.          .:.          
echo.    .=**=:       :-:           
echo.      .+*+=:     =-:           
echo.   .    =**=:.  .::.           
echo.  =++:  .+++=-:.:...           
echo. .+***+-=++====:...  ...::--=+:
echo.  -**##****+===-:.. :=++++++-. 
echo.    :+***+**+==-:...::==-:.    
echo.     :=+++***++=-. ...         
echo.    :+====+++====-...          
echo.   =*=============-..          
echo. .+*+============++-:          
echo. .:=*=====+====++++=:          
echo.   .======+++=+++++-.          
echo.    .-====-+=:---:.            
echo.       -=:::. ..  Select Shadow Quality:
echo.
echo. 1. Very Low
echo. 2. Low
echo. 3. Medium
echo. 4. High
echo. 5. Very High
echo.
echo. 6. Back
echo.
set CHOICE=none
SET /P CHOICE=Please select an option: 
IF NOT %CHOICE%==1 IF NOT %CHOICE%==2 IF NOT %CHOICE%==3 IF NOT %CHOICE%==4 IF NOT %CHOICE%==5 IF NOT %CHOICE%==6 goto :new_config_shadows

IF %CHOICE%==1 (
    echo. >> %autoexecFile%
    echo //SHADOWS: VERY LOW >> %autoexecFile%
    type "%shadows_folder%\very_low_shadows.txt" >> %autoexecFile%
    echo set shadows=VERY LOW >> "%dev_folder%\configvars.bat"
    goto :new_config_lighting
)
IF %CHOICE%==2 (
    echo. >> %autoexecFile%
    echo //SHADOWS: LOW >> %autoexecFile%
    type "%shadows_folder%\low_shadows.txt" >> %autoexecFile%
    echo set shadows=LOW >> "%dev_folder%\configvars.bat"
    goto :new_config_lighting
)
IF %CHOICE%==3 (
    echo. >> %autoexecFile%
    echo //SHADOWS: MEDIUM >> %autoexecFile%
    type "%shadows_folder%\medium_shadows.txt" >> %autoexecFile%
    echo set shadows=MEDIUM >> "%dev_folder%\configvars.bat"
    goto :new_config_lighting
)
IF %CHOICE%==4 (
    echo. >> %autoexecFile%
    echo //SHADOWS: HIGH >> %autoexecFile%
    type "%shadows_folder%\high_shadows.txt" >> %autoexecFile%
    echo set shadows=HIGH >> "%dev_folder%\configvars.bat"
    goto :new_config_lighting
)
IF %CHOICE%==5 (
    echo. >> %autoexecFile%
    echo //SHADOWS: VERY HIGH >> %autoexecFile%
    type "%shadows_folder%\very_high_shadows.txt" >> %autoexecFile%
    echo set shadows=VERY HIGH >> "%dev_folder%\configvars.bat"
    goto :new_config_lighting
)
IF %CHOICE%==6 (
    goto :generator
)

:new_config_lighting
cls
echo.
echo. .-++=:.          .:.          
echo.    .=**=:       :-:           
echo.      .+*+=:     =-:           
echo.   .    =**=:.  .::.           
echo.  =++:  .+++=-:.:...           
echo. .+***+-=++====:...  ...::--=+:
echo.  -**##****+===-:.. :=++++++-. 
echo.    :+***+**+==-:...::==-:.    
echo.     :=+++***++=-. ...         
echo.    :+====+++====-...          
echo.   =*=============-..          
echo. .+*+============++-:          
echo. .:=*=====+====++++=:          
echo.   .======+++=+++++-.          
echo.    .-====-+=:---:.            
echo.       -=:::. ..  Select Lighting Quality:
echo.
echo. 1. Very Low
echo. 2. Low
echo. 3. Medium
echo. 4. High
echo. 5. Very High
echo.
echo. 6. Back
echo.
set CHOICE=none
SET /P CHOICE=Please select an option: 
IF NOT %CHOICE%==1 IF NOT %CHOICE%==2 IF NOT %CHOICE%==3 IF NOT %CHOICE%==4 IF NOT %CHOICE%==5 IF NOT %CHOICE%==6 goto :new_config_lighting

IF %CHOICE%==1 (
    echo. >> %autoexecFile%
    echo //LIGHTING: VERY LOW >> %autoexecFile%
    type "%lighting_folder%\very_low_lighting.txt" >> %autoexecFile%
    echo set lighting=VERY LOW >> "%dev_folder%\configvars.bat"
    goto :new_config_water
)
IF %CHOICE%==2 (
    echo. >> %autoexecFile%
    echo //LIGHTING: LOW >> %autoexecFile%
    type "%lighting_folder%\low_lighting.txt" >> %autoexecFile%
    echo set lighting=LOW >> "%dev_folder%\configvars.bat"
    goto :new_config_water
)
IF %CHOICE%==3 (
    echo. >> %autoexecFile%
    echo //LIGHTING: MEDIUM >> %autoexecFile%
    type "%lighting_folder%\medium_lighting.txt" >> %autoexecFile%
    echo set lighting=MEDIUM >> "%dev_folder%\configvars.bat"
    goto :new_config_water
)
IF %CHOICE%==4 (
    echo. >> %autoexecFile%
    echo //LIGHTING: HIGH >> %autoexecFile%
    type "%lighting_folder%\high_lighting.txt" >> %autoexecFile%
    echo set lighting=HIGH >> "%dev_folder%\configvars.bat"
    goto :new_config_water
)
IF %CHOICE%==5 (
    echo. >> %autoexecFile%
    echo //LIGHTING: VERY HIGH >> %autoexecFile%
    type "%lighting_folder%\very_high_lighting.txt" >> %autoexecFile%
    echo set lighting=VERY HIGH >> "%dev_folder%\configvars.bat"
    goto :new_config_water
)
IF %CHOICE%==6 (
    goto :generator
)

:new_config_water
cls
echo.
echo. .-++=:.          .:.          
echo.    .=**=:       :-:           
echo.      .+*+=:     =-:           
echo.   .    =**=:.  .::.           
echo.  =++:  .+++=-:.:...           
echo. .+***+-=++====:...  ...::--=+:
echo.  -**##****+===-:.. :=++++++-. 
echo.    :+***+**+==-:...::==-:.    
echo.     :=+++***++=-. ...         
echo.    :+====+++====-...          
echo.   =*=============-..          
echo. .+*+============++-:          
echo. .:=*=====+====++++=:          
echo.   .======+++=+++++-.          
echo.    .-====-+=:---:.            
echo.       -=:::. ..  Select Water Quality:
echo.
echo. 1. Very Low
echo. 2. Low
echo. 3. Medium
echo. 4. High
echo. 5. Very High
echo.
echo. 6. Back
echo.
set CHOICE=none
SET /P CHOICE=Please select an option: 
IF NOT %CHOICE%==1 IF NOT %CHOICE%==2 IF NOT %CHOICE%==3 IF NOT %CHOICE%==4 IF NOT %CHOICE%==5 IF NOT %CHOICE%==6 goto :new_config_water

IF %CHOICE%==1 (
    echo. >> %autoexecFile%
    echo //WATER: VERY LOW >> %autoexecFile%
    type "%water_folder%\very_low_water.txt" >> %autoexecFile%
    echo set water=VERY LOW >> "%dev_folder%\configvars.bat"
    goto :new_config_antialiasing
)
IF %CHOICE%==2 (
    echo. >> %autoexecFile%
    echo //WATER: LOW >> %autoexecFile%
    type "%water_folder%\low_water.txt" >> %autoexecFile%
    echo set water=LOW >> "%dev_folder%\configvars.bat"
    goto :new_config_antialiasing
)
IF %CHOICE%==3 (
    echo. >> %autoexecFile%
    echo //WATER: MEDIUM >> %autoexecFile%
    type "%water_folder%\medium_water.txt" >> %autoexecFile%
    echo set water=MEDIUM >> "%dev_folder%\configvars.bat"
    goto :new_config_antialiasing
)
IF %CHOICE%==4 (
    echo. >> %autoexecFile%
    echo //WATER: HIGH >> %autoexecFile%
    type "%water_folder%\high_water.txt" >> %autoexecFile%
    echo set water=HIGH >> "%dev_folder%\configvars.bat"
    goto :new_config_antialiasing
)
IF %CHOICE%==5 (
    echo. >> %autoexecFile%
    echo //WATER: VERY HIGH >> %autoexecFile%
    type "%water_folder%\very_high_water.txt" >> %autoexecFile%
    echo set water=VERY HIGH >> "%dev_folder%\configvars.bat"
    goto :new_config_antialiasing
)
IF %CHOICE%==6 (
    goto :generator
)

:new_config_antialiasing
cls
echo.
echo. .-++=:.          .:.          
echo.    .=**=:       :-:           
echo.      .+*+=:     =-:           
echo.   .    =**=:.  .::.           
echo.  =++:  .+++=-:.:...           
echo. .+***+-=++====:...  ...::--=+:
echo.  -**##****+===-:.. :=++++++-. 
echo.    :+***+**+==-:...::==-:.    
echo.     :=+++***++=-. ...         
echo.    :+====+++====-...          
echo.   =*=============-..          
echo. .+*+============++-:          
echo. .:=*=====+====++++=:          
echo.   .======+++=+++++-.          
echo.    .-====-+=:---:.            
echo.       -=:::. ..  Select Antialiasing Quality:
echo.
echo. 1. Very Low
echo. 2. Low
echo. 3. Medium
echo. 4. High
echo. 5. Very High
echo.
echo. 6. Back
echo.
set CHOICE=none
SET /P CHOICE=Please select an option: 
IF NOT %CHOICE%==1 IF NOT %CHOICE%==2 IF NOT %CHOICE%==3 IF NOT %CHOICE%==4 IF NOT %CHOICE%==5 IF NOT %CHOICE%==6 goto :new_config_water

IF %CHOICE%==1 (
    echo. >> %autoexecFile%
    echo //AA: VERY LOW >> %autoexecFile%
    type "%antialias_folder%\very_low_aa.txt" >> %autoexecFile%
    echo set antialiasing=VERY LOW >> "%dev_folder%\configvars.bat"
    goto :new_config_facialfeatures
)
IF %CHOICE%==2 (
    echo. >> %autoexecFile%
    echo //AA: LOW >> %autoexecFile%
    type "%antialias_folder%\low_aa.txt" >> %autoexecFile%
    echo set antialiasing=LOW >> "%dev_folder%\configvars.bat"
    goto :new_config_facialfeatures
)
IF %CHOICE%==3 (
    echo. >> %autoexecFile%
    echo //AA: MEDIUM >> %autoexecFile%
    type "%antialias_folder%\medium_aa.txt" >> %autoexecFile%
    echo set antialiasing=MEDIUM >> "%dev_folder%\configvars.bat"
    goto :new_config_facialfeatures
)
IF %CHOICE%==4 (
    echo. >> %autoexecFile%
    echo //AA: HIGH >> %autoexecFile%
    type "%antialias_folder%\high_aa.txt" >> %autoexecFile%
    echo set antialiasing=HIGH >> "%dev_folder%\configvars.bat"
    goto :new_config_facialfeatures
)
IF %CHOICE%==5 (
    echo. >> %autoexecFile%
    echo //AA: VERY HIGH >> %autoexecFile%
    type "%antialias_folder%\very_high_aa.txt" >> %autoexecFile%
    echo set antialiasing=VERY HIGH >> "%dev_folder%\configvars.bat"
    goto :new_config_facialfeatures
)
IF %CHOICE%==6 (
    goto :generator
)

:new_config_facialfeatures
cls
echo.
echo. .-++=:.          .:.          
echo.    .=**=:       :-:           
echo.      .+*+=:     =-:           
echo.   .    =**=:.  .::.           
echo.  =++:  .+++=-:.:...           
echo. .+***+-=++====:...  ...::--=+:
echo.  -**##****+===-:.. :=++++++-. 
echo.    :+***+**+==-:...::==-:.    
echo.     :=+++***++=-. ...         
echo.    :+====+++====-...          
echo.   =*=============-..          
echo. .+*+============++-:          
echo. .:=*=====+====++++=:          
echo.   .======+++=+++++-.          
echo.    .-====-+=:---:.            
echo.       -=:::. ..  Select Facial Feature Quality:
echo.
echo. 1. Very Low
echo. 2. Low
echo. 3. Medium
echo. 4. High
echo. 5. Very High
echo.
echo. 6. Back
echo.
set CHOICE=none
SET /P CHOICE=Please select an option: 
IF NOT %CHOICE%==1 IF NOT %CHOICE%==2 IF NOT %CHOICE%==3 IF NOT %CHOICE%==4 IF NOT %CHOICE%==5 IF NOT %CHOICE%==6 goto :new_config_water

IF %CHOICE%==1 (
    echo. >> %autoexecFile%
    echo //FACIAL FEATURES: VERY LOW >> %autoexecFile%
    type "%facialfeatures_folder%\very_low_ff.txt" >> %autoexecFile%
    echo set facial_features=VERY LOW >> "%dev_folder%\configvars.bat"
    goto :new_config_ragdolls
)
IF %CHOICE%==2 (
    echo. >> %autoexecFile%
    echo //FACIAL FEATURES: LOW >> %autoexecFile%
    type "%facialfeatures_folder%\low_ff.txt" >> %autoexecFile%
    echo set facial_features=LOW >> "%dev_folder%\configvars.bat"
    goto :new_config_ragdolls
)
IF %CHOICE%==3 (
    echo. >> %autoexecFile%
    echo //FACIAL FEATURES: MEDIUM >> %autoexecFile%
    type "%facialfeatures_folder%\medium_ff.txt" >> %autoexecFile%
    echo set facial_features=MEDIUM >> "%dev_folder%\configvars.bat"
    goto :new_config_ragdolls
)
IF %CHOICE%==4 (
    echo. >> %autoexecFile%
    echo //FACIAL FEATURES: HIGH >> %autoexecFile%
    type "%facialfeatures_folder%\high_ff.txt" >> %autoexecFile%
    echo set facial_features=HIGH >> "%dev_folder%\configvars.bat"
    goto :new_config_ragdolls
)
IF %CHOICE%==5 (
    echo. >> %autoexecFile%
    echo //FACIAL FEATURES: VERY HIGH >> %autoexecFile%
    type "%facialfeatures_folder%\very_high_ff.txt" >> %autoexecFile%
    echo set facial_features=VERY HIGH >> "%dev_folder%\configvars.bat"
    goto :new_config_ragdolls
)
IF %CHOICE%==6 (
    goto :generator
)

:new_config_ragdolls
cls
echo.
echo. .-++=:.          .:.          
echo.    .=**=:       :-:           
echo.      .+*+=:     =-:           
echo.   .    =**=:.  .::.           
echo.  =++:  .+++=-:.:...           
echo. .+***+-=++====:...  ...::--=+:
echo.  -**##****+===-:.. :=++++++-. 
echo.    :+***+**+==-:...::==-:.    
echo.     :=+++***++=-. ...         
echo.    :+====+++====-...          
echo.   =*=============-..          
echo. .+*+============++-:          
echo. .:=*=====+====++++=:          
echo.   .======+++=+++++-.          
echo.    .-====-+=:---:.            
echo.       -=:::. ..  Select Ragdoll Quality:
echo.
echo. 1. Very Low
echo. 2. Low
echo. 3. Medium
echo. 4. High
echo. 5. Very High
echo.
echo. 6. Back
echo.
set CHOICE=none
SET /P CHOICE=Please select an option: 
IF NOT %CHOICE%==1 IF NOT %CHOICE%==2 IF NOT %CHOICE%==3 IF NOT %CHOICE%==4 IF NOT %CHOICE%==5 IF NOT %CHOICE%==6 goto :new_config_water

IF %CHOICE%==1 (
    echo. >> %autoexecFile%
    echo //RAGDOLLS: VERY LOW >> %autoexecFile%
    type "%ragdoll_folder%\very_low_ragdolls.txt" >> %autoexecFile%
    echo set ragdolls=VERY LOW >> "%dev_folder%\configvars.bat"
    goto :new_config_props
)
IF %CHOICE%==2 (
    echo. >> %autoexecFile%
    echo //RAGDOLLS: LOW >> %autoexecFile%
    type "%ragdoll_folder%\low_ragdolls.txt" >> %autoexecFile%
    echo set ragdolls=LOW >> "%dev_folder%\configvars.bat"
    goto :new_config_props
)
IF %CHOICE%==3 (
    echo. >> %autoexecFile%
    echo //RAGDOLLS: MEDIUM >> %autoexecFile%
    type "%ragdoll_folder%\medium_ragdolls.txt" >> %autoexecFile%
    echo set ragdolls=MEDIUM >> "%dev_folder%\configvars.bat"
    goto :new_config_props
)
IF %CHOICE%==4 (
    echo. >> %autoexecFile%
    echo //RAGDOLLS: HIGH >> %autoexecFile%
    type "%ragdoll_folder%\high_ragdolls.txt" >> %autoexecFile%
    echo set ragdolls=HIGH >> "%dev_folder%\configvars.bat"
    goto :new_config_props
)
IF %CHOICE%==5 (
    echo. >> %autoexecFile%
    echo //RAGDOLLS: VERY HIGH >> %autoexecFile%
    type "%ragdoll_folder%\very_high_ragdolls.txt" >> %autoexecFile%
    echo set ragdolls=VERY HIGH >> "%dev_folder%\configvars.bat"
    goto :new_config_props
)
IF %CHOICE%==6 (
    goto :generator
)

:new_config_props
cls
echo.
echo. .-++=:.          .:.          
echo.    .=**=:       :-:           
echo.      .+*+=:     =-:           
echo.   .    =**=:.  .::.           
echo.  =++:  .+++=-:.:...           
echo. .+***+-=++====:...  ...::--=+:
echo.  -**##****+===-:.. :=++++++-. 
echo.    :+***+**+==-:...::==-:.    
echo.     :=+++***++=-. ...         
echo.    :+====+++====-...          
echo.   =*=============-..          
echo. .+*+============++-:          
echo. .:=*=====+====++++=:          
echo.   .======+++=+++++-.          
echo.    .-====-+=:---:.            
echo.       -=:::. ..  Select Prop Quality:
echo.
echo. 1. Very Low
echo. 2. Low
echo. 3. Medium
echo. 4. High
echo. 5. Very High
echo.
echo. 6. Back
echo.
set CHOICE=none
SET /P CHOICE=Please select an option: 
IF NOT %CHOICE%==1 IF NOT %CHOICE%==2 IF NOT %CHOICE%==3 IF NOT %CHOICE%==4 IF NOT %CHOICE%==5 IF NOT %CHOICE%==6 goto :new_config_water

IF %CHOICE%==1 (
    echo. >> %autoexecFile%
    echo //PROPS: VERY LOW >> %autoexecFile%
    type "%props_folder%\very_low_props.txt" >> %autoexecFile%
    echo set props=VERY LOW >> "%dev_folder%\configvars.bat"
    goto :new_config_decals
)
IF %CHOICE%==2 (
    echo. >> %autoexecFile%
    echo //PROPS: LOW >> %autoexecFile%
    type "%props_folder%\low_props.txt" >> %autoexecFile%
    echo set props=LOW >> "%dev_folder%\configvars.bat"
    goto :new_config_decals
)
IF %CHOICE%==3 (
    echo. >> %autoexecFile%
    echo //PROPS: MEDIUM >> %autoexecFile%
    type "%props_folder%\medium_props.txt" >> %autoexecFile%
    echo set props=MEDIUM >> "%dev_folder%\configvars.bat"
    goto :new_config_decals
)
IF %CHOICE%==4 (
    echo. >> %autoexecFile%
    echo //PROPS: HIGH >> %autoexecFile%
    type "%ragdoll_folder%\high_props.txt" >> %autoexecFile%
    echo set props=HIGH >> "%dev_folder%\configvars.bat"
    goto :new_config_decals
)
IF %CHOICE%==5 (
    echo. >> %autoexecFile%
    echo //PROPS: VERY HIGH >> %autoexecFile%
    type "%props_folder%\very_high_props.txt" >> %autoexecFile%
    echo set props=VERY HIGH >> "%dev_folder%\configvars.bat"
    goto :new_config_decals
)
IF %CHOICE%==6 (
    goto :generator
)

:new_config_decals
cls
echo.
echo. .-++=:.          .:.          
echo.    .=**=:       :-:           
echo.      .+*+=:     =-:           
echo.   .    =**=:.  .::.           
echo.  =++:  .+++=-:.:...           
echo. .+***+-=++====:...  ...::--=+:
echo.  -**##****+===-:.. :=++++++-. 
echo.    :+***+**+==-:...::==-:.    
echo.     :=+++***++=-. ...         
echo.    :+====+++====-...          
echo.   =*=============-..          
echo. .+*+============++-:          
echo. .:=*=====+====++++=:          
echo.   .======+++=+++++-.          
echo.    .-====-+=:---:.            
echo.       -=:::. ..  Select Decals Quality:
echo.
echo. 1. Very Low
echo. 2. Low
echo. 3. Medium
echo. 4. High
echo. 5. Very High
echo.
echo. 6. Back
echo.
set CHOICE=none
SET /P CHOICE=Please select an option: 
IF NOT %CHOICE%==1 IF NOT %CHOICE%==2 IF NOT %CHOICE%==3 IF NOT %CHOICE%==4 IF NOT %CHOICE%==5 IF NOT %CHOICE%==6 goto :new_config_water

IF %CHOICE%==1 (
    echo. >> %autoexecFile%
    echo //DECALS: VERY LOW >> %autoexecFile%
    type "%decals_folder%\very_low_decals.txt" >> %autoexecFile%
    echo set decals=VERY LOW >> "%dev_folder%\configvars.bat"
    goto :new_config_ropes
)
IF %CHOICE%==2 (
    echo. >> %autoexecFile%
    echo //DECALS: LOW >> %autoexecFile%
    type "%decals_folder%\low_decals.txt" >> %autoexecFile%
    echo set decals=LOW >> "%dev_folder%\configvars.bat"
    goto :new_config_ropes
)
IF %CHOICE%==3 (
    echo. >> %autoexecFile%
    echo //DECALS: MEDIUM >> %autoexecFile%
    type "%decals_folder%\medium_decals.txt" >> %autoexecFile%
    echo set decals=MEDIUM >> "%dev_folder%\configvars.bat"
    goto :new_config_ropes
)
IF %CHOICE%==4 (
    echo. >> %autoexecFile%
    echo //DECALS: HIGH >> %autoexecFile%
    type "%decals_folder%\high_decals.txt" >> %autoexecFile%
    echo set decals=HIGH >> "%dev_folder%\configvars.bat"
    goto :new_config_ropes
)
IF %CHOICE%==5 (
    echo. >> %autoexecFile%
    echo //DECALS: VERY HIGH >> %autoexecFile%
    type "%decals_folder%\very_high_decals.txt" >> %autoexecFile%
    echo set decals=VERY HIGH >> "%dev_folder%\configvars.bat"
    goto :new_config_ropes
)
IF %CHOICE%==6 (
    goto :generator
)

:new_config_ropes
cls
echo.
echo. .-++=:.          .:.          
echo.    .=**=:       :-:           
echo.      .+*+=:     =-:           
echo.   .    =**=:.  .::.           
echo.  =++:  .+++=-:.:...           
echo. .+***+-=++====:...  ...::--=+:
echo.  -**##****+===-:.. :=++++++-. 
echo.    :+***+**+==-:...::==-:.    
echo.     :=+++***++=-. ...         
echo.    :+====+++====-...          
echo.   =*=============-..          
echo. .+*+============++-:          
echo. .:=*=====+====++++=:          
echo.   .======+++=+++++-.          
echo.    .-====-+=:---:.            
echo.       -=:::. ..  Select Rope Quality:
echo.
echo. 1. Very Low
echo. 2. Low
echo. 3. Medium
echo. 4. High
echo. 5. Very High
echo.
echo. 6. Back
echo.
set CHOICE=none
SET /P CHOICE=Please select an option: 
IF NOT %CHOICE%==1 IF NOT %CHOICE%==2 IF NOT %CHOICE%==3 IF NOT %CHOICE%==4 IF NOT %CHOICE%==5 IF NOT %CHOICE%==6 goto :new_config_water

IF %CHOICE%==1 (
    echo. >> %autoexecFile%
    echo //ROPES: VERY LOW >> %autoexecFile%
    type "%ropes_folder%\very_low_ropes.txt" >> %autoexecFile%
    echo set ropes=VERY LOW >> "%dev_folder%\configvars.bat"
)
IF %CHOICE%==2 (
    echo. >> %autoexecFile%
    echo //ROPES: LOW >> %autoexecFile%
    type "%ropes_folder%\low_ropes.txt" >> %autoexecFile%
    echo set ropes=LOW >> "%dev_folder%\configvars.bat"
)
IF %CHOICE%==3 (
    echo. >> %autoexecFile%
    echo //ROPES: MEDIUM >> %autoexecFile%
    type "%ropes_folder%\medium_ropes.txt" >> %autoexecFile%
    echo set ropes=MEDIUM >> "%dev_folder%\configvars.bat"
)
IF %CHOICE%==4 (
    echo. >> %autoexecFile%
    echo //ROPES: HIGH >> %autoexecFile%
    type "%ropes_folder%\high_ropes.txt" >> %autoexecFile%
    echo set ropes=HIGH >> "%dev_folder%\configvars.bat"
)
IF %CHOICE%==5 (
    echo. >> %autoexecFile%
    echo //ROPES: VERY HIGH >> %autoexecFile%
    type "%ropes_folder%\very_high_ropes.txt" >> %autoexecFile%
    echo set ropes=VERY HIGH >> "%dev_folder%\configvars.bat"
)
IF %CHOICE%==6 (
    goto :generator
)

:new_config_finish
call "%dev_folder%\configvars.bat"
setlocal DISABLEDELAYEDEXPANSION
cls
echo.
echo. .-++=:.          .:.          
echo.    .=**=:       :-:           
echo.      .+*+=:     =-:           
echo.   .    =**=:.  .::.           
echo.  =++:  .+++=-:.:...           
echo. .+***+-=++====:...  ...::--=+:
echo.  -**##****+===-:.. :=++++++-. 
echo.    :+***+**+==-:...::==-:.    
echo.     :=+++***++=-. ...         
echo.    :+====+++====-...          
echo.   =*=============-..          
echo. .+*+============++-:          
echo. .:=*=====+====++++=:          
echo.   .======+++=+++++-.          
echo.    .-====-+=:---:.            
echo.       -=:::. ..  Configuration Done!
echo.
echo. Your selected settings:
echo. 
echo. Textures: %textures%
echo. Models: %models%
echo. Shadows: %shadows%
echo. Lighting: %lighting%
echo. Water: %water%
echo. Antialiasing: %antialiasing%
echo. Facial Features: %facial_features%
echo. Ragdolls: %ragdolls%
echo. Props: %props%
echo. Decals: %decals%
echo. Ropes: %ropes%
echo.
echo. 1. Install scripts
echo. 2. Go to Main Menu
echo. 3. Quit App
echo.
setlocal ENABLEDELAYEDEXPANSION
set CHOICE=none
SET /P CHOICE=Please select an option: 
IF NOT %CHOICE%==1 IF NOT %CHOICE%==2 IF NOT %CHOICE%==3 goto :new_config_finish

IF %CHOICE%==1 (
    echo NOT DONE
)
IF %CHOICE%==2 (
    goto :main_menu
)
IF %CHOICE%==3 (
    cls
    goto :eof
)

:new_config_scripts
call "%dev_folder%\configvars.bat"
IF %nullmovement_installed%==TRUE set nullmovement_status=X
IF %nullmovement_installed%==FALSE set nullmovement_status= 
IF %notutorial_installed%==TRUE set notutorial_status=X
IF %notutorial_installed%==FALSE set notutorial_status= 
IF %preload_installed%==TRUE set preload_status=X
IF %preload_installed%==FALSE set preload_status= 

cls
echo.
echo. .-++=:.          .:.          
echo.    .=**=:       :-:           
echo.      .+*+=:     =-:           
echo.   .    =**=:.  .::.           
echo.  =++:  .+++=-:.:...           
echo. .+***+-=++====:...  ...::--=+:
echo.  -**##****+===-:.. :=++++++-. 
echo.    :+***+**+==-:...::==-:.    
echo.     :=+++***++=-. ...         
echo.    :+====+++====-...          
echo.   =*=============-..          
echo. .+*+============++-:          
echo. .:=*=====+====++++=:          
echo.   .======+++=+++++-.          
echo.    .-====-+=:---:.            
echo.       -=:::. ..  Select scripts to install.
echo.
echo. 1. Null-Movement Script [%nullmovement_status%]
echo. 2. No Tutorial Script [%notutorial_status%]
echo. 3. Preload Script [%preload_status%]
echo.
echo. 4. Back
echo.
set CHOICE=none
SET /P CHOICE=Please select an option: 
IF NOT %CHOICE%==1 IF NOT %CHOICE%==2 IF NOT %CHOICE%==3 IF NOT %CHOICE%==4 IF NOT %CHOICE%==5 goto :new_config_scripts

IF %CHOICE%==1 (
    goto :scripts_nullmovement
)
IF %CHOICE%==2 (
    goto :scripts_notutorial
)
IF %CHOICE%==3 (
    goto :scripts_preload
)
IF %CHOICE%==4 (
    goto :main_menu
)

:scripts_preload
setlocal DISABLEDELAYEDEXPANSION
cls
echo.
echo. .-++=:.          .:.          
echo.    .=**=:       :-:           
echo.      .+*+=:     =-:           
echo.   .    =**=:.  .::.           
echo.  =++:  .+++=-:.:...           
echo. .+***+-=++====:...  ...::--=+:
echo.  -**##****+===-:.. :=++++++-. 
echo.    :+***+**+==-:...::==-:.    
echo.     :=+++***++=-. ...         
echo.    :+====+++====-...          
echo.   =*=============-..          
echo. .+*+============++-:          
echo. .:=*=====+====++++=:          
echo.   .======+++=+++++-.          
echo.    .-====-+=:---:.            
echo.       -=:::. ..  Install Preload Script?
echo.
echo. About script: Preloads models and textures. Useful for using mods on valve
echo. servers. MAY CAUSE CRASHING!!
echo.
echo. 1. Install Preload Script
echo. 2. Back
echo.
setlocal ENABLEDELAYEDEXPANSION
SET /P CHOICE=Please select an option: 
IF NOT %CHOICE%==1 IF NOT %CHOICE%==2 goto :scripts_preload

IF %CHOICE%==1 (
    CD scripts 2>NUL && CD .. || mkdir scripts
    cd scripts
    type "%scripts_folder%\preload.txt" > preload.cfg
    set preload_installed=TRUE
    echo set preload_installed=TRUE >> "%dev_folder%\configvars.bat"
    echo exec scripts/preload.cfg >> %autoexecFile%
    goto :new_config_scripts
)
IF %CHOICE%==2 (
    goto :new_config_scripts
)

:scripts_notutorial
cls
echo.
echo. .-++=:.          .:.          
echo.    .=**=:       :-:           
echo.      .+*+=:     =-:           
echo.   .    =**=:.  .::.           
echo.  =++:  .+++=-:.:...           
echo. .+***+-=++====:...  ...::--=+:
echo.  -**##****+===-:.. :=++++++-. 
echo.    :+***+**+==-:...::==-:.    
echo.     :=+++***++=-. ...         
echo.    :+====+++====-...          
echo.   =*=============-..          
echo. .+*+============++-:          
echo. .:=*=====+====++++=:          
echo.   .======+++=+++++-.          
echo.    .-====-+=:---:.            
echo.       -=:::. ..  Install No Tutorial Script?
echo.
echo. About script: Disables all tutorials in-game.
echo.
echo. 1. Install No Tutorial Script
echo. 2. Back
echo.
SET /P CHOICE=Please select an option: 
IF NOT %CHOICE%==1 IF NOT %CHOICE%==2 goto :scripts_notutorial

IF %CHOICE%==1 (
    CD scripts 2>NUL && CD .. || mkdir scripts
    cd scripts
    type "%scripts_folder%\notutorial.txt" > notutorial.cfg
    set notutorial_installed=TRUE
    echo set notutorial_installed=TRUE >> "%dev_folder%\configvars.bat"
    echo exec scripts/notutorial.cfg >> %autoexecFile%
    goto :new_config_scripts
)
IF %CHOICE%==2 (
    goto :new_config_scripts
)

:scripts_nullmovement
cls
echo.
echo. .-++=:.          .:.          
echo.    .=**=:       :-:           
echo.      .+*+=:     =-:           
echo.   .    =**=:.  .::.           
echo.  =++:  .+++=-:.:...           
echo. .+***+-=++====:...  ...::--=+:
echo.  -**##****+===-:.. :=++++++-. 
echo.    :+***+**+==-:...::==-:.    
echo.     :=+++***++=-. ...         
echo.    :+====+++====-...          
echo.   =*=============-..          
echo. .+*+============++-:          
echo. .:=*=====+====++++=:          
echo.   .======+++=+++++-.          
echo.    .-====-+=:---:.            
echo.       -=:::. ..  Install Null-Movement Script?
echo.
echo. About script: Allows movement keys to override each other 
echo. rather than cancel each other out.
echo.
echo. 1. Install Null-Movement Script
echo. 2. Back
echo.
set CHOICE=none
SET /P CHOICE=Please select an option: 
IF NOT %CHOICE%==1 IF NOT %CHOICE%==2 goto :scripts_nullmovement

IF %CHOICE%==1 (
    CD scripts 2>NUL && CD .. || mkdir scripts
    cd scripts
    type "%scripts_folder%\nullmovement.txt" > null.cfg
    set nullmovement_installed=TRUE
    echo set nullmovement_installed=TRUE >> "%dev_folder%\configvars.bat"
    echo exec scripts/null.cfg >> %autoexecFile%
    goto :new_config_scripts
)
IF %CHOICE%==2 (
    goto :new_config_scripts
)

:backup_on
cls
echo.
echo. .-++=:.          .:.          
echo.    .=**=:       :-:           
echo.      .+*+=:     =-:           
echo.   .    =**=:.  .::.           
echo.  =++:  .+++=-:.:...           
echo. .+***+-=++====:...  ...::--=+:
echo.  -**##****+===-:.. :=++++++-. 
echo.    :+***+**+==-:...::==-:.    
echo.     :=+++***++=-. ...         
echo.    :+====+++====-...          
echo.   =*=============-..          
echo. .+*+============++-:          
echo. .:=*=====+====++++=:          
echo.   .======+++=+++++-.          
echo.    .-====-+=:---:.            
set CHOICE=none
SET /P CHOICE=       -=:::. ..  Do you want to disable automatic backup? (Y/N): 
IF NOT %CHOICE%==y IF NOT %CHOICE%==Y IF NOT %CHOICE%==n IF NOT %CHOICE%==N goto :backup_on

IF %CHOICE%==y (
    set automatic_backup=off
    goto :main_menu
)
IF %CHOICE%==Y (
    set automatic_backup=off
    goto :main_menu
)
IF %CHOICE%==n (
    goto :main_menu
)
IF %CHOICE%==N (
    goto :main_menu
)

:backup_off
cls
echo.
echo. .-++=:.          .:.          
echo.    .=**=:       :-:           
echo.      .+*+=:     =-:           
echo.   .    =**=:.  .::.           
echo.  =++:  .+++=-:.:...           
echo. .+***+-=++====:...  ...::--=+:
echo.  -**##****+===-:.. :=++++++-. 
echo.    :+***+**+==-:...::==-:.    
echo.     :=+++***++=-. ...         
echo.    :+====+++====-...          
echo.   =*=============-..          
echo. .+*+============++-:          
echo. .:=*=====+====++++=:          
echo.   .======+++=+++++-.          
echo.    .-====-+=:---:.            
set CHOICE=none
SET /P CHOICE=       -=:::. ..  Do you want to enable automatic backup? (Y/N): 
IF NOT %CHOICE%==y IF NOT %CHOICE%==Y IF NOT %CHOICE%==n IF NOT %CHOICE%==N goto :backup_off

IF %CHOICE%==y (
    set automatic_backup=on
    goto :backup
)
IF %CHOICE%==Y (
    set automatic_backup=on
    goto :backup
)
IF %CHOICE%==n (
    goto :main_menu
)
IF %CHOICE%==N (
    goto :main_menu
)

:invalid_folder
color 4F
echo WRONG FOLDER
echo "_GENERATE.bat" MUST BE CONTAINED IN THE "TF2GCC" FOLDER, AND
echo THE "TF2GCC" FOLDER MUST BE LOCATED IN THE "tf/custom" FOLDER
endlocal
pause
goto :eof