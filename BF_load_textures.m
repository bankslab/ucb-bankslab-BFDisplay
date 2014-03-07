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
    algorithm  = 1;        % Pinhole, Single, Blending, Optimization
    near_plane = 20;       % Near, Far
    far_plane  = 14;       % Near, Far
    occl_side  = 0;        % Left, Right
    occl_tex   = 1;        % Noise, Voronoi
    fix_plane  = 14;       % Near, Far
    
elseif trial_mode == 1
    % Trial Parameters
    algorithm  = get(scellThisRound{s_i}, 'currentValue');
    fix_plane  = get(scellThisRound{s_i}, 'fix_plane');
    near_plane  = get(scellThisRound{s_i}, 'near_plane');
    far_plane  = get(scellThisRound{s_i}, 'far_plane');
    occl_side  = get(scellThisRound{s_i}, 'occl_side');
    occl_tex   = get(scellThisRound{s_i}, 'occl_tex');
end

if makeFix
    % Load the fixation cross
    string_holder = [];
    string_holder{1} = 'siemens_star';
    string_holder{2} = num2str(fix_plane);
    string_holder{3} = num2str(1); % rename files and delete this line
    
else
    % Load the occlusion stimulus
    %     string_holder{length(trial_params)} = [];
    %     string_holder{1} = num2str(algorithm);
    %     string_holder{2} = num2str(tex1_side);
    %     string_holder{3} = num2str(front_plane_depth);
    
    string_holder = [];
    string_holder{1} = num2str(algorithm);
    string_holder{2} = num2str(near_plane);
    string_holder{3} = num2str(far_plane);
    string_holder{4} = num2str(occl_tex);
    string_holder{5} = num2str(occl_side);
    string_holder{6} = num2str(fix_plane);

end


% TODO: the paths below need to be changed for the new experiment
file_name = strcat(strjoin(string_holder, '_'), '.mat');
file_path = strjoin({'BF_texture_files', 'optimizer', exp_num, num2str(IPD), string_holder{1}, file_name}, '/');
imageSet = load(file_path);

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
        
%         layerImg = uint8((255*((1*double(imageSet.layers{eye*4+plane})/255).^(gammaValue))).*generateAperture(5,2.4,1.0,eye));
        layerImg = uint8((255*((1*double(imageSet.layers{eye*4+plane})/255).^(gammaValue))));
        
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