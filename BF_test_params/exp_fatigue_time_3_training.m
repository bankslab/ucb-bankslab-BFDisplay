% Fatigue time study
% Three days.
% Each day has two session: control, conflict
% Always two sessions are run in following order: control - conflict
% No break between the two.
% The order of the days is randomized.
% Day 1: conflict: A stays still, V changes on every trial. control: VA change together on every trial.
% Day 2: conflict: A stays still, V changes on every 4 trials. control: VA change together on every 4 trials.
% Day 3: conflict: A stays still, V changes on every 4^2 trials. control: VA change together on every 4^2 trials.
% We hypothesize that Day 1 will show the biggest difference in terms of
% fatigue, Day 2 will show smaller difference, and Day 3 will show the
% smallest difference.

% Variables to be used...
current_condition=1;
current_session=1;
answer_flag=0;
current_corrfreq=1;
trial_index=0;
subject_initials=observer_initials(1:3); % extract subject initials - three letters

experiment_type='fatigue_time_3'; % Experiment for measuring visual fatigue, staircase method
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
howmanyconditions=6; %number of experiment days
howmanycorrfreq=3; %number of corrugation frequencies
stimulus_duration=2; %Time duration for one stimulus. This is equal to the phase2_duration of scell.
session_duration=2*25*2*6; % real experiment
break_duration=5; % real experiment

lowcorrfreq=1;
highcorrfreq=2;
interval=(log(highcorrfreq)-log(lowcorrfreq))/(howmanycorrfreq-1);
corrfreq_array=exp(log(lowcorrfreq):interval:log(highcorrfreq)); %corrugation frequency spaced logarithmically equally.
trialspercorrfreq=floor(session_duration/(howmanycorrfreq*stimulus_duration)); %number of trials per one corrugation frequency
howmanytrials=howmanycorrfreq * trialspercorrfreq;

t_freq_permutations=[1 2 3;1 3 2;2 1 3;2 3 1;3 1 2;3 2 1]; % permutations of temporal frequencies
conditionrecordfilename = [pwd '/BF_data_files/Temporal_VA_conflict/condition_record/fatigue_time_3_condition_record.txt'];
condition_order=zeros(1,howmanyconditions);
finished_conditions=0;
if (exist(conditionrecordfilename,'file')~=2) % if the record file does not exist, make one.
	file_record=fopen(conditionrecordfilename,'a');
	fprintf(file_record,'%s\t',subject_initials);
	for ii=1:length(squeeze(t_freq_permutations(1,:)))
		conflict_order=randperm(2);
		fprintf(file_record, '%d\t',2*(t_freq_permutations(1,ii)-1)+conflict_order(1));
		condition_order(2*(ii-1)+1)=2*(t_freq_permutations(1,ii)-1)+conflict_order(1);
		fprintf(file_record, '%d\t',2*(t_freq_permutations(1,ii)-1)+conflict_order(2));
		condition_order(2*(ii-1)+2)=2*(t_freq_permutations(1,ii)-1)+conflict_order(2);
	end
	fprintf(file_record, '%d\n', finished_conditions);
% 	fclose(file_record);
end

% open record file
[t_initials,t_c1,t_c2,t_c3,t_c4,t_c5,t_c6,t_finished]=textread(conditionrecordfilename,'%s%d%d%d%d%d%d%d');
for ii=1:length(t_initials) % go one-by-one on t_initials and check with subject_initials
	if strcmp(t_initials{ii},subject_initials)
		condition_order(1)=t_c1(ii);
		condition_order(2)=t_c2(ii);
		condition_order(3)=t_c3(ii);
		condition_order(4)=t_c4(ii);
		condition_order(5)=t_c5(ii);
		condition_order(6)=t_c6(ii);
		finished_conditions=t_finished(ii);
		break;
	elseif (ii==length(t_c1)) % given observer is not listed on the file yet. make ordering and record it.
		file_record=fopen(conditionrecordfilename,'a');
		t_freq_perm_index=mod(length(t_c1)+1,6);
		if t_freq_perm_index==0
			t_freq_perm_index=6;
		end
		fprintf(file_record,'%s\t',subject_initials);
		for jj=1:length(squeeze(t_freq_permutations(1,:)))
			conflict_order=randperm(2);
			fprintf(file_record, '%d\t',2*(t_freq_permutations(t_freq_perm_index,jj)-1)+conflict_order(1));
			condition_order(2*(jj-1)+1)=2*(t_freq_permutations(t_freq_perm_index,jj)-1)+conflict_order(1);
			fprintf(file_record, '%d\t',2*(t_freq_permutations(t_freq_perm_index,jj)-1)+conflict_order(2));
			condition_order(2*(jj-1)+2)=2*(t_freq_permutations(t_freq_perm_index,jj)-1)+conflict_order(2);
		end
		fprintf(file_record, '%d\n', finished_conditions);
		t_initials{ii+1}=subject_initials;
		t_c1(ii+1)=condition_order(1);
		t_c2(ii+1)=condition_order(2);
		t_c3(ii+1)=condition_order(3);
		t_c4(ii+1)=condition_order(4);
		t_c5(ii+1)=condition_order(5);
		t_c6(ii+1)=condition_order(6);
		t_finished(ii+1)=finished_conditions;
	end
end

conflict_length=[0 0 0]; % index by conditions, unit is # of trials.

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

% initialize experiment data recording structure..
% record_data.subject=subject_initials;
% record_data.condition_order=condition_order;

