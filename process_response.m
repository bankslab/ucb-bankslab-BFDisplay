% This code manually saves the data in two ways
% First it manually writes a line to a text file after each trial
% Second it also saves the scell variables after each block

trial_counter = trial_counter + 1;

% after each block, take a break
if mod(trial_counter, param.trials_per_block) == 0
    block_counter = block_counter + 1;
    disp([num2str(block_counter) ' block(s) completed'])
    message = 'endofblock';
    BF_disp_message
    save(scell_filename,'scell','param','scellCompleted','scellThisRound','scellNextRound', 'trial_counter', 'block_counter');
end

% Write response to file
% CHANGE THESE VARIABLES FOR EACH EXPERIMENT
fprintf(text_fp, '%d\t%d\t%d\t%d\t%d\t%d\n', ...
    trial_counter, trial_params{2}, trial_params{3}, trial_params{1}(1), trial_params{1}(2), show_image);
if trial_counter == param.max_trials
    stop_flag = 1;
end

% Prepare for next trial
scellThisRound{s_i} = processResponseStaircase(scellThisRound{s_i}, show_image);

% If not MCS, then use staircasing code here
if isempty(get(scellThisRound{s_i},'MCS'))
    reversalsAfterResponse=get(scellThisRound{s_i},'currentReversals'); % remember # reversals
    if get(scellThisRound{s_i},'complete')==1
        clear temp;
        temp=[];
        for ii=1:length(scellThisRound)
            if ii==s_i
                scellCompleted{end+1}=scellThisRound{ii};
            else
                temp{end+1}=scellThisRound{ii};
            end
        end
        clear scellThisRound;
        scellThisRound=temp;
    elseif reversalsAfterResponse>reversalsBeforeResponse
        clear temp;
        temp=[];
        for ii=1:length(scellThisRound)
            if ii==s_i
                scellNextRound{end+1}=scellThisRound{ii};
            else
                temp{end+1}=scellThisRound{ii};
            end
        end
        clear scellThisRound;
        scellThisRound=temp;
    else % do nothing
    end
    % If MCS, use MCS code here
elseif get(scellThisRound{s_i},'MCS')==1 % MCS
    if get(scellThisRound{s_i},'complete')==1
        clear temp;
        temp=[];
        for ii=1:length(scellThisRound)
            if ii==s_i
                scellCompleted{end+1}=scellThisRound{ii};
            else
                temp{end+1}=scellThisRound{ii};
            end
        end
        clear scellThisRound;
        scellThisRound=temp;
    else % move scell to next round anyway
        clear temp;
        temp=[];
        for ii=1:length(scellThisRound)
            if ii==s_i
                scellNextRound{end+1}=scellThisRound{ii};
            else
                temp{end+1}=scellThisRound{ii};
            end
        end
        clear scellThisRound;
        scellThisRound=temp;
    end
end

% End the experiment here
if isempty(scellThisRound)
    if isempty(scellNextRound)
        stop_flag=1; % end of the experiment
    else
        scellThisRound=scellNextRound;
        scellNextRound=[];
    end
end

% Start the next trial here (with a random scell)
s_i=ceil(rand(1)*length(scellThisRound));
