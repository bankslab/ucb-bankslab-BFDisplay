%This file is the prototype for the staircase method of measuring blur- and disparity-based detection thresholds


experiment_type='disparity_blur';       % Experiment for measuring visual fatigue, staircase method

trial_mode=1;                           % Enter the presentation and respond flavor of the program
show_verg_ref_dist=0;

dynamic_mode=0;                         % 1 for time varying stimulus, 0 for a static stimulus
static_mode=1;                          % 1 to present a static scene, this will be precomputed in load time
diopter_offset = 1/FarMidDist - 2.5;    % Used to move the stimuli into the display's native frusta
                
renderviews= [0 1];           % 0 is the left eye, 1 is the right eye
                
s = PTBStaircase;           % Instantiate a staircase
dumpworkspace=1;            % Dump all variables to mat file for future reference.  
trials_per_block=12;        % check: what does it stand for?

% Set up the staircases' values.  Start with one staircase.  This
% will later be duplicated and the appropriate values will be
% changed for each staircase

scell{1} = set(s,...
    'condition_num',1,... %check
    'initialValue',-0.025,...
    'initialValue_random_range', 0.005,...
    'stepSize',-0.005,...
    'minValue',-0.03,...
    'maxValue',0.0,....
    'maxReversals',10,...
    'maximumtrials', 40,...
    'stimDistance',0.37,... 
    'stepLimit',.00125,...
    'numUp',1,...
    'numDown',2,...
    'phase1_duration',0.500,...     % Fixation duration
    'phase2_duration',0.150,...     % Stimulus duration
    'eccentricity',0,...            % Specified in arcmin
    'pedestal',0.40,...             % Defined relative to viewer (m)
    'blur_disparity_stim',1,...     % 0 = thin lines, 1 = 1/f disk
    'phase1_focusmult',0,...        % 0 = no accommodation 
    'monocular',0);                 % 1 = monocular (left eye) condition
    


% Copy to other staircases
scell{2} = scell{1};
scell{2} = set(scell{2},'pedestal',0.37);
scell{2} = set(scell{2},'initialValue', 0.01);
scell{2} = set(scell{2},'initialValue_random_range', 0.0005);
scell{2} = set(scell{2},'stepLimit',.00015625);
scell{2} = set(scell{2},'stepSize',0.005);
scell{2} = set(scell{2},'maxValue',0.03);
scell{2} = set(scell{2},'minValue',0);

% scell{3} = scell{2};
% scell{3} = set(scell{3},'pedestal',0.355);
% scell{3} = set(scell{3},'initialValue', 0.01);
% scell{3} = set(scell{3},'initialValue_random_range', 0.005);
% scell{3} = set(scell{3},'stepLimit',.0003125);
% scell{3} = set(scell{3},'stepSize',0.01);

scell{3} = scell{2};
scell{3} = set(scell{3},'pedestal',0.310);
scell{3} = set(scell{3},'initialValue', 0.02);
scell{3} = set(scell{3},'initialValue_random_range', 0.005);
scell{3} = set(scell{3},'stepLimit',.0003125);
scell{3} = set(scell{3},'stepSize',0.01);

scell{4} = scell{3};
scell{4} = set(scell{4},'pedestal',0.280);
scell{4} = set(scell{4},'initialValue', 0.03);
scell{4} = set(scell{4},'initialValue_random_range', 0.01);
scell{4} = set(scell{4},'stepLimit',.000625);

% scell{4} = scell{3};
% scell{4} = set(scell{4},'pedestal',0.34);
% scell{4} = set(scell{4},'initialValue', 0.015);
% scell{4} = set(scell{4},'initialValue_random_range', 0.005);
% scell{4} = set(scell{4},'stepLimit',.000625);
% 
% scell{5} = scell{4};
% scell{5} = set(scell{5},'pedestal',0.325);
% scell{5} = set(scell{5},'initialValue', 0.02);
% scell{5} = set(scell{5},'initialValue_random_range', 0.005);
% 
% scell{6} = scell{4};
% scell{6} = set(scell{6},'pedestal',0.310);
% scell{6} = set(scell{6},'initialValue', 0.02);
% scell{6} = set(scell{6},'initialValue_random_range', 0.005);
% 
% scell{7} = scell{4};
% scell{7} = set(scell{7},'pedestal',0.295);
% scell{7} = set(scell{7},'initialValue', 0.02);
% scell{7} = set(scell{7},'initialValue_random_range', 0.01);
% 
% scell{8} = scell{4};
% scell{8} = set(scell{8},'pedestal',0.280);
% scell{8} = set(scell{8},'initialValue', 0.03);
% scell{8} = set(scell{8},'initialValue_random_range', 0.01);
% 
% % Nonius lines
% scell{9} = set(s,...
%     'condition_num',1,... 
%     'initialValue', 0.37,...                   % In arc-minutes
%     'initialValue_random_range', 0.02,...
%     'stepSize',-0.01,...
%     'minValue',0.27,...
%     'maxValue',0.40,...
%     'maxReversals',10,...
%     'maximumtrials', 33,...
%     'stimDistance',0.37,... %check
%     'stepLimit',.0005,...
%     'numUp',1,...
%     'numDown',1,...
%     'phase1_duration',0.50,...      % Fixation duration
%     'phase2_duration',0.150,...     % Stimulus duration
%     'eccentricity',0,...            % Specified in arcmin
%     'pedestal',0.37,...             % Defined relative to viewer (m)
%     'blur_disparity_stim',3,...     % 0 = disparity only, 1 = blur only, 2 = both, 3 = nonius lines
%     'phase1_focusmult',0);          % 0 = no accommodation

% Set all the staircases to restrict the range of test stimuli
for i=3: length(scell);
    maxVal = get(scell{i},'stimDistance') - get(scell{i},'pedestal');
    scell{i}= set(scell{i},'maxValue',maxVal);
end 


% Initialize the staircases
for i=1: length(scell);
    scell{i}=initializeStaircase(scell{i});
end


%Prepare the data file
testfileoutdir = [pwd '/datafiles'];
mkdir(testfileoutdir);
textfilenameout = [pwd '/datafiles/resultfile_' observer_initials '_' exp_num '_' datestr(clock, 30) '.txt'];

