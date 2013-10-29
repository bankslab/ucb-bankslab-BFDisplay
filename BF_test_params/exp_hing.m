% optimizer experiment template file
experiment_type = 'hing';
trial_mode = 1;
dynamic_mode = 0;
static_mode = 1;
renderviews = [0 1]; %0 is the left eye
projection_type = 1;

s = PTBStaircase;
dumpworkspace=1;


%% INITSCELL
% Experiment parameters
param.stim_duration = 1;

% MCS hinge values
param.algorithm = {'optimization', 'blending', 'single', 'sharp'};
%param.algorithm = {'optimization', 'sharp'};
param.hinge_dist = 2;%[2 : 1.2 : 3.2];
param.focus_dist = 2;%[2 : 1.2 : 3.2];
param.MCS_stimuli = [78 : 3 : 102]; %[60 : 3 : 120]; %angle values
param.angle_noise = [0 0];%[-5 0 5];
param.max_responses = 10;

% count how many staircases we want

scell{1} = set(s,...
    'MCS',1,...
    'initialized','no');

for alg_index = 1:length(param.algorithm)
    for hinge_dist_index = 1:length(param.hinge_dist)
        %for focus_index = 1:length(param.focus_dist)
            scell{alg_index, hinge_dist_index} = set(scell{1},... %scell{alg_index, hinge_dist_index, focus_index} = set(scell{1},...
                'algorithm',param.algorithm{alg_index},...
                'hinge_distance',param.hinge_dist(hinge_dist_index),...
                'focus_distance', param.hinge_dist(hinge_dist_index),... %'focus_distance', param.focus_dist(focus_index),...
                'MCS_stimuli', param.MCS_stimuli,... %will need to be more specific for 2nd test
                'angle_noise', param.angle_noise(randi(2)),...
                'MCS_num_responses',zeros(1,length(param.MCS_stimuli)),...
                'MCS_num_stimuli',length(param.MCS_stimuli),...
                'MCS_max_responses', param.max_responses);
            scell{alg_index, hinge_dist_index}=... %scell{alg_index, hinge_dist_index, focus_index}=...
                initializeStaircase(scell{alg_index, hinge_dist_index});
                %initializeStaircase(scell{alg_index, hinge_dist_index, focus_index});
        %end
    end
end

%% SCELL ORDER
scellSize=size(scell);
scellLength=prod(scellSize(:));
scellArray=reshape(scell,scellLength,1);
scellCompleted=[];
scellThisRound=[];
scellNextRound=[];

for scellID=randperm(scellLength)

    if get(scellArray{scellID},'complete')==1
        scellCompleted{end+1}=scellArray{scellID};
    elseif strcmp(get(scellArray{scellID},'initialized'),'yes')
        scellThisRound{end+1}=scellArray{scellID};
    end
end

s_i = ceil(rand(1) * length(scellThisRound));
