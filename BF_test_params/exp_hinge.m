% optimizer experiment template file
experiment_type = 'marina_occlusions';
trial_mode = 0;
dynamic_mode = 0;
static_mode = 1;
renderviews = [0 1]; %0 is the left eye
projection_type = 1;

s = PTBStaircase;
dumpworkspace=1;


%% INITSCELL
% Experiment parameters
param.stim_duration = 0.2; % seconds

% MCS marina_occlusions values
param.algorithm     = {'optimization'};
%param.front_plane   = 4; % Plane number (1 to 4)
%param.back_plane    = 3;
param.MCS_stimuli   = [0, 1]; % left or right side in front
param.max_responses = 10;

% count how many staircases we want

scell{1} = set(s,...
    'MCS',1,...
    'initialized','no');

for alg_index = 1:length(param.algorithm)
    scell{alg_index} = set(scell{1},...
        'algorithm',param.algorithm{alg_index},...
        'MCS_stimuli', param.MCS_stimuli,...
        'MCS_num_responses',zeros(1,length(param.MCS_stimuli)),...
        'MCS_num_stimuli',length(param.MCS_stimuli),...
        'MCS_max_responses', param.max_responses);
    scell{alg_index}=... 
        initializeStaircase(scell{alg_index});
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
