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
fprintf(text_fp, ' trial_counter\t algorithm\t fix depth\t occl_side\t occl_depth\t occl_tex\t response\n');

% Check if a data file exists, and if so open it
if (exist(scell_filename, 'file') == 2)
    load(scell_filename);
    
else
    % INITSCELL
    
    % Experiment parameters
    param.fix_duration     = 0.5; % seconds
    param.stim_duration    = 2; % seconds
    param.trials_per_block = 80;
    param.max_responses    =  6;  % per stimulus
    param.max_trials       = 800; % to make sure it doesn't go forever
    
    % Variables
    param.algorithm   = [2, 4]; % Pinhole, Single, Blending, Optimization
    param.occl_tex    = [0, 1];       % Left or Right - tex1 is voronoi
    
    param.fix_depth   = 20;       % Near or Far 
    
    param.occl_side   = [0, 1];       % Left or Right
    param.MCS_stimuli = [26, 32];     % Diopters - occluder depth
    
    % count how many staircases we want
    
    scell{1} = set(s, 'MCS',1, 'initialized', 'no');

    %TODO: nothing below this line has been changed yet - DONE
    % These loops should go through each of the parameters above
    % For parameters that will be randomized, don't include a loop
    % Randomization happens in the BF_display_Start file (see old code)

    
    for algorithm_index = 1:length(param.algorithm)
        for occl_tex_index = 1:length(param.occl_tex)
            for fix_depth_index = 1:length(param.fix_depth)
                for occl_side_index = 1:length(param.occl_side)
                    scell{algorithm_index, occl_tex_index, fix_depth_index, occl_side_index} = set(scell{1},...
                        'algorithm', param.algorithm(algorithm_index),...
                        'occl_tex', param.occl_tex(occl_tex_index),...
                        'fix_depth', param.fix_depth(fix_depth_index),...
                        'occl_side', param.occl_side(occl_side_index),...
                        'MCS_stimuli', param.MCS_stimuli,...
                        'MCS_num_responses', zeros(1,length(param.MCS_stimuli)),...
                        'MCS_num_stimuli', length(param.MCS_stimuli),...
                        'MCS_max_responses', param.max_responses);

                        scell{algorithm_index, occl_tex_index, fix_depth_index, occl_side_index}=...
                            initializeStaircase(scell{algorithm_index, occl_tex_index, fix_depth_index, occl_side_index});
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
