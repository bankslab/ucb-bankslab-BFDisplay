%this is a default file, there are no psychophysical methods, just some
%quick demos

experiment_type='alignmode';   %This will show vernier lines distributed across depth
%stim_type='demomode';
cameraCalibration=1; % Setting this to 1 will make the stimuli stay on the monitor until the subject responds
% set the above (cameraCalibration) to 0 for human subjects

trial_mode=1;   %Enter the presentation, and respond flavor of the program

dynamic_mode=0;   %1 for time varying stimulus, 0 for a static stimulus
static_mode=1;    %1 to present a static scene, this will be precomputed in load time

                IPD=0;  % the alignment calculations are based on eye at center
                whichEye=0;
                alignmag=0;
                align_param=1;
                
                renderviews= [0];  %0 is the left eye, 1 is the right eye

                
s = PTBStaircase;           % Instantiate a staircase

dumpworkspace=1;  %dump all variables to mat file for future reference.  

depthplane=2;
%depthplane+renderviews*4

% Set up the staircases' values.  Start with one staircase.  This
% will later be duplicated and the appropriate values will be
% changed for each staircase



scell{1} = set(s,...
    'initialValue', degvertoffset(depthplane+renderviews*4),...
    'initialValue_random_range', .1,...
    'stepSize',.3,...
    'minValue',-80,...
    'maxValue',80,....
    'maxReversals',15,...
    'maximumtrials', 60,...
    'stimDistance',350,...
    'currentReversals',0,...
    'lastDirection',0,...
    'complete',0,...
    'stepLimit',.01,...
    'numUp',1,...
    'numDown',1,...
    'align_plane',4,...
    'align_parameter', 1,...   %1 for deg horiz offset, 2 for vertoffset, 3 for mag
    'phase1_duration', 1.0);

% % Copy to other staircases
scell{2} =  scell{1};
% Set the correct stimulus distances
scell{2} = set(scell{2}, 'initialValue',deghorizoffset(depthplane+renderviews*4));
scell{2} = set(scell{2}, 'align_parameter',2);
% 
% % Copy to other staircases
scell{3} =  scell{2};
% Set the correct stimulus distances
scell{3} = set(scell{3}, 'initialValue',horizFOVoffset(depthplane+renderviews*4));
scell{3} = set(scell{3}, 'stepSize', 2);
scell{3} = set(scell{3}, 'align_parameter',3);
% Set initial staircase


for i=1: length(scell);  %A nice feature would be to move this loop to within initialize staircase, and it would initialize them all with one command
scell{i}=initializeStaircase(scell{i});
end






%Prepare the data file
testfileoutdir = [pwd '/datafiles'];
mkdir(testfileoutdir);
textfilenameout = [pwd '/datafiles/resultfile_' observer_initials '_' exp_num '_' datestr(clock, 30) '.txt'];



