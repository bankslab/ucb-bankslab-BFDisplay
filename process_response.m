% This code manually writes a line to a text file after each trial
% It also saves a .mat file containing important variables, to allow the
% experiment to be closed and restarted where it left off
% The code also pauses after each block

% Write response to file
% CHANGE THESE VARIABLES FOR EACH EXPERIMENT
if trial_mode==1 & ~escPressed
    trialCounter = trialCounter + 1;
    blockCounter = blockCounter + 1;
    while(trialCounter < length(trialOrder) && ~isempty(find(cancelledConditions == trialOrder(trialCounter))))
        trialCounter = trialCounter + 1;
        blockCounter = blockCounter + 1;
    end 
    save(expFileName, 'trialList', 'trialOrder', 'trialCounter','cancelledConditions', 'blockLength');
end

if (trialCounter == length(trialOrder)) | blockCounter > blockLength | escPressed
    stop_flag = 1;
end