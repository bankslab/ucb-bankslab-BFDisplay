%This file is the prototype for the staircase method of measuring visual
%fatigue. 'Time to fuse' experiment is adopted due to similarity. Here four
%cases of staircase are measured, cues-consistent & cues-inconsistent # of
%staircases could be increased in later version according to the
%experimental configuration.


experiment_type='fatigue_fixduration'; % Experiment for measuring visual fatigue, staircase method
stim_type='fuse_stim';   %fuse_stim will show a sinusoidal depth random dot stereogram
%experiment_type='demomode';

trial_mode=1;   %Enter the presentation, and respond flavor of the program
show_verg_ref_dist=0;  %This is only useful for debugging.  It will print out the distances to screen

dynamic_mode=0;   %1 for time varying stimulus, 0 for a static stimulus
static_mode=1;    %1 to present a static scene, this will be precomputed in load time

                
                renderviews= [0 1];  %0 is the left eye, 1 is the right eye

                
s = PTBStaircase;           % Instantiate a staircase

dumpworkspace=1;  %dump all variables to mat file for future reference.  

trials_per_block=12; %Trials_per_block is the number of trials before it asks the observer to take a break

% Set up the staircases' values.  Start with one staircase.  This
% will later be duplicated and the appropriate values will be
% changed for each staircase



scell{1} = set(s,...
    'condition_num',1,... %Condition_num is only used for numbering the conditions in data output.  
    'initialValue', 1,...
    'initialValue_random_range', 0,...
    'stepSize',0.,... % not using staircase method
    'minValue',0.,...% not using staircase method
    'maxValue',1,....% not using staircase method
    'maxReversals',1000,...% not using staircase method
    'maximumtrials', 1000,...% not using staircase method
    'stepLimit',0.5,...
    'numUp',1,...
    'numDown',2,...
    'phase1_duration', 2.0,...
    'phase1_duration_rpt', .3,...
    'phase1_verg_dist', FarDist,...
    'phase1_accom_dist', FarDist,...
    'phase2_duration', 1.5,...
    'phase2_verg_dist',FarMidDist,...
    'phase2_accom_dist', FarDist,...
    'phase1_stim', 'fixation_cross',...
    'phase2_stim', 'fuse_stim',...
    'rds_grating_angularsize', 4.2,...      %Specify angular size in degrees diameter
    'rds_grating_numdots', 830,...
    'rds_grating_orientation', 15,...
    'rds_grating_cpd', 2,...
    'rds_grating_disparity', 10);    %specified in arcmin
    

% % Copy to other staircases
scell{2} =  scell{1};
% Set the correct stimulus params
scell{2} = set(scell{2}, 'condition_num',2,...
    'phase1_verg_dist', FarMidDist,...
    'phase1_accom_dist', FarMidDist,...
    'phase2_verg_dist', MidNearDist,...
    'phase2_accom_dist', FarMidDist);

% % Copy to other staircases
scell{3} =  scell{1};
% Set the correct stimulus params
scell{3} = set(scell{3}, 'condition_num',3,...
    'phase1_verg_dist', FarDist,...
    'phase1_accom_dist', FarDist,...
    'phase2_verg_dist', FarMidDist,...
    'phase2_accom_dist', FarMidDist);

% % Copy to other staircases
scell{4} =  scell{1};
% Set the correct stimulus params
scell{4} = set(scell{4}, 'condition_num',4,...
    'phase1_verg_dist', FarMidDist,...
    'phase1_accom_dist', FarDist,...
    'phase2_verg_dist', MidNearDist,...
    'phase2_accom_dist', FarMidDist);

% % Copy to other staircases
scell{5} =  scell{1};
% Set the correct stimulus params
scell{5} = set(scell{5}, 'condition_num',5,...
    'phase2_duration',3.0);

% % Copy to other staircases
scell{6} =  scell{2};
% Set the correct stimulus params
scell{6} = set(scell{6}, 'condition_num',6,...
    'phase2_duration',3.0);

% % Copy to other staircases
scell{7} =  scell{3};
% Set the correct stimulus params
scell{7} = set(scell{7}, 'condition_num',7,...
    'phase2_duration',3.0);

% % Copy to other staircases
scell{8} =  scell{4};
% Set the correct stimulus params
scell{8} = set(scell{8}, 'condition_num',8,...
    'phase2_duration',3.0);


% Set initial staircase


for i=1: length(scell);  %A nice feature would be to move this loop to within initialize staircase, and it would initialize them all with one command
scell{i}=initializeStaircase(scell{i});
end






%Prepare the data file
testfileoutdir = [pwd '/datafiles'];
mkdir(testfileoutdir);
textfilenameout = [pwd '/datafiles/resultfile_' observer_initials '_' exp_num '_' datestr(clock, 30) '.txt'];



