% Load images and build textures for optimizer experiments

if ~exist('image_list', 'var')
    image_list{8} = [];
end

%test
load('BF_params/correctedLinearGamma_256steps_zeroOffset.mat');
cg1{1} = correctedGamma{1}(:,1);
cg2{1} = correctedGamma{1}(:,2);
cg3{1} = correctedGamma{1}(:,3);
cg1{2} = correctedGamma{2}(:,1);
cg2{2} = correctedGamma{2}(:,2);
cg3{2} = correctedGamma{2}(:,3);
    
if trial_mode == 0 
    %demo_params = strcat('optimization_2.6_2.6_90_0');
    %load(strcat('BF_texture_files/optimizer/', exp_num, '/optimization/', demo_params, '.mat'))

    demo_params = strcat('optimization_2_2_90_0');
    load(strcat('BF_texture_files/optimizer/', exp_num, '/61/optimization/', demo_params, '.mat'))
    
    
    for plane = (1:4)
       for eye = (0:1)
            img_index = 5-plane + eye*4;
            %for spheres demo
            %demo_params = strcat('s_optimization_2_2_90_5_', num2str(plane), '_', num2str(eye));
            %fname = strcat('BF_texture_files/optimizer/', exp_num, '/demo_images/', demo_params, '.hdr');
            
            hdr = uint8(zeros(800,800,3));
            % This "yellow" section should be cropped by
            % BF_bind_texture_to_square later on (to make correctly
            % sized and scaled square texture.
            %hdr(:,:,1:2) = 255;
            
            %upside down compensation
            hdr(550:-1:51,101:700,:) = uint8(double(layers{eye*4+plane}).*generateAperture(18,2.3,1.5,eye));
            %test
            hdr1 = hdr(:,:,1);
            hdr2 = hdr(:,:,2);
            hdr3 = hdr(:,:,3);
            
            hdr1 = uint8(255*cg1{eye+1}(hdr1+1));
            hdr2 = uint8(255*cg2{eye+1}(hdr2+1));
            hdr3 = uint8(255*cg3{eye+1}(hdr3+1));
            
            hdr(:,:,1) = hdr1;
            hdr(:,:,2) = hdr2;
            hdr(:,:,3) = hdr3;
            
            %compensation for 2.5 diopter vergence angle
            %disparityCompensationShift = -(2*(eye-0.5))*((0.06/2)*800/2)/((1/2.5)*tan(toRadians('d',32.6/2)));
            %dcs = disparityCompensationShift;
            %hdr(:,abs(dcs)+1:(800-abs(dcs)),:) = hdr(:,abs(dcs)+dcs+1:(800-abs(dcs))+dcs,:) ;

            %paint the sides to black
            %hdr(:,1:abs(dcs)+1,:) = 0; 
            %hdr(:,(800-abs(dcs)-1):800,:) = 0;
            image_list{img_index} = hdr;
        end
    end
    %param.rotation = [0 5];
    
    
elseif trial_mode == 1
    if ~isempty(trial_params)
        % Convert numbers to strings
        string_holder{length(trial_params)} = [];
        string_holder{1} = trial_params{1}; %algorithm
        for i = 2:length(trial_params)
            string_holder{i} = num2str(trial_params{i});
        end
        param_string = strjoin(string_holder, '_');
        file_name = strcat(param_string, '.mat');
        file_path = strjoin({'BF_texture_files', 'optimizer', exp_num, '61', trial_params{1}, file_name}, '/');
        load(file_path);
        
        for plane = (1:4)
            for eye = (0:1)
                img_index = plane + eye*4;
            
                hdr = uint8(zeros(800,800,3));
                % This "yellow" section should be cropped by
                % BF_bind_texture_to_square later on (to make correctly
                % sized and scaled square texture.
                %hdr(:,:,1:2) = 255;
                
                %upside down compensation
                aperture = generateAperture(18,0.3+trial_params{3},trial_params{3},eye);
                hdr(550:-1:51,101:700,:) = uint8(double(layers{eye*4+plane}).*generateAperture(18,2.3,1.5,eye));
                
                %test
                hdr1 = hdr(:,:,1);
                hdr2 = hdr(:,:,2);
                hdr3 = hdr(:,:,3);

                hdr1 = uint8(255*cg1{eye+1}(hdr1+1));
                hdr2 = uint8(255*cg2{eye+1}(hdr2+1));
                hdr3 = uint8(255*cg3{eye+1}(hdr3+1));

                hdr(:,:,1) = hdr1;
                hdr(:,:,2) = hdr2;
                hdr(:,:,3) = hdr3;
                
                %compensation for 2.5 diopter vergence angle
                disparityCompensationShift = -(2*(eye-0.5))*((0.06/2)*800/2)/((1/2.5)*tan(toRadians('d',32.6/2)));
                dcs = round(disparityCompensationShift);
                hdr(:,abs(dcs)+1:(800-abs(dcs)),:) = hdr(:,abs(dcs)+dcs+1:(800-abs(dcs))+dcs,:) ;
                
                %paint the sides to black
                hdr(:,1:abs(dcs)+1,:) = 0;
                hdr(:,(800-abs(dcs)-1):800,:) = 0;
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

