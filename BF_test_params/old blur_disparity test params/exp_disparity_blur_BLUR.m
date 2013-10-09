%This file is the prototype for the staircase method of measuring blur- and disparity-based detection thresholds


experiment_type='disparity_blur';       % Experiment for measuring visual fatigue, staircase method

trial_mode=1;                           % Enter the presentation and respond flavor of the program
show_verg_ref_dist=0;

dynamic_mode=0;                         % 1 for time varying stimulus, 0 for a static stimulus
static_mode=1;                          % 1 to present a static scene, this will be precomputed in load time

                
renderviews= [0];           % 0 is the left eye, 1 is the right eye
                
s = PTBStaircase;           % Instantiate a staircase
dumpworkspace=1;            % Dump all variables to mat file for future reference.  
trials_per_block=12;        % check: what does it stand for?

% Set up the staircases' values.  Start with one staircase.  This
% will later be duplicated and the appropriate values will be
% changed for each staircase

scell{1} = set(s,...
    'condition_num',1,... %check
    'initialValue', 0.10,...
    'initialValue_random_range', 0,...
    'stepSize',.01,...
    'minValue',-300,...
    'maxValue',300,....
    'maxReversals',10,...
    'maximumtrials', 33,...
    'stimDistance',350,... %check
    'stepLimit',.05,...
    'numUp',1,...
    'numDown',2,...
    'phase1_duration',1.00,...      % Fixation duration
    'phase2_duration',1.00,...      % Stimulus duration
    'eccentricity',120,...          % Specified in arcmin
    'pedestal',0,...                % Specified in arcmin
    'blur_disparity_stim',1,...     % 0 = disparity only, 1 = blur only, 2 = both
    'phase1_focusmult',1.0);        % 0 = no accommodation        
    

% % Copy to other staircases
scell{2} =  scell{1};
scell{2} = set(scell{2},'eccentricity',-120); 
% % Set the correct stimulus params
% scell{2} = set(scell{2}, 'condition_num',2,...
%     'phase1_verg_dist', FarMidDist,...
%     'phase1_accom_dist', FarMidDist,...
%     'phase2_verg_dist', MidNearDist,...
%     'phase2_accom_dist', FarMidDist);
% 
% % % Copy to other staircases
% scell{3} =  scell{1};
% % Set the correct stimulus params
% scell{3} = set(scell{3}, 'condition_num',3,...
%     'phase1_verg_dist', FarDist,...
%     'phase1_accom_dist', FarDist,...
%     'phase2_verg_dist', FarMidDist,...
%     'phase2_accom_dist', FarMidDist);
% 
% % % Copy to other staircases
% scell{4} =  scell{1};
% % Set the correct stimulus params
% scell{4} = set(scell{4}, 'condition_num',4,...
%     'phase1_verg_dist', FarMidDist,...
%     'phase1_accom_dist', FarDist,...
%     'phase2_verg_dist', MidNearDist,...
%     'phase2_accom_dist', FarMidDist);


% Initialize the staircases
for i=1: length(scell);
    scell{i}=initializeStaircase(scell{i});
end


%Prepare the data file
testfileoutdir = [pwd '/datafiles'];
mkdir(testfileoutdir);
textfilenameout = [pwd '/datafiles/resultfile_' observer_initials '_' exp_num '_' datestr(clock, 30) '.txt'];

