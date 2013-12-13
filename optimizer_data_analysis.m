%load data file(s)
%load RAA_Test_Optimization_exp_hing_20131018T172845.mat
allthedata = [scellThisRound, scellNextRound];
%allthedata = scellCompleted;
for i = 1:length(allthedata)
    hinge_direction = get(allthedata{i}, 'values');
    responses = get(allthedata{i}, 'responses');
    angles = get(allthedata{i}, 'angles');
    unique_values = unique(hinge_direction);
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
    data_label = strjoin({upper(algorithm), ',', num2str(disparity_distance), 'D dist', num2str(accom_distance), 'D focus'}, ' ');
    %disp(data_label)
    %disp(data_structure)
    switch algorithm
        case 'pinhole'
            column = 1;
        case 'single'
            column = 2;
        case 'blending'
            column = 3;
        case 'optimization'
            column = 4;
    end
    
    switch num2str(accom_distance)
        case '2'
            row = 0;
        case '3.2'
            row = 4;
    end
    
    num_rows = 2;
    num_columns = length(allthedata)/num_rows;
    subplot(num_rows, num_columns, column+row),  scatter(data_structure(:,1), data_structure(:, 4), 'filled')
    title(data_label);
    xlabel('Angles');
    ylabel('% Responses Greater than 90 degrees');
    
end