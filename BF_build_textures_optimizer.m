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
    demo_params = strcat('optimization_trial2_32_0');
    load(strcat('BF_texture_files/optimizer/', exp_num, '/', num2str(IPD), '/optimization/', demo_params, '.mat'))
    
    
    for plane = (1:4)
       for eye = (0:1)
            img_index = plane + eye*4;
            
            hdr = uint8(zeros(800,800,3));
            
            %upside down compensation
            hdr(550:-1:51,101:700,:) = uint8(double(layers{eye*4+plane}).*generateAperture(18,3.2,1.5,eye));
            
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
    if ~isempty(trial_params)
        % Convert numbers to strings
        string_holder{length(trial_params)} = [];
        string_holder{1} = trial_params{1}{1}; %algorithm
        string_holder{2} = trial_params{2}{1}; %tex_side
        for i = 3:length(trial_params)
            string_holder{i} = num2str(trial_params{i});
        end
        param_string = strjoin(string_holder, '_');
        file_name = strcat(param_string, '.mat');
        file_path = strjoin({'BF_texture_files', 'optimizer', exp_num, num2str(IPD), trial_params{1}{1}, file_name}, '/');
        load(file_path);
        
        for plane = (1:4)
            for eye = (0:1)
                img_index = plane + eye*4;
                
                hdr = uint8(zeros(800,800,3));
                
                %upside down compensation
                hdr(550:-1:51,101:700,:) = uint8(double(layers{eye*4+plane}).*generateAperture(18,3.2,1.5,eye));
                
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

