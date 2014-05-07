% optimizer experiment template file
experiment_type = 'monocular_hinge';
trial_mode      = 1;
dynamic_mode    = 0;
static_mode     = 1;
renderviews     = [0, 1]; %0 is left eye
projection_type = 1;
keyCode_mat = [ 1  2  3  4;...
               82 80 81 79];  % for fixation

% Create text file for data saving
folderName = 'data_monocular_hinge';
mkdir(folderName);
fileName = sprintf([folderName '/%s.data'], observer_initials);
text_fp = fopen(fileName, 'a');
fprintf(text_fp, '\n*** monocular_hinge experiment ***\n');
fprintf(text_fp, 'Subject Name:\t%s\n', observer_initials);
fprintf(text_fp, '*** **************************** ***\n');
fprintf(text_fp, 'block num\t trial num\t stim dur\t algorithm\t texture\t hinge angle\t tex_version\t hinge direction\t response\n');

% Check if an experiment file exists, and if so open it
% This file contains relevant variables to continue the experiment
expFileName = [fileName(1:end-4) 'mat'];
if (exist(expFileName, 'file') == 2)
     load(expFileName);
else
    % Create new experiment matrix
    % Set parameters
    param.vertex_dist   = 27;           % diopters
    param.fix_duration  = 2;            % seconds
    %param.stim_duration = [0.1];  % seconds
    param.stim_duration = [0.3, 3, 5];  % seconds
    % Algorithm: 1:Pinhole, 2:Single, 3:Blending, 4:Optimization
    param.algorithm     = [1, 2, 3, 4];
    % Texture: 1:noise, 2:noodles, 3:voronoi, 4:farfalle
    param.texture       = [1, 2, 3, 4];
    param.angle         = [70, 90];     % degrees
    param.tex_version   = [1, 2];       % two different random variations
    param.MCS_stimuli   = [0, 180];     % hinge direction
    param.max_responses = 2;            % per stimulus

    % Combine all parameters into a giant matrix
    % Order is the same as header text above
    trialList = allcomb(param.algorithm, param.texture, param.angle, param.tex_version, repmat(param.MCS_stimuli, param.max_responses, 1));
        
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