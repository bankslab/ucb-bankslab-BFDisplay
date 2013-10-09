% pilot ver.06
% Three days.
% Each day has two conditions: control, conflict
% Day 1: conflict: A stays still, V changes on every trial. control: VA change together on every trial.
% Day 2: conflict: A stays still, V changes on every n^2 trials. control: VA change together on every n^2 trials.
% Day 3: conflict: A stays still, V changes on every n^3 trials. control: VA change together on every n^3 trials.
% We hypothesize that Day 1 will show the biggest difference in terms of
% fatigue, Day 2 will show smaller difference, and Day 3 will show the
% smallest difference.

% Variables to be used...
current_condition=1;
trial_index=1;
answer_flag=0;
current_corrfreq=1;

experiment_type='fatigue_time_pilot_06'; % Experiment for measuring visual fatigue, staircase method
stim_type='fuse_stim';   %fuse_stim will show a sinusoidal depth random dot stereogram
%experiment_type='demomode';

trial_mode=1;   %Enter the presentation, and respond flavor of the program
show_verg_ref_dist=0;  %This is only useful for debugging.  It will print out the distances to screen

dynamic_mode=0;   %1 for time varying stimulus, 0 for a static stimulus
static_mode=1;    %1 to present a static scene, this will be precomputed in load time

                
                renderviews= [0 1];  %0 is the left eye, 1 is the right eye

                
s = PTBStaircase;           % Instantiate a staircase

dumpworkspace=1;  %dump all variables to mat file for future reference.  

% Variables only used in fatigue assessment experiment.
howmanydays=3; %number of experiment days
howmanyconditions=howmanydays*2;
howmanycorrfreq=3; %number of corrugation frequencies
break_duration=300; %Time duration for break between assessments. 1 sec because it's pilot test.
condition_duration=20*60;
stimulus_duration=1.5; %Time duration for one stimulus. This is equal to the phase2_duration of scell.

lowcorrfreq=1;
highcorrfreq=2;
interval=(log(highcorrfreq)-log(lowcorrfreq))/(howmanycorrfreq-1);
corrfreq_array=exp(log(lowcorrfreq):interval:log(highcorrfreq)); %corrugation frequency spaced logarithmically equally.
trialspercorrfreq=floor(condition_duration/(howmanycorrfreq*stimulus_duration)); %number of trials per one corrugation frequency
howmanytrials=howmanycorrfreq * trialspercorrfreq;

condition_order=zeros(1,howmanyconditions);
recordfilename = [pwd '/BF_data_files/Temporal_VA_conflict/condition_record/' observer_initials '_' exp_num '_record.txt'];
finished_conditions=0;
if (exist(recordfilename)~=2) % if the record file does not exist
	file_record=fopen(recordfilename,'a');
	day_order=randperm(howmanydays);
	for ii=1:howmanydays
		day_condition_order=randperm(2);
		condition_order(2*(ii-1)+1)=2*(day_order(ii)-1)+day_condition_order(1);
		fprintf(file_record, '%d\n', 2*(day_order(ii)-1)+day_condition_order(1));
		condition_order(2*(ii-1)+2)=2*(day_order(ii)-1)+day_condition_order(2);
		fprintf(file_record, '%d\n', 2*(day_order(ii)-1)+day_condition_order(2));
	end
	fprintf(file_record, '%d', finished_conditions);
else % if the record file exists
	temp=textread(recordfilename,'%d');
	condition_order=temp(1:howmanyconditions);
	finished_conditions=temp(howmanyconditions+1);
end

conflict_length=[1 1 4 4 16 16]; % index by conditions, unit is # of trials.

scell{1} = set(s,... % Just to use setting variables. Vergence, Version are determined outside of scell.
    'condition_num',1,... %Condition_num is only used for numbering the conditions in data output.  
    'initialValue', 0,...% Specify the number of repetition of current scell. (Note that it is not a staircase)
    'initialValue_random_range', 0,...
    'stepSize',0,...% not using staircase method. Should be 0 in fatigue assessment exp!
    'minValue',0,...% not using staircase method
    'maxValue',4,...% 
    'maxReversals',1000,...% not using staircase method
    'maximumtrials', 1000,...% not using staircase method
    'stepLimit',1,...
    'numUp',1,...
    'numDown',2,...
    'phase1_duration', 2.0,...
    'phase1_duration_rpt', .3,...
    'phase1_verg_dist', FarMidDist,...
    'phase1_accom_dist', FarMidDist,...
    'phase2_duration', stimulus_duration,... %To access stimulus_duration, get phase2_duration
    'phase2_verg_dist',NearDist,...
    'phase2_accom_dist', FarMidDist,...
    'phase1_stim', 'fixation_cross',...
    'phase2_stim', 'fuse_stim',...
    'rds_grating_angularsize', 4.2,...      %Specify angular size in degrees diameter
    'rds_grating_numdots', 600,...
    'rds_grating_orientation', 10,...
    'rds_grating_cpd', 2,...
    'rds_grating_disparity', 4);    %specified in arcmin

%Prepare the data file
testfileoutdir = [pwd '/datafiles'];
mkdir(testfileoutdir);
textfilenameout = [pwd '/datafiles/resultfile_' observer_initials '_' exp_num '_' datestr(clock, 30) '.txt'];

