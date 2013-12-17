
function [] = BF_display_Start(viewMode, observer_initials, exp_num)
        %BF_display_Start(viewMode, WhatDefaultParams, observer_initials)
      %David Hoffman
      %July 2, 2008 Eventually this will be the roon experiment file for BF
      %Lens system based display
    clear GL;
    tic;
%     clear java;
    %profile on;
    
    
    %David has adapted the anaglyph teapot demo to use dual displays on
    %10/27/07
    %Getting rid of the silly teapot and putting in some other primatives
    %at different depths
    
    
    if (exist([pwd '/BF_display_Start.m'])~=2)
        disp('********************************************************************************')
        disp('*********************************ERROR******************************************')
        disp('********************************************************************************')
        disp('*************Please set the working Directory to the PTBLayers******************')
        disp('********************************************************************************')
        disp('********************************************************************************')
        disp('********************************************************************************')
        disp('********************************************************************************')
        return
        
    end
    
    


         global IPD;
         global nearClip;
         global farClip;
         global vertFOV;
         global horizFOV;
         global deghorizoffset;
         global degvertoffset; 
         global vertFOVoffset;
         global horizFOVoffset; 
         global GL;

if ~exist('viewMode', 'var')
    viewMode = 9;
    disp('**************No Stereo Mode entered*************, defaulting to Anaglyph')
end    
if ~exist('observer_initials', 'var') 
    observer_initials= 'DBUG';
end
if ~exist('exp_num', 'var')
    exp_num= 'exp_0';
end
if ~exist('parameter_setting', 'var')
    parameter_setting=1;
end


if ~exist([observer_initials '.m'], 'file' )
    disp(['***********There is no observer known as ' observer_initials '  *********************'])
    disp('***********Please make a parameter file for this observer****************************')
    return
end

if ~exist([exp_num '.m'], 'file')
    disp(['***********There is no testfile known as ' exp_num '  *********************'])
    disp('***********Please check the test file****************************')
    return
end



     % Is the script running in OpenGL Psychtoolbox?
    AssertOpenGL;   
    %InitializeMatlabOpenGL;
    InitializeMatlabOpenGL(0,0);
    Screen('Preference', 'SkipSyncTests', 0);
    % Find the screen to use for display:
    screenid=max(Screen('Screens'));

    if viewMode == 10
        % Yes. Do we have at least two separate displays for both views?
        if length(Screen('Screens')) < 2
            error('Sorry, for stereoMode 10 you''ll need at least 2 separate display screens in non-mirrored mode.');
        end
        
        if ~IsWin
            % Assign left-eye view (the master window) to main display:
            screenid = 0;
        else
            % Assign left-eye view (the master window) to main display:
            screenid = 1;
        end

        %Change the screen resolutions
        current_resolution=Screen('Resolution',1);
%         if current_resolution.width==1056;
%             oldres=SetResolution(0, 640, 480, 180);
%             SetResolution(1, 640, 480, 180);
%         else
%             oldres=current_resolution;
%         end


    end
    
     
  %Load the special params for a specific user
    eval([observer_initials]);  
    %The observer_initials must contain the IPD, parameter_setting, and
    %calibration settings
    
    
%Make sure that the display is configured correctly for the observer
disp('*************************CHECKLIST******************************')
disp('****************************************************************')
disp('*********************SET IPD************************************')
disp('*********************SET HAPLOSCOPE VERGENCE********************')
disp('****************************************************************')
disp('****************************************************************')
disp('****************************************************************')
disp('********************PRESS RETURN TO INITIALIZE******************')
disp('****************************************************************')
disp('****************************************************************')
disp('****************************************************************')


pause()
    
%         
    vertFOV= 23.3;  %degrees absolute
    horizFOV= 32.6;  %degrees 
%     % For non-bf-lens haploscope:
%     vertFOV= 44*0.9;  %degrees absolute
%     horizFOV= 57*0.9;  %degrees '

    % Below is dioptric distance of actual experimental setup.
    % Format: [Farthest, FarMid, MidNear, Near]
    dio=[0 0.575 1.28 1.785];
    % Change it to metric distances that have following characteristics.
    % 1. The farthest distance is better to be less than 2 meters.
    % 2. The relative difference between dioptric distances should not
    % changed.
    observer_initials_length=length(observer_initials);
    tempStart=observer_initials_length-3;
    tempEnd=observer_initials_length;
    tempTestSequence=observer_initials(tempStart:tempEnd);
    if strcmp(exp_num,'exp_specularity') || strcmp(tempTestSequence,'spec')
        imageplanedist=1./(3.1887+dio); % far-mid plane at 27cm away.
        % NOTE!
        % Because of base distance difference, subjects need separate
        % calibration.
    else
        imageplanedist=1./(0.6988+dio);
    end

    %Make the distance handles
    FarDist=imageplanedist(1);
    FarMidDist=imageplanedist(2);
    MidNearDist=imageplanedist(3);
    NearDist=imageplanedist(4);
    %UberNearDist and UberUberNearDist are only used as convergence distances.
    UberNearDist=1/(0.6988+2.4);
    UberUberNearDist=1/(0.6988+3.0);
    %UberFarDist, only used as vergence distance
    UberFarDist=1/(0.6988-0.6);

    MidpointFarMidDist=2/(1/imageplanedist(1)+1/imageplanedist(2));  %Dioptric midpoint
    MidpointMidMidDist=2/(1/imageplanedist(2)+1/imageplanedist(3));  %Dioptric midpoint
    MidpointMidNearDist=2/(1/imageplanedist(3)+1/imageplanedist(4));  %Dioptric midpoint

    SuperNearDist=1/(1/imageplanedist(4)+0.6);
    %end of distance handles
    




% load([pwd '/BF_params/BF_CLUTlookuptables.mat']);
% 
% 
% %Load the test specific parameters, and if staircases are used, start those
% %too
% %BF_CLUT_L= flipud(BF_CLUT_L)/255;
% BF_CLUT_L= (BF_CLUT_L)/255;
% BF_CLUT_R=BF_CLUT_R/255;




eval([exp_num]);

                     
    % Disable Synctests for this simple demo:
    %Screen('Preference','SkipSyncTests',1);            
 
     ListenChar(2)
    
    
%      try
    
    % Enable unified mode of KbName, so KbName accepts identical key names on
    % all operating systems:
    KbName('UnifyKeyNames');


    

        
    

        % For Psychtoolbox 3.x
    % Disable the Warnings and checks
    %oldEnableFlag   = Screen('Preference', 'SuppressAllWarnings', 1);
    %oldSyncTests    = Screen('Preference', 'SkipSyncTests', 1);
    %oldVisualDebug  = Screen('Preference', 'VisualDebugLevel', 0);
    
    % Setup image processing pipeline:
    PsychImaging('PrepareConfiguration');
    
    % Load and apply display calibration/undistortion for left and right
    % view channels: The zero flag means: don't plot any calibration
    % figures. The two optional values define xLoomSize and yLoomSize - the
    % density of the undistortion mesh. They default to 73 and 53 resp. if left out:
    
%     PsychImaging('AddTask', 'AllViews','FlipHorizontal');  
%     PsychImaging('AddTask', 'RightView' , 'GeometryCorrection', 'BVLCalibdata_CAM20130425_1_800_600_180.mat', 0, 37, 27);
%    PsychImaging('AddTask', 'RightView' , 'GeometryCorrection', 'BVLCalibdata_JSK20090908_1_800_600_180.mat', 0, 37, 27);
%     PsychImaging('AddTask', 'LeftView', 'GeometryCorrection', 'BVLCalibdata_T_S20090908_0_800_600_180.mat', 0, 37, 27);
    PsychImaging('AddTask', 'RightView','GeometryCorrection','BVLCalibdata_1_800_600_180hz_08122013_MB_RA_JK.mat',0,37,27);
    PsychImaging('AddTask', 'LeftView','GeometryCorrection','BVLCalibdata_0_800_600_180hz_08142013_MB_JK.mat',0,37,27);

    % Note:  Comment-out the two preceding lines for use with non-bf-lens hapoloscope
    
    % This line would enable horizontal mirroring of images on both stereo
    % views:
    PsychImaging('AddTask', 'AllViews','FlipHorizontal');  
    %PsychImaging('AddTask', 'AllViews','FlipVertical');


    % Open a double-buffered full-screen window on the main displays screen.
    %[windowPtr , winRect] = Screen('OpenWindow', screenid, 0, [], [], [], viewMode, [], kPsychNeedFastBackingStore);
    %This one just below was the old one that I used
    %[windowPtr, windowRect] = Screen('OpenWindow', screenid, 0, [], 32, 2, 0, 8);
    
    
    
    % Open a double-buffered full-screen window on the main displays screen
    % in stereo display mode 'viewMode' and background clear color black
    % (aka 0). This will enable the image processing operations - display
    % undistortion for both views:

	if strcmp(experiment_type,'demomode2')
		PsychImaging('AddTask','General','FloatikngPoint16Bit');
		PsychImaging('AddTask','General','UseFastOffscreenWindows');
	end
    if strcmp(experiment_type,'specularity')
        PsychImaging('AddTask','General','FloatingPoint16Bit');
        PsychImaging('AddTask','General','UseFastOffscreenWindows');
    end
    [windowPtr, winRect] = PsychImaging('OpenWindow', screenid, 0, [], [], [], viewMode, []);
	if strcmp(experiment_type,'demomode2')
		Screen('Blendfunction',windowPtr,GL_SRC_ALPHA,GL_ONE);
		woff=Screen('OpenOffscreenWindow',windowPtr,BlackIndex(windowPtr));
		w_1l=Screen('OpenOffscreenWindow',windowPtr,BlackIndex(windowPtr));
		w_1r=Screen('OpenOffscreenWindow',windowPtr,BlackIndex(windowPtr));
		w_2l=Screen('OpenOffscreenWindow',windowPtr,BlackIndex(windowPtr));
		w_2r=Screen('OpenOffscreenWindow',windowPtr,BlackIndex(windowPtr));
		w_3l=Screen('OpenOffscreenWindow',windowPtr,BlackIndex(windowPtr));
		w_3r=Screen('OpenOffscreenWindow',windowPtr,BlackIndex(windowPtr));
		w_4l=Screen('OpenOffscreenWindow',windowPtr,BlackIndex(windowPtr));
		w_4r=Screen('OpenOffscreenWindow',windowPtr,BlackIndex(windowPtr));
    end
%     if strcmp(experiment_type,'specularity')
% 		w_reflectionBuffer=Screen('OpenOffscreenWindow',windowPtr,BlackIndex(windowPtr));
%     end
    if viewMode==10 % BF display
        load('BF_params/BF_correctedLinearGamma.mat');
        origGamma=Screen('LoadNormalizedGammaTable', windowPtr, correctedGamma{1});
    elseif viewMode==9 % probably desktop or laptop
        % skip gamma adjustment
%         load('BF_params/BF_CLUTlookuptables.mat');
%         origGamma=Screen('LoadNormalizedGammaTable', windowPtr, BF_CLUT_L);
    elseif viewMode==4 % BF display with DATAPixx
        load('BF_params/correctedLinearGamma_256steps_zeroOffset.mat');
        
        if strcmp(experiment_type, 'monocular_hinge')
            correctedGamma{2} = transpose(repmat(0:1/255:1, [3 1]));
        end
        origGamma=Screen('LoadNormalizedGammaTable', windowPtr, correctedGamma{2});
    end
    
    if viewMode == 10
        % In dual-window, dual-display mode, we open the slave window on
        % the secondary screen. Please note that, after opening this window
        % with the same parameters as the "master-window", we won't touch
        % it anymore until the end of the experiment. PTB will take care of 
        % managing this window automatically as appropriate for a stereo
        % display setup. That is why we are not even interested in the window
        % handles of this window:
        if IsWin
            slaveScreen = 2;
        else
            slaveScreen = 1;
        end
        %[winnum, windRect]=Screen('OpenWindow', slaveScreen, 0, [], [], [], viewMode, [], kPsychNeedFastBackingStore);
        %The above line was for before the calibration was added
% 		if strcmp(experiment_type,'demomode2')
% 			PsychImaging('PrepareConfiguration');
% 			PsychImaging('AddTask','General','FloatikngPoint16Bit');
% 			PsychImaging('AddTask','General','UseFastOffscreenWindows');
% 		end
        [windowPtr2, winRect2]=Screen('OpenWindow', slaveScreen, 0, [], [], [], viewMode);
%         origGamma2=Screen('LoadNormalizedGammaTable', windowPtr2, BF_CLUT_R);
        origGamma2=Screen('LoadNormalizedGammaTable', windowPtr2, correctedGamma{2});
    end
    
    
    windowWidth     = winRect(3);
    windowHeight    = winRect(4); 
    
    
    %Default material parameters
        % Material properties
    materialAmb     = [1 1 1 1];
    materialDiff    = [1 1 1 1];
    materialSpec    = [1.0 0.2 0.0 1];
    materialShin    = 50.0;

    % Sphere colors
    matSphereAmb    = builtin('single',materialAmb);
    matSphereDiff   = builtin('single',materialDiff);

    % Cube colors
    matCubeAmb      = builtin('single',[1 1 1 1]);
    matCubeDiff     = builtin('single',[1 1 1.0 1]);
    
    
    
    
    
    
      % Initially fill left- and right-eye image buffer with black background
    % color:
    Screen('SelectStereoDrawBuffer', windowPtr, 0);
    Screen('FillRect', windowPtr, [0 255 0]);
    Screen('SelectStereoDrawBuffer', windowPtr, 1);
    Screen('FillRect', windowPtr, BlackIndex(screenid));
    Screen('SelectStereoDrawBuffer', windowPtr, 0);
    Screen('FillRect', windowPtr, [0 255 0]);
    Screen('SelectStereoDrawBuffer', windowPtr, 1);
    Screen('FillRect', windowPtr, BlackIndex(screenid));
    
    % Show cleared start screen:
    onset=Screen('Flip', windowPtr);  
    
    
    
    
        %code for building the depth textures
        
        
                    % Clip planes
%                     nearClip    = .25;        %in meters
                    nearClip    = .05;        %in meters
                    farClip     = 2;       %in meters
                    % note:  Keep the near and far clip as close together as
                    % possible. The depth texture is finite and spans from the near
                    % to far clip plane
                    if max(imageplanedist)>farClip-.1 || min(imageplanedist)<nearClip+.05
                        disp('***********************************************************')
                        disp('***********************************************************')
                        disp('***********************************************************')
                        disp('***********************************************************')
                        disp('********Check that depth planes fit in clipping bounds*****')
                        disp('***********************************************************')
                        disp('***********************************************************')
                        disp('***********************************************************')
                        disp('***********************************************************')
                        disp('***********************************************************')
                        return
                    end
            
            
    Screen('BeginOpenGL', windowPtr);
    glActiveTexture(GL.TEXTURE1);
    glTexEnvi(GL.TEXTURE_ENV, GL.TEXTURE_ENV_MODE, GL.MODULATE);
    glActiveTexture(GL.TEXTURE0);
    glTexEnvi(GL.TEXTURE_ENV, GL.TEXTURE_ENV_MODE, GL.MODULATE);
    Screen('EndOpenGL', windowPtr);
    glClearDepth(1.0);
    DEPTHTEXSIZE=4096;   %This is from depth.h and is a parameter for depth image size
  
    
    depthtex_id=glGenTextures(7);
    
        for depthtex_handle=1:7    %repeat this call for each depth plane
            BFCalcDepthTexture(depthtex_handle,depthtex_id, nearClip, farClip, imageplanedist, DEPTHTEXSIZE)
        end
        %depthtex_handle=
        %1:  Depth blend, plane 1
        %2:  Depth blend, plane 2
        %3:  Depth blend, plane 3
        %4:  Depth blend, plane 4
        %5:  25% luminance
        %6:  0% luminance
        %7:  100% luminance
        
        
    
    Screen('BeginOpenGL', windowPtr);
    glActiveTexture(GL.TEXTURE1);
    glTexEnvi(GL.TEXTURE_ENV, GL.TEXTURE_ENV_MODE, GL.MODULATE);
    glActiveTexture(GL.TEXTURE0);
    glTexEnvi(GL.TEXTURE_ENV, GL.TEXTURE_ENV_MODE, GL.MODULATE);        
    Screen('EndOpenGL', windowPtr);    
    
	Screen('BeginOpenGL', windowPtr);      
% Light properties
    lightPos    = [0 0 2 5];
    lightAmb    = [0.1 0.1 0.1 1.0];
    lightDiff   = [1.0 1.0 1.0 1.0];
    lightSpec   = [0.2 0.2 0.2 1.0];



    % Some GL init
    glClearColor(0.0, 0.0, 0.0, 0.0);
    glEnable(GL.DEPTH_TEST);
    
    if strcmp(experiment_type, 'monocular_hinge')
        glDisable(GL.DEPTH_TEST);
    end
    %glShadeModel(GL.SMOOTH);

    glEnable(GL.CULL_FACE);

    %glEnable(GL.BLEND);
    %glBlendFunc(GL.SRC_ALPHA, GL.ONE_MINUS_SRC_ALPHA);

    % Turn on OpenGL local lighting model: The lighting model supported by
    % OpenGL is a local Phong model with Gouraud shading.
%     glEnable(GL.LIGHTING);
%     glEnable(GL.LIGHT0);
        glDisable(GL.LIGHTING);


    % Setup GL Lighting and materials
    %
    % BUG_NOTE:  There are some order dependencies here that I don't
    % believe exist in C/OpenGL code.  You need to define the Light
    % properties before the Material properties.  Otherwise the light
    % position is wrong.
    %
    % ALSO:     Diffuse lighting doesn't appear to work on the first pass,
    % only ambient.  But after that it works fine.  There's probably some
    % initialization issues ernally.  Simple fix:  draw a dummy stimuli
    % first, then real ones from then on.
    %
%     glLightfv(GL.LIGHT0, GL.POSITION,   lightPos);
%     glLightfv(GL.LIGHT0, GL.DIFFUSE,    lightDiff);
%     glLightfv(GL.LIGHT0, GL.AMBIENT,    lightAmb);
%     glLightfv(GL.LIGHT0, GL.SPECULAR,   lightSpec);


    numframes = 1;
   
    
    
    %Generate the textures that we want to keep throughout
    texname_static=BF_build_textures;
    %Generate textures for specularity project. It needs many textures, so
    %make it only when we are in specularity project.
    if strcmp(experiment_type,'specularity')
%         BF_build_textures_for_specularity_project;
        BF_build_textures_for_specularity_project3;
    end
    
    if strcmp(experiment_type, 'monocular_hinge')
        glDisable(GL.DEPTH_TEST);
        trial_params=[];
        fix_params=[];
        started=0;
        BF_build_textures_optimizer;
    end
    
    
    Screen('EndOpenGL', windowPtr);
	
    if strcmp(experiment_type,'demomode2')
		Screen('BeginOpenGL', windowPtr);      
		lightPos    = [0 0 2 5];
		lightAmb    = [0.1 0.1 0.1 1.0];
		lightDiff   = [1.0 1.0 1.0 1.0];
		lightSpec   = [0.2 0.2 0.2 1.0];
		glClearColor(0.0, 0.0, 0.0, 0.0);
		glEnable(GL.DEPTH_TEST);
		glEnable(GL.CULL_FACE);
		glDisable(GL.LIGHTING);
% 		texname_static_woff=BF_build_textures; % might be non-mandatory?
		Screen('EndOpenGL', windowPtr);
    end
    

    activelensmode=1;
    depthplane=1;
    depthtex_handle=1;
    

   
    spatialundistort=1;   %Enables and disables the spatial undistortion

    adjustEye=0;  %Which eye is being adjusted during alignment

    %for randomdot stimuli, need a random dot seed array
    %or else it will randomize the dots between each view
    %eventually make this vector the right length, or don't exceed the 400.
    
    
           %make a sample RDS
        RDS_list_index=glGenLists(1);
        glNewList(RDS_list_index, GL.COMPILE)
        %BF_make_rds_grating(distance, numdots, grating_orientation,
        %cyclesperdegree, diameter_size_degrees, arcmindisp, IPD, dotradius_arcmin, texname_static)
        
%         BF_make_rds_grating(MidNearDist, 300, 90, 1.35, 4, 10, IPD, 1.5,
%         texname_static);
        BF_make_rds_grating(MidNearDist, 30, 90, 1.35, 1.5, 0, IPD, 1.5, texname_static);
        glEndList();
        
        CYLDOTS_list_index=glGenLists(1);
        glNewList(CYLDOTS_list_index, GL.COMPILE)
        BF_make_cylinder_dots(200, .1, .15, .001);
        glEndList();
        
        
        
        
        if ~exist('depthoffset', 'var')
            depthoffset=0;  % how many meters should the focus cues be set backwards
                            % from the specified object distance
                            % a positive number pushes the focus cues back
        end
        if ~exist('focus_cue_multiplier', 'var')
            focus_cue_multiplier=1;   %by what factor should focal information be scaled about the ending focal distance
                                      %if depthoffset is 0, then this is
                                      %simple and just expands or
                                      %diminishes focal cues
                                      %If depthoffset is nonzero, then it
                                      %does this about the offset focal
                                      %point
                                      %1 means that focus cues are proportional
                                      %to the real depth
                                      %<1 means that focus cues are compressed
                                      %>1 means that focus cues are exaggerated
        end      
        if ~exist('vergdist', 'var')
            vergdist=NearDist;         %This will be the default vergence distance for an object
                                      %This is particularly important if we
                                      %are using a focus_cue_multiplier
        end
        if ~exist('stim_type', 'var')
            stim_type='None';
        end
        if ~exist('show_verg_ref_dist', 'var')
            show_verg_ref_dist=0;   %This is a debugging tool so you know what the focal distance is.  It is set from the test file
        end
        if ~exist('trials_per_block', 'var')
            trials_per_block=200;
        end
        if ~exist('projection_type', 'var')
            projection_type=0;  % 0 is perspective, 1 is orthographic (warning: stereo will not work if set to 1)
        end        
        if ~exist('use3planeonly', 'var')
            use3planeonly=0;  %with the demo, only do 3 squares if flag is set to 1
        end        

        
    %Build the display lists
    %This is the precomputation of the openGL stuff
    %Trades off real time flexibility for speed in some cases
    %Best chances of not dropping frames
    
    %write and call display lists in same sequence as the init setting
    %vectors
    Screen('BeginOpenGL', windowPtr);
    
    
    if trial_mode==0
		if strcmp(experiment_type,'demomode2')
			Screen('EndOpenGL',windowPtr);
			jitter_radius=3e-3; % 6mm radius
			num_sample_1d=12;
			[xx,yy]=meshgrid((-jitter_radius):(2*jitter_radius/(num_sample_1d-1)):(jitter_radius));
			sample_onoff=sqrt(xx.^2+yy.^2)-jitter_radius;
			sample_onoff=sign(abs(sample_onoff)-sample_onoff);
			num_sample=sum(sum(sample_onoff));
			sample_counter=0;
			for ii=1:num_sample_1d
				for jj=1:num_sample_1d
					if sample_onoff(ii,jj)==1 % if the sample is inside the jitter circle
						x_off=xx(ii,jj);
						y_off=yy(ii,jj);

						sample_counter=sample_counter+1;
						disp(['calculating ' num2str(sample_counter) ' out of ' num2str(num_sample)]);
						for depthplane= 4: -1: 1
							depthtex_handle=7; % 100% depth texture in all cases.
							for whichEye=0:1
								Screen('BeginOpenGL',woff);
								genlist_start=glGenLists(16);  %Returns integer of first set of free display lists
								genlist_projection1=[0 1 2 3 4 5 6 7]+genlist_start;  %Set of indices 
								static_scene_disp_list=[0 1 2 3 4 5 6 7]+genlist_start+8;
								glNewList(genlist_projection1(depthplane+whichEye*4), GL.COMPILE);
								BF_viewport_specific_GL_commands;
								glEndList();

								glNewList(static_scene_disp_list(depthplane+whichEye*4), GL.COMPILE);
								BFRenderScene_static;
								glEndList();
								glCallList(genlist_projection1(depthplane+whichEye*4));    %mandatory projection setup
								glCallList(static_scene_disp_list(depthplane+whichEye*4));
								Screen('EndOpenGL',woff);
								if depthplane==1 && whichEye==0
									Screen('DrawTexture',w_1l,woff,[],[],[],0,1/num_sample);
								elseif depthplane==1 && whichEye==1
									Screen('DrawTexture',w_1r,woff,[],[],[],0,1/num_sample);
								elseif depthplane==2 && whichEye==0
									Screen('DrawTexture',w_2l,woff,[],[],[],0,1/num_sample);
								elseif depthplane==2 && whichEye==1
									Screen('DrawTexture',w_2r,woff,[],[],[],0,1/num_sample);
								elseif depthplane==3 && whichEye==0
									Screen('DrawTexture',w_3l,woff,[],[],[],0,1/num_sample);
								elseif depthplane==3 && whichEye==1
									Screen('DrawTexture',w_3r,woff,[],[],[],0,1/num_sample);
								elseif depthplane==4 && whichEye==0
									Screen('DrawTexture',w_4l,woff,[],[],[],0,1/num_sample);
								elseif depthplane==4 && whichEye==1
									Screen('DrawTexture',w_4r,woff,[],[],[],0,1/num_sample);
								end
							end
						end
					end
				end
			end
			Screen('BeginOpenGL',windowPtr);
        elseif strcmp(experiment_type,'specularity')
			genlist_start=glGenLists(16);  %Returns integer of first set of free display lists
			genlist_projection1=[0 1 2 3 4 5 6 7]+genlist_start;  %Set of indices 
			static_scene_disp_list=[0 1 2 3 4 5 6 7]+genlist_start+8;
% 			static_surface_scene_disp_list=[0 1 2 3 4 5 6 7]+genlist_start+8;
% 			static_reflection_scene_disp_list=[0 1 2 3 4 5 6 7]+genlist_start+16;

            for depthplane= 4: -1: 1
			    depthtex_handle=depthplane;
                for whichEye=0:1
				    glNewList(genlist_projection1(depthplane+whichEye*4), GL.COMPILE);
				    BF_viewport_specific_GL_commands;
				    glEndList();
%                     stim_layer='surface';
				    glNewList(static_scene_disp_list(depthplane+whichEye*4), GL.COMPILE);
				    BFRenderScene_static;
				    glEndList();
%                     stim_layer='reflection';
% 				    glNewList(static_reflection_scene_disp_list(depthplane+whichEye*4), GL.COMPILE);
% 				    BFRenderScene_static;
% 				    glEndList();
                end
            end
            
            elseif strcmp(experiment_type, 'monocular_hinge')
            glDisable(GL.DEPTH_TEST);
            genlist_start=glGenLists(17);  %Returns integer of first set of free display lists
            genlist_projection1=[0 1 2 3 4 5 6 7]+genlist_start;  %Set of indices
            static_scene_disp_list=[0 1 2 3 4 5 6 7]+genlist_start+8;
            wrap_texture_on_square=16+genlist_start;

            for depthplane= 4: -1: 1
                depthtex_handle=depthplane;
                for whichEye=0:1
                    glNewList(genlist_projection1(depthplane+whichEye*4), GL.COMPILE);
                    BF_viewport_specific_GL_commands;
                    glEndList();

                    glNewList(static_scene_disp_list(depthplane+whichEye*4), GL.COMPILE);
                    BFRenderScene_static;
                    glEndList();
                end
            end

        else
			genlist_start=glGenLists(17);  %Returns integer of first set of free display lists
			genlist_projection1=[0 1 2 3 4 5 6 7]+genlist_start;  %Set of indices 
			static_scene_disp_list=[0 1 2 3 4 5 6 7]+genlist_start+8;
            wrap_texture_on_square=16+genlist_start;

			for depthplane= 4: -1: 1
			    depthtex_handle=depthplane;
			    for whichEye=0:1
				    glNewList(genlist_projection1(depthplane+whichEye*4), GL.COMPILE);
				    BF_viewport_specific_GL_commands;
				    glEndList();

				    glNewList(static_scene_disp_list(depthplane+whichEye*4), GL.COMPILE);
				    BFRenderScene_static;
				    glEndList();
			    end
            end
            glNewList(wrap_texture_on_square,GL.COMPILE);
            glScalef(.05, .05, 1);
            BF_bind_texture_to_square(texname_static,14);
            glEndList();
		end
       
    else
        
		%open a data file
		if strcmp(experiment_type, 'fatigue_time_pilot_02') || strcmp(experiment_type, 'fatigue_time') || strcmp(experiment_type,'fatigue_time_3')...
                ||strcmp(experiment_type,'fatigue_time_4')||strcmp(experiment_type,'fatigue_time_5')
			resultfilenameout = [pwd '/BF_data_files/Temporal_VA_conflict/BF_' observer_initials '_' exp_num '_' datestr(clock, 30) '.txt'];
			datafilename = [pwd '/BF_data_files/Temporal_VA_conflict/BF_DATA_' observer_initials '_' exp_num '_' datestr(clock, 30)];
        elseif strcmp(experiment_type,'focusVaryingStereo')
			resultfilenameout = [pwd '/BF_data_files/FocusVaryingStereo/BF_' observer_initials '_' exp_num '_' datestr(clock, 30) '.txt'];
			datafilename = [pwd '/BF_data_files/FocusVaryingStereo/BF_DATA_' observer_initials '_' exp_num '_' datestr(clock, 30)];
		else
			resultfilenameout = [pwd '/BF_data_files/BF_' observer_initials '_' exp_num '_' datestr(clock, 30) '.txt'];
        end
		file_1 = fopen(resultfilenameout,'a');
		dumpworkspacefilename=[pwd '/BF_data_files/BF_WORKSPACE_' observer_initials '_' exp_num '_' datestr(clock, 30)];

    end       

	if strcmp(experiment_type, 'alignmode')  ||  strcmp(experiment_type, 'iodrectmode')
		calibrationfile_1= fopen([pwd '/BF_params/' observer_initials '.m'], 'a');
	end

            
            
            
    Screen('EndOpenGL', windowPtr);
        
	list_rendering=1;
	recompute_projection_list=1;
	recompute_static_scene_list=1;

    % Animation loop: Run until escape key is presed
    tic;
    frameNum=0;
    strInputName='';
    while (trial_mode==0)
        timeOffset=toc;
        kinetic_dist= 0.8657+ .4637*sin(numframes/100);
        cyl_rotation=numframes/3;
        % BFWaitForInput (actually KbCheck) takes about 1.8msec.
        % Let's do that once every 8 frames,
        % which still is sampling at every 44msec.
        frameNum=frameNum+1;
        if mod(frameNum,18)==0
            [strInputName, x, y] = BFWaitForInput(0.000001); % takes 0.0017 sec
            BF_keyboard_handling;    %handle the responses
        end
        if list_rendering==1 && 0==strcmp(strInputName, '') && ~strcmp(experiment_type,'demomode2')...
                && ~strcmp(experiment_type,'specularity')
			%Only rebuild the display lists if they pressed a button and they are in list_rendering,
			%Also only rebuild if we have made a viewport specific change, like in 
			%otherwise, proceed

			%glDeleteLists(genlist_start,8);  %Clear the old display lists
			depthplaneinit=depthplane;
			depthtexinit=depthtex_handle;
			if activelensmode==1
				if recompute_projection_list==1

					for depthplane= 1: 4
					    depthtex_handle=depthplane ;
					    for whichEye=renderviews
						    glNewList(genlist_projection1(depthplane+whichEye*4), GL.COMPILE);
						    BF_viewport_specific_GL_commands;
						    glEndList();
					    end
					end
					recompute_projection_list=0;
				end

				if recompute_static_scene_list==1

					for depthplane= 4: -1: 1
					    depthtex_handle=depthplane ;
					    for whichEye=renderviews
						    glNewList(static_scene_disp_list(depthplane+whichEye*4), GL.COMPILE);
						    BFRenderScene_static;
						    glEndList();
					    end
					end
					recompute_static_scene_list=0;
				end                    


			else

			    for whichEye=renderviews
				    glNewList(genlist_projection1(depthplane+whichEye*4), GL.COMPILE);
				    BF_viewport_specific_GL_commands;
				    glEndList();
			    end
			end

			depthplane=depthplaneinit;
			depthtex_handle=depthtexinit;
%         elseif list_rendering==1 && 0==strcmp(strInputName, '') && strcmp(experiment_type,'specularity')
% 			%Only rebuild the display lists if they pressed a button and they are in list_rendering,
% 			%Also only rebuild if we have made a viewport specific change, like in 
% 			%otherwise, proceed
% 
% 			%glDeleteLists(genlist_start,8);  %Clear the old display lists
% 			depthplaneinit=depthplane;
% 			depthtexinit=depthtex_handle;
% 			if activelensmode==1
% 				if recompute_projection_list==1
% 
% 					for depthplane= 1: 4
% 					    depthtex_handle=depthplane ;
% 					    for whichEye=renderviews
% 						    glNewList(genlist_projection1(depthplane+whichEye*4), GL.COMPILE);
% 						    BF_viewport_specific_GL_commands;
% 						    glEndList();
% 					    end
% 					end
% 					recompute_projection_list=0;
% 				end
% 
% 				if recompute_static_scene_list==1
% 
% 					for depthplane= 4: -1: 1
% 					    depthtex_handle=depthplane ;
% 					    for whichEye=renderviews
% 						    glNewList(static_scene_disp_list(depthplane+whichEye*4), GL.COMPILE);
% 						    BFRenderScene_static;
% 						    glEndList();
% 					    end
% 					end
% 					recompute_static_scene_list=0;
% 				end                    
% 
% 
% 			else
% 
% 			    for whichEye=renderviews
% 				    glNewList(genlist_projection1(depthplane+whichEye*4), GL.COMPILE);
% 				    BF_viewport_specific_GL_commands;
% 				    glEndList();
% 			    end
% 			end
% 
% 			depthplane=depthplaneinit;
% 			depthtex_handle=depthtexinit;

        elseif list_rendering==1 && 0==strcmp(strInputName, '') && strcmp(experiment_type,'specularity')
			genlist_start=glGenLists(16);  %Returns integer of first set of free display lists
			genlist_projection1=[0 1 2 3 4 5 6 7]+genlist_start;  %Set of indices 
			static_scene_disp_list=[0 1 2 3 4 5 6 7]+genlist_start+8;

            for depthplane= 4: -1: 1
			    depthtex_handle=depthplane;
			    for whichEye=0:1
				    glNewList(genlist_projection1(depthplane+whichEye*4), GL.COMPILE);
				    BF_viewport_specific_GL_commands;
				    glEndList();
%                     stim_layer='surface';
				    glNewList(static_surface_scene_disp_list(depthplane+whichEye*4), GL.COMPILE);
				    BFRenderScene_static;
				    glEndList();
%                     stim_layer='reflection';
% 				    glNewList(static_reflection_scene_disp_list(depthplane+whichEye*4), GL.COMPILE);
% 				    BFRenderScene_static;
% 				    glEndList();
			    end
            end
            
        end
        
        if activelensmode

			depthplane=depthplane+1;
			if depthplane>4

				depthplane=1;
			end
		    depthtex_handle=depthplane;     
        end
        
        if strcmp(experiment_type,'demomode2')
			for whichEye=renderviews

				Screen('SelectStereoDrawBuffer', windowPtr, whichEye);
				Screen('FillRect',windowPtr,[0 0 0]);

				if static_mode  %optional mode for staic imagery
					if depthplane==1 && whichEye==0
						Screen('CopyWindow',w_1l,windowPtr);
					elseif depthplane==1 && whichEye==1
						Screen('CopyWindow',w_1r,windowPtr);
					elseif depthplane==2 && whichEye==0
						Screen('CopyWindow',w_2l,windowPtr);
					elseif depthplane==2 && whichEye==1
						Screen('CopyWindow',w_2r,windowPtr);
					elseif depthplane==3 && whichEye==0
						Screen('CopyWindow',w_3l,windowPtr);
					elseif depthplane==3 && whichEye==1
						Screen('CopyWindow',w_3r,windowPtr);
					elseif depthplane==4 && whichEye==0
						Screen('CopyWindow',w_4l,windowPtr);
					elseif depthplane==4 && whichEye==1
						Screen('CopyWindow',w_4r,windowPtr);
					end
				end

	%                 glTranslatef(0.03,.030, -kinetic_dist);
	%                 glutWireSphere(0.04, 25, 25);
	% 
	%                 glTranslatef(-0.06,-.06, +(kinetic_dist)-(.8+1.2-kinetic_dist));
	%                 glutWireSphere(0.05, 20, 20);

				if show_verg_ref_dist  % print out the lens specified depth

					Screen('TextSize',windowPtr, 50);

					Screen('DrawText', windowPtr, ['Depthplane is = ' num2str(depthplane)], 100, 100, [0, 0, 255, 255]); 
					Screen('DrawText', windowPtr, ['WhichEye is = ' num2str(whichEye)], 100, 200, [0, 0, 255, 255]); 
				end
				if depthplane==3
					if whichEye==1
						Screen('FillRect', windowPtr, [255 255 255], [winRect(3)*.85, winRect(4)*.85, winRect(3) , winRect(4)]);
					else
						Screen('FillRect', windowPtr, [255 255 255], [0, winRect(4)*.85, winRect(3)*.15 , winRect(4)]);
					end
				end

			end


			%Screen('Flip', windowPtr [, when] [, dontclear] [, dontsync] [, multiflip]);
			onset=Screen('Flip', windowPtr, [], 2, 1);
			%onset=Screen('Flip', windowPtr, [], 2, 2);
			% Check for keyboard press and exit, if so:
			%glFinish
        elseif strcmp(experiment_type,'specularity')

            timeStamp=zeros(1,8);
			for whichEye=renderviews
				Screen('SelectStereoDrawBuffer', windowPtr, whichEye);
				Screen('BeginOpenGL', windowPtr);
                timeStamp(whichEye*4+1)=toc;
                timeStampDescription{whichEye*4+1}='Began OpenGL';

				glCallList(genlist_projection1(depthplane+whichEye*4));    %mandatory projection setup
                glCallList(static_scene_disp_list(depthplane+whichEye*4));
%                 glCallList(static_surface_scene_disp_list(depthplane+whichEye*4));
%                 Screen('EndOpenGL',windowPtr);
%                 Screen('BeginOpenGL',w_reflectionBuffer);
% 				glCallList(genlist_projection1(depthplane+whichEye*4));    %mandatory projection setup
%                 glCallList(static_reflection_scene_disp_list(depthplane+whichEye*4));
%                 Screen('EndOpenGL',w_reflectionBuffer);
                Screen('EndOpenGL',windowPtr);
                timeStamp(whichEye*4+2)=toc;
                timeStampDescription{whichEye*4+2}='Called list';

%                 [srcFactorOld, destFactorOld, colorMaskOld]=Screen('BlendFunction',windowPtr,GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
%                 Screen('DrawTexture',windowPtr,w_reflectionBuffer);
%                 Screen('BlendFunction',windowPtr,srcFactorOld,destFactorOld);
                timeStamp(whichEye*4+3)=toc;
                timeStampDescription{whichEye*4+3}='Alpha blending';
				if depthplane==3
					if whichEye==1
						Screen('FillRect', windowPtr, [255 255 255], [winRect(3)*.85, winRect(4)*.85, winRect(3) , winRect(4)]);
					else
						Screen('FillRect', windowPtr, [255 255 255], [0, winRect(4)*.85, winRect(3)*.15 , winRect(4)]);
					end
				end
                timeStamp(whichEye*4+4)=toc;
                timeStampDescription{whichEye*4+4}='Drew rectangles';

			end
            timeStamp(whichEye*4+5)=toc;
            timeStampDescription{whichEye*4+5}='Ready to flip';

			onset=Screen('Flip', windowPtr, [], 2, 1);

            timeStamp(whichEye*4+6)=toc;
            timeStampDescription{whichEye*4+6}='Flipped';
			%onset=Screen('Flip', windowPtr, [], 2, 2);
			% Check for keyboard press and exit, if so:
			%glFinish
            alphaBlendingThreshold=0.0003;
            
            if (timeStamp(3)-timeStamp(2))>alphaBlendingThreshold || (timeStamp(7)-timeStamp(6))>alphaBlendingThreshold
                disp(['depthplane ' num2str(depthplane)]);
                for ii=1:length(timeStamp)
                    if ii==1
                        disp([num2str(timeStamp(ii)-timeOffset) ' ' timeStampDescription{ii}]);
                    else
                        disp([num2str(timeStamp(ii)-timeStamp(ii-1)) ' ' timeStampDescription{ii}]);
                    end
                    if ii==length(timeStamp)-1
                        disp([num2str(timeStamp(ii)-timeOffset) ' took for whole rendering']);
                    elseif ii==length(timeStamp)
                        disp([num2str(timeStamp(ii)-timeOffset) ' took upto here']);
                    end
                end
                disp(' ');
            end
            
		else
            timeStamp=zeros(1,8);
			for whichEye=renderviews
				Screen('SelectStereoDrawBuffer', windowPtr, whichEye);
				Screen('BeginOpenGL', windowPtr);
                timeStamp(whichEye*3+1)=toc;
                timeStampDescription{whichEye*3+1}='Began OpenGL';

				glCallList(genlist_projection1(depthplane+whichEye*4));    %mandatory projection setup

%                 glCallList(static_scene_disp_list(depthplane+whichEye*4));
%                 BFRenderScene_dynamic;
				if static_mode  %optional mode for staic imagery
					glCallList(static_scene_disp_list(depthplane+whichEye*4));
				end
				if dynamic_mode  %optional mode for moving imagery
                    glTranslatef(-0.06,.060, -kinetic_dist);
					glCallList(wrap_texture_on_square);
				end
                timeStamp(whichEye*3+2)=toc;
                timeStampDescription{whichEye*3+2}='Called list';

	%                 glTranslatef(0.03,.030, -kinetic_dist);
	%                 glutWireSphere(0.04, 25, 25);
	% 
	%                 glTranslatef(-0.06,-.06, +(kinetic_dist)-(.8+1.2-kinetic_dist));
	%                 glutWireSphere(0.05, 20, 20);

				Screen('EndOpenGL', windowPtr);
% 				if show_verg_ref_dist  % print out the lens specified depth
% 
% 					Screen('TextSize',windowPtr, 50);
% 
% 					Screen('DrawText', windowPtr, ['Depthplane is = ' num2str(depthplane)], 100, 100, [0, 0, 255, 255]); 
% 					Screen('DrawText', windowPtr, ['WhichEye is = ' num2str(whichEye)], 100, 200, [0, 0, 255, 255]); 
% 				end
				if depthplane==3
					if whichEye==1
						Screen('FillRect', windowPtr, [255 255 255], [winRect(3)*.85, winRect(4)*.85, winRect(3) , winRect(4)]);
% 						Screen('FillRect', windowPtr, [255 255 255], [winRect(3)*.5, winRect(4)*.85, winRect(3) , winRect(4)]);
					else
						Screen('FillRect', windowPtr, [255 255 255], [0, winRect(4)*.85, winRect(3)*.15 , winRect(4)]);
% 						Screen('FillRect', windowPtr, [255 255 255], [0, winRect(4)*.85, winRect(3)*.5 , winRect(4)]);
					end
				end

                timeStamp(whichEye*3+3)=toc;
                timeStampDescription{whichEye*3+3}='Drew rectangles';
			end

            timeStamp(whichEye*3+4)=toc;
            timeStampDescription{whichEye*3+4}='Ready to flip';

			%Screen('Flip', windowPtr [, when] [, dontclear] [, dontsync] [, multiflip]);
			onset=Screen('Flip', windowPtr, [], 2, 1);
            timeStamp(whichEye*3+5)=toc;
            timeStampDescription{whichEye*3+5}='Flipped';
            % below for frame time recording
%             if ~exist('ttt','var')
%                 ttt=1;
%             else
%                 frameTime(ttt)=GetSecs;
%                 ttt=ttt+1;
%                 if ttt>2000
%                     framePeriod=frameTime(2:end)-frameTime(1:(length(frameTime)-1));
%                     plot(framePeriod);
%                     keyboard;
%                 end
%             end
			%onset=Screen('Flip', windowPtr, [], 2, 2);
			% Check for keyboard press and exit, if so:
			%glFinish
%             if ~exist('timingIndex','var')
%                 timingIndex=0
%                 timing0=GetSecs;
%             else
%                 timingIndex=timingIndex+1;
%                 timing(timingIndex)=GetSecs-timing0;
%                 if timingIndex>100
%                     sca;
%                     plot(timing(2:end)-timing(1:(length(timing)-1)));
%                     hold on;
%                     plot([0 100],[1/180 1/180],'b--');
%                     keyboard;
%                 end
%             end
            %{
            disp(['depthplane ' num2str(depthplane)]);
            for ii=1:length(timeStamp)
                if ii==1
                    disp([num2str(timeStamp(ii)-timeOffset) ' ' timeStampDescription{ii}]);
                else
                    disp([num2str(timeStamp(ii)-timeStamp(ii-1)) ' ' timeStampDescription{ii}]);
                end
                if ii==length(timeStamp)-1
                    disp([num2str(timeStamp(ii)-timeOffset) ' took for whole rendering']);
                elseif ii==length(timeStamp)
                    disp([num2str(timeStamp(ii)-timeOffset) ' took upto here']);
                end
            end
            disp(' ');
            %}
		end
                
        timecounter(numframes)=toc;
        timecounter1(numframes)=timeStamp(1);
        timecounter2(numframes)=timeStamp(2);
        timecounter3(numframes)=timeStamp(3);
        timecounter4(numframes)=timeStamp(4);
        timecounter5(numframes)=timeStamp(5);
        timecounter6(numframes)=timeStamp(6);
        timecounter7(numframes)=timeStamp(7);
        timecounter8(numframes)=timeStamp(8);
        
        numframes = numframes + 1;
        
    end  %while trial mode==0


    if ~exist('trial_counter')
        trial_counter=0;
    end
    if ~exist('block_counter')
        block_counter=0;
    end
    if trial_mode==1
        
        current_sc=1;
        BF_initialize_trial;    %Just to build projections for splash screen
		BF_display_initial_message;

        if strcmp(experiment_type, 'monocular_hinge')
            
            % MARINA'S ADDITION %%
            % Open file
            currentTime = clock;
            ye = currentTime(1); mo = currentTime(2); da = currentTime(3);
            ho = currentTime(4); mi = currentTime(5); se = currentTime(6);
            
            mkdir('Data_Monocular_Hinge');
            fileName = sprintf('Data_Monocular_Hinge/%s_%2d_%2d__%2d_%2d.data', observer_initials, da,  mo, ho, mi);
            fp = fopen(fileName, 'a');
            
            fprintf(fp, '\n*** monocular hinge direction experiment ***\n');
            fprintf(fp, 'Subject Name:\t%s\n', observer_initials);
            fprintf(fp, 'Date and Time:\t%2d/%2d/%4d\t%2d:%2d:%2.0f\n', da, mo, ye, ho, mi, se);
            fprintf(fp, '*** **************************** ***\n');
            fprintf(fp, ' ss\t algorithm\t disparity_dist\t accom_dist\t angle\t currentvalue\t resp_curr\n');
            % MARINA''S ADDITION %%
            
            stop_flag=0;
            started=1;
            while stop_flag==0
                trial_params{1} = get(scellThisRound{s_i}, 'algorithm');
                trial_params{2} = get(scellThisRound{s_i}, 'disparity_dist');
                trial_params{3} = get(scellThisRound{s_i}, 'accom_dist');
                trial_params{4} = get(scellThisRound{s_i}, 'angle');
                trial_params{5} = get(scellThisRound{s_i}, 'currentValue'); % hinge direction
                BF_build_textures_optimizer;
                BF_initialize_trial; % calls RenderSceneStatic
                BF_run_trial; % calls actual GL commands
                process_response; % gets keyboard input and updates staircase

                trial_counter = trial_counter + 1;

                if mod(trial_counter, param.trials_per_block) == 0
                    % take a break
                    block_counter = block_counter + 1;
                    disp([num2str(block_counter) ' block(s) completed'])
                    message = 'endofblock';
                    BF_disp_message
                    save(record_filename,'scell','param','scellCompleted','scellThisRound','scellNextRound', trial_counter, block_counter);
                end
                
                %Write Trial Data
                fprintf(fp, '%d\t%d\t%d\t%d\t%d\t%d\t%d\n', ...
                trial_counter, trial_params{1}, trial_params{2}, trial_params{3}, trial_params{4}, trial_params{5}, f_print_response);
                if trial_counter == param.max_trials
                    stop_flag = 1;
                end

                % Trying to solve inter-trial delay
                size = uint32(zeros(length(texname_static),1));
                glDeleteTextures(size, texname_static);
                size = uint32(zeros(length(genlist_projection1),1));
                glDeleteTextures(size, genlist_projection1);
                size = uint32(zeros(length(static_scene_disp_list1),1));
                glDeleteTextures(size, static_scene_disp_list1);
                Screen('Close', texname_static);
                Screen('Close', genlist_projection1);
                Screen('Close', static_scene_disp_list1);
                
            end
            save(record_filename,'scell','param','scellCompleted','scellThisRound','scellNextRound', trial_counter, block_counter);
            fclose(fp);
      
        end
        
        if strcmp(experiment_type,'fatigue_assess1') || strcmp(experiment_type,'fatigue_assess2') || strcmp(experiment_type,'fatigue_assess3')
            % TD: read the exp record file.
            % If does not exist, create one.
            % condition order is determined when it is created only. Later,
            % just read it.
            % trial order, corrfreq order is determined here always.
            %open a data file
            condition_order=zeros(1,howmanyconditions);
            recordfilename = [pwd '/BF_data_files/condition_record/' observer_initials '_' exp_num '_record.txt'];
            finished_conditions=0;
            if (exist(recordfilename)~=2) % if the record file does not exist
                file_record=fopen(recordfilename,'a');
                condition_order=randperm(howmanyconditions);
                for ii=1:howmanyconditions
                    fprintf(file_record, '%d\n', condition_order(ii));
                end
                fprintf(file_record, '%d', finished_conditions);
            else % if the record file exists
                temp=textread(recordfilename,'%d');
                condition_order=temp(1:howmanyconditions);
                finished_conditions=temp(howmanyconditions+1);
            end

            stop_flag=0;
            for condition_index=finished_conditions+1:howmanyconditions
                current_condition=condition_order(condition_index);

                % start of main experiment
                for ii=1:trialspercorrfreq
                    corrfreq_order=randperm(howmanycorrfreq);
                    for jj=1:howmanycorrfreq
                        if (stop_flag==1)
                            break;
                        end
                        current_sc=corrfreq_order(jj)+(condition_order(condition_index)-1)*howmanycorrfreq;
                        BF_initialize_trial;
                        BF_run_trial;
                    end
                    if (stop_flag==1)
                        break;
                    end
                end
                if (stop_flag==1)
                    break;
                end
                
                % TD: This is when one session ends. Rewrite the record.
                file_record=fopen(recordfilename,'w');
                for ii=1:howmanyconditions
                    fprintf(file_record, '%d\n', condition_order(ii));
                    file_record=fopen(recordfilename,'a');
                end
                fprintf(file_record, '%d', condition_index);
                
                % Break message
                if condition_index<howmanyconditions
                    tic;
                    message='breakuntilnextassessment';
                    BF_disp_message;
                    if strcmp(strInputName2,'ESCAPE')
                        stop_flag=1;
                        break;
                    end
                end
            end
		elseif strcmp(experiment_type,'fatigue_time_pilot_03')
			% I erased all other pilot codes for time study, but left it.
			% This is an example code for dynamic stimulus
            % TD: read the exp record file.
            % If does not exist, create one.
            % condition order is determined when it is created only. Later,
            % just read it.
            % trial order, corrfreq order is determined here always.
            %open a data file

            stop_flag=0;
			facesize=.01;


            for condition_index=finished_conditions+1:howmanyconditions
                current_condition=condition_order(condition_index);
				focus_cue_multiplier=focus_cue(current_condition);
                vergdist=1/vergence_offset;
				
				if ~exist('genlist_projection', 'var')
					genlist_start=glGenLists(8);
					genlist_projection=[0 1 2 3 4 5 6 7]+genlist_start;
				end
				for depthplane= 4: -1: 1
					depthtex_handle=depthplane ;
					for whichEye=renderviews
						glNewList(genlist_projection(whichEye*4+depthplane), GL.COMPILE);
						BF_viewport_specific_GL_commands;
						glEndList();
					end
				end

			% start of main experiment
				tic;
                for ii=1:trialspercorrfreq
                    corrfreq_order=randperm(howmanycorrfreq);
                    for jj=1:howmanycorrfreq
                        if (stop_flag==1)
                            break;
						end
						answer=0;
						response=0;
						
                        current_corrfreq=corrfreq_order(jj);
						rpt_orientation= round(rand(1));
						BF_initialize_trial;
                        BF_run_trial;
                    end
                    if (stop_flag==1)
                        break;
                    end
                end
                if (stop_flag==1)
                    break;
                end
                
                % TD: This is when one session ends. Rewrite the record.
                file_record=fopen(recordfilename,'w');
                for ii=1:howmanyconditions
                    fprintf(file_record, '%d\n', condition_order(ii));
                    file_record=fopen(recordfilename,'a');
                end
                fprintf(file_record, '%d', condition_index);
                
                % Break message
                if condition_index<howmanyconditions
                    tic;
                    message='breakuntilnextassessment';
                    BF_disp_message;
                    if strcmp(strInputName2,'ESCAPE')
                        stop_flag=1;
                        break;
                    end
                end
            end
		elseif strcmp(experiment_type,'fatigue_time')
            % TD: read the exp record file.
            % If does not exist, create one.
            % condition order is determined when it is created only. Later,
            % just read it.
            % trial order, corrfreq order is determined here always.
            %open a data file

            stop_flag=0;
			if finished_conditions<howmanyconditions
%                 condition_order
				for condition_index=(finished_conditions+1):howmanyconditions
					current_condition=condition_order(condition_index);
					trial_index=0;

					% start of main experiment
					for ii=1:trialspercorrfreq
						corrfreq_order=randperm(howmanycorrfreq);
						for jj=1:howmanycorrfreq
							if (stop_flag==1)
								break;
							end
							answer=0;
							response=0;

							trial_index=jj+(ii-1)*howmanycorrfreq;
							current_corrfreq=corrfreq_array(corrfreq_order(jj));
							BF_initialize_trial;
							BF_run_trial;
						end
						if (stop_flag==1)
							break;
						end
					end
					if (stop_flag==1)
						break;
					end
                    finished_conditions=finished_conditions+1;

					% Break message
					if finished_conditions<howmanyconditions % display only after the first session.
						tic;
                        if mod(finished_conditions,2)==1
    						message='persessionQ';
                        elseif mod(finished_conditions,2)==0
                            message='persessionQcomparisonQ';
                        end
						BF_disp_message;
						if strcmp(strInputName2,'ESCAPE')
							stop_flag=1;
							break;
						end
					end
				end
                % TD: Experiment ends. Rewrite the record.
                file_record=fopen(recordfilename,'w');
                for ii=1:howmanyconditions
                    fprintf(file_record, '%d\n', condition_order(ii));
                    file_record=fopen(recordfilename,'a');
                end
                fprintf(file_record, '%d', finished_conditions);
			end
		elseif strcmp(experiment_type,'fatigue_time_3')||strcmp(experiment_type,'fatigue_time_4')
            % TD: read the exp record file.
            % If does not exist, create one.
            % condition order is determined when it is created only. Later,
            % just read it.
            % trial order, corrfreq order is determined here always.
            %open a data file

			if finished_conditions<howmanyconditions
%                 condition_order
				first_condition_index=finished_conditions+1;
				if mod(finished_conditions,2)==0
					last_condition_index=finished_conditions+2;
				else
					last_condition_index=finished_conditions+1;
				end
				for condition_index=first_condition_index:last_condition_index % 2 conditions per day for now
					current_condition=condition_order(condition_index);
					trial_index=0;

					% start of main experiment
					for ii=1:trialspercorrfreq
						corrfreq_order=randperm(howmanycorrfreq);
						for jj=1:howmanycorrfreq
							if (stop_flag==1)
								break;
							end
							answer=0;
							response=0;

							trial_index=jj+(ii-1)*howmanycorrfreq;
							current_corrfreq=corrfreq_array(corrfreq_order(jj));
							BF_initialize_trial;
							BF_run_trial;
						end
						if (stop_flag==1)
							break;
						end
					end
					if (stop_flag==1)
						break;
					end
                    finished_conditions=finished_conditions+1;

					% Break message
					if finished_conditions<last_condition_index % display only after the first session.
						tic;
   						message='break_fatigue_time';
						BF_disp_message;
						if strcmp(strInputName2,'ESCAPE')
							stop_flag=1;
							break;
						end
					end
				end
                % TD: Experiment ends. Rewrite the record.
                file_record=fopen(conditionrecordfilename,'w');
				for ii=1:length(t_c1)
					if strcmp(t_initials{ii},subject_initials)
                        if current_condition==7 || current_condition==8
    						fprintf(file_record, '%s\t%d\t%d\t%d\n',t_initials{ii},t_c1(ii),t_c2(ii),finished_conditions);
                        else
    						fprintf(file_record, '%s\t%d\t%d\t%d\t%d\t%d\t%d\t%d\n',t_initials{ii},t_c1(ii),t_c2(ii),t_c3(ii),t_c4(ii),t_c5(ii),t_c6(ii),finished_conditions);
                        end
					else
                        if current_condition==7 || current_condition==8
                            fprintf(file_record, '%s\t%d\t%d\t%d\n',t_initials{ii},t_c1(ii),t_c2(ii),t_finished(ii));
                        else
                            fprintf(file_record, '%s\t%d\t%d\t%d\t%d\t%d\t%d\t%d\n',t_initials{ii},t_c1(ii),t_c2(ii),t_c3(ii),t_c4(ii),t_c5(ii),t_c6(ii),t_finished(ii));
                        end
					end
                    file_record=fopen(conditionrecordfilename,'a');
				end
				fclose(file_record);
            end
        elseif strcmp(experiment_type,'fatigue_time_5')
            if finished_conditions<howmanyconditions
                %                 condition_order
                first_condition_index=finished_conditions+1;
                if strcmp(exp_num((end-6):end),'pretest')||strcmp(exp_num((end-8):(end-2)),'raining')
                    last_condition_index=6; % always run all 6 conditions
                elseif mod(finished_conditions,2)==0
                    last_condition_index=finished_conditions+2;
                else
                    last_condition_index=finished_conditions+1;
                end
                debugging=[];
                % generate projection list
                if ~exist('genlist_projection1', 'var')
                    genlist_projection1=[0 1 2 3 4 5 6 7]+glGenLists(8); % control session projection
                    genlist_projection2=[0 1 2 3 4 5 6 7]+glGenLists(8); % conflict session projection
                end
                for depthplane= 4: -1: 1
                    if depthplane==1
                        depthtex_handle=6; % don't display anything on farthest plane
                    else
                        depthtex_handle=depthplane;
                    end
                    for whichEye=renderviews
                        glNewList(genlist_projection1(depthplane+whichEye*4), GL.COMPILE);
                        BF_viewport_specific_GL_commands;
                        glEndList();
                    end
                    if depthplane==2 % genlist_projection2 displays only farmimd plane
                        depthtex_handle=7;
                    else
                        depthtex_handle=6;
                    end
                    for whichEye=renderviews
                        glNewList(genlist_projection2(depthplane+whichEye*4), GL.COMPILE);
                        BF_viewport_specific_GL_commands;
                        glEndList();
                    end
                end
                for condition_index=first_condition_index:last_condition_index % 2 conditions per day for now
                    debugging{condition_index}=[];
                    debugging{condition_index}.vergdist=[];
                    debugging{condition_index}.accdist=[];
                    dIndex=0;
                    current_condition=condition_order(condition_index);
                    
                    trial_index=0;
                    
                    % start of main experiment
                    tic;
                    for ii=1:trialspercorrfreq
                        corrfreq_order=randperm(howmanycorrfreq);
                        for jj=1:howmanycorrfreq
                            if (stop_flag==1)
                                break;
                            end
                            answer=0;
                            response=0;
                            
                            trial_index=jj+(ii-1)*howmanycorrfreq;
                            current_corrfreq=corrfreq_array(corrfreq_order(jj));
                            BF_initialize_trial;
                            BF_run_trial;
                        end
                        if (stop_flag==1)
                            break;
                        end
                    end
                    if (stop_flag==1)
                        break;
                    end
                    finished_conditions=finished_conditions+1;
                    
                    % Break message
                    if finished_conditions<last_condition_index % display only after the first session.
                        tic;
                        % reset audio signal object and indices
                        %                         pause(0.1);
                        %                         w_i=1;
                        %                         c_i=1;
                        message='break_fatigue_time';
                        BF_disp_message;
                        if strcmp(strInputName2,'ESCAPE')
                            stop_flag=1;
                            break;
                        end
                    end
                end
%                 figure(1);
%                 for ii=1:6
%                     subplot(2,3,ii);
%                     plot(debugging{ii}.vergdist,'b-');
%                     hold on;
%                     plot(debugging{ii}.accdist,'r-');
%                     hold off;
%                 end
                % TD: Experiment ends. Rewrite the record.
                file_record=fopen(conditionrecordfilename,'w');
                for ii=1:length(t_c1)
                    if strcmp(t_initials{ii},subject_initials)
                        if current_condition==7 || current_condition==8
                            fprintf(file_record, '%s\t%d\t%d\t%d\n',t_initials{ii},t_c1(ii),t_c2(ii),finished_conditions);
                        else
                            fprintf(file_record, '%s\t%d\t%d\t%d\t%d\t%d\t%d\t%d\n',t_initials{ii},t_c1(ii),t_c2(ii),t_c3(ii),t_c4(ii),t_c5(ii),t_c6(ii),finished_conditions);
                        end
                    else
                        if current_condition==7 || current_condition==8
                            fprintf(file_record, '%s\t%d\t%d\t%d\n',t_initials{ii},t_c1(ii),t_c2(ii),t_finished(ii));
                        else
                            fprintf(file_record, '%s\t%d\t%d\t%d\t%d\t%d\t%d\t%d\n',t_initials{ii},t_c1(ii),t_c2(ii),t_c3(ii),t_c4(ii),t_c5(ii),t_c6(ii),t_finished(ii));
                        end
                    end
                    file_record=fopen(conditionrecordfilename,'a');
                end
                fclose(file_record);
            end
        elseif strcmp(experiment_type,'specularity_flat')
			genlist_start=glGenLists(8+numReflectionImageInOneSet*8);  %Returns integer of first set of free display lists
			genlist_projection1=[0 1 2 3 4 5 6 7]+genlist_start;  %Set of indices 
			static_scene_disp_list=(0:1:(numReflectionImageInOneSet*8-1))+genlist_start+8; % necessary?
%             static_scene_disp_list
            for depthplane= 4: -1: 1
                depthtex_handle=depthplane;
                for whichEye=renderviews
                    glNewList(genlist_projection1(depthplane+whichEye*4), GL.COMPILE);
                    BF_viewport_specific_GL_commands;
                    glEndList();
                end
            end
            
            stop_flag=0;
            while(stop_flag==0)
                % decide which condition to run
                
                BF_initialize_trial; % load image files and make scene display list
                BF_run_trial; % show the images and respond to the input
            end
            
        elseif strcmp(experiment_type,'fatigue_assess_sym0p1D')  || strcmp(experiment_type,'fatigue_assess_sym1p3D')  || strcmp(experiment_type,'fatigue_assess_sym2p5D')
            % TD: read the exp record file.
            % If does not exist, create one.
            % condition order is determined when it is created only. Later,
            % just read it.
            % trial order, corrfreq order is determined here always.
            %open a data file
            condition_order=zeros(1,howmanyconditions);
            recordfilename = [pwd '/BF_data_files/condition_record/' observer_initials '_' exp_num '_record.txt'];
            fatiguerecordstarttime=floor(GetSecs);
            fatiguerecordfilename = [pwd '/BF_data_files/condition_record/' observer_initials '_' exp_num '_fatigue_time_' num2str(fatiguerecordstarttime) '.txt'];
            finished_conditions=0;
            if (exist(recordfilename)~=2) % if the record file does not exist
                file_record=fopen(recordfilename,'a');
                condition_order=randperm(howmanyconditions);
                for ii=1:howmanyconditions
                    fprintf(file_record, '%d\n', condition_order(ii));
                end
                fprintf(file_record, '%d', finished_conditions);
            else % if the record file exists
                temp=textread(recordfilename,'%d');
                condition_order=temp(1:howmanyconditions);
                finished_conditions=temp(howmanyconditions+1);
            end

            file_fatigue_record=fopen(fatiguerecordfilename,'a');
            stop_flag=0;
            for condition_index=finished_conditions+1:howmanyconditions
                current_condition=condition_order(condition_index);
                if strcmp(experiment_type,'fatigue_assess_sym0p1D')
                    condition_num_to_be_recorded=current_condition;
                elseif strcmp(experiment_type,'fatigue_assess_sym1p3D')
                    condition_num_to_be_recorded=current_condition+howmanyconditions;
                elseif strcmp(experiment_type,'fatigue_assess_sym2p5D')
                    condition_num_to_be_recorded=current_condition+2*howmanyconditions;
                end
                % Get degree of visual fatigue before the start of the session.
                degree_fatigue=-1;
                message='fatiguequestion';
                BF_disp_message;
                fatigue_measured_at=0; % It's before the start.
                fprintf(file_fatigue_record, '%d\t%d\t%d\n', condition_num_to_be_recorded, fatigue_measured_at, degree_fatigue);

                % start of one session
                condition_start_time=floor(GetSecs);
                for ii=1:trialspercorrfreq
                    corrfreq_order=randperm(howmanycorrfreq);
                    for jj=1:howmanycorrfreq
                        if (stop_flag==1)
                            break;
                        end
                        current_sc=corrfreq_order(jj)+(condition_order(condition_index)-1)*howmanycorrfreq;
                        BF_initialize_trial;
                        BF_run_trial;
                    end
                    if (stop_flag==1)
                        break;
                    end
                    if mod(ii,fatigue_question_period)==0 && ii~=trialspercorrfreq
                        degree_fatigue=-1; % it means undefined
                        message='fatiguequestion';
                        BF_disp_message;
                        fatigue_measured_at=floor(GetSecs)-condition_start_time;
                        fprintf(file_fatigue_record, '%d\t%d\t%d\n', condition_num_to_be_recorded, fatigue_measured_at, degree_fatigue);
                    end
                end
                if (stop_flag==1)
                    break;
                end

                % Get degree of visual fatigue at the end of the session.
                degree_fatigue=-1; % it means undefined
                message='fatiguequestion';
                BF_disp_message;
                fatigue_measured_at=floor(GetSecs)-condition_start_time;
                fprintf(file_fatigue_record, '%d\t%d\t%d\n', condition_num_to_be_recorded, fatigue_measured_at, degree_fatigue);
                % TD: This is when one session ends. Rewrite the record.
                file_record=fopen(recordfilename,'w');
                for ii=1:howmanyconditions
                    fprintf(file_record, '%d\n', condition_order(ii));
                    file_record=fopen(recordfilename,'a');
                end
                fprintf(file_record, '%d', condition_index);
                
                % Break message
                if condition_index<howmanyconditions
                    tic;
                    message='breakuntilnextassessment';
                    BF_disp_message;
                    if strcmp(strInputName2,'ESCAPE')
                        stop_flag=1;
                        break;
                    end
                end
            end
        elseif strcmp(experiment_type,'fatigue_assess_sym_training') % everything is the same but not making any record files.
            % TD: read the exp record file.
            % If does not exist, create one.
            % condition order is determined when it is created only. Later,
            % just read it.
            % trial order, corrfreq order is determined here always.
            %open a data file
            condition_order=zeros(1,howmanyconditions);
            finished_conditions=0;
            condition_order=randperm(howmanyconditions);
            stop_flag=0;
            for condition_index=finished_conditions+1:howmanyconditions
                current_condition=condition_order(condition_index);
                % Get degree of visual fatigue before the start of the session.
                degree_fatigue=-1;
                message='fatiguequestion';
                BF_disp_message;

                for ii=1:trialspercorrfreq
                    corrfreq_order=randperm(howmanycorrfreq);
                    for jj=1:howmanycorrfreq
                        if (stop_flag==1)
                            break;
                        end
                        current_sc=corrfreq_order(jj)+(condition_order(condition_index)-1)*howmanycorrfreq;
                        BF_initialize_trial;
                        BF_run_trial;
                    end
                    if (stop_flag==1)
                        break;
                    end
                    if mod(ii,fatigue_question_period)==0
                        degree_fatigue=-1; % it means undefined
                        message='fatiguequestion';
                        BF_disp_message;
                    end
                end
                if (stop_flag==1)
                    break;
                end

                % Get degree of visual fatigue at the end of the session.
                degree_fatigue=-1; % it means undefined
                message='fatiguequestion';
                BF_disp_message;
                % TD: This is when one session ends. Rewrite the record.

                % Break message
                if condition_index<howmanyconditions
                    tic;
                    message='breakuntilnextassessment';
                    BF_disp_message;
                    if strcmp(strInputName2,'ESCAPE')
                        stop_flag=1;
                        break;
                    end
                end
            end
        elseif strcmp(experiment_type,'fatigue_dip0p1D')  || strcmp(experiment_type,'fatigue_dip1p3D')  || strcmp(experiment_type,'fatigue_dip2p5D')
            stop_flag=0;
            record_flag=0;
            for ii=1:2
                disparity=0;
                if ii==1
                    message='positivediplopia';
                    BF_disp_message;
                elseif ii==2
                    message='negativediplopia';
                    BF_disp_message;
                end
                while record_flag==0 && stop_flag==0 % record_flag becomes 1 when the subject hits ENTER.

                    BF_initialize_trial; % prepare the stimuli
                    BF_run_trial; % run the stimuli
                    
                    if (ii==1 && disparity<0) || (ii==2 && disparity>0)
                        message='wrongdirection';
                        BF_disp_message;
                        disparity=0;
                    end

                    % Renew disparity value according to subject's reponse

                end
                if stop_flag==1
                    break;
                end
                BF_record_response;
                record_flag=0;
            end
        elseif strcmp(experiment_type,'fatigue_symmetry')
            % TD: read the exp record file.
            % If does not exist, create one.
            % condition order is determined when it is created only. Later,
            % just read it.
            % trial order, corrfreq order is determined here always.
            %open a data file
            condition_order=zeros(1,howmanyconditions);
            recordfilename = [pwd '/BF_data_files/condition_record/' observer_initials '_' exp_num '_record.txt'];
            finished_conditions=0;
            
            if (exist(recordfilename)~=2) % if the record file does not exist
                % confirm below first, and then confirm the whole
                % exp_condition of fatigue_symmetry
                file_record=fopen(recordfilename,'a');
                pair_order=randperm(howmanypairs)-1;
                for ii=1:howmanypairs
                    subpair_order=randperm(2);
                    condition_order((ii-1)*2+1)=pair_order(ii)+subpair_order(1);
                    condition_order((ii-1)*2+2)=pair_order(ii)+subpair_order(2);
                end
                for ii=1:howmanyconditions
                    fprintf(file_record, '%d\n', condition_order(ii));
                end
                fprintf(file_record, '%d', finished_conditions);
            else % if the record file exists
                temp=textread(recordfilename,'%d');
                condition_order=temp(1:howmanyconditions);
                finished_conditions=temp(howmanyconditions+1);
            end

            stop_flag=0;
            for condition_index=finished_conditions+1:howmanyconditions
                current_condition=condition_order(condition_index);

                % start of main experiment
                for ii=1:trialspercorrfreq
                    corrfreq_order=randperm(howmanycorrfreq);
                    for jj=1:howmanycorrfreq
                        if (stop_flag==1)
                            break;
                        end
                        current_sc=corrfreq_order(jj)+(condition_order(condition_index)-1)*howmanycorrfreq;
                        BF_initialize_trial;
                        BF_run_trial;
                    end
                    if (stop_flag==1)
                        break;
                    end
                end
                if (stop_flag==1)
                    break;
                end
                
                % TD: This is when one session ends. Rewrite the record.
                file_record=fopen(recordfilename,'w');
                for ii=1:howmanyconditions
                    fprintf(file_record, '%d\n', condition_order(ii));
                    file_record=fopen(recordfilename,'a');
                end
                fprintf(file_record, '%d', condition_index);
                
                % Break message
                if condition_index<howmanyconditions
                    tic;
                    message='breakuntilnextassessment';
                    BF_disp_message;
                    if strcmp(strInputName2,'ESCAPE')
                        stop_flag=1;
                        break;
                    end
                end
            end

        elseif strcmp(experiment_type,'exp_aca')
            condition_order=randperm(howmanyconditions);
            stop_flag=0;
            exp_aca_phase=0; % initialization
            acc_stim=0;
            acc_response=0;
            acc_conv=0;
            for condition_index=1:howmanyconditions
                % decide current condition
                current_condition=condition_order(condition_index);
                
                % start of pre-session AC/A measurement
                exp_aca_phase=1; % means pre-session AC/A measurement
                exp_stim_type=stim_type;
                stim_type='aca_measure';

                % specify the condition of measurement of AC/A
                num_data_to_collect=3;
                aca_plane_list=[FarMidDist MidNearDist NearDist]; % location of accommodative stimulus for AC/A measurement
                rulerangle=4; % intended angular size of the ruler
                line_pos_range_degree=4; % angular range of line position, in degrees

                for ii=1:length(aca_plane_list)
                    aca_plane=aca_plane_list(ii);
                    data_count=1;
                    while data_count<num_data_to_collect && stop_flag==0
                        % calculate the intended size of the ruler.
                        % The vertical lines above 0 and 10 are separated by
                        % 402 pixels.
                        % The bitmap file is 512 pixels wide.
                        rulersize=2*aca_plane*(512/402)*tand(rulerangle/2);
                        linesize=rulersize/7;

                        % angular devation of the line from the center
                        line_pos_degree=line_pos_range_degree/2-line_pos_range_degree*rand;
                        % actual position of the line
                        line_pos=aca_plane*tand(line_pos_degree);

                        BF_initialize_trial; % prepare the stimuli
                        BF_run_trial; % run the stimuli
                        
                        data_count=data_count+1;
                    end
                    if stop_flag==1
                        break;
                    end
                end
                stim_type=exp_stim_type;
                % end of pre-session AC/A measurement

                % start of oddity task
                exp_aca_phase=2; % means oddity task
                for ii=1:trialspercorrfreq
                    corrfreq_order=randperm(howmanycorrfreq);
                    for jj=1:howmanycorrfreq
                        if (stop_flag==1)
                            break;
                        end
                        current_sc=corrfreq_order(jj)+(condition_order(condition_index)-1)*howmanycorrfreq;
                        BF_initialize_trial;
                        BF_run_trial;
                    end
                    if (stop_flag==1)
                        break;
                    end
                end
                if (stop_flag==1)
                    break;
                end
                
                % start of post-session AC/A measurement
                exp_aca_phase=3; % means post-session AC/A measurement
                exp_stim_type=stim_type;
                stim_type='aca_measure';

                % specify the condition of measurement of AC/A
                num_data_to_collect=3;
                aca_plane_list=[FarMidDist MidNearDist NearDist]; % location of accommodative stimulus for AC/A measurement
                rulerangle=4; % intended angular size of the ruler
                line_pos_range_degree=4; % angular range of line position, in degrees

                for ii=1:length(aca_plane_list)
                    aca_plane=aca_plane_list(ii);
                    data_count=1;
                    while data_count<num_data_to_collect && stop_flag==0
                        % calculate the intended size of the ruler.
                        % The vertical lines above 0 and 10 are separated by
                        % 402 pixels.
                        % The bitmap file is 512 pixels wide.
                        rulersize=2*aca_plane*(512/402)*tand(rulerangle/2);
                        linesize=rulersize/7;

                        % angular devation of the line from the center
                        line_pos_degree=line_pos_range_degree/2-line_pos_range_degree*rand;
                        % actual position of the line
                        line_pos=aca_plane*tand(line_pos_degree);

                        BF_initialize_trial; % prepare the stimuli
                        BF_run_trial; % run the stimuli
                        
                        data_count=data_count+1;
                    end
                    if stop_flag==1
                        break;
                    end
                end
                stim_type=exp_stim_type;
                % end of post-session AC/A measurement
                
                % Break message
                if condition_index<howmanyconditions
                    tic;
                    message='breakuntilnextassessment';
                    BF_disp_message;
                    if strcmp(strInputName2,'ESCAPE')
                        stop_flag=1;
                        break;
                    end
                end
            end
            
        elseif ~strcmp(experiment_type, 'monocular_hinge')
            while (trial_counter<3000)
                 stop_flag = 0;
                 trial_counter=trial_counter+1;
                 current_sc = selectStaircase(scell); %randomly select a staircase
                 if current_sc<=0
                     break
                 end
                 
                 BF_initialize_trial;
                 BF_run_trial;
                 
                 if stop_flag==1
                     break;
                 end

                 if mod(trial_counter, trials_per_block)==0
                     message='takeabreak';
                     BF_disp_message
                 end


                    %Screen('Flip', windowPtr [, when] [, dontclear] [, dontsync]
                    %[, multiflip]);
                    onset=Screen('Flip', windowPtr, [], 2, 1);
            end
        end
%             keyboard;
            message='experimentcomplete';
            BF_disp_message
        
        
    end
  

        
 
    
    
    
    
    
    printcalibration_data_to_file=0;
    if strcmp(exp_num, 'exp_iodrects')  %special case where we want to save the data
        printcalibration_data_to_file=1;
    end
    if trial_mode==1
        if dumpworkspace
            if exist('soundCorrect','var')
                clear soundCorrect;
                clear soundWrong;
            end
            save (dumpworkspacefilename)  %Wrtie out all info to file for after the fact review
			if strcmp(experiment_type, 'fatigue_time')||strcmp(experiment_type,'fatigue_time_3')...
                    ||strcmp(experiment_type,'fatigue_time_4')||strcmp(experiment_type,'fatigue_time_5')
                if exist('record_data','var')
    				save (datafilename,'record_data') % If the experiment is 'exp_fatigue_time,' save variable 'record_data' when dumping workspace.
                end
                plot(frameTimePlot);
                axis([1 length(frameTimePlot) 0 2/100]);
            elseif strcmp(experiment_type,'focusVaryingStereo')
                if exist('block','var')
    				save (datafilename,'block') % If the experiment is 'exp_fatigue_time,' save variable 'record_data' when dumping workspace.
                end
			end
        end
        if (strcmp(experiment_type, 'alignmode') && (current_sc<=0));  %report alignment results
            printcalibration_data_to_file=1;
                       %This loop will do the averaging of the last 5 reversals
                for i=1: length(scell); 
                        alignplane= get(scell{i}, 'align_plane');
                        align_param= get(scell{i}, 'align_parameter');
                                reversalflags=get(scell{i}, 'reversalflag');
                                thevalues=get(scell{i}, 'values');
                                thereversals=thevalues(find(reversalflags==1));
                                lastreversal=length(thereversals);
                                bestguess= mean(thereversals(lastreversal-5:lastreversal));
                                errorestimate=std(thereversals(lastreversal-5:lastreversal));
                        if align_param==1
                            degvertoffset(alignplane+renderviews*4)=bestguess;
                            degvertoffseterror(alignplane+renderviews*4)=errorestimate;
                        elseif align_param==2
                            deghorizoffset(alignplane+renderviews*4)=bestguess;
                            deghorizoffseterror(alignplane+renderviews*4)=errorestimate;
                        elseif align_param==3
                                vertFOVoffset(alignplane+renderviews*4)=  -bestguess*vertFOV/horizFOV;
                                horizFOVoffset(alignplane+renderviews*4)= -bestguess;
                                horizFOVoffseterror(alignplane+renderviews*4)= errorestimate;
                        end
                end            
        end
            
            
    end

    if trial_mode==0 && (strcmp(experiment_type, 'alignmode')) || (strcmp(experiment_type, 'iodrectmode'))    
            
            printcalibration_data_to_file=1;
    end
    if printcalibration_data_to_file==1
                    fprintf(calibrationfile_1, '\n\n%s\n\n', ['%calibration: ' exp_num ' was performed on: ' datestr(clock, 0) '.mat']);
                    fprintf(calibrationfile_1, '\t\t%s\n', ['deghorizoffset = [' num2str(deghorizoffset) '];' ]);
                    fprintf(calibrationfile_1, '\t\t%s\n', ['degvertoffset = [' num2str(degvertoffset) '];' ]);
                    fprintf(calibrationfile_1, '\t\t%s\n', ['vertFOVoffset = [' num2str(vertFOVoffset) '];' ]);
                    fprintf(calibrationfile_1, '\t\t%s\n', ['horizFOVoffset = [' num2str(horizFOVoffset) '];' ]);
                    fprintf(calibrationfile_1, '\t\t%s\n', ['vertFOV = [' num2str(vertFOV) '];' ]);
                    fprintf(calibrationfile_1, '\t\t%s\n', ['horizFOV = [' num2str(horizFOV) '];' ]);
                    
                    if (trial_mode==1)
                    fprintf(calibrationfile_1, '\t\t%s\n', ['horizFOVoffseterror = [' num2str(horizFOVoffseterror) '];' ]);
                    fprintf(calibrationfile_1, '\t\t%s\n', ['deghorizoffseterror = [' num2str(deghorizoffseterror) '];' ]);
                    fprintf(calibrationfile_1, '\t\t%s\n', ['degvertoffseterror = [' num2str(degvertoffseterror) '];' ]);
                    end
                    
                    disp('********************************************************************************')
                    disp('********************************************************************************')
                    disp(['********The calibration data has been saved to the ' observer_initials ' file***********'])
                    disp('********************************************************************************')
                    disp('********************************************************************************')
    end    
    
    
    
    
             message='turnlensoff';
             BF_disp_message    
    
    
    
    

%          Screen('LoadNormalizedGammaTable', windowPtr);
%     
%     if exist('windowPtr2', 'var')
%     Screen('LoadNormalizedGammaTable', windowPtr2);    
%     end
    

    
    % Close onscreen window and release all other ressources:
    Screen('CloseAll');

    % Reenable Synctests after this simple demo:
    %Screen('Preference','SkipSyncTests',1);
%     figure(5)
%     plot(timecounter(3:end)-timecounter(2:end-1))
    
    
    
    if (viewMode==10) && current_resolution.width==1056;
        SetResolution(0, oldres);
        SetResolution(1, oldres);
    end
    

    
    ListenChar(0);

    
 
%     catch
    
%     Screen('LoadNormalizedGammaTable', windowPtr);
%     
%     if exist('windowPtr2', 'var')
%     Screen('LoadNormalizedGammaTable', windowPtr2);    
%     end
%     
%     % Executes in case of an error: Closes onscreen window:
%     Screen('CloseAll');
    ListenChar(0);
%    psychrethrow(psychlasterror);
    
    if (viewMode==10) && current_resolution.width==1056;
        SetResolution(0, oldres);
        SetResolution(1, oldres);
    end
    
% end;
    
    
    
