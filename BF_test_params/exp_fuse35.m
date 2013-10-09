%this file is the prototype for the time to fuse task


experiment_type='timetofuse';
stim_type='fuse_stim';   %This will show vernier lines distributed across depth
%experiment_type='demomode';

trial_mode=1;   %Enter the presentation, and respond flavor of the program
show_verg_ref_dist=0;

dynamic_mode=0;   %1 for time varying stimulus, 0 for a static stimulus
static_mode=1;    %1 to present a static scene, this will be precomputed in load time

                
                renderviews= [0 1];  %0 is the left eye, 1 is the right eye

                
s = PTBStaircase;           % Instantiate a staircase

dumpworkspace=1;  %dump all variables to mat file for future reference.  

trials_per_block=12;

% Set up the staircases' values.  Start with one staircase.  This
% will later be duplicated and the appropriate values will be
% changed for each staircase



scell{1} = set(s,...
    'condition_num',0,...
    'initialValue', 1,...
    'initialValue_random_range', 0,...
    'stepSize',.5,...
    'minValue',.05,...
    'maxValue',5,....
    'maxReversals',20,...
    'maximumtrials', 60,...
    'stimDistance',350,...
    'stepLimit',.05,...
    'numUp',1,...
    'numDown',2,...
    'phase1_duration', 2.0,...
    'phase1_duration_rpt', .3,...
    'phase1_verg_dist', MidpointMidMidDist,...
    'phase1_accom_dist', MidpointMidMidDist,...
    'phase2_verg_dist',MidpointMidMidDist,...
    'phase2_accom_dist', MidpointMidMidDist,...
    'phase1_stim', 'fixation_cross',...
    'phase2_stim', 'fuse_stim',...
    'rds_grating_angularsize', 4.2,...      %Specify angular size in degrees diameter
    'rds_grating_numdots', 830,...
    'rds_grating_orientation', 15,...
    'rds_grating_cpd', 1.8,...
    'rds_grating_disparity', 4);    %specified in arcmin
    



% % Copy to other staircases
scell{2} =  scell{1};
% Set the correct stimulus params
scell{2} = set(scell{2}, 'condition_num',18,...
    'phase2_verg_dist', MidpointMidMidDist,...
    'phase2_accom_dist', MidNearDist);



scell{3} =  scell{1};
% Set the correct stimulus params
scell{3} = set(scell{3}, 'condition_num',23,...
    'phase2_verg_dist', MidpointMidMidDist,...
    'phase2_accom_dist', FarMidDist);


% Set initial staircase


for i=1: length(scell);  %A nice feature would be to move this loop to within initialize staircase, and it would initialize them all with one command
scell{i}=initializeStaircase(scell{i});
end






%Prepare the data file
testfileoutdir = [pwd '/datafiles'];
mkdir(testfileoutdir);
textfilenameout = [pwd '/datafiles/resultfile_' observer_initials '_' exp_num '_' datestr(clock, 30) '.txt'];



