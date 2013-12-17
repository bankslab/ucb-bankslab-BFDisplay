%load data file(s)
%load RAA_Test_Optimization_exp_hing_20131018T172845.mat
allthedata = [scellThisRound, scellNextRound];
%allthedata = scellCompleted;
for i = 1:length(allthedata)
    algorithm = get(allthedata{i}, 'algorithm');
    disparity_dist = get(allthedata{i}, 'disparity_dist');
    accom_dist = get(allthedata{i}, 'accom_dist');
    hinge_direction = get(allthedata{i}, 'values');
    responses = get(allthedata{i}, 'responses');
    angle = get(allthedata{i}, 'angle');
    unique_values = unique(hinge_direction);
    max_trials = length(responses);
    
    data_index = 1;
    data_structure = [unique_values', nan(length(unique_values), 3)];
    for stim_value = unique_values
        num_correct = 0;
        out_of = 0;
        stim_index = find(hinge_direction == stim_value);
        for j = stim_index
            if j <= max_trials
                out_of = out_of + 1;
                if hinge_direction(j) == 0 && responses(j) == 1 ...
                    || hinge_direction(j) == 180 && responses(j) == 0 ...
                || hinge_direction(j) == 360 && responses(j) == 1 ...
                    || hinge_direction(j) == 540 && responses(j) == 0
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
    
    switch algorithm
        case 1
            alg_name = 'optimization';
        case 2
            alg_name = 'blending';
        case 3
            alg_name = 'single';
        case 4
            alg_name = 'pinhole';
    end
    
    combined = [sum(data_structure([1, 3], [2, 3])); ...
                sum(data_structure([2, 4], [2, 3]))];
    
    totals = [combined, 100*combined(:, 1)./combined(:, 2)];
    
    combined_totals = sum(totals(:, 1:2));
    
    overall = 100*combined_totals(1)/combined_totals(2);
    
    disp(alg_name)
    disp(angle)
    disp(overall)
    combined(1,2)
    
    
    %{
    data_label = strjoin({upper(alg_name), ',', num2str(disparity_dist), 'D dist', num2str(accom_dist), 'D focus'}, ' ');
    %disp(data_label)
    %disp(data_structure)
    
    num_rows = length(allthedata);
    subplot(num_rows, 1, algorithm),  scatter(data_structure(:,1), data_structure(:, 4), 'filled')
    title(data_label);
    xlabel('Angles');
    ylabel('% Responses V');
    %}
end