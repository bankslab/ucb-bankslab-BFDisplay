%this is a default file, there are no psychophysical methods, just some
%quick demos

experiment_type='alignmode';   %This will show vernier lines distributed across depth
%stim_type='demomode';

trial_mode=0;   %Enter the presentation, and respond flavor of the program

dynamic_mode=0;   %1 for time varying stimulus, 0 for a static stimulus
static_mode=1;    %1 to present a static scene, this will be precomputed in load time

                IPD=0;  % the alignment calculations are based on eye at center
                whichEye=0;
                alignmag=0;
                align_param=0;
                alignplane=3;
                renderviews= [0 1];  %0 is the left eye, 1 is the right eye
                align_adjust=.02;



dumpworkspace=1;  %dump all variables to mat file for future reference.  


%depthplane+renderviews*4

% Set up the staircases' values.  Start with one staircase.  This
% will later be duplicated and the appropriate values will be
% changed for each staircase





%Prepare the data file
testfileoutdir = [pwd '/datafiles'];
mkdir(testfileoutdir);
textfilenameout = [pwd '/datafiles/resultfile_' observer_initials '_' exp_num '_' datestr(clock, 30) '.txt'];



