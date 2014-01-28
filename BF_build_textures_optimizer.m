% Load images and build textures for optimizer experiments

if ~exist('image_list', 'var')
    image_list{8} = [];
end

% gamma calibration
load('BF_params/correctedLinearGamma_256steps_zeroOffset.mat');
cg1{1} = correctedGamma{1}(:,1);
cg2{1} = correctedGamma{1}(:,2);
cg3{1} = correctedGamma{1}(:,3);
cg1{2} = correctedGamma{2}(:,1);
cg2{2} = correctedGamma{2}(:,2);
cg3{2} = correctedGamma{2}(:,3);
    
if trial_mode == 0
    % FOR LYTRO IMAGES
    demo_comparison = {};
    %fName1 = 'flower_optimization';
    %fName1 = 'bridge_optimization';
    %fName1 = 'flower2_optimization';

    %fName2 = strcat(demo_comparison{2}, '_', '2');
    imageSet1 = load(strcat('BF_texture_files/optimizer/camera/', num2str(IPD), '/', fName1, '.mat'));
    %imageSet2 = load(strcat('BF_texture_files/optimizer/', exp_num, '/', num2str(IPD), '/', fName2, '.mat'));
 
    
    for plane = (1:4)
       for eye = (0:1)
            img_index = plane + eye*4;
            
            hdr = uint8(zeros(800,800,3)+25);
            
            % image placement and upside down compensation
            hdr(600:-1:1, 1:800, :) = uint8(2*double(imageSet1.layers{eye*4+plane}));
            
            % divide the two halves
            %hdr(600:-1:001, 400:401, :) = 40;
            
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
            
            image_list{img_index} = hdr;
        end
    end   
    
elseif trial_mode == 1
    if started
        % Load Images
        
        %{
        % FOR PLAID SCENE
        if show_image == 1
            fName = 'single_trial3.mat';
        elseif show_image == 2
            fName = 'pinhole_trial3.mat';
        elseif show_image == 3
            fName = 'blending_trial3.mat';
        elseif show_image == 4
            fName = 'optimization_trial3.mat';
        end
        gammaValue = 2;
        imageSet = load(strcat('BF_texture_files/optimizer/camera/0.061/', fName));
        %}
        
        %{
        % FOR Mitsuba SCENE
        if show_image == 1
            fName = 'synthetic_pinhole.mat';
        elseif show_image == 2
            fName = 'synthetic_single.mat';
        elseif show_image == 3
            fName = 'synthetic_blending.mat';
        elseif show_image == 4
            fName = 'synthetic_optimization.mat';
        end
        gammaValue = 2;
        imageSet = load(strcat('BF_texture_files/optimizer/camera/0.061/', fName));
        %}
        
        
        % FOR OCTOPUS SCENE
        if show_image == 1
            fName = 'octopus_single.mat';
            gammaValue = 1;
        elseif show_image == 2
            fName = 'octopus_optimization.mat';
            gammaValue = .91;
        end
        imageSet = load(strcat('BF_texture_files/optimizer/camera/0.061/', fName));
        
        
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

                layerImg = imresize(uint8(255*((1*double(imageSet.layers{eye*4+plane})/255).^(gammaValue))),0.5);
                
                % Find size of loaded image
                [h, w, z] = size(layerImg);
                
                assert((h < 600 && w < 800), 'Image is too large')
                
                hBuffer = (600 - h)/2;
                wBuffer = (800 - w)/2;
                
                hdr((600-hBuffer):-1:(hBuffer+1), (wBuffer+1):(800-wBuffer), :) = layerImg;
                
                % FOR OCTOPUS SCENE
                %hdr(474:-1:127, 220:740, :) = imresize(uint8(255*((1*double(imageSet.layers{eye*4+plane})/255).^(gammaValue))),0.5);
                
                % FOR OLD STUFF
                %hdr(600:-1:001, 101:700, :) = imresize(uint8(1*double(imageSet.layers{eye*4+plane})),0.5);
                %hdr(600:-1:1, 1:800, :) = uint8(255*((double(imageSet.layers{eye*4+plane})/255).^(2)));
                
                %{
                % FOR PLAID SCENE
                hdr(600:-1:1, 1:800, :) = uint8(255*((double(imageSet.layers{eye*4+plane})/255)));
                hdr(:, 101:800, :) = hdr(:, 1:700, :);
                hdr(:, 701:800, :) = 0;
                %}
                
                % FOR Mitsuba SCENE
                %hdr(600:-1:1, 1:800, :) = uint8(255*((2*double(imageSet.layers{eye*4+plane})/255)));
                
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

                image_list{img_index} = hdr;
            end
        end
    end
end

texname_static = glGenTextures(8);
img_size = [800 600];

for img_num = 1:length(image_list)
    glBindTexture(GL.TEXTURE_2D,texname_static(img_num));
    
    % Setup texture wrapping behaviour:
    glTexParameterfv(GL.TEXTURE_2D, GL.TEXTURE_WRAP_S, GL.REPEAT);
    glTexParameterfv(GL.TEXTURE_2D, GL.TEXTURE_WRAP_T, GL.REPEAT);
    
    % Setup filtering for the textures:
    glTexParameterfv(GL.TEXTURE_2D, GL.TEXTURE_MAG_FILTER, GL.LINEAR);
    glTexParameterfv(GL.TEXTURE_2D, GL.TEXTURE_MIN_FILTER, GL.LINEAR);
    
    % Choose texture application function: It shall modulate the light
    % reflection properties of the the cubes face:
    glTexEnvfv(GL.TEXTURE_ENV, GL.TEXTURE_ENV_MODE, GL.MODULATE);
    
    %build the texture and temporarily store it to tx.
    tx = permute(image_list{img_num}, [3 2 1]); %load image here
    
    % Assign image in matrix 'tx' to i'th texture:
    glTexImage2D(GL.TEXTURE_2D, 0, GL.RGB, img_size(1), img_size(2), 0, GL.RGB, GL.UNSIGNED_BYTE, tx);
end

