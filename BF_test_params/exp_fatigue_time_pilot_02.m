%This file is the prototype for the staircase method of measuring visual
%fatigue. 'Time to fuse' experiment is adopted due to similarity. Here four
%cases of staircase are measured, cues-consistent & cues-inconsistent # of
%staircases could be increased in later version according to the
%experimental configuration.

% Accommodative stimulus stays at imageplanedist(3), which is MidNearDist.

% Variables to be used...
current_condition=1;
trial_index=1;
answer_flag=0;
current_corrfreq=1;

experiment_type='fatigue_time_pilot_02'; % Experiment for measuring visual fatigue, staircase method
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
howmanyconditions=4; %number of conditions
howmanycorrfreq=3; %number of corrugation frequencies
break_duration=1200; %Time duration for break between assessments. 1 sec because it's pilot test.
stimulus_duration=1.7; %Time duration for one stimulus. This is equal to the phase2_duration of scell.

lowcorrfreq=1;
highcorrfreq=2;
interval=(log(highcorrfreq)-log(lowcorrfreq))/(howmanycorrfreq-1);
corrfreq_array=exp(log(lowcorrfreq):interval:log(highcorrfreq)); %corrugation frequency spaced logarithmically equally.
trialspercorrfreq=117; %number of trials per one corrugation frequency
howmanytrials=howmanycorrfreq * trialspercorrfreq;

versionmagnitude=0; % in degrees
tempindex=zeros(howmanyconditions,howmanytrials);
one_at_odd=abs(sin((1:howmanytrials)*pi/2));
one_at_even=abs(cos((1:howmanytrials)*pi/2));
horizontal_version_angle=one_at_odd.*(versionmagnitude*(2*round(rand(1,howmanytrials))-1));
vertical_version_angle=one_at_even.*(versionmagnitude*(2*round(rand(1,howmanytrials))-1));
horizontal_version_dist=imageplanedist(3)*tand(horizontal_version_angle);
vertical_version_dist=imageplanedist(3)*tand(vertical_version_angle);
lowconflictp2t=1.2;
highconflictp2t=2.4;
vergence_dist=zeros(howmanyconditions,howmanytrials);
temp_index=1:howmanytrials;
relative_vergence1=lowconflictp2t*(cos(temp_index*pi)/2+0.5); % 0.5 Hz
% relative_vergence2=lowconflictp2t*(cos(temp_index*pi/5)/2+0.5); % 0.1 Hz, sinusoidal waveform
triangular_normalized=[0 0.2 0.4 0.6 0.8 1 0.8 0.6 0.4 0.2];
relative_vergence2=lowconflictp2t*triangular_normalized(1+mod(temp_index,10)); % 0.1 Hz, triangular waveform
relative_vergence3=highconflictp2t*round(cos(temp_index*pi/2)/2+0.3); % 0.25 Hz, whose one cycle is: 1 0 0 0
relative_vergence4=(1/imageplanedist(4)-1/imageplanedist(2))*round(cos(temp_index*pi/2)/2+0.3); % 0.25 Hz, whose one cycle is: 1 0 0 0
vergence_dist(1,:)=1./(1/imageplanedist(2)+relative_vergence1);
vergence_dist(2,:)=1./(1/imageplanedist(2)+relative_vergence2);
vergence_dist(3,:)=1./(1/imageplanedist(2)+relative_vergence3);
vergence_dist(4,:)=1./(1/imageplanedist(2)+relative_vergence4);
accommodation_dist=ones(howmanyconditions,howmanytrials)*imageplanedist(2);
accommodation_dist(4,:)=accommodation_dist(4,:)+(imageplanedist(4)-imageplanedist(2))*round(cos(temp_index*pi/2)/2+0.3);

condition_order=zeros(1,howmanyconditions);
recordfilename = [pwd '/BF_data_files/Temporal_VA_conflict/' observer_initials '_' exp_num '_record.txt'];
finished_conditions=0;
if (exist(recordfilename)~=2) % if the record file does not exist
	file_record=fopen(recordfilename,'a');
	condition_order=randperm(howmanyconditions);
	for ii=1:howmanyconditions
		fprintf(file_record, '%d\n', condition_order(ii));
	end
	fprintf(file_record, '%d', finished_conditions);
else % if the record file exists
	temp=textread(recordfilename,'%d');
	condition_order=temp(1:howmanyconditions);
	finished_conditions=temp(howmanyconditions+1);
end

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

