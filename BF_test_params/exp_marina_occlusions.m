% optimizer experiment template file
experiment_type = 'marina_occlusions';
trial_mode = 1;
dynamic_mode = 0;
static_mode = 1;
renderviews = [0 1]; %0 is the left eye
projection_type = 1;

s = PTBStaircase;
dumpworkspace=1;


%% INITSCELL
% Experiment parameters
param.fix_duration  = 2; % seconds
param.stim_duration = 0.2; % seconds

% MCS marina_occlusions values
param.algorithm     = {'optimization'};
param.front_plane   = [26, 32]; % Plane number (Diopters)
param.tex_side      = {'trial2', 'trial3'};
param.MCS_stimuli   = [0, 1]; % left or right side in front
param.max_responses = 10;
param.max_trials    = 80;

% count how many staircases we want

scell{1} = set(s,...
    'MCS',1,...
    'initialized','no');

for alg_index = 1:length(param.algorithm)
    for plane_index = 1:length(param.front_plane)
        planes = [param.front_plane(plane_index), 20];
        for fix_plane_index = 1:length(planes)
            scell{alg_index, plane_index, fix_plane_index} = set(scell{1},...
                'fix_plane', planes(fix_plane_index),...
                'fix_side', [],... % Set randomly per trial in BF_display_start
                'algorithm', param.algorithm(alg_index),...
                'front_plane', param.front_plane(plane_index),...
                'tex_side', [],... % Set randomly per trial in BF_display_start
                'MCS_stimuli', param.MCS_stimuli,...
                'MCS_num_responses', zeros(1,length(param.MCS_stimuli)),...
                'MCS_num_stimuli', length(param.MCS_stimuli),...
                'MCS_max_responses', param.max_responses);
            scell{alg_index, plane_index, fix_plane_index}=... 
                initializeStaircase(scell{alg_index, plane_index, fix_plane_index});
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
