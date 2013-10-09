% Part of PTBStaircase class.
%Staircase algorithim was started by Bjorn, modified by Robin and was
%heavily adapted by David
%
% Code heavily borrowed from quest2 examples provided by Bjorn Vlaskamp

% Class constructor function
function ms = mystaircase()

% Staircase class constructor
ms.condition_num = [];
ms.initialValue = [];
ms.initialValue_random_range = [];
ms.currentValue = [];
ms.stepSize = [];
ms.maxValue = [];
ms.minValue = [];
ms.stepLimit = [];
ms.maxReversals = [];
ms.maximumtrials = [];           % If there are this many trials, mark the staircase as complete
ms.currentReversals = [];
ms.lastDirection = [];
ms.stimDistance = [];
ms.altVariable = [];            % Some variable that is different for each staircase
ms.complete = [];               % Is this staircase complete (max # of reversals met)
ms.responses = [];              % Vector containing each response
ms.values = [];                 % Vector containing each stimulus value
ms.numUp = [];                  % numUp and numDown are used for staircases that are
ms.numDown = [];                % not 1-up/1-down.  

ms.reversalflag =[];            % trials flagged on which a reversal occured
ms.responserun = [];            % how many responses have been the same.
                                % ... this assumes that the response is
                                % ...right or wrong
ms.responserunflip = [];        % Used to deter,ome whether the step size should be halved

ms.straightrun = [];            % Should the staircase ignore the response and use the same step size/direction after each trial?

ms.training = [];               % Is this a training session?
                                
ms.phase1_duration =[];
ms.phase1_duration_rpt= [0];
ms.phase1_stim=[];
ms.phase1_verg_dist=[];
ms.phase1_accom_dist=[];
ms.phase1_focusmult=[];
ms.phase2_duration =[];
ms.phase2_stim=[];
ms.phase2_verg_dist=[];
ms.phase2_accom_dist=[];
ms.phase2_focusmult=[];
ms.phase3_duration=[];
ms.align_parameter=[];
ms.align_plane=[];
                                
ms.rds_grating_angularsize=[];
ms.rds_grating_numdots=[];
ms.rds_grating_orientation=[];
ms.rds_grating_cpd=[];
ms.rds_grating_disparity=[];
                                
% Blur and disparity variables
ms.eccentricity = [];
ms.pedestal = [];
ms.fixation_distance = [];
ms.blur_disparity_stim = [];
ms.stim_order = [];
ms.monocular = [];

% Variables for method of constant stimuli
ms.MCS = [];                    % Set to true for method of constant stimuli
ms.MCS_num_stimuli = [];        % Number of stimuli to be presented
ms.MCS_stimuli = [];            % Vector containin actual stimuli
ms.MCS_num_responses = [];      % Vector of the number of responses for each stimulus
ms.MCS_max_responses = [];      % Number of responses desired for each stimulus


ms = class(ms,'PTBStaircase');