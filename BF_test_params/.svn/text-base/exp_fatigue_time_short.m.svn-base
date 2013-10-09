%This file is the prototype for the staircase method of measuring visual
%fatigue. 'Time to fuse' experiment is adopted due to similarity. Here four
%cases of staircase are measured, cues-consistent & cues-inconsistent # of
%staircases could be increased in later version according to the
%experimental configuration.


experiment_type='fatigue_time'; % Experiment for measuring visual fatigue, staircase method
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
howmanyconditions=2; %number of conditions
howmanycorrfreq=3; %number of corrugation frequencies
howmanyconflictlevel=2;
trialspercorrfreq=36; %number of trials per one corrugation frequency
%howmanytrials=howmanycorrfreq * trialspercorrfreq;
conflict_det=[20 10]; % number of conflict stimuli.
lowcorrfreq=1;
highcorrfreq=2;
interval=(log(highcorrfreq)-log(lowcorrfreq))/(howmanycorrfreq-1);
corrfreq_array=exp(log(lowcorrfreq):interval:log(highcorrfreq)); %corrugation frequency spaced logarithmically equally.
break_duration=1; %Time duration for break between assessments
stimulus_duration=1.5; %Time duration for one stimulus. This is equal to the phase2_duration of scell.
oddity_question_duration=1; %Time duration for the questions between trials
fatigue_question_period=8; %fatigue question appears once per this number in "corrfreq for loop."
fatigue_question_duration=5;
degree_fatigue=-1;


VergenceDifferencePower=1;
SmallerConflictVergenceDist=1/(1/imageplanedist(3)+VergenceDifferencePower); % cross conflict of 0.6 D
LargerConflictVergenceDist=1/(1/imageplanedist(3)+2*VergenceDifferencePower); % cross conflict of 1.2 D

% Set up the staircases' values.  Start with one staircase.  This
% will later be duplicated and the appropriate values will be
% changed for each staircase

% low conflict (0D conflict)
scell{1} = set(s,...
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
    'phase1_verg_dist', MidNearDist,...
    'phase1_accom_dist', MidNearDist,...
    'phase2_duration', stimulus_duration,... %To access stimulus_duration, get phase2_duration
    'phase2_verg_dist',MidNearDist,...
    'phase2_accom_dist', MidNearDist,...
    'phase1_stim', 'fixation_cross',...
    'phase2_stim', 'fuse_stim',...
    'rds_grating_angularsize', 4.2,...      %Specify angular size in degrees diameter
    'rds_grating_numdots', 600,...
    'rds_grating_orientation', 10,...
    'rds_grating_cpd', 2,...
    'rds_grating_disparity', 4);    %specified in arcmin

% large conflict (0.6D conflict)
scell{2} = scell{1};
scell{2} = set(scell{1}, 'condition_num',2,...
    'phase1_verg_dist', MidNearDist,...
    'phase1_accom_dist', MidNearDist,...
    'phase2_verg_dist', SmallerConflictVergenceDist,...
    'phase2_accom_dist', MidNearDist);

% % Copy to other condition.
scell{1+1*howmanycorrfreq*howmanyconflictlevel} =  scell{1};
scell{1+1*howmanycorrfreq*howmanyconflictlevel} = set(scell{1+1*howmanycorrfreq*howmanyconflictlevel}, 'condition_num',1+1*howmanycorrfreq*howmanyconflictlevel);
scell{2+1*howmanycorrfreq*howmanyconflictlevel} =  scell{2};
scell{2+1*howmanycorrfreq*howmanyconflictlevel} = set(scell{2+1*howmanycorrfreq*howmanyconflictlevel}, 'condition_num',2+1*howmanycorrfreq*howmanyconflictlevel);

for kk=1:howmanyconditions
    for jj=1:howmanycorrfreq
		scell{1+(jj-1)*howmanyconflictlevel+(kk-1)*howmanycorrfreq*howmanyconflictlevel}=...
			scell{1+(kk-1)*howmanycorrfreq*howmanyconflictlevel};
		scell{2+(jj-1)*howmanyconflictlevel+(kk-1)*howmanycorrfreq*howmanyconflictlevel}=...
			scell{2+(kk-1)*howmanycorrfreq*howmanyconflictlevel};
		scell{1+(jj-1)*howmanyconflictlevel+(kk-1)*howmanycorrfreq*howmanyconflictlevel}=...
			set(scell{1+(jj-1)*howmanyconflictlevel+(kk-1)*howmanycorrfreq*howmanyconflictlevel},...
			'condition_num',1+(jj-1)*howmanyconflictlevel+(kk-1)*howmanycorrfreq*howmanyconflictlevel,...
			'rds_grating_cpd',corrfreq_array(jj));
		scell{2+(jj-1)*howmanyconflictlevel+(kk-1)*howmanycorrfreq*howmanyconflictlevel}=...
			set(scell{2+(jj-1)*howmanyconflictlevel+(kk-1)*howmanycorrfreq*howmanyconflictlevel},...
			'condition_num',2+(jj-1)*howmanyconflictlevel+(kk-1)*howmanycorrfreq*howmanyconflictlevel,...
			'rds_grating_cpd',corrfreq_array(jj));
    end
end

% Set initial staircase


for i=1: length(scell);  %A nice feature would be to move this loop to within initialize staircase, and it would initialize them all with one command
scell{i}=initializeStaircase(scell{i});
end

% Below is to check conditions.
% check_condition_num=zeros(1,length(scell));
% check_phase1_verg_dist=zeros(1,length(scell));
% check_phase1_accom_dist=zeros(1,length(scell));
% check_phase2_verg_dist=zeros(1,length(scell));
% check_phase2_accom_dist=zeros(1,length(scell));
% check_rds_grating_cpd=zeros(1,length(scell));
% for ii=1:howmanyconditions*howmanycorrfreq
%     check_condition_num(ii)=get(scell{ii},'condition_num');
%     check_phase1_verg_dist(ii)=get(scell{ii},'phase1_verg_dist');
%     check_phase1_accom_dist(ii)=get(scell{ii},'phase1_accom_dist');
%     check_phase2_verg_dist(ii)=get(scell{ii},'phase2_verg_dist');
%     check_phase2_accom_dist(ii)=get(scell{ii},'phase2_accom_dist');
%     check_rds_grating_cpd(ii)=get(scell{ii},'rds_grating_cpd');
% end

%Prepare the data file
testfileoutdir = [pwd '/datafiles'];
mkdir(testfileoutdir);
textfilenameout = [pwd '/datafiles/resultfile_' observer_initials '_' exp_num '_' datestr(clock, 30) '.txt'];

