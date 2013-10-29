%load data file(s)
%load RAA_Test_Optimization_exp_hing_20131018T172845.mat
%allthedata = [scellThisRound, scellNextRound];
allthedata = scellCompleted;
for i = 1:length(allthedata)
    algorithm = get(allthedata{i}, 'algorithm');
    hinge_distance = get(allthedata{i},'hinge_distance');
    focus_distance = get(allthedata{i},'focus_distance');
    trial_values = get(allthedata{i},'values');
    responses = get(allthedata{i},'responses');
    unique_values = unique(get(allthedata{i},'values'));
    max_trials = length(responses);
    %max_trials = min(length(trial_values), length(responses));
    %max_trials = 28;
    
    data_index = 1;
    data_structure = [unique_values', nan(length(unique_values), 3)];
    for stim_value = unique_values
        num_correct = 0;
        out_of = 0;
        stim_index = find(trial_values == stim_value);
        for j = stim_index
            if j <= max_trials
                out_of = out_of + 1;
%                if trial_values(j) <= 90 && responses(j) == 1 ...
%                    || trial_values(j) > 90 && responses(j) == 2
                if responses(j) == 2
                    num_correct = num_correct + 1;
                end
            end
        end
        
        percent_correct = round(100*num_correct/out_of);

        data_structure(data_index, 2) = num_correct;
        data_structure(data_index, 3) = out_of;
        data_structure(data_index, 4) = percent_correct;
        
        data_index = data_index + 1;
    end
    data_label = strjoin({upper(algorithm), ',', num2str(hinge_distance), 'D dist', num2str(focus_distance), 'D focus'}, ' ');
    %disp(data_label)
    %disp(data_structure)
    subplot(2, length(allthedata)/2, i),  scatter(data_structure(:,1), data_structure(:, 4), 'filled')
    title(data_label);
    xlabel('Angles');
    ylabel('% Responses Greater than 90 degrees');
    
end