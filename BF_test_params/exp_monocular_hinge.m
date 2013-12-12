% optimizer experiment template file
experiment_type = 'monocular_hinge';
trial_mode = 1;
dynamic_mode = 0;
static_mode = 1;
renderviews = [0, 1]; %0 is the left eye
projection_type = 1;

s = PTBStaircase;
dumpworkspace=1;


%% INITSCELL
% Experiment parameters
param.stim_duration = 3; % seconds

% MCS monocular_hinge values
param.algorithm      = {'optimization', 'single', 'pinhole', 'blending'};
param.disparity_dist = 2.6;
param.accom_dist     = 2.6;
param.angle          = [70, 90, 110, 130]; 
param.MCS_stimuli    = [0, 180, 360, 540]; % direction of hinge
param.max_responses  = 10;
param.max_trials     = 321;

% count how many staircases we want

scell{1} = set(s,...
    'MCS',1,...
    'initialized','no');

for alg_index = 1:length(param.algorithm)
    for angle_index = 1:length(param.angle)
        scell{alg_index, angle_index, direction_index} = set(scell{1},...
            'algorithm', param.algorithm(alg_index),...
            'angle', param.angle(angle_index),...
            'disparity_dist', param.disparity_dist,...
            'accom_dist', param.accom_dist,...
            'MCS_stimuli', param.MCS_stimuli,...
            'MCS_num_responses', zeros(1,length(param.MCS_stimuli)),...
            'MCS_num_stimuli', length(param.MCS_stimuli),...
            'MCS_max_responses', param.max_responses);
        scell{alg_index, angle_index}=... 
            initializeStaircase(scell{alg_index, angle_index});
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
