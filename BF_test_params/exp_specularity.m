% specularity perception experiment on flat surfaces, monocular viewing
% NOTE!
% Observer files for specularity experiment should be end with four letter
% sequence: spec
% Example of observer file name: JSK_spec.m


experiment_type='specularity';
stim_type= 'specularity';
%stim_type='demomode';
trial_mode=0;

dynamic_mode=0;   %1 for time varying stimulus, 0 for a static stimulus
static_mode=1;    %1 to present a static scene, this will be precomputed in load time

renderviews= [0 1];  %0 is the left eye, 1 is the right eye

dumpworkspace=0;  %dumps all the variables in program to mat file

projection_type=0;  % 0 is perspective, 1 is orthographic (warning: stereo will not work if set to 1)

focus_cue_multiplier=1;              

vergdist=FarMidDist;  

surfaceTextureFileName='BF_texture_files/specularitySurface.jpg';
reflectionTextureFileName='BF_texture_files/specularityReflection.jpg';
sphereRadius=0.01; %
reflectionOffset=0;

iodIndex=11; % variable that controls simulated iod of cameras.
surfaceScaleIndex=11; % simulated scaling of the sphere. Larger means elongated in depth.
reflectionScaleIndex=11; % simulated focal depth of reflection

% s = PTBStaircase;           % Instantiate a staircase
% 
% % in the order of {FAR FARMID MIDNEAR NEAR}
% % image_fname={'black.bmp' 'light.bmp' 'black.bmp' 'plane.bmp'};
% scell{1} = set(s,... % Just to use setting variables. Vergence, Version are determined outside of scell.
%     'condition_num',1,... %Condition_num is only used for numbering the conditions in data output.  
%     'initialValue', 0,...% Specify the number of repetition of current scell. (Note that it is not a staircase)
%     'initialValue_random_range', 0,...
%     'stepSize',0,...% not using staircase method. Should be 0 in fatigue assessment exp!
%     'minValue',0,...% not using staircase method
%     'maxValue',4,...% 
%     'maxReversals',1000,...% not using staircase method
%     'maximumtrials', 1000,...% not using staircase method
%     'stepLimit',1,...
%     'numUp',1,...
%     'numDown',2,...
%     'phase1_duration', 2.0,...
%     'phase1_duration_rpt', .3,...
%     'phase1_verg_dist', FarMidDist,...
%     'phase1_accom_dist', FarMidDist,...
%     'phase2_duration', 1,... %To access stimulus_duration, get phase2_duration
%     'phase2_verg_dist',NearDist,...
%     'phase2_accom_dist', FarMidDist,...
%     'phase1_stim', 'fixation_cross',...
%     'phase2_stim', 'fuse_stim',...
%     'rds_grating_angularsize', 4.2,...      %Specify angular size in degrees diameter
%     'rds_grating_numdots', 600,...
%     'rds_grating_orientation', 10,...
%     'rds_grating_cpd', 2,...
%     'rds_grating_disparity', 4);    %specified in arcmin
