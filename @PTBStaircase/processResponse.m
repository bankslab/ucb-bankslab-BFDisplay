% Part of PTBStaircase class
% Robin Held
% Banks Lab
% UC Berkeley

% This function takes in the latest response and updates the number of
% reversals, step size, etc.
% Here, 0 means the response should be skipped, 1 means 'less,' (or
% in the case of slant nulling, that the stimulus appeared to have
% negative slant), and 2 means 'more'

function [ms] = processResponse(ms,response)

if ms.MCS == 1
    % Method of constant stimuli
    % Add response to response vector.
    ms.responses = [ms.responses(:)' response];
    % Increment number of resposnes for this stimulus
    it = find(ms.MCS_stimuli == ms.currentValue);
    ms.MCS_num_responses(it) = ms.MCS_num_responses(it) + 1;
    
    display(['For  pedestal ' num2str(ms.pedestal) ' : ' num2str(sum(ms.MCS_num_responses)) ' trials completed out of ' num2str(ms.MCS_max_responses * ms.MCS_num_stimuli)]);
    
    if length(ms.responses) == 1
        % This is the first response, so make sure it is recorded
        ms.values(1) = ms.currentValue;
    end
    
    if(sum(ms.MCS_num_responses) >= ms.MCS_max_responses * ms.MCS_num_stimuli)
        ms.complete = 1;
        display([num2str(ms.pedestal) 'm pedestal completed']);
    end
    
    % Determine the next stimulus value...if the pedestal is not
    % complete
    if ~ms.complete
        % Randomly choose a stimulus that has not been shown the
        % maximum number of times
        newValue = inf;
        while(newValue == inf)
            it = ceil(ms.MCS_num_stimuli*rand);
            if (ms.MCS_num_responses(it) < ms.MCS_max_responses)
                newValue = ms.MCS_stimuli(it);
            end
        end
        
        % Add the new value to the array of values
        ms.values = [ms.values newValue];
        ms.currentValue = newValue;
    end
end
