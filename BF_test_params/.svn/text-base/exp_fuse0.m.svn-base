%this file is the prototype for the time to fuse task


experiment_type='timetofuse';
stim_type='fuse_stim';   %This will show vernier lines distributed across depth
%experiment_type='demomode';

trial_mode=1;   %Enter the presentation, and respond flavor of the program
show_verg_ref_dist=1;

dynamic_mode=0;   %1 for time varying stimulus, 0 for a static stimulus
static_mode=1;    %1 to present a static scene, this will be precomputed in load time
vergdist= MidNearDist;

                depthoffset=0;   %this will specify how much to offset the focus cue distance
                                 %it is in units of meters, + is further, -
                                 %is closer
                focus_cue_multiplier=1;  
                                 %Keep this at 1 for optimized speed.
                                 %Otherwise the focus_cue_multiplier will
                                 %multiply a depth interval by this
                                 %value.  It will recenter the focus cues 
                                 %about vergdist+depthoffset 
                
                renderviews= [0 1];  %0 is the left eye, 1 is the right eye

                
s = PTBStaircase;           % Instantiate a staircase

dumpworkspace=1;  %dump all variables to mat file for future reference.  

depthplane=2;
%depthplane+renderviews*4

% Set up the staircases' values.  Start with one staircase.  This
% will later be duplicated and the appropriate values will be
% changed for each staircase



scell{1} = set(s,...
    'condition_num',1,...
    'initialValue', 2,...
    'initialValue_random_range', 0,...
    'stepSize',.4,...
    'minValue',0,...
    'maxValue',3,....
    'maxReversals',10,...
    'maximumtrials', 33,...
    'stimDistance',350,...
    'lastDirection',0,...
    'complete',0,...
    'stepLimit',.1,...
    'numUp',1,...
    'numDown',2,...
    'phase1_duration', .6,...
    'phase1_duration_rpt', .3,...
    'phase1_verg_dist', FarMidDist,...
    'phase1_accom_dist', FarMidDist,...
    'phase2_verg_dist',FarMidDist,...
    'phase2_accom_dist', FarMidDist,...
    'phase1_stim', 'fixation_cross',...
    'phase2_stim', 'fuse_stim',...
    'rds_grating_angularsize', 2,...      %Specify angular size in degrees diameter
    'rds_grating_numdots', 350,...
    'rds_grating_orientation', 15,...
    'rds_grating_cpd', 1,...
    'rds_grating_disparity', 20);    %specified in arcmin
    

% % % Copy to other staircases
% scell{2} =  scell{1};
% % Set the correct stimulus distances
% scell{2} = set(scell{2}, 'align_parameter',2);
% % 


% Set initial staircase


for i=1: length(scell);  %A nice feature would be to move this loop to within initialize staircase, and it would initialize them all with one command
scell{i}=initializeStaircase(scell{i});
end






%Prepare the data file
testfileoutdir = [pwd '/datafiles'];
mkdir(testfileoutdir);
textfilenameout = [pwd '/datafiles/resultfile_' observer_initials '_' exp_num '_' datestr(clock, 30) '.txt'];



