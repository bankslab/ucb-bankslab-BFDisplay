% optimizer experiment template file
experiment_type = 'marina_occlusions';
trial_mode = 0;
dynamic_mode = 0;
static_mode = 1;
renderviews = [0, 1]; %0 is the left eye
projection_type = 1;

s = PTBStaircase;

% Reload old filenames and keep writing into same file
scell_filename = [pwd '/BF_data_files/optimizer/' observer_initials '_' exp_num '_record.mat'];
text_fileName = sprintf('data_marina_occlusions/%s.data', observer_initials);

% Create text file for data saving
mkdir('data_marina_occlusions');
text_fp = fopen(text_fileName, 'a');
fprintf(text_fp, '\n*** occlusion experiment ***\n');
fprintf(text_fp, 'Subject Name:\t%s\n', observer_initials);
fprintf(text_fp, '*** **************************** ***\n');
% TODO: CHANGE THESE NAMES FOR EACH EXPERIMENT - DONE
fprintf(text_fp, ' ss\t fix side\t fix depth\t algorithm\t text1 side\t front plane depth\t response\n');

% Check if a data file exists, and if so open it
if (exist(scell_filename, 'file') == 2)
    load(scell_filename);     

else
    % INITSCELL
    
    % Experiment parameters
    param.fix_duration     = 0.5; % seconds
    param.stim_duration    = 0.2; % seconds
    param.trials_per_block = 80;
    param.max_responses    =  6;  % per stimulus
    param.max_trials       = 800; % to make sure it doesn't go forever
    
    % Variables
    param.fix_side   = [0, 1]; % Left or Right
    param.fix_depth  = [0, 1]; % Near or Far
    param.algorithm  = [1, 2, 3, 4]; % Pinhole, Single, Blending, Optimization
    param.tex1_side  = [0, 1]; % Left or Right
    param.front_plane_depth = [2.6, 3.2]; % Diopters
    %param.MCS_stimuli      = ; %TODO: This should be one of the above parameters


    % count how many staircases we want

    scell{1} = set(s,...
        'MCS',1,...
        'initialized','no');

    %TODO: nothing below this line has been changed yet - DONE
    % These loops should go through each of the parameters above
    % For parameters that will be randomized, don't include a loop
    % Randomization happens in the BF_display_Start file (see old code)
    
    for fix_side_index = 1:length(param.fix_side)
        for fix_depth_index = 1:length(param.fix_depth)
            for algorithm_index = 1:length(param.algorithm)
                for fix_side_index = 1:length(param.tex1_side)
                    for tex1_side_index = 1:length(param.questions)
                        for front_plane_depth_index = 1:length(param.front_plane_depth)
                            scell{fix_side_index, fix_depth_index, algorithm_index, tex1_side_index, tex1_side_index} = set(scell{1},...
                                'fix_side', param.fix_side(fix_side_index),...
                                'fix_depth', param.fix_depth(fix_depth_index),...
                                'algorithm', param.algorithm(algorithm_index, :),...
                                'tex1_side', param.tex1_side(tex1_side_index, :),...
                                'front_plane_depth', param.front_plane_depth(front_plane_depth_index, :),...
                                 'fix_duration', param.fix_duration,...
                                'stim_duration', param.stim_duration,...
                                'trials_per_block', param.trials_per_block,...
                                'max_trials', param.max_trials,...
                                'MCS_stimuli', param.MCS_stimuli,...
                                'MCS_num_responses', zeros(1,length(param.MCS_stimuli)),...
                                'MCS_num_stimuli', length(param.MCS_stimuli),...
                                'MCS_max_responses', param.max_responses);
                            
                            scell{fix_side_index, fix_depth_index, algorithm_index, tex1_side_index, tex1_side_index}=...
                                initializeStaircase(scell{fix_side_index, fix_depth_index, algorithm_index, tex1_side_index, tex1_side_index});
                        end
                    end
                end
            end
        end
    end

    % SCELL ORDER
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
