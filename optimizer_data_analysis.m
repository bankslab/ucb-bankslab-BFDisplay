%load data file(s)
subjects = {'RAA', 'G_B', 'PVJ'};
FinalOutput = zeros(4*length(subjects), 2);
SemiFinalOutput = repmat(FinalOutput, 3, 1);

subjectNum = 0;
for subject = subjects
    filename = strcat(subject, '_Test_Optimization_exp_monocular_hinge_record.mat');
    load(filename{1})
    if isempty(scellCompleted)
        allthedata = [scellThisRound, scellNextRound];
    else
        allthedata = scellCompleted;
    end
    for i = 1:length(allthedata)
        algorithm = get(allthedata{i}, 'algorithm');
        disparity_dist = get(allthedata{i}, 'disparity_dist');
        accom_dist = get(allthedata{i}, 'accom_dist');
        hinge_direction = get(allthedata{i}, 'values');
        responses = get(allthedata{i}, 'responses');
        angle = get(allthedata{i}, 'angle');
        switch angle
            case 70
                position = 0;
            case 90
                position = 1;
            case 110
                position = 2;
        end
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
        
        % Combine identical hinge direction
        combined = [sum(data_structure([1, 3], [2, 3])); ...
                    sum(data_structure([2, 4], [2, 3]))];
        
        % Output for each hinge direction
        totals = [combined, 100*combined(:, 1)./combined(:, 2)];

        % Output for each algorithm & angle
        combined_totals = sum(totals(:, 1:2));
        overall = 100*combined_totals(1)/combined_totals(2);
        
        outputRow = 12*subjectNum+4*position+algorithm;
        SemiFinalOutput(outputRow, 1) = algorithm;
        %SemiFinalOutput(outputRow, 2) = overall;
        SemiFinalOutput(outputRow, 2) = combined_totals(1);
    end
    
    
    %figure;
    clr = hsv;
    hold on;
    for alg_index = 1:4
        AllAnglesCombined = SemiFinalOutput(12*subjectNum+alg_index:4:12*(subjectNum+1), 2);
        %SumAllAnglesCombined = sum(AllAnglesCombined)/3;
        SumAllAnglesCombined = sum(AllAnglesCombined);
        FinalOutput(4*subjectNum+alg_index, :) = [alg_index, SumAllAnglesCombined];
        %h(alg_index) = plot(1:length(AllAnglesCombined), AllAnglesCombined, '.-');
        %set(h(alg_index),'Color',clr(2*alg_index^2,:))
        
    end
    %legend('optimization', 'blending', 'single', 'pinhole');
    hold off;
    
    subjectNum = subjectNum + 1;
end

AllSubjects = NaN*ones(4,2);
for alg = 1:4
    for s = 0:length(subjects)-1
        %AllSubjects(alg, :) = [alg, sum(FinalOutput(alg:4:end, 2))/length(subjects)+1];
        AllSubjects(alg, :) = [alg, sum(FinalOutput(alg:4:end, 2))];
    end
end
        

%{
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
%}