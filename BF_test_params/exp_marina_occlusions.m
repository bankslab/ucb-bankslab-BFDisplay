% optimizer experiment template file
experiment_type = 'marina_occlusions';
trial_mode = 0;
dynamic_mode = 0;
static_mode = 1;
renderviews = [0, 1]; %0 is the left eye
projection_type = 1;
keyCode_mat = [1 2 3 4; 82 80 81 79];  % for fixation

% Create text file for data saving
folderName = 'data_marina_occlusions';
mkdir(folderName);
fileName = sprintf([folderName '/%s.data'], observer_initials);
text_fp = fopen(fileName, 'a');
fprintf(text_fp, '\n*** occlusion experiment ***\n');
fprintf(text_fp, 'Subject Name:\t%s\n', observer_initials);
fprintf(text_fp, '*** **************************** ***\n');
fprintf(text_fp, 'block num\t trial num\t stim dur\t occl side\t near tex\t far tex\t algorithm\t fix plane\t near plane\t far plane\t  response\n');

% Check if an experiment file exists, and if so open it
% This file contains relevant variables to continue the experiment
expFileName = [fileName(1:end-4) 'mat'];
if (exist(expFileName, 'file') == 2)
     load(expFileName);
else
    % Create new experiment matrix
    
    % Set parameters
    param.occl_side     = [0, 1];     % 0:Left,  1:Right    
    param.aperture_size = [4, 5, 6, 7];
    param.fix_duration  = 2;        % seconds
    
    % FIRST EXPERIMENT  
    param.max_responses = 5;          % per stimulus
    param.stim_duration = [0.3, 3];   % seconds
    % Algorithm: 1:Pinhole, 2:Single, 3:Blending, 4:Optimization
    param.MCS_stimuli   = [2, 4];     % algorithm
    % Depth of stimuli in diopters
    % 1st Column: fixation plane
    % 2nd Column: near plane (occluder)
    % 3rd Column: far plane (occluded)
    % Single-plane vs Optimization
    param.fix_near_far = [20, 32, 20;...
                          32, 32, 20];
    % end of parameters for FIRST EXPERIMENT  
                      
                      
%     % SECOND experiment
%     param.max_responses = 5;          % per stimulus
%     param.stim_duration = [1.5];   % seconds
%     % Algorithm: 1:Pinhole, 2:Single, 3:Blending, 4:Optimization
%     param.MCS_stimuli   = [2];     % algorithm
%     % Depth of stimuli in diopters
%     % 1st Column: fixation plane
%     % 2nd Column: near plane (occluder)
%     % 3rd Column: far plane (occluded)
%     % Single-plane vs Optimization
%     param.fix_near_far = [15, 27, 15;...
%                           15, 15, 3;...
%                           20, 32, 20;...
%                           20, 20, 8;...
%                           27, 39, 27;...
%                           27, 27, 15;...
%                           32, 44, 32;...
%                           32, 32, 20];
%     % end of parameters for SECOND experiment
    
    
    param.conditions = 1:size(param.fix_near_far, 1); % possible combinations (rows)

    % Combine all parameters into a giant matrix
    % Order is the same as header text above
    trialList = allcomb(param.occl_side, param.aperture_size, repmat(param.MCS_stimuli, param.max_responses, 1), param.conditions);
    trialList = [trialList(:,1:3) param.fix_near_far(trialList(:, 4), :)];
        
    % Repeat and shuffle for each stim duration
    trialOrder = [];
    for st = param.stim_duration
        trialOrder = [trialOrder; repmat(st, size(trialList, 1), 1), trialList(randperm(size(trialList, 1)), :)];
    end
    
    % Randomly shuffle the blocks
    % Scalar in num_blocks is the number of blocks per stim duration
    param.num_blocks = 2 * length(param.stim_duration);
    param.trials_per_block = size(trialOrder, 1) / param.num_blocks;
    
    block_order_col = repmat(randperm(param.num_blocks), param.trials_per_block, 1);
    block_order_col = reshape(block_order_col, numel(block_order_col), 1);
    trialOrder = [block_order_col, trialOrder];
    
    % Shuffle and sort by stim duration
    trialOrder = trialOrder(randperm(size(trialOrder, 1)), :);
    [Y, I] = sort(trialOrder(:, 1));
    trialOrder = trialOrder(I, 2:end);
    
    param.max_trials = size(trialOrder, 1);
end
