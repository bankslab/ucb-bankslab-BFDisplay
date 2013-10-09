%David Hoffman
%July 2, 2008

%This file contains the starting points for how the display is set up
%all units if not specified are in meters


%This file was made July 2, 2008 as part of the project of transitioning
%from demo code to experiment code


    
        IPD=.061;  %Inter pupillary distance, at far
    
            % Clip planes
        nearClip    = .3;        %in meters
        farClip     = 4;       %in meters
            % note:  Keep the near and far clip as close together as
            % possible. The depth texture is finite and spans from the near
            % to far clip plane
            % Make sure to check how well the depths are represnted in 24
            % steps that are linear in normal metric space
        
            vertFOV= 23.3;  %degrees absolute
            horizFOV= 32.6;  %degrees 
            
            %imageplanedist= [.402 .5127 .7842 1.3295 ];
            %For infinite condition, dioptric image plane distances are: 0, 0.575, 1.28, 1.785
            %Since the relative relationship among these values are
            %important, we add 1 diopters: 1, 1.575, 2.28, 2.785
            %And, finally, we change them to metric distances:
            imageplanedist= [ 1.3295 .7842  .5127 .402];
            
            %These are alignment parameters that deal with
            %lens state magnification and prismatic shifts
            
            %Deepth plane numbering Far to near: 1:4
            %1L, 2L, 3L, 4L, 1R, 2R, 3R, 4R
            
            %ideally modify 1L and 1R in initial setup, and then
            %don't touch the 1L, and 1R terms

            
            
            %21-oct-2008  David generated these starting
            %values.  These values are corrected for absolute angular size
            %and between plane alignment, when the lens system is in its
            %most forward state.

            %calibration: exp_iodrects was performed on: 06-Aug-2009 14:47:11.mat

            deghorizoffset = [-0.81       0.914     0.86375     0.83375       -0.62    -0.28625      -0.167    -0.05075];
            degvertoffset = [-0.1     -0.1145    -0.11925      -0.139       -0.48      -0.165    -0.17175       -0.19];
            vertFOVoffset = [0.92     0.17242   -0.059762    -0.33868        0.32    -0.11025    -0.25417    -0.43661];
            horizFOVoffset = [1.12     0.24124   -0.083615    -0.47387         0.9    -0.15425    -0.35563    -0.61088];
            vertFOV = [23.3];
            horizFOV = [32.6];

            
            %calibration: exp_4R was performed on: 10-Aug-2009 15:55:17.mat
            %by Takashi

            deghorizoffset = [-0.81    -0.70775    -0.60375      -0.521       -0.62     -0.5475    -0.45825    -0.38175];
            degvertoffset = [-0.1    -0.02325       0.037      0.1025       -0.48     -0.4445     -0.3765     -0.3515];
            vertFOVoffset = [0.92     0.55973     0.33377    0.047615        0.32     0.36442     0.13008    -0.12186];
            horizFOVoffset = [1.12     0.78313     0.46699     0.06662         0.9     0.50988       0.182    -0.17051];


            %calibration: exp_4L was performed on: 20-Aug-2009 18:04:20.mat
            %by Joohwan

            deghorizoffset = [-1.21      -1.189     -1.1827      -1.172       -1.12      -1.057    -0.97875    -0.90375];
            degvertoffset = [1.58      1.6803      1.8113      1.9225        0.46      0.6045     0.78125     0.91825];
            vertFOVoffset = [0.92     0.55195      0.3855     0.15393        0.32     0.37049    0.047175     -0.1869];
            horizFOVoffset = [1.12     0.77226     0.53937     0.21537         0.9     0.51837    0.066005    -0.26149];
            vertFOV = [23.3];
            horizFOV = [32.6];
            
            FarDist=imageplanedist(1);
            FarMidDist=imageplanedist(2);
            MidNearDist=imageplanedist(3);
            NearDist=imageplanedist(4);
            
            MidpointFarMidDist=2/(1/imageplanedist(1)+1/imageplanedist(2));  %Dioptric midpoint
            MidpointMidMidDist=2/(1/imageplanedist(2)+1/imageplanedist(3));  %Dioptric midpoint
            MidpointMidNearDist=2/(1/imageplanedist(3)+1/imageplanedist(4));  %Dioptric midpoint
            
            SuperNearDist=1/(1/imageplanedist(4)+0.6);
            
            

            
            
            disp('*****************************')
            disp('System Params loaded for original 3 plane configuration (infinity)')
            disp('-5.5 D lens for left eye, -5.25D for right eye')
            disp('*****************************')