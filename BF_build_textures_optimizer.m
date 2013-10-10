% Load images and build textures for optimizer experiments

if ~exist('image_list', 'var')
    image_list{8} = [];
end

if trial_mode == 0
    for plane = (1:4)
        for eye = (0:1)
            img_index = plane + eye*4;
            demo_params = strcat('optimization_0.5_0.5_90_0_', num2str(plane), '_', num2str(eye));
            fname = strcat('BF_texture_files/optimizer/', exp_num, '/demo_images/', demo_params, '.hdr');
            image_list{img_index} = 255 * hdrread(fname);
        end
    end
    %param.rotation = [0 5];
    
    
elseif trial_mode == 1
    if ~isempty(trial_params)
        trial_parameters = strjoin(trial_params, '_');
        for plane = (1:4)
            for eye = (0:1)
                img_index = plane + eye*4;
                param_string = strjoin({trial_parameters, num2str(plane), num2str(eye)}, '_');
                fname = strcat('BF_texture_files/optimizer/', exp_num, '/', param_string, '.hdr');
                image_list{img_index} = 255 * hdrread(fname);
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

