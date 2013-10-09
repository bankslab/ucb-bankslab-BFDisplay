%This file is the prototype for the staircase method of measuring blur- and disparity-based detection thresholds


experiment_type='disparity_blur';       % Experiment for measuring visual fatigue, staircase method

trial_mode=1;                           % Enter the presentation and respond flavor of the program
show_verg_ref_dist = 0;

dynamic_mode = 0;                         % 1 for time varying stimulus, 0 for a static stimulus
static_mode = 1;                          % 1 to present a static scene, this will be precomputed in load time
diopter_offset = 1/FarMidDist - 2.5;    % Used to move the stimuli into the display's native frusta
FarMidDist
                
renderviews = [0 1];           % 0 is the left eye, 1 is the right eye
                
s = PTBStaircase;           % Instantiate a staircase
dumpworkspace=1;            % Dump all variables to mat file for future reference.  
trials_per_block=12;        % check: what does it stand for?

% Set up the staircases' values.  Start with one staircase.  This
% will later be duplicated and the appropriate values will be
% changed for each staircase

scell{1} = set(s,...
    'condition_num',1,... %check
    'initialValue', -0.055,...
    'initialValue_random_range', 0.00,...
    'stepSize',.005,...
    'minValue',-0.12,...
    'maxValue',0.00,....
    'maxReversals',10,...
    'maximumtrials', 100,...
    'stimDistance',0.27,... %check
    'stepLimit',.000625,...
    'numUp',1,...
    'numDown',2,...
    'phase1_duration',1.000,...     % Fixation duration 0.750
    'phase2_duration',0.150,...     % Stimulus duration
    'eccentricity',0,...            % Specified in arcmin
    'pedestal',0.39,...             % Defined relative to viewer (m)
    'blur_disparity_stim',1,...     % 0 = disparity only, 1 = blur only, 2 = both
    'phase1_focusmult',1,...        % 0 = no accommodation        
    'straightrun',1);               % Go through each possible value given the current step size/direction and max/min values 
    

% Copy to other staircases
scell{2} = scell{1};
scell{2} = set(scell{2},'pedestal',0.375); 
scell{2} = set(scell{2},'initialValue', -0.045);
scell{3} = scell{2};
scell{3} = set(scell{3},'pedestal',0.36);
scell{4} = scell{2};
scell{4} = set(scell{4},'pedestal',0.345); 
scell{5} = scell{4};
scell{5} = set(scell{5},'pedestal',0.33); 
scell{6} = scell{2};
scell{6} = set(scell{6},'pedestal',0.315);
scell{7} = scell{2};
scell{7} = set(scell{7},'pedestal',0.30); 
scell{7} = set(scell{7},'initialValue', -0.03);
% scell{1} = set(scell{1},'pedestal',0.345); 
% scell{1} = set(scell{1},'initialValue', -0.05);
% scell{2} = scell{1};
% scell{3} = scell{1};
% scell{4} = scell{1};

% Set all the staircases to restrict the range of test stimuli
for i=1: length(scell);
    minVal = get(scell{i},'stimDistance') - get(scell{i},'pedestal');
    scell{i}= set(scell{i},'minValue',minVal);
end 


% Initialize the staircases
for i=1: length(scell);
    scell{i}=initializeStaircase(scell{i});
end


%Prepare the data file
testfileoutdir = [pwd '/datafiles'];
mkdir(testfileoutdir);
textfilenameout = [pwd '/datafiles/resultfile_' observer_initials '_' exp_num '_' datestr(clock, 30) '.txt'];

