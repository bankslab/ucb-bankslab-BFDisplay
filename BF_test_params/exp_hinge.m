% optimizer experiment template file
experiment_type = 'hinge';
trial_mode      = 1;
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
    p.trialsPerBlock = 175;
    p.stim_duration  = 1; %sec
    %p.algorithm      = {'optimization', 'blending', 'single', 'pinhole'};
    p.algorithm      = {'optimization'};
    p.disparity_dist = 2;              % [2 : 1.2 : 3.2];
    p.accom_dist     = [2, 3.2];       % [2 : 1.2 : 3.2];
    p.angle_noise    = [0 0];          % [-5 0 5];
    
    % Staircase Parameters
    p.linStep        = 3;
    p.updown         = {[2 1] [1 2]};
    p.minmax         = [60 120];
    p.startVals      = [p.minmax(1) + p.linStep,...
                        p.minmax(2) - p.linStep];
    p.nTrials        = []; %set by nReversals
    p.nReversals     = 6;
    
    % Check that staircase values are valid
    assert(p.startVals(1) > p.minmax(1) & p.startVals(2) < p.minmax(2), 'Starting values are not within valid range');
    assert(p.startVals(1) > p.startVals(2), 'First start value must be greater than second start value');
    
    % Build staircases
    % Two different staircases per scell
    for s_index = [1 2]
        p.this_updown = p.updown{s_index};
        s = staircase('create', p.this_updown, p.minmax, p.nTrials, p.nReversals, p.linStep);
        s.stimVal = p.startVals(s_index);
        s.step = [p.linStem p.linStep];
        s.angle_noise_vals = [];
        s.indexVal = 0;
        s.complete = 0;
        
        for alg_index = 1:length(p.algorithm)
            for disparity_dist_index = 1:length(p.disparity_dist)
                for accom_dist_index = 1:length(p.accom_dist)
                    s.algorithm      = p.algorithm{alg_index};
                    s.disparity_dist = p.disparity_dist(disparity_dist_index);
                    s.accom_dist     = p.accom_dist(accom_dist_index);
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
