%this file is the prototype for the time to fuse task


experiment_type='cyl_structure';
stim_type='cyl_structure';   %This will show vernier lines distributed across depth
%experiment_type='demomode';
projection_type=1;  % 0 is perspective, 1 is orthographic (warning: stereo will not work if set to 1)

trial_mode=1;   %Enter the presentation, and respond flavor of the program
show_verg_ref_dist=0;

dynamic_mode=1;   %1 for time varying stimulus, 0 for a static stimulus
static_mode=0;    %1 to present a static scene, this will be precomputed in load time

  %focus_cue_multiplier=10;              
                renderviews= [1];  %0 is the left eye, 1 is the right eye

   vergdist=FarMidDist;             
s = PTBStaircase;           % Instantiate a staircase

dumpworkspace=1;  %dump all variables to mat file for future reference.  

trials_per_block=250;

% Set up the staircases' values.  Start with one staircase.  This
% will later be duplicated and the appropriate values will be
% changed for each staircase

cyl_radius=.1; %meters
cyl_height=.15; %meters
dotradius= .001; %meters
cyl_rotation_period=3.2;  %time to complete a revolution
pause_time=.5;

scell{1} = set(s,...
    'condition_num',0,...
    'initialValue', 0,...
    'initialValue_random_range', 0,...
    'stepSize',.8,...
    'minValue',-2,...
    'maxValue',0.7,....
    'maxReversals',20,...
    'maximumtrials', 50,...
    'stepLimit',.1,...
    'numUp',1,...
    'numDown',2,...
    'phase1_duration', 4,...
    'rds_grating_numdots', 200,...
    'phase1_verg_dist', FarMidDist,...
    'phase1_accom_dist', FarMidDist,...
    'phase1_stim', 'cyl_structure');    
%     
% 
% % % Copy to other staircases
 scell{2} =  scell{1};

% 
% % % Copy to other staircases
% scell{3} =  scell{1};
% % Set the correct stimulus params
% scell{3} = set(scell{3}, 'condition_num',2,...
%     'phase2_verg_dist', MidpointMidMidDist,...
%     'phase2_accom_dist', NearDist);
% 
% % % Copy to other staircases
% scell{4} =  scell{1};
% % Set the correct stimulus params
% scell{4} = set(scell{4}, 'condition_num',3,...
%     'phase2_verg_dist', NearDist,...
%     'phase2_accom_dist', NearDist);
% 
% % % Copy to other staircases
% scell{5} =  scell{1};
% % Set the correct stimulus params
% scell{5} = set(scell{5}, 'condition_num',4,...
%     'phase2_verg_dist', FarDist,...
%     'phase2_accom_dist', MidpointMidMidDist);
% 
% % % Copy to other staircases
% scell{6} =  scell{1};
% % Set the correct stimulus params
% scell{6} = set(scell{6}, 'condition_num',5,...
%     'phase2_verg_dist', NearDist,...
%     'phase2_accom_dist', MidpointMidMidDist);
% 
% % % Copy to other staircases
% scell{7} =  scell{1};
% % Set the correct stimulus params
% scell{7} = set(scell{7}, 'condition_num',6,...
%     'phase2_verg_dist', FarDist,...
%     'phase2_accom_dist', FarDist);
% 
% scell{8} =  scell{1};
% % Set the correct stimulus params
% scell{8} = set(scell{8}, 'condition_num',7,...
%     'phase2_verg_dist', MidpointMidMidDist,...
%     'phase2_accom_dist', FarDist);
% 
% scell{9} =  scell{1};
% % Set the correct stimulus params
% scell{9} = set(scell{9}, 'condition_num',8,...
%     'phase2_verg_dist', NearDist,...
%     'phase2_accom_dist', FarDist);
% 
% 
% Set initial staircase


for i=1: length(scell);  %A nice feature would be to move this loop to within initialize staircase, and it would initialize them all with one command
scell{i}=initializeStaircase(scell{i});
end






%Prepare the data file
testfileoutdir = [pwd '/datafiles'];
mkdir(testfileoutdir);
textfilenameout = [pwd '/datafiles/resultfile_' observer_initials '_' exp_num '_' datestr(clock, 30) '.txt'];



