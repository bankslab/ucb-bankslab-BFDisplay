stop_flag=0;
dumpworkspace=1;
subjectInitials=observer_initials(1:3);
experiment_type='focusVaryingStereo';
stim_type='openGLCube';
trial_mode=1;
dynamic_mode=1;
static_mode=0;
renderviews= [0 1];  %0 is the left eye, 1 is the right eye

pathFileName='FocusVaryingStereoDisplay/pathFiles/pathBF.txt';
[pathReadTime pathReadDistance]=textread(pathFileName,'%f%f');

stereoFrameRate=45;
experimentDuration=6*50; % time in seconds
trialDuration=1; % seconds
stimPresentationDuration=0.3; % seconds
pathGenerated=[];
stimRelativeDisparity=[]; % 0: no stim / +: left closer / -: right closer
firstFrameInTrial=[];
stimValueArray=[-2 -1 1 2]; % arcmin
stimDeterminedForCurrentTrial=0;
for tempFrameNum=1:(stereoFrameRate*experimentDuration)
    if tempFrameNum==1
        pathGenerated(tempFrameNum)=pathReadDistance(1);
        stimRelativeDisparity(tempFrameNum)=0;
    else
        tempTime=(tempFrameNum-1)/stereoFrameRate;
        tempTimeStamp(1)=pathReadTime(find(pathReadTime<=tempTime,1,'last'));
        tempTimeStamp(2)=pathReadTime(find(pathReadTime>tempTime,1));
        tempDistance(1)=pathReadDistance(find(pathReadTime<=tempTime,1,'last'));
        tempDistance(2)=pathReadDistance(find(pathReadTime>tempTime,1));
        pathGenerated(tempFrameNum)=tempDistance(1)+...
            (tempDistance(2)-tempDistance(1))*(tempTime-tempTimeStamp(1))/(tempTimeStamp(2)-tempTimeStamp(1));
        if (tempTime>trialDuration) ... % first trial appears after one trial duration
                && (mod(tempTime,trialDuration)<stimPresentationDuration)
            if stimDeterminedForCurrentTrial==0
                tempIndex=randi(length(stimValueArray));
                tempValue=stimValueArray(tempIndex);
                stimRelativeDisparity(tempFrameNum)=tempValue;
                firstFrameInTrial(end+1)=tempFrameNum;
                stimDeterminedForCurrentTrial=1;
            else
                stimRelativeDisparity(tempFrameNum)=tempValue;
            end
        else
            stimDeterminedForCurrentTrial=0;
            stimRelativeDisparity(tempFrameNum)=0;
        end
    end
end

frames_per_trial=90; % 2 sec
trials_per_block=stereoFrameRate*experimentDuration/frames_per_trial;
tempIndex=randi(2);
if tempIndex==1
    block{1}.condition='cues-consistent';
    block{2}.condition='cues-inconsistent';
else
    block{1}.condition='cues-inconsistent';
    block{2}.condition='cues-consistent';
end
block{1}.vergdist=[];
block{1}.relativeDisparity=[];
block{1}.response=[];
block{1}.performance=[];
block{2}.vergdist=[];
block{2}.relativeDisparity=[];
block{2}.response=[];
block{2}.performance=[];
stereoFrameNum=0;

% The current design doesn't use PTBStaircase sells.
% Below is a dummy staircase sell
s=PTBStaircase;
scell{1}=set(s,...
    'condition_num',1,...
    'initialValue',0,...
    'initialValue_random_range',0,...
    'stepSize',0,...
    'minValue',0,...
    'maxValue',4,...
    'maxReversals',1000,...
    'maximumtrials',1000,...
    'stepLimit',1,...
    'numUp',1,...
    'numDown',2);

scell{1}=initializeStaircase(scell{1});