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
    focus = 1;          % 0:no focus cue(pinhole),  1:rendered blur(single), 2:volumetric(optimized blending)
    stereo = 0;         % 0:monocular (only right view), 1:binocular
    motion = 1;         % 0:static, 1:dynamic
    paint = 0;          % 0:reflections, 1:painted
    roughness = 0;      % 0:perfectly smooth, 1: 0.01 roughness, 2: roughest
    fix_dur  = param.fix_duration;       % Seconds
    stim_dur = param.stim_duration;      % Seconds
   
elseif trial_mode == 1
    % Extract Trial Parameters
    
    focus = trialOrder(trial_counter, 1);          % 0:no focus cue(pinhole),  1:rendered blur(single), 2:volumetric(optimized blending)
    stereo = trialOrder(trial_counter, 2);         % 0:monocular (only right view), 1:binocular
    motion = trialOrder(trial_counter, 3);         % 0:static, 1:dynamic
    paint = trialOrder(trial_counter, 4);          % 0:reflections, 1:painted
    roughness = trialOrder(trial_counter, 5);      % 0:perfectly smooth, 1: 0.01 roughness, 2: roughest
    fix_dur  = param.fix_duration;       % Seconds
    stim_dur = param.stim_duration;      % Seconds
    
end

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
    string_holder{3} = num2str(32);
    string_holder{4} = num2str(1); % rename files and delete this line
   
    file_name = strcat(strjoin(string_holder, '_'), '.mat');
    file_path = strjoin({'BF_texture_files', 'optimizer', exp_num, num2str(IPD), string_holder{1}, file_name}, '/');

else
    % Load the occlusion stimulus
    % Order here is agreed upon with Abdullah
    string_holder = [];
    paintStr = 'rp'; %r reflection p paint: when p is 1 string starts with p
    string_holder{1} = paintStr(paint+1);
    string_holder{2} = num2str(focus);
    string_holder{3} = num2str(roughness);
    string_holder{4} = num2str(62);
    string_holder{5} = num2str(50);
    
    file_name = strcat(strjoin(string_holder, '_'), '.mat');
    file_path = strjoin({'BF_texture_files', 'optimizer', exp_num, num2str(IPD), file_name}, '/');

end

imageSet = load(file_path);

%{
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
        
        layerImg = uint8((255*((1*double(imageSet.layers{eye*4+plane})/255).^(gammaValue))).*generateAperture(10,2.5,1.0,eye));
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
%}