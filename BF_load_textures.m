% Load images and build textures for optimizer experiments

if first_run == 0
    % initialize variables
    temp_image_list{8} = [];
    image_list{8} = [];
    
    % gamma calibration
    gammaValue = 1;
    load('BF_params/correctedLinearGamma_256steps_zeroOffset.mat');
    cg1{1} = correctedGamma{1}(:,1);
    cg2{1} = correctedGamma{1}(:,2);
    cg3{1} = correctedGamma{1}(:,3);
    cg1{2} = correctedGamma{2}(:,1);
    cg2{2} = correctedGamma{2}(:,2);
    cg3{2} = correctedGamma{2}(:,3);
    
    first_run = 1;
end
%demo vs. experiment mode

% if trial_mode == 0
%     % Demo Parameters
%     fix_dur    = param.fix_duration;
%     stim_dur   = 10;       % Seconds
%     algorithm  = 4;        % 1:Pinhole, 2:Single, 3:Blending, 4:Optimization
%     aperture_size = 4;
%     occl_side  = 0;        % 0:Left,  1:Right
%     fix_plane  = 32;       % Diopters
%     near_plane = 32;       % Diopters
%     far_plane  = 20;       % Diopters
%     
%     % define random textures for near and far textures
%     near_tex = 4;
%     far_tex  = 2;
% %     near_tex = randi(4);
% %     far_tex  = randi(4);
% %     while far_tex == near_tex,
% %         far_tex = randi(4);
% %     end
%     
% elseif trial_mode == 1
%     % Extract Trial Parameters
%     fix_dur    = param.fix_duration;
%     stim_dur   = trialOrder(trial_counter, 1);
%     algorithm  = trialOrder(trial_counter, 4);
%     aperture_size = trialOrder(trial_counter, 3);
%     occl_side  = trialOrder(trial_counter, 2);
%     fix_plane  = trialOrder(trial_counter, 5);
%     near_plane = trialOrder(trial_counter, 6);
%     far_plane  = trialOrder(trial_counter, 7);
%     
%     % define random textures for near and far textures
%     near_tex = randi(4);
%     far_tex  = randi(4);
%     while far_tex == near_tex,
%         far_tex = randi(4);
%     end
%     
% end

if makeFix
    % Load the fixation cross
    string_holder = [];
    %     string_holder{1} = 'fixation';
    % make string holder for E fixation
    e_rand_dir = randi(4);
    e_dir_code = keyCode_mat(2, e_rand_dir);
    e_folder = 'e_stim_slim';
    string_holder{1} = 'e_stim_slim';
    string_holder{2} = sprintf('%d', e_rand_dir);
    string_holder{3} = num2str(fix_plane);
    string_holder{4} = num2str(1); % rename files and delete this line
   
    file_name = strcat(strjoin(string_holder, '_'), '.mat');
    file_path = strjoin({'BF_texture_files', 'optimizer', exp_num, num2str(IPD), string_holder{1}, file_name}, '/');

else
    % render the stimulus at the near and far plane
    %open offscreen window
    %render dot locations
    %get image off the offscreen window
end

imageSet = load(file_path);