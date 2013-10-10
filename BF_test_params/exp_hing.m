% optimizer experiment template file
experiment_type = 'hing';
trial_mode = 0;
dynamic_mode = 0;
static_mode = 1;
renderviews = [0 1]; %0 is the left eye
projection_type = 1;
 
s = PTBStaircase;
dumpworkspace=1;
%{ 
% Variables for method of constant stimuli
s.MCS = true;             % Set to true for method of constant stimuli
s.MCS_num_stimuli = 5;    % Number of stimuli to be presented (# of x values)
if initial_run == true
    s.MCS_stimuli = [];   % Vector containin actual stimuli (value of x values)
else
    s.MCS_stimuli = [];
end
s.MCS_max_responses = [];  % Number of responses desired for each stimulus (# of trials per x value)
%}