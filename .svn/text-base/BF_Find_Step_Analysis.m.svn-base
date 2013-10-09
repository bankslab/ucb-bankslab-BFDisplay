%%%%%%%%%%%%%%%%%%%%%
% Analyze responses to step-finding data for blur-disparity experiment
% Robin Held
% Banks Lab
% 01/27/10
%%%%%%%%%%%%%%%%%%%%%

clear;
% staircase = [];


% Was only one pedestal value used?
multiple_pedestals = 1;
plot_function = 0;
run_pfit = 1;

lam_limit = 0.005;

% Prompt the user to get the data files
[FileName,PathName,FilterIndex] = uigetfile('*.txt','MultiSelect','on');

whatisthis=whos('FileName');   %Handle a single or multipe input files
if strcmp(whatisthis.class, 'cell')
    number_of_files=length(FileName);
else
    number_of_files=1;
end


% Create dummy files
trial_counter = [];
condition_num = [];
currentValue = [];
current_sc = [];
eccentricity = [];
pedestal = [];
blur_disparity_stim = [];
response = [];

% Compile the data from all of the selected files
for i = 1:number_of_files
    display(['File ' num2str(i) ' of ' num2str(length(FileName))]);
    
    if strcmp(whatisthis.class, 'cell')   %Handle single or multi files
        filename = [PathName FileName{i}];
    else
        filename=[PathName FileName];
    end
    
    [t_poundsign trial_counter_temp, current_sc_temp, condition_num_temp, currentValue_temp, eccentricity_temp, ...
        pedestal_temp, blur_disparity_stim_temp, response_temp, strInputName_temp] = textread(filename, '%c%d%d%d%f%d%f%d%d%s');
    
    trial_counter = [trial_counter; trial_counter_temp];
    current_sc = [current_sc; current_sc_temp];
    condition_num = [condition_num; condition_num_temp];
    currentValue = [currentValue; currentValue_temp];
    eccentricity = [eccentricity; eccentricity_temp];
    pedestal = [pedestal; pedestal_temp];
    blur_disparity_stim = [blur_disparity_stim; blur_disparity_stim_temp];
    response = [response; response_temp];
    
end


% current_sc(find(current_sc == 5)) = 1;
% current_sc(find(current_sc == 6)) = 2;
% current_sc(find(current_sc == 7)) = 3;
% current_sc(find(current_sc == 8)) = 4;

if ~multiple_pedestals
    % Only one unique staircase
    number_of_staircases = 1;

    i = 1;
    staircase{1}.trial_counter = trial_counter;
    staircase{i}.condition_num = condition_num(1);
    staircase{i}.currentValue = currentValue;
    staircase{i}.eccentricity = eccentricity(1);
    staircase{i}.pedestal = pedestal(1);
    staircase{i}.blur_disparity_stim = blur_disparity_stim(1);
    staircase{i}.response = response;
        
else 
    % Multiple staircases with different pedestal values
    number_of_staircases = max(current_sc);

    % Separate staircases
    for i = 1:max(current_sc)
        indices = find(current_sc == i);
        staircase{i}.trial_counter = trial_counter(indices);
        staircase{i}.condition_num = condition_num(indices(1));
        staircase{i}.currentValue = currentValue(indices);
        staircase{i}.eccentricity = eccentricity(indices(1));
        staircase{i}.pedestal = pedestal(indices(1));
        staircase{i}.blur_disparity_stim = blur_disparity_stim(indices(1));
        staircase{i}.response = response(indices);
    end
end

staircasedata(1:number_of_staircases, 1:10)=0;  
reversalcount(1:number_of_staircases)=0;
%These two variables are needed for psignfit
responsedata(1:number_of_staircases, 1:10)=0;  
repspertrialdata(1:number_of_staircases, 1:10)=1; %psignfit can't deal with a 0 for number of trials    
stimuli(1:number_of_staircases,1:2) = -5000;
stim_response(1:number_of_staircases,1:2) = 0;
stim_response_last_index(1:number_of_staircases) = 0;
stim_response_number_of_responses(1:number_of_staircases,1:2) = 0;

% Acquire statistics for use with psignifit
for which_staircase = 1:number_of_staircases
    for i = 1:length(staircase{which_staircase}.response)    
        % Load current stimulus setting
        stimulus = staircase{which_staircase}.currentValue(i);
        response = staircase{which_staircase}.response(i)-1;        % Converting so 0 = wrong, 1 = correct
        if response >= 0
            % Check if that stimulus setting has already been
            % encountered.
            index = find(stimuli(which_staircase,:) == stimulus);
            if (index > 0)
                % Stimulus setting has been encountered.
                stim_response(which_staircase,index) = stim_response(which_staircase,index) + response;
                stim_response_number_of_responses(which_staircase,index) = stim_response_number_of_responses(which_staircase,index) + 1;
            else
                % Stimulus setting has NOT been encountered.
                stim_response_last_index(which_staircase) = stim_response_last_index(which_staircase) + 1;
                index2 = stim_response_last_index(which_staircase);
                stimuli(which_staircase,index2) = stimulus;
                stim_response(which_staircase,index2) = response;
                stim_response_number_of_responses(which_staircase,index2) = 1;
            end
        end
    end
end

% Divide out by the number of trials
for it = 1:number_of_staircases
    staircase{it}.psigdata(:,1) = stimuli(it,1:stim_response_last_index(it));
    staircase{it}.psigdata(:,2) = stim_response(it,1:stim_response_last_index(it))./stim_response_number_of_responses(it,1:stim_response_last_index(it));
    staircase{it}.psigdata(:,3) = stim_response_number_of_responses(it,1:stim_response_last_index(it));
    
    if run_pfit
        figure
       S = pfit(staircase{it}.psigdata,'plot_opt', 'plot without stats', 'shape','cumulative Gaussian','n_intervals', 2, 'conf', [0.025 0.05 0.950 0.975],'lambda_limits', [0 lam_limit],'gamma_limits', [0 lam_limit],'runs', 3500,'sens',0); 
       title(['Pedestal ' num2str(staircase{it}.pedestal) 'm'],'FontSize',18); 
       set(gca,'FontSize',14);
       xlabel('Test Step (m)','FontSize',18,'FontWeight','bold');
       ylabel('Proportion of Correct Responses','FontSize',18,'FontWeight','bold');
       
       % Store statistics
       statistics(it,1) = (S.params.est(1) - S.params.lims(1,1))/1.96;
       statistics(it,2) = S.params.est(1);
       statistics(it,3) = (S.params.lims(4,1) - S.params.est(1))/1.96;
       
    end
    
    if plot_function
        figure;
        hold on;
        for i = 1:length(staircase{it}.psigdata(:,1))
            plot(staircase{it}.psigdata(i,1),staircase{it}.psigdata(i,2),'o','MarkerSize',staircase{it}.psigdata(i,3)/2)
        end
        ylim([0 1.0]);
        title(['Pedestal: '  num2str(staircase{it}.pedestal) 'm'],'FontSize',18);
        xlabel(['Test distance (m)'],'FontSize',16);
        ylabel(['% Correct'],'FontSize',16);
        set(gca,'FontSize',14);
        save_name = ['FindingSteps_' num2str(staircase{it}.pedestal) 'm_Pedestal.eps'];
%         saveas(gcf,save_name,'epsc');
    end
%     figure;
%     plot((1./(staircase{it}.pedestal + staircase{it}.psigdata(:,1)) - 1./staircase{it}.pedestal),staircase{it}.psigdata(:,2))
%     ylim([0 1.0]);
%     title(['Pedestal: '  num2str(staircase{it}.pedestal) 'm'],'FontSize',18);
%     xlabel(['Test distance (D)'],'FontSize',16);
%     ylabel(['% Correct'],'FontSize',16);
%     set(gca,'FontSize',14);
%     save_name = ['FindingSteps_' num2str(staircase{it}.pedestal) 'm_Pedestal_Diopters.eps'];
%     saveas(gcf,save_name,'epsc');
    
    
    
end     

if ~multiple_pedestals    
    % Display the data
    plot(staircase{1,1}.psigdata(:,1),staircase{1,1}.psigdata(:,2),'o');
end