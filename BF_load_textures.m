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
    surfaceDepth = 1.8;   % 1.8 only
    reflectionDepth = 1.3;% 1.3 and maybe 0.6
    texture = 1;
    fix_dur  = param.fix_duration;       % Seconds
    stim_dur = param.stim_duration;      % Seconds
   
elseif trial_mode == 1
    % Extract Trial Parameters
    
    focus = trialList(trialOrder(trialCounter), 1);          % 0:no focus cue(pinhole),  1:rendered blur(single), 2:volumetric(optimized blending)
    stereo = trialList(trialOrder(trialCounter), 2);         % 0:monocular (only right view), 1:binocular
    motion = trialList(trialOrder(trialCounter), 3);         % 0:static, 1:dynamic
    paint = trialList(trialOrder(trialCounter), 4);          % 0:reflections, 1:painted
    roughness = trialList(trialOrder(trialCounter), 5);      % 0:perfectly smooth, 1: 0.01 roughness, 2: roughest
    surfaceDepth = trialList(trialOrder(trialCounter), 6);   % 1.8 only
    reflectionDepth = trialList(trialOrder(trialCounter), 7);% 1.3 and maybe 0.6
    texture = trialList(trialOrder(trialCounter), 8);        % 1 2 3 4 texture variety
    
end

% Load the occlusion stimulus
% Order here is agreed upon with Abdullah
string_holder = [];
paintStr = 'rp'; %r reflection p paint: when p is 1 string starts with p
string_holder{1} = paintStr(paint+1);
string_holder{2} = num2str(focus);
string_holder{3} = num2str(roughness);
string_holder{4} = num2str(62);
string_holder{5} = num2str(50);

trialCounter
trialOrder(trialCounter)
file_name = strcat(strjoin(string_holder, '_'), '.mat')
file_path = strjoin({'BF_texture_files', 'optimizer', exp_num, num2str(0.062), num2str(reflectionDepth), num2str(texture), file_name}, '/')


imageSet = load(file_path);
