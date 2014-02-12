% optimizer experiment template file
experiment_type = 'comparison';
trial_mode = 1;
dynamic_mode = 0;
static_mode = 1;
renderviews = [0, 1]; %0 is the left eye
projection_type = 1;

s = PTBStaircase;

% Reload old filenames and keep writing into same file
scell_filename = [pwd '/BF_data_files/optimizer/' observer_initials '_' exp_num '_record.mat'];
text_fileName = sprintf('data_comparison/%s.data', observer_initials);

% Create text file for data saving
mkdir('data_comparison');
text_fp = fopen(text_fileName, 'a');
fprintf(text_fp, '\n*** comparison experiment ***\n');
fprintf(text_fp, 'Subject Name:\t%s\n', observer_initials);
fprintf(text_fp, '*** **************************** ***\n');
% CHANGE THESE NAMES FOR EACH EXPERIMENT
fprintf(text_fp, ' ss\t scene\t question\t alg_left\t alg_right\t response\n');
    
if (exist(scell_filename, 'file') == 2)
% Check if a data file exists, and if so open it
    load(scell_filename);     
else
    %% INITSCELL
    % Reference Parameters
    param.disparity_dist   = 1.7;
    param.accom_dist       = 1.7;
    param.alg_names        = {'optimization', 'blending', 'single', 'pinhole'};
    param.question_names   = {'Stronger impression of depth?',
                              'Realistic occlusion boundaries?',
                              'Objects appear further apart?',
                              'More saturated in color?'};
    
    % Experiment parameters
    param.stim_duration    = 0.2;     % seconds
    param.question_duration=  2;     % seconds
    param.trials_per_block = 72;
    param.max_responses    =  1;     % per stimulus
    param.max_trials       = 1000;
    
    % Variables
    param.algorithms       = 1:4;
    param.combinations     = nchoosek(param.algorithms, 2);
    param.questions        = 1:4; 
    param.num_scenes       = 1;
    param.MCS_stimuli      = 1:param.num_scenes;


    % count how many staircases we want

    scell{1} = set(s,...
        'MCS',1,...
        'initialized','no');

    
    for combo_index = 1:length(param.combinations)
        for question_index = 1:length(param.questions)
            scell{combo_index, question_index} = set(scell{1},...
                'combination', param.combinations(combo_index, :),...
                'question', param.questions(question_index),...
                'MCS_stimuli', param.MCS_stimuli,...
                'MCS_num_responses', zeros(1,length(param.MCS_stimuli)),...
                'MCS_num_stimuli', length(param.MCS_stimuli),...
                'MCS_max_responses', param.max_responses);
            scell{combo_index, question_index}=... 
                initializeStaircase(scell{combo_index, question_index});
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
end

s_i = ceil(rand(1) * length(scellThisRound));
