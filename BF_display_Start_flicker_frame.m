function [] = BF_display_Start(viewMode, observer_initials, exp_num)
      %BF_display_Start(viewMode, observer_initials)
      %David Hoffman
      %July 2, 2008 Eventually this will be the roon experiment file for BF
      %Lens system based display
      
    clear GL;
    clear java;
    %profile on;
    
    viewMode=0;
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
    Screen('Preference', 'SkipSyncTests', 1);
    % Find the screen to use for display:
    screenid=max(Screen('Screens'));


    
     
    
    
    
    
    % Disable Synctests for this simple demo:
    %Screen('Preference','SkipSyncTests',1);

%Load the basic values, that should be as close as possible to correct.      
BF_default_params;
load([pwd '/BF_params/BF_CLUTlookuptables.mat']);
%Load the special params for a specific user
eval([observer_initials]);

%Load the test specific parameters, and if staircases are used, start those
%too
%BF_CLUT_L= flipud(BF_CLUT_L)/255;
BF_CLUT_L= (BF_CLUT_L)/255;
BF_CLUT_R=BF_CLUT_R/255;




eval([exp_num]);

                     
            
 
    ListenChar(2)
    
    
    try
    
    % Enable unified mode of KbName, so KbName accepts identical key names on
    % all operating systems:
    KbName('UnifyKeyNames');


    

        
    

        % For Psychtoolbox 3.x
    % Disable the Warnings and checks
    %oldEnableFlag   = Screen('Preference', 'SuppressAllWarnings', 1);
    %oldSyncTests    = Screen('Preference', 'SkipSyncTests', 1);
    %oldVisualDebug  = Screen('Preference', 'VisualDebugLevel', 0);
    

    

    % Open a double-buffered full-screen window on the main displays screen.
    %[windowPtr , winRect] = Screen('OpenWindow', screenid, 0, [], [], [], viewMode, [], kPsychNeedFastBackingStore);
    %This one just below was the old one that I used
    %[windowPtr, windowRect] = Screen('OpenWindow', screenid, 0, [], 32, 2, 0, 8);
    
    
    
    % Open a double-buffered full-screen window on the main displays screen
    % in stereo display mode 'viewMode' and background clear color black
    % (aka 0). This will enable the image processing operations - display
    % undistortion for both views:

    [windowPtr, winRect] = Screen('OpenWindow', screenid);
        %origGamma=Screen('LoadNormalizedGammaTable', windowPtr, BF_CLUT_L);
    

    
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

    % Show cleared start screen:
    onset=Screen('Flip', windowPtr);  
    
    
    
    
        %code for building the depth textures
        
    Screen('BeginOpenGL', windowPtr);
    glActiveTexture(GL.TEXTURE1);
    glTexEnvi(GL.TEXTURE_ENV, GL.TEXTURE_ENV_MODE, GL.MODULATE);
    glActiveTexture(GL.TEXTURE0);
    glTexEnvi(GL.TEXTURE_ENV, GL.TEXTURE_ENV_MODE, GL.MODULATE);
    Screen('EndOpenGL', windowPtr);
    glClearDepth(1.0);
    DEPTHTEXSIZE=1024;   %This is from depth.h and is a parameter for depth image size
  
    
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
    
    
    
   Screen('EndOpenGL', windowPtr);
    

    activelensmode=1;
    depthplane=1;
    depthtex_handle=1;
    

   
    timecounter=zeros(200000,1);
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
        
        BF_make_rds_grating(MidNearDist, 300, 90, 1.35, 4, 10, IPD, 1.5, texname_static);
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

        
    %Build the display lists
    %This is the precomputation of the openGL stuff
    %Trades off real time flexibility for speed in some cases
    %Best chances of not dropping frames
    
    %write and call display lists in same sequence as the init setting
    %vectors
    Screen('BeginOpenGL', windowPtr);
    
    
    if trial_mode==0
        genlist_start=glGenLists(16);  %Returns integer of first set of free display lists
        genlist_projection1=[0 1 2 3 4 5 6 7]+genlist_start;  %Set of indices 
        static_scene_disp_list=[0 1 2 3 4 5 6 7]+genlist_start+8;

            for depthplane= 4: -1: 1
                   depthtex_handle=depthplane ;
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
        

            
            %open a data file
            resultfilenameout = [pwd '/BF_data_files/BF_' observer_initials '_' exp_num '_' datestr(clock, 30) '.txt'];
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
    
    

    
renderviews=1;
    
    while (trial_mode==0)
      
        tic
        kinetic_dist= 0.8657+ .4637*sin(numframes/100);
        cyl_rotation=numframes/3;
        
        
         [strInputName, x, y] = BFWaitForInput(0.000001);
         
        BF_keyboard_handling;    %handle the responses
        
           
            
            if list_rendering==1 && 0==strcmp(strInputName, '')              %Only rebuild the display lists if they pressed a button and they are in list_rendering,
                                                                             %Also only rebuild if we have made a viewport specific change, like in 
                                                                          %otherwise, proceed
                                                              
                %glDeleteLists(genlist_start,8);  %Clear the old display lists
                depthplaneinit=depthplane;
                depthtexinit=depthtex_handle;
                if activelensmode==1
                    if recompute_projection_list==1
                        
                        
                        for depthplane= 1: 4
                               depthtex_handle=depthplane ;
                               for whichEye=[0 1]
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
                               for whichEye=[0 1]
                                   glNewList(static_scene_disp_list(depthplane+whichEye*4), GL.COMPILE);
                                   BFRenderScene_static;
                                   glEndList();
                               end
                        end
                        recompute_static_scene_list=0;
                    end                    
                    
                    
                else
                    
                       for whichEye=[0 1]
                           glNewList(genlist_projection1(depthplane+whichEye*4), GL.COMPILE);
                           BF_viewport_specific_GL_commands;
                           glEndList();
                       end
                end
                
                depthplane=depthplaneinit;
                depthtex_handle=depthtexinit;

            end
            
            
            
            
            
            
            if activelensmode && renderviews==1
                
                depthplane=depthplane+1;
                if depthplane>4
                    
                    depthplane=1;
                end
               depthtex_handle=depthplane;     
            end
            

            renderviews=(renderviews==0);
            
            for whichEye=renderviews
                
                
                Screen('BeginOpenGL', windowPtr);
                
               
                glCallList(genlist_projection1(depthplane+whichEye*4));    %mandatory projection setup
                
                if static_mode  %optional mode for staic imagery
                    glCallList(static_scene_disp_list(depthplane+whichEye*4));
                end
                if dynamic_mode  %optional mode for moving imagery
                    BFRenderScene_dynamic;
                end
                

%                 glTranslatef(0.03,.030, -kinetic_dist);
%                 glutWireSphere(0.04, 25, 25);
% 
%                 glTranslatef(-0.06,-.06, +(kinetic_dist)-(.8+1.2-kinetic_dist));
%                 glutWireSphere(0.05, 20, 20);

                Screen('EndOpenGL', windowPtr);
                if show_verg_ref_dist  % print out the lens specified depth
                    
                    Screen('TextSize',windowPtr, 50);
                    
                   Screen('DrawText', windowPtr, ['Depthplane is = ' num2str(depthplane)], 100, 100, [0, 0, 255, 255]); 
                   Screen('DrawText', windowPtr, ['WhichEye is = ' num2str(whichEye)], 100, 200, [0, 0, 255, 255]); 
                end
                    %for blue lining
                    if whichEye==1
                        Screen('DrawLine', windowPtr, [255 255 255],0, winRect(4), winRect(3)*.75 , winRect(4), 3);
                    else
                        Screen('DrawLine', windowPtr, [255 255 255],0, winRect(4), winRect(3)*.25 , winRect(4), 3);
                    end
               
               if whichEye==1
                    
                        Screen('FillRect', windowPtr, [255 255 255], [winRect(3)*.85, winRect(4)*.85, winRect(3) , winRect(4)]);
                        if depthplane==4
                        Screen('FillRect', windowPtr, [255 255 255], [0, winRect(4)*.85, winRect(3)*.15 , winRect(4)]);
                        end
                end
                
            end

                
        %Screen('Flip', windowPtr [, when] [, dontclear] [, dontsync] [, multiflip]);
        onset=Screen('Flip', windowPtr, [], 2, 1);
        %onset=Screen('Flip', windowPtr, [], 2, 2);
        % Check for keyboard press and exit, if so:
        %glFinish
                
                timecounter(numframes)=toc;
        
        numframes = numframes + 1;
        
    end  %while trial mode==0


    trial_counter=0;
    if trial_mode==1
        
        
        current_sc=1;
        BF_initialize_trial;    %Just to build projections for splash screen
        message='turnlenson';
        BF_disp_message
        
        message='readytobegin';
        BF_disp_message

        while (trial_counter<500)
            

                trial_counter=trial_counter+1
             current_sc = selectStaircase(scell); %randomly select a staircase
             if current_sc<=0
                 break
             end

             BF_initialize_trial;


             BF_run_trial;



             if mod(trial_counter, trials_per_block)==0
                 message='takeabreak';
                 BF_disp_message
             end


                %Screen('Flip', windowPtr [, when] [, dontclear] [, dontsync]
                %[, multiflip]);
                onset=Screen('Flip', windowPtr, [], 2, 1);
        end
        
             message='experimentcomplete';
             BF_disp_message
        
        
    end
  

        
 
    
    
    
    
    
    printcalibration_data_to_file=0;
    if trial_mode==1
        if dumpworkspace
            save (dumpworkspacefilename)  %Wrtie out all info to file for after the fact review
        end
        if (strcmp(experiment_type, 'alignmode') && (current_sc<=0));  %report alignment results
            
                       %This loop will do the averaging of the last 5 reversals
                for i=1: length(scell); 
                        alignplane= get(scell{i}, 'align_plane');
                        align_param= get(scell{i}, 'align_parameter');
                                reversalflags=get(scell{i}, 'reversalflag');
                                thevalues=get(scell{i}, 'values');
                                thereversals=thevalues(find(reversalflags==1));
                                lastreversal=length(thereversals);
                                bestguess= mean(thereversals(lastreversal-4:lastreversal));
                                errorestimate=std(thereversals(lastreversal-4:lastreversal));
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
            
            
            

            printcalibration_data_to_file=1;
        end
    elseif trial_mode==0 && strcmp(experiment_type, 'alignmode')      
            
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
                    fprintf(calibrationfile_1, '\t\t%s\n', ['horizFOVoffseterror = [' num2str(horizFOVoffseterror) '];' ]);
                    fprintf(calibrationfile_1, '\t\t%s\n', ['deghorizoffseterror = [' num2str(deghorizoffseterror) '];' ]);
                    fprintf(calibrationfile_1, '\t\t%s\n', ['degvertoffseterror = [' num2str(degvertoffseterror) '];' ]);
                    disp('********************************************************************************')
                    disp('********************************************************************************')
                    disp(['********The calibration data has been saved to the ' observer_initials ' file***********'])
                    disp('********************************************************************************')
                    disp('********************************************************************************')
    end    
    
    
    
    
             message='turnlensoff';
             BF_disp_message    
    
    
    
    
%         Screen('LoadNormalizedGammaTable', windowPtr, origGamma);
%         
%     if exist('windowPtr2', 'var')    
%     Screen('LoadNormalizedGammaTable', windowPtr2, origGamma);
%     end
%     
    
    % Close onscreen window and release all other ressources:
    Screen('CloseAll');

    % Reenable Synctests after this simple demo:
    %Screen('Preference','SkipSyncTests',1);
%     figure(5)
    plot(timecounter(1:numframes))
    
    
    
    if (viewMode==10) && current_resolution.width==1056;
        SetResolution(0, oldres);
        SetResolution(1, oldres);
    end
    

    
    ListenChar(0);

    
catch
    
%     Screen('LoadNormalizedGammaTable', windowPtr, origGamma);
%     
%     if exist('windowPtr2', 'var')
%     Screen('LoadNormalizedGammaTable', windowPtr2, origGamma2);    
%     end
    
    % Executes in case of an error: Closes onscreen window:
    Screen('CloseAll');
    ListenChar(0);
    psychrethrow(psychlasterror);
    
    if (viewMode==10) && current_resolution.width==1056;
        SetResolution(0, oldres);
        SetResolution(1, oldres);
    end
    
end;
    
    
    