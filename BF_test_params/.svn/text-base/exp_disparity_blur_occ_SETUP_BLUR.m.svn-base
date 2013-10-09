%This file is the prototype for the staircase method of measuring blur- and disparity-based detection thresholds


experiment_type='disparity_blur_occlusion';       % Experiment for measuring visual fatigue, staircase method

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
    'initialValue', 0.00,...
    'initialValue_random_range', 0.02,...
    'stepSize',.000,...
    'minValue',0.00,...
    'maxValue',0.125,....
    'maxReversals',10,...
    'maximumtrials', 40,...
    'stimDistance',0.275,... %check
    'stepLimit',.000625,...
    'numUp',1,...
    'numDown',2,...
    'phase1_duration',0.500,...     % Fixation duration
    'phase2_duration',10,...     % Stimulus duration
    'eccentricity',0,...            % Specified in arcmin
    'pedestal',0.295,...            % Defined relative to viewer (m)
    'blur_disparity_stim',1,...     % 0 = thin lines, 1 = 1/f disk
    'phase1_focusmult',1,...        % 0 = no accommodation 
    'monocular',0,...               % 1 = monocular (left eye) condition
    'training',0);
%     
% 
% % Copy to other staircases
% scell{2} = scell{1};
% scell{2} = set(scell{2},'pedestal',0.295);
% 
% scell{3} = scell{1};
% scell{3} = set(scell{3},'pedestal',0.315); 
% 
% 
% scell{4} = scell{1};
% scell{4} = set(scell{4},'pedestal',0.335); 
% scell{4} = set(scell{4},'initialValue', -0.05);
% scell{4} = set(scell{4},'initialValue_random_range', 0.005);
% scell{4} = set(scell{4},'stepSize', -0.01);
% scell{4} = set(scell{4},'maxValue', 0);
% scell{4} = set(scell{4},'minValue', -0.06);
% 
% scell{5} = scell{4};
% scell{5} = set(scell{5},'pedestal',0.355); 
% scell{5} = set(scell{5},'initialValue', -0.07);
% scell{5} = set(scell{5},'minValue', -0.08);
% 
% 
% scell{6} = scell{4};
% scell{6} = set(scell{6},'pedestal',0.375); 
% scell{6} = set(scell{6},'initialValue', -0.09);
% scell{6} = set(scell{6},'minValue', -0.10);
% 
% 
% scell{7} = scell{4};
% scell{7} = set(scell{7},'pedestal',0.395); 
% scell{7} = set(scell{7},'initialValue', -0.11);
% scell{7} = set(scell{7},'minValue', -0.12);

% 
% % 
% % 
% % scell{2} = scell{1};
% % scell{2} = set(scell{2},'pedestal',0.375); 
% % scell{2} = set(scell{2},'initialValue', -0.020);
% % scell{3} = scell{2};
% % scell{3} = set(scell{3},'pedestal',0.36);
% % scell{4} = scell{2};
% % scell{4} = set(scell{4},'pedestal',0.345); 
% % scell{5} = scell{2};
% % scell{5} = set(scell{5},'pedestal',0.33); 
% % scell{6} = scell{2};
% % scell{6} = set(scell{6},'pedestal',0.315);
% % scell{7} = scell{2};
% % scell{7} = set(scell{7},'pedestal',0.30); 
% % scell{7} = set(scell{7},'initialValue', -0.015);
% % scell{7} = set(scell{7},'minValue',-0.12);
% 
% % Set all the staircases to restrict the range of test stimuli
% for i=1:3;
%     maxVal = 0.40 - get(scell{i},'pedestal');
%     scell{i}= set(scell{i},'maxValue',maxVal);    
% end 
% 
% for i=4:length(scell);
%     minVal = get(scell{i},'stimDistance') - get(scell{i},'pedestal');
%     scell{i}= set(scell{i},'minValue',minVal);
% end 
% 

% Initialize the staircases
for i=1: length(scell);
    scell{i}=initializeStaircase(scell{i});
end


%Prepare the data file
testfileoutdir = [pwd '/datafiles'];
mkdir(testfileoutdir);
textfilenameout = [pwd '/datafiles/resultfile_' observer_initials '_' exp_num '_' datestr(clock, 30) '.txt'];

