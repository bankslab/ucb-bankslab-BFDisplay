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

if trial_mode == 0
    % Demo Parameters
    stim_dur     = 7;      % Seconds
    algorithm    = 2;      % 1:Pinhole, 2:Single, 3:Blending, 4:Optimization
    texture      = 1;      % 1:, 2:, 3:
    angle        = 70;     % Degrees
    tex_version  = 1;      % Degrees
    direction    = 0;      % Degrees

elseif trial_mode == 1
    % Extract Trial Parameters
    stim_dur    = trialOrder(trial_counter, 1);
    algorithm   = trialOrder(trial_counter, 2);
    texture     = trialOrder(trial_counter, 3);
    angle       = trialOrder(trial_counter, 4);
    tex_version = trialOrder(trial_counter, 5);
    direction   = trialOrder(trial_counter, 6);
end

if makeFix
    % Load the fixation cross
    e_rand_dir = randi(4);
    e_dir_code = keyCode_mat(2, e_rand_dir);
    folder_name = 'e_stim_slim';
    string_holder = [];
    string_holder{1} = 'e_stim_slim';
    string_holder{2} = sprintf('%d', e_rand_dir);
    string_holder{3} = num2str(param.vertex_dist);
    string_holder{4} = num2str(1); % rename files and delete this line
else
    % Load the occlusion stimulus
    % Order here is agreed upon with Abdullah
    folder_name = num2str(pupil_size);
    string_holder = [];
    string_holder{1} = num2str(algorithm);
    string_holder{2} = num2str(texture);
    string_holder{3} = num2str(angle);
    string_holder{4} = num2str(direction);
    string_holder{5} = num2str(tex_version);
end
    file_name = strcat(folder_name, '/', strjoin(string_holder, '_'), '.mat');
    file_path = strcat(strjoin({'BF_texture_files', 'optimizer', exp_num, ''},'/'), file_name);

% TODO: the paths below need to be changed for the new experiment
%file_path = strjoin({'BF_texture_files', 'optimizer', exp_num, num2str(IPD), string_holder{1}, file_name}, '/');
% if exist('imageSet','var')
%     clear imageSet;
% end
imageSet = load(file_path);

% %********* Abdullah's modification to involve more crosstalk starts
% inducedCrossTalk = 2;%10 means intensity distribution: 70 10 10 10, 10 70 10 10 etc
% layers2 = imageSet.layers;
%     
% for i = 1:4
%     layers{i} = double(layers2{i})*((100.0-inducedCrossTalk*4.0)/100.0);
%     layers{i+4} = double(layers2{i+4})*((100.0-inducedCrossTalk*4.0)/100.0);
%     for j = 1:4
%         layers{i} = layers{i} + double(layers2{j})*(inducedCrossTalk/100.0);
%         layers{i+4} = layers{i+4} + double(layers2{j+4})*(inducedCrossTalk/100.0);
%     end
%     layers{i} = uint8(layers{i});
%     layers{i+4} = uint8(layers{i+4});
% end
% imageSet.layers = layers;
% %********* Abdullah's modification to involve more crosstalk ends

for plane = (1:4)
    for eye = (0:1)
        img_index = plane + eye*4;
        
        % Blank image holder (must be square)
        hdr = uint8(zeros(800,800,3));
        
        % Displayed image is placed into image holder
        % Blank areas outside [600, 800] are not visible
        % Image must also be flipped upside down
        % Example1: Display a full-screen white square
        % hdr(600:-1:1, 1:800, :) = 255*ones(600, 800, 3);
        % Example2: Display HDR or double values w/ GammaCorrection
        % hdr(600:-1:1, 1:800, :) = uint8(255*(double(file/255).^(GammaValue)));
        
        layerImg = uint8((255*((1*double(imageSet.layers{eye*4+plane})/255).^(gammaValue))).*generateAperture(20,2.5,1.0,eye));
%         layerImg = uint8((255*((1*double(imageSet.layers{eye*4+plane})/255).^(gammaValue))));
        
        % Find size of loaded image
        [h, w, z] = size(layerImg);
        
        assert((h < 600 && w < 800), 'Image is too large')
        
        hBuffer = (600 - h)/2;
        wBuffer = (800 - w)/2;
        
        hdr((600-hBuffer):-1:(hBuffer+1), (wBuffer+1):(800-wBuffer), :) = layerImg;
        
        % gamma calibration
        hdr1 = hdr(:,:,1);
        hdr2 = hdr(:,:,2);
        hdr3 = hdr(:,:,3);
        
        hdr1 = uint8(255*cg1{eye+1}(hdr1+1));
        hdr2 = uint8(255*cg2{eye+1}(hdr2+1));
        hdr3 = uint8(255*cg3{eye+1}(hdr3+1));
        
        hdr(:,:,1) = hdr1;
        hdr(:,:,2) = hdr2;
        hdr(:,:,3) = hdr3;
        
        temp_image_list{img_index} = hdr;
    end
end