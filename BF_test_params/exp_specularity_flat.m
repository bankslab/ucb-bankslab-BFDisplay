% specularity perception experiment on flat surfaces, monocular viewing


experiment_type='specularity_flat';
stim_type= 'specularity_flat';
%stim_type='demomode';
trial_mode=1;

dynamic_mode=0;   %1 for time varying stimulus, 0 for a static stimulus
static_mode=1;    %1 to present a static scene, this will be precomputed in load time

renderviews= [0 1];  %0 is the left eye, 1 is the right eye

dumpworkspace=0;  %dumps all the variables in program to mat file

projection_type=0;  % 0 is perspective, 1 is orthographic (warning: stereo will not work if set to 1)

focus_cue_multiplier=1;              

vergdist=FarMidDist;  

numReflectionImageInOneSet=19;
numSurfaceImageInOneSet=19;

for ii=1:numReflectionImageInOneSet
    leftReflectionImageFileName{ii,1}=['BF_texture_files/specOnly/spec_-3_' num2str(floor(ii/10)) '.' num2str(mod(ii,10)) '0_2_p3.png'];
    leftReflectionImageFileName{ii,2}=['BF_texture_files/specOnly/spec_-3_' num2str(floor(ii/10)) '.' num2str(mod(ii,10)) '0_2_p2.png'];
    leftReflectionImageFileName{ii,3}=['BF_texture_files/specOnly/spec_-3_' num2str(floor(ii/10)) '.' num2str(mod(ii,10)) '0_2_p1.png'];
    rightReflectionImageFileName{ii,1}=['BF_texture_files/specOnly/spec_3_' num2str(floor(ii/10)) '.' num2str(mod(ii,10)) '0_2_p3.png'];
    rightReflectionImageFileName{ii,2}=['BF_texture_files/specOnly/spec_3_' num2str(floor(ii/10)) '.' num2str(mod(ii,10)) '0_2_p2.png'];
    rightReflectionImageFileName{ii,3}=['BF_texture_files/specOnly/spec_3_' num2str(floor(ii/10)) '.' num2str(mod(ii,10)) '0_2_p1.png'];
end
for ii=1:numSurfaceImageInOneSet
    leftSurfaceImageFileName{ii,1}=['BF_texture_files/texOnly/tex_-3_' num2str(floor(ii/10)) '.' num2str(mod(ii,10)) '0_p3.png'];
    leftSurfaceImageFileName{ii,2}=['BF_texture_files/texOnly/tex_-3_' num2str(floor(ii/10)) '.' num2str(mod(ii,10)) '0_p2.png'];
    leftSurfaceImageFileName{ii,3}=['BF_texture_files/texOnly/tex_-3_' num2str(floor(ii/10)) '.' num2str(mod(ii,10)) '0_p1.png'];
    rightSurfaceImageFileName{ii,1}=['BF_texture_files/texOnly/tex_3_' num2str(floor(ii/10)) '.' num2str(mod(ii,10)) '0_p3.png'];
    rightSurfaceImageFileName{ii,2}=['BF_texture_files/texOnly/tex_3_' num2str(floor(ii/10)) '.' num2str(mod(ii,10)) '0_p2.png'];
    rightSurfaceImageFileName{ii,3}=['BF_texture_files/texOnly/tex_3_' num2str(floor(ii/10)) '.' num2str(mod(ii,10)) '0_p1.png'];
end

reflectionScaleIndex=10; % variable that controls simulated iod of cameras.
surfaceScaleIndex=10;
textureImageSize=0.1;

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
