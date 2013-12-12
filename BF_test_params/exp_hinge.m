% optimizer experiment template file
experiment_type = 'hinge';
trial_mode      = 0;
dynamic_mode    = 0;
static_mode     = 1;
renderviews     = [0 1]; %0 is the left eye
projection_type = 1;
dumpworkspace   = 1;

record_filename = [pwd '/BF_data_files/optimizer/' observer_initials '_' exp_num '_record.mat'];

if (exist(record_filename, 'file') == 2)
% Check if a data file exists, and if so open it
    load(record_filename);

else
% Otherwise, create a new experiment
    % Experiment Parameters
    p.trialsPerBlock = 50;
    p.block_counter  = 0;
    p.stim_duration  = 8; %sec
    p.algorithm      = {'optimization', 'blending', 'single', 'pinhole'};
    p.disparity_dist = 2.6;   %[2, 2.3, 2.6, 2.9, 3.2];
    p.accom_dist     = 2.6; %[2, 2.3, 2.6, 2.9, 3.2];
    p.angle_noise    = [0, 180, 360, 540]; %[-5, 0, 5];
    
    % Staircase Parameters
    p.linStep        = 20; %2;
    p.updown         = {[1 1] [1 1]};
    p.minmax         = [70 130];
    p.startVals      = [130 70];
                       %[p.minmax(2) - p.linStep,...
                       % p.minmax(1) + p.linStep];
    p.nTrials        = 25;
    p.nReversals     = [];
    
    % Check that staircase values are valid
    assert(p.startVals(1) >= p.minmax(1) & p.startVals(2) <= p.minmax(2), 'Starting values are not within valid range');
    assert(p.startVals(1) >= p.startVals(2), 'First start value must be greater than second start value');
    
    % Build staircases
    % Two different staircases per scell
    for s_index = [1 2]
        p.this_updown = p.updown{s_index};
        s = staircase('create', p.this_updown, p.minmax, p.nTrials, p.nReversals, p.linStep);
        s.stimVal = p.startVals(s_index);
        s.step = [p.linStep, p.linStep];
        s.angle_noise_vals = [];
        s.indexVal = 0;
        
        % Do not run non-volumetric cases for in-between planes
        % Do not run cues inconsistent for in-between planes
        for disparity_dist_index = 1:length(p.disparity_dist)
            for accom_dist_index = 1:length(p.accom_dist)
                for alg_index = 1:length(p.algorithm)
                    s.algorithm      = p.algorithm{alg_index};
                    s.disparity_dist = p.disparity_dist(disparity_dist_index);
                    s.accom_dist     = p.accom_dist(accom_dist_index);
                    if (s.disparity_dist == 2.3 || s.disparity_dist == 2.9 || ...
                        s.accom_dist     == 2.3 || s.accom_dist     == 2.9) && ...
                      ((s.disparity_dist ~= s.accom_dist) || ...
                       (strcmp(s.algorithm, 'single') || strcmp(s.algorithm, 'pinhole')))
                        s.complete = 1;
                    else
                        s.complete = 0;
                    end
                    initSCell{alg_index, disparity_dist_index, accom_dist_index}{s_index} = s;
                end
            end
        end
    end
    
    % Resize and shuffle scells
    scellSize       = size(initSCell);
    scellLength     = prod(scellSize(:));
    scellArray      = reshape(initSCell, scellLength,1);
    scell = [];
    
    for scellID = randperm(scellLength)
        scell{end + 1} = scellArray{scellID};
    end
end
