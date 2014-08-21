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

if conflict_cases == 0
    if trial_mode == 0
        % Demo Parameters
        focus = 1;          % 0:no focus cue(pinhole),  1:rendered blur(single), 2:volumetric(optimized blending)
        stereo = 0;         % 0:monocular (only right view), 1:binocular
        motion = 1;         % 0:static, 1:dynamic
        paint = 0;          % 0:reflections, 1:painted
        roughness = 0;      % 0:perfectly smooth, 1: 0.01 roughness, 2: roughest
        surfaceDepth = 1.8;   % 1.8 only
        reflectionDepth = 1.3;% 1.3 and maybe 0.6
        texture = 1;

    elseif trial_mode == 1
        % Extract Trial Parameters

        focus = trialList(trialOrder(trialCounter), 1);          % 0:no focus cue(pinhole),  1:rendered blur(single), 2:volumetric(optimized blending)
        stereo = trialList(trialOrder(trialCounter), 2);         % 0:monocular (only right view), 1:binocular
        motion = trialList(trialOrder(trialCounter), 3);         % 0:static, 1:dynamic
        paint = trialList(trialOrder(trialCounter), 4);          % 0:reflections, 1:painted
        roughness = trialList(trialOrder(trialCounter), 5);      % 0:perfectly smooth, 1: 0.01 roughness, 2: roughest
        surfaceDepth = trialList(trialOrder(trialCounter), 6);   % 1.8 only
        reflectionDepth = trialList(trialOrder(trialCounter), 7) % 1.3 and maybe 0.6
        texture = trialList(trialOrder(trialCounter), 8)         % 1 2 3 4 texture variety

    end
else
    if trial_mode == 0
        % Demo Parameters
        focus = 2;          % 0:no focus cue(pinhole),  1:rendered blur(single), 2:volumetric(optimized blending)
        stereo = 1;         % 0:monocular (only right view), 1:binocular
        motion = 1;         % 0:static, 1:dynamic
        if( stereo == 1 || motion == 1)
            paint = 1;
        else
            paint = 0;
        end         % 0:reflections, 1:painted
        roughness = 0;      % 0:perfectly smooth, 1: 0.01 roughness, 2: roughest
        texture = 2;

    elseif trial_mode == 1
        % Extract Trial Parameters

        focus = trialList(trialOrder(trialCounter), 1);          % 0:no focus cue(pinhole), 2:volumetric(optimized blending)
        stereo = trialList(trialOrder(trialCounter), 2);         % 0:monocular (only right view), 1:paint, 2:reflected
        motion = trialList(trialOrder(trialCounter), 3);         % 0:static, 1:paint, 2:reflected
        roughness = trialList(trialOrder(trialCounter), 4);      % 0:perfectly smooth, 1: 0.01 roughness, 2: roughest
        texture = trialList(trialOrder(trialCounter), 5);        % 1 2 3 4 texture variety
        if( stereo == 1 || motion == 1)
            paint = 1;
        else
            paint = 0;
        end
    end
end

% Load the occlusion stimulus
% Order here is agreed upon with Abdullah
string_holder = [];
string_holder{1} = num2str(focus/2); %convert 0,2 to 0,1
string_holder{2} = num2str(1-paint); %paint means 
string_holder{3} = num2str(roughness);
string_holder{4} = num2str(62);
string_holder{5} = num2str(50);

trialCounter
trialOrder(trialCounter)
file_name = strcat(strjoin(string_holder, '_'), '.mat')

if conflict_cases == 0
    file_path = strjoin({'BF_texture_files', 'optimizer', exp_num, num2str(0.062), num2str(reflectionDepth), num2str(texture), file_name}, '/')
else
    file_path = strjoin({'BF_texture_files', 'optimizer', exp_num, 'conflict', num2str(texture), file_name}, '/')
end

if animation_scenes
    file_path = strjoin({'BF_texture_files', 'optimizer', 'video/optimized_animation.mat'}, '/')
end

imageSet = load(file_path);