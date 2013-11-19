% optimizer experiment template file
experiment_type = 'hinge';
trial_mode = 0;
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
param.algorithm = {'optimization', 'blending', 'single', 'pinhole'};
%param.algorithm = {'pinhole'};
param.disparity_dist = [2.6];%[2 : 1.2 : 3.2];
param.accom_dist = [2 3.2];%[2 : 1.2 : 3.2];
param.MCS_stimuli = [42 : 6 : 108]; %[60 : 3 : 120]; %angle values
param.angle_noise = [-5 0];
param.max_responses = 4;

% count how many staircases we want

scell{1} = set(s,...
    'MCS',1,...
    'initialized','no');

for alg_index = 1:length(param.algorithm)
    for disparity_dist_index = 1:length(param.disparity_dist)
        for accom_dist_index = 1:length(param.accom_dist)
            scell{alg_index, disparity_dist_index, accom_dist_index} = set(scell{1},...
                'algorithm',param.algorithm{alg_index},...
                'disparity_distance',param.disparity_dist(disparity_dist_index),...
                'accom_distance', param.accom_dist(accom_dist_index),...
                'MCS_stimuli', param.MCS_stimuli,... %will need to be more specific for 2nd test
                'angle_noise', param.angle_noise(randi(2)),...
                'MCS_num_responses',zeros(1,length(param.MCS_stimuli)),...
                'MCS_num_stimuli',length(param.MCS_stimuli),...
                'MCS_max_responses', param.max_responses);
            scell{alg_index, disparity_dist_index, accom_dist_index}=...
                initializeStaircase(scell{alg_index, disparity_dist_index, accom_dist_index});
        end
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
