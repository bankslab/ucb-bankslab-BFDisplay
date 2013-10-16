
function texname_static=BF_build_textures

global GL
% Generate 6 textures and store their handles in vecotr 'texname'
texname_static=glGenTextures(27);

br_gray=90; % gray for BG of high pass rds grating

% % Load a binary file which contains binary pixel data for the six textures:
%  matdemopath = [PsychtoolboxRoot 'PsychDemos/OpenGL4MatlabDemos/mogldemo.mat'];
%  load(matdemopath, 'face')

%Texture 1        Luminace grating
            % Enable i'th texture by binding it:
            glBindTexture(GL.TEXTURE_2D,texname_static(1));
            % Compute image in matlab matrix 'tx'
        %     f=max(min(128*(1+face{1}),255),0);
        %     tx=repmat(flipdim(f,1),[ 1 1 3 ]);
        %     tx=permute(flipdim(uint8(tx),1),[ 3 2 1 ]);



            % Setup texture wrapping behaviour:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_S,GL.REPEAT);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_T,GL.REPEAT);
            % Setup filtering for the textures:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MAG_FILTER,GL.LINEAR);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MIN_FILTER,GL.LINEAR);
            % Choose texture application function: It shall modulate the light
            % reflection properties of the the cubes face:
            glTexEnvfv(GL.TEXTURE_ENV,GL.TEXTURE_ENV_MODE,GL.MODULATE);

            Lum_grating_res=256;  %luminance grating resolution
            %build the texture and temporarily store it to tx.
            tx=permute((uint8(BF_make_lum_grating(Lum_grating_res, 45,6, [1,1,.5]))), [3 2 1]);

            % Assign image in matrix 'tx' to i'th texture:
            glTexImage2D(GL.TEXTURE_2D,0,GL.RGB,Lum_grating_res,Lum_grating_res,0,GL.RGB,GL.UNSIGNED_BYTE,tx);
            clear tx
    
 %Texture 2 
          % make a texture of a vertical line for nonius task
                glBindTexture(GL.TEXTURE_2D,texname_static(2));
            % Compute image in matlab matrix 'tx'
        %     f=max(min(128*(1+face{1}),255),0);
        %     tx=repmat(flipdim(f,1),[ 1 1 3 ]);
        %     tx=permute(flipdim(uint8(tx),1),[ 3 2 1 ]);



            % Setup texture wrapping behaviour:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_S,GL.REPEAT);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_T,GL.REPEAT);
            % Setup filtering for the textures:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MAG_FILTER,GL.LINEAR);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MIN_FILTER,GL.LINEAR);
            % Choose texture application function: It shall modulate the light
            % reflection properties of the the cubes face:
            glTexEnvfv(GL.TEXTURE_ENV,GL.TEXTURE_ENV_MODE,GL.MODULATE);


            %build the texture and temporarily store it to tx1.
            tx=permute(uint8(BF_make_vert_nonius_tex), [3 2 1]);

            % Assign image in matrix 'tx' to i'th texture:
            glTexImage2D(GL.TEXTURE_2D,0,GL.RGB,8,8,0,GL.RGB,GL.UNSIGNED_BYTE,tx);
            clear tx
    
    
%Texture 3    
              % make a texture of a horizontal line for nonius task
                glBindTexture(GL.TEXTURE_2D,texname_static(3));
            % Compute image in matlab matrix 'tx'
        %     f=max(min(128*(1+face{1}),255),0);
        %     tx=repmat(flipdim(f,1),[ 1 1 3 ]);
        %     tx=permute(flipdim(uint8(tx),1),[ 3 2 1 ]);



            % Setup texture wrapping behaviour:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_S,GL.REPEAT);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_T,GL.REPEAT);
            % Setup filtering for the textures:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MAG_FILTER,GL.LINEAR);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MIN_FILTER,GL.LINEAR);
            % Choose texture application function: It shall modulate the light
            % reflection properties of the the cubes face:
            glTexEnvfv(GL.TEXTURE_ENV,GL.TEXTURE_ENV_MODE,GL.MODULATE);


            %build the texture and temporarily store it to tx1.
            tx=permute(uint8(BF_make_horiz_nonius_tex), [3 2 1]);

            % Assign image in matrix 'tx' to i'th texture:
            glTexImage2D(GL.TEXTURE_2D,0,GL.RGB,8,8,0,GL.RGB,GL.UNSIGNED_BYTE,tx);
            clear tx
    
    
%Texture 4    
              % make a texture of a target
                glBindTexture(GL.TEXTURE_2D,texname_static(4));
            % Compute image in matlab matrix 'tx'
        %     f=max(min(128*(1+face{1}),255),0);
        %     tx=repmat(flipdim(f,1),[ 1 1 3 ]);
        %     tx=permute(flipdim(uint8(tx),1),[ 3 2 1 ]);



            % Setup texture wrapping behaviour:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_S,GL.REPEAT);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_T,GL.REPEAT);
            % Setup filtering for the textures:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MAG_FILTER,GL.LINEAR);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MIN_FILTER,GL.LINEAR);
            % Choose texture application function: It shall modulate the light
            % reflection properties of the the cubes face:
            glTexEnvfv(GL.TEXTURE_ENV,GL.TEXTURE_ENV_MODE,GL.MODULATE);


            %build the texture and temporarily store it to tx1.
            tx=permute(uint8(BF_make_target_tex), [ 3 2 1]);

            % Assign image in matrix 'tx' to i'th texture:
            glTexImage2D(GL.TEXTURE_2D,0,GL.RGB,64,64,0,GL.RGB,GL.UNSIGNED_BYTE,tx);
            clear tx    
    
%Texture 5    
              % make a texture of a circle
                glBindTexture(GL.TEXTURE_2D,texname_static(5));
            % Compute image in matlab matrix 'tx'
        %     f=max(min(128*(1+face{1}),255),0);
        %     tx=repmat(flipdim(f,1),[ 1 1 3 ]);
        %     tx=permute(flipdim(uint8(tx),1),[ 3 2 1 ]);



            % Setup texture wrapping behaviour:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_S,GL.REPEAT);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_T,GL.REPEAT);
            % Setup filtering for the textures:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MAG_FILTER,GL.LINEAR);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MIN_FILTER,GL.LINEAR);
            % Choose texture application function: It shall modulate the light
            % reflection properties of the the cubes face:
            glTexEnvfv(GL.TEXTURE_ENV,GL.TEXTURE_ENV_MODE,GL.MODULATE);
            texsizecircle=8;

            %build the texture and temporarily store it to tx1.
            tx=permute(uint8(BF_make_circle(texsizecircle)), [ 3 2 1]);

            % Assign image in matrix 'tx' to i'th texture:
            glTexImage2D(GL.TEXTURE_2D,0,GL.RGB,texsizecircle, texsizecircle,0,GL.RGB,GL.UNSIGNED_BYTE,tx);
            clear tx        
            
            
            
%Texture 6 
          % make a texture of a vertical line with a tab for nonius task
                glBindTexture(GL.TEXTURE_2D,texname_static(6));
            % Compute image in matlab matrix 'tx'
        %     f=max(min(128*(1+face{1}),255),0);
        %     tx=repmat(flipdim(f,1),[ 1 1 3 ]);
        %     tx=permute(flipdim(uint8(tx),1),[ 3 2 1 ]);



            % Setup texture wrapping behaviour:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_S,GL.REPEAT);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_T,GL.REPEAT);
            % Setup filtering for the textures:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MAG_FILTER,GL.LINEAR);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MIN_FILTER,GL.LINEAR);
            % Choose texture application function: It shall modulate the light
            % reflection properties of the the cubes face:
            glTexEnvfv(GL.TEXTURE_ENV,GL.TEXTURE_ENV_MODE,GL.MODULATE);


            %build the texture and temporarily store it to tx1.
            tx=permute(uint8(BF_make_vert_noniustab_tex), [3 2 1]);

            % Assign image in matrix 'tx' to i'th texture:
            glTexImage2D(GL.TEXTURE_2D,0,GL.RGB,8,8,0,GL.RGB,GL.UNSIGNED_BYTE,tx);
            clear tx
    
 %Texture 7 
          % make a texture of a horizontal line with a tab for nonius task
                glBindTexture(GL.TEXTURE_2D,texname_static(7));
            % Compute image in matlab matrix 'tx'
        %     f=max(min(128*(1+face{1}),255),0);
        %     tx=repmat(flipdim(f,1),[ 1 1 3 ]);
        %     tx=permute(flipdim(uint8(tx),1),[ 3 2 1 ]);



            % Setup texture wrapping behaviour:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_S,GL.REPEAT);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_T,GL.REPEAT);
            % Setup filtering for the textures:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MAG_FILTER,GL.LINEAR);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MIN_FILTER,GL.LINEAR);
            % Choose texture application function: It shall modulate the light
            % reflection properties of the the cubes face:
            glTexEnvfv(GL.TEXTURE_ENV,GL.TEXTURE_ENV_MODE,GL.MODULATE);


            %build the texture and temporarily store it to tx1.
            tx=permute(uint8(BF_make_horiz_noniustab_tex), [3 2 1]);

            % Assign image in matrix 'tx' to i'th texture:
            glTexImage2D(GL.TEXTURE_2D,0,GL.RGB,8,8,0,GL.RGB,GL.UNSIGNED_BYTE,tx);
            clear tx           
            

 %Texture 8 
          % make a texture of a near sample target
                glBindTexture(GL.TEXTURE_2D,texname_static(8));

            % Setup texture wrapping behaviour:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_S,GL.REPEAT);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_T,GL.REPEAT);
            % Setup filtering for the textures:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MAG_FILTER,GL.LINEAR);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MIN_FILTER,GL.LINEAR);
            % Choose texture application function: It shall modulate the light
            % reflection properties of the the cubes face:
            glTexEnvfv(GL.TEXTURE_ENV,GL.TEXTURE_ENV_MODE,GL.MODULATE);


            %build the texture and temporarily store it to tx1.
            tx=permute(uint8(BF_make_near_sample_tex), [3 2 1]);

            % Assign image in matrix 'tx' to i'th texture:
            glTexImage2D(GL.TEXTURE_2D,0,GL.RGB,128,128,0,GL.RGB,GL.UNSIGNED_BYTE,tx);
            clear tx         
            
  %Texture 9 
          % make a texture of a near sample target
                glBindTexture(GL.TEXTURE_2D,texname_static(9));

            % Setup texture wrapping behaviour:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_S,GL.REPEAT);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_T,GL.REPEAT);
            % Setup filtering for the textures:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MAG_FILTER,GL.LINEAR);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MIN_FILTER,GL.LINEAR);
            % Choose texture application function: It shall modulate the light
            % reflection properties of the the cubes face:
            glTexEnvfv(GL.TEXTURE_ENV,GL.TEXTURE_ENV_MODE,GL.MODULATE);


            %build the texture and temporarily store it to tx1.
            tx=permute(uint8(BF_make_near_mid_sample_tex), [3 2 1]);

            % Assign image in matrix 'tx' to i'th texture:
            glTexImage2D(GL.TEXTURE_2D,0,GL.RGB,128,128,0,GL.RGB,GL.UNSIGNED_BYTE,tx);
            clear tx                
  
            
   %Texture 10 
          % make a texture of a near sample target
                glBindTexture(GL.TEXTURE_2D,texname_static(10));

            % Setup texture wrapping behaviour:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_S,GL.REPEAT);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_T,GL.REPEAT);
            % Setup filtering for the textures:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MAG_FILTER,GL.LINEAR);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MIN_FILTER,GL.LINEAR);
            % Choose texture application function: It shall modulate the light
            % reflection properties of the the cubes face:
            glTexEnvfv(GL.TEXTURE_ENV,GL.TEXTURE_ENV_MODE,GL.MODULATE);


            %build the texture and temporarily store it to tx1.
            tx=permute(uint8(BF_make_mid_far_sample_tex), [3 2 1]);

            % Assign image in matrix 'tx' to i'th texture:
            glTexImage2D(GL.TEXTURE_2D,0,GL.RGB,128,128,0,GL.RGB,GL.UNSIGNED_BYTE,tx);
            clear tx    

     %Texture 11 
          % make a texture of a near sample target
                glBindTexture(GL.TEXTURE_2D,texname_static(11));

            % Setup texture wrapping behaviour:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_S,GL.REPEAT);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_T,GL.REPEAT);
            % Setup filtering for the textures:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MAG_FILTER,GL.LINEAR);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MIN_FILTER,GL.LINEAR);
            % Choose texture application function: It shall modulate the light
            % reflection properties of the the cubes face:
            glTexEnvfv(GL.TEXTURE_ENV,GL.TEXTURE_ENV_MODE,GL.MODULATE);


            %build the texture and temporarily store it to tx1.
            tx=permute(uint8(BF_make_far_sample_tex), [3 2 1]);

            % Assign image in matrix 'tx' to i'th texture:
            glTexImage2D(GL.TEXTURE_2D,0,GL.RGB,128,128,0,GL.RGB,GL.UNSIGNED_BYTE,tx);
            clear tx    

            
     %Texture 12 
          % make a texture of a grid
                glBindTexture(GL.TEXTURE_2D,texname_static(12));

            % Setup texture wrapping behaviour:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_S,GL.REPEAT);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_T,GL.REPEAT);
            % Setup filtering for the textures:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MAG_FILTER,GL.LINEAR);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MIN_FILTER,GL.LINEAR);
            % Choose texture application function: It shall modulate the light
            % reflection properties of the the cubes face:
            glTexEnvfv(GL.TEXTURE_ENV,GL.TEXTURE_ENV_MODE,GL.MODULATE);


            %build the texture and temporarily store it to tx1.
            tx=permute(uint8(BF_make_groundplane), [3 2 1]);

            % Assign image in matrix 'tx' to i'th texture:
            glTexImage2D(GL.TEXTURE_2D,0,GL.RGB,512,512,0,GL.RGB,GL.UNSIGNED_BYTE,tx);
            clear tx               
   
      %Texture 13 
          % make a texture of a snellen eye chart
                glBindTexture(GL.TEXTURE_2D,texname_static(13));

            % Setup texture wrapping behaviour:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_S,GL.REPEAT);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_T,GL.REPEAT);
            % Setup filtering for the textures:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MAG_FILTER,GL.LINEAR);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MIN_FILTER,GL.LINEAR);
            % Choose texture application function: It shall modulate the light
            % reflection properties of the the cubes face:
            glTexEnvfv(GL.TEXTURE_ENV,GL.TEXTURE_ENV_MODE,GL.MODULATE);


            %build the texture and temporarily store it to tx1.
            tx=permute(uint8(BF_make_snellen), [3 2 1]);

            % Assign image in matrix 'tx' to i'th texture:
            glTexImage2D(GL.TEXTURE_2D,0,GL.RGB,512,512,0,GL.RGB,GL.UNSIGNED_BYTE,tx);
            clear tx             
            
       %Texture 14 
          % make a texture of cal logo
                glBindTexture(GL.TEXTURE_2D,texname_static(14));

            % Setup texture wrapping behaviour:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_S,GL.REPEAT);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_T,GL.REPEAT);
            % Setup filtering for the textures:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MAG_FILTER,GL.LINEAR);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MIN_FILTER,GL.LINEAR);
            % Choose texture application function: It shall modulate the light
            % reflection properties of the the cubes face:
            glTexEnvfv(GL.TEXTURE_ENV,GL.TEXTURE_ENV_MODE,GL.MODULATE);


            %build the texture and temporarily store it to tx1.
            tx=permute(uint8(BF_make_cal_logo), [3 2 1]);

            % Assign image in matrix 'tx' to i'th texture:
            glTexImage2D(GL.TEXTURE_2D,0,GL.RGB,512,512,0,GL.RGB,GL.UNSIGNED_BYTE,tx);
            clear tx          

       %Texture 15 
            % make a texture of cal logo
            glBindTexture(GL.TEXTURE_2D,texname_static(15));

            % Setup texture wrapping behaviour:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_S,GL.REPEAT);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_T,GL.REPEAT);
            % Setup filtering for the textures:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MAG_FILTER,GL.LINEAR);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MIN_FILTER,GL.LINEAR);
            % Choose texture application function: It shall modulate the light
            % reflection properties of the the cubes face:
            glTexEnvfv(GL.TEXTURE_ENV,GL.TEXTURE_ENV_MODE,GL.MODULATE);


            %build the texture and temporarily store it to tx1.
            tx=permute(uint8(BF_make_ruler), [3 2 1]);
                

            
            % Assign image in matrix 'tx' to i'th texture:
            glTexImage2D(GL.TEXTURE_2D,0,GL.RGB,512,512,0,GL.RGB,GL.UNSIGNED_BYTE,tx);
            clear tx
       %Texture 16 
            % make a texture of a gaussian dot
            glBindTexture(GL.TEXTURE_2D,texname_static(16));

            % Setup texture wrapping behaviour:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_S,GL.REPEAT);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_T,GL.REPEAT);
            % Setup filtering for the textures:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MAG_FILTER,GL.LINEAR);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MIN_FILTER,GL.LINEAR);
            % Choose texture application function: It shall modulate the light
            % reflection properties of the the cubes face:
            glTexEnvfv(GL.TEXTURE_ENV,GL.TEXTURE_ENV_MODE,GL.MODULATE);


            %build the texture and temporarily store it to tx1.
            gauss_size = 512;
            % Create the Gaussian distribution
            [X Y] = meshgrid(-1.25:2.5/(gauss_size - 1):1.25, -1.25:2.5/(gauss_size - 1):1.25);
            a = 0.600561;     % FWHM at +/- 0.5
            Z = exp( - ((X / a).^2 + (Y / a).^2)) ;
            Z = uint8(Z*255);
            gauss_tx = zeros(gauss_size, gauss_size, 3);
            gauss_tx(:,:,1) = Z;
            gauss_tx(:,:,2) = Z;
            tx=permute(uint8(gauss_tx), [3 2 1]);
            % Assign image in matrix 'tx' to i'th texture:
            glTexImage2D(GL.TEXTURE_2D,0,GL.RGB,gauss_size,gauss_size,0,GL.RGB,GL.UNSIGNED_BYTE,tx);
            clear tx  
       %Texture 17 
            % make a texture of pink (1/f) noise
            glBindTexture(GL.TEXTURE_2D,texname_static(17));

            % Setup texture wrapping behaviour:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_S,GL.REPEAT);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_T,GL.REPEAT);
            % Setup filtering for the textures:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MAG_FILTER,GL.NEAREST);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MIN_FILTER,GL.NEAREST);
            % Choose texture application function: It shall modulate the light
            % reflection properties of the the cubes face:
            glTexEnvfv(GL.TEXTURE_ENV,GL.TEXTURE_ENV_MODE,GL.MODULATE);


            %build the texture and temporarily store it to tx1.
            texture_size = 128;
            pink_size = 128;
            pink_texture_large = pink_noise(pink_size);
            pink_texture = zeros(texture_size,texture_size,3);
            pink_texture(:,:,1) = round(pink_texture_large(1:texture_size,1:texture_size))*0.5;
            pink_texture(:,:,2) = pink_texture(:,:,1);
            pink_texture(:,:,3) = pink_texture(:,:,1);
            tx=permute(uint8(pink_texture*255), [3 2 1]);
            
            % Assign image in matrix 'tx' to i'th texture:
            glTexImage2D(GL.TEXTURE_2D,0,GL.RGB,texture_size,texture_size,0,GL.RGB,GL.UNSIGNED_BYTE,tx);
            clear tx  
    %Texture 18    
              % make a texture of a white target
                glBindTexture(GL.TEXTURE_2D,texname_static(18));
            % Compute image in matlab matrix 'tx'
        %     f=max(min(128*(1+face{1}),255),0);
        %     tx=repmat(flipdim(f,1),[ 1 1 3 ]);
        %     tx=permute(flipdim(uint8(tx),1),[ 3 2 1 ]);



            % Setup texture wrapping behaviour:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_S,GL.REPEAT);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_T,GL.REPEAT);
            % Setup filtering for the textures:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MAG_FILTER,GL.NEAREST);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MIN_FILTER,GL.NEAREST);
            % Choose texture application function: It shall modulate the light
            % reflection properties of the the cubes face:
            glTexEnvfv(GL.TEXTURE_ENV,GL.TEXTURE_ENV_MODE,GL.MODULATE);

            tx_1 = BF_make_target_tex_thick;
%             tx_1(:,:,3) = 0;
            %build the texture and temporarily store it to tx1.
            tx=permute(uint8(tx_1), [ 3 2 1]);

            % Assign image in matrix 'tx' to i'th texture:
            glTexImage2D(GL.TEXTURE_2D,0,GL.RGB,64,64,0,GL.RGB,GL.UNSIGNED_BYTE,tx);
            clear tx             
            
       %Texture 19 
            % make a texture of a square
            glBindTexture(GL.TEXTURE_2D,texname_static(19));

            % Setup texture wrapping behaviour:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_S,GL.REPEAT);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_T,GL.REPEAT);
            % Setup filtering for the textures:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MAG_FILTER,GL.LINEAR);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MIN_FILTER,GL.LINEAR);
            % Choose texture application function: It shall modulate the light
            % reflection properties of the the cubes face:
            glTexEnvfv(GL.TEXTURE_ENV,GL.TEXTURE_ENV_MODE,GL.MODULATE);

            %build the texture and temporarily store it to tx1.
            tx=permute(uint8(BF_makesquaretex), [3 2 1]);
            
            % Assign image in matrix 'tx' to i'th texture:
            glTexImage2D(GL.TEXTURE_2D,0,GL.RGB,128,128,0,GL.RGB,GL.UNSIGNED_BYTE,tx);
            clear tx     
            
        %Texture 20
            % make a texture of a line with gaussian blur
            glBindTexture(GL.TEXTURE_2D,texname_static(20));

            % Setup texture wrapping behaviour:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_S,GL.REPEAT);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_T,GL.REPEAT);
            % Setup filtering for the textures:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MAG_FILTER,GL.LINEAR);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MIN_FILTER,GL.LINEAR);
            % Choose texture application function: It shall modulate the light
            % reflection properties of the the cubes face:
            glTexEnvfv(GL.TEXTURE_ENV,GL.TEXTURE_ENV_MODE,GL.MODULATE);

            %build the texture and temporarily store it to tx20.
            gauss_size = 64;
            line_multiplier = 4; % How much longer is the line than it is wide?
            % Create the Gaussian distribution
            [X Y] = meshgrid(-1.25:2.5/(gauss_size - 1):1.25, -1.25:2.5/(gauss_size - 1):1.25);
            z_line = ones(gauss_size*(line_multiplier-1)+1,1);
            a = 0.600561;     % FWHM at +/- 0.5
            Z = exp( - ((X / a).^2 + (Y / a).^2)) ;
            Z = conv2(z_line,Z);
            Z = uint8(Z);
            gauss_tx = zeros(gauss_size*line_multiplier, gauss_size*line_multiplier, 3);
            gauss_tx(:,gauss_size*line_multiplier/2-gauss_size/2:gauss_size*line_multiplier/2+gauss_size/2-1,1) = Z;
            gauss_tx(:,gauss_size*line_multiplier/2-gauss_size/2:gauss_size*line_multiplier/2+gauss_size/2-1,2) = Z;

            tx=permute(uint8(gauss_tx), [3 2 1]);
            
            % Assign image in matrix 'tx' to i'th texture:
            glTexImage2D(GL.TEXTURE_2D,0,GL.RGB,gauss_size*line_multiplier,gauss_size*line_multiplier,0,GL.RGB,GL.UNSIGNED_BYTE,tx);
            clear tx              
            
        %Texture 21
            % make a texture of a circle blur with a guassian dot
            glBindTexture(GL.TEXTURE_2D,texname_static(21));

            % Setup texture wrapping behaviour:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_S,GL.REPEAT);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_T,GL.REPEAT);
            % Setup filtering for the textures:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MAG_FILTER,GL.LINEAR);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MIN_FILTER,GL.LINEAR);
            % Choose texture application function: It shall modulate the light
            % reflection properties of the the cubes face:
            glTexEnvfv(GL.TEXTURE_ENV,GL.TEXTURE_ENV_MODE,GL.MODULATE);

            %build the texture and temporarily store it to tx20.
            gauss_size = 64;
            circle_multiplier = 4; % How much wider is the circle than the width of the gaussian dot?
            % Create the Gaussian distribution
            [X Y] = meshgrid(-1.25:2.5/(gauss_size - 1):1.25, -1.25:2.5/(gauss_size - 1):1.25);
            z_circle = ones(gauss_size*(circle_multiplier-1)+1);
            [circle_X, circle_Y] = meshgrid(-1:2/(gauss_size*(circle_multiplier-1)):1, -1:2/(gauss_size*(circle_multiplier-1)):1);
            z_circle = z_circle.*(sqrt(circle_X.^2 + circle_Y.^2) <= 1);
            
            a = 0.600561;     % FWHM at +/- 0.5
            Z = exp( - ((X / a).^2 + (Y / a).^2)) ;
            Z = conv2(z_circle,Z)*0.5;
            Z = uint8(Z);
            gauss_tx = zeros(gauss_size*circle_multiplier, gauss_size*circle_multiplier, 4);
            gauss_tx(:,:,1) = Z;
            gauss_tx(:,:,2) = Z;
            gauss_tx(:,:,4) = Z;

            tx=permute(uint8(gauss_tx), [3 2 1]);
            
            % Assign image in matrix 'tx' to i'th texture:
            glTexImage2D(GL.TEXTURE_2D,0,GL.RGBA,gauss_size*circle_multiplier,gauss_size*circle_multiplier,0,GL.RGBA,GL.UNSIGNED_BYTE,tx);
            clear tx  
            
        %Texture 22
            % make a thin, rectangular texture of pink (1/f) noise
            glBindTexture(GL.TEXTURE_2D,texname_static(22));

            % Setup texture wrapping behaviour:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_S,GL.REPEAT);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_T,GL.REPEAT);
            % Setup filtering for the textures:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MAG_FILTER,GL.NEAREST);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MIN_FILTER,GL.NEAREST);
            % Choose texture application function: It shall modulate the light
            % reflection properties of the the cubes face:
            glTexEnvfv(GL.TEXTURE_ENV,GL.TEXTURE_ENV_MODE,GL.MODULATE);


            %build the texture and temporarily store it to tx1.
            texture_size = 64;
            width = 0.2;            % Width of strip
            temp_tx = pink_noise(texture_size)*0.5;
            pink_texture = zeros(texture_size,texture_size,3);
            pink_texture(:,floor(texture_size*(0.5-width/2)):ceil(texture_size*(0.5+width/2)),1) = temp_tx(:,floor(texture_size*(0.5-width/2)):ceil(texture_size*(0.5+width/2)));
            pink_texture(:,:,2) = pink_texture(:,:,1);
            tx=permute(uint8(pink_texture*255), [3 2 1]);
            
            % Assign image in matrix 'tx' to i'th texture:
            glTexImage2D(GL.TEXTURE_2D,0,GL.RGB,texture_size,texture_size,0,GL.RGB,GL.UNSIGNED_BYTE,tx);
            clear tx  

% make a texture of a vertical line for nonius task (half luminance)
            glBindTexture(GL.TEXTURE_2D,texname_static(23));
     
            % Setup texture wrapping behaviour:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_S,GL.REPEAT);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_T,GL.REPEAT);
            % Setup filtering for the textures:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MAG_FILTER,GL.LINEAR);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MIN_FILTER,GL.LINEAR);
            % Choose texture application function: It shall modulate the light
            % reflection properties of the the cubes face:
            glTexEnvfv(GL.TEXTURE_ENV,GL.TEXTURE_ENV_MODE,GL.MODULATE);


            %build the texture and temporarily store it to tx1.
            tx=permute(uint8(BF_make_vert_nonius_tex_low_lum), [3 2 1]);

            % Assign image in matrix 'tx' to i'th texture:
            glTexImage2D(GL.TEXTURE_2D,0,GL.RGB,8,8,0,GL.RGB,GL.UNSIGNED_BYTE,tx);
            clear tx
            
%Texture 24    
              % make a texture of a hard-edged circle
                glBindTexture(GL.TEXTURE_2D,texname_static(24));
            % Compute image in matlab matrix 'tx'
        %     f=max(min(128*(1+face{1}),255),0);
        %     tx=repmat(flipdim(f,1),[ 1 1 3 ]);
        %     tx=permute(flipdim(uint8(tx),1),[ 3 2 1 ]);



            % Setup texture wrapping behaviour:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_S,GL.REPEAT);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_T,GL.REPEAT);
            % Setup filtering for the textures:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MAG_FILTER,GL.LINEAR);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MIN_FILTER,GL.LINEAR);
            % Choose texture application function: It shall modulate the light
            % reflection properties of the the cubes face:
            glTexEnvfv(GL.TEXTURE_ENV,GL.TEXTURE_ENV_MODE,GL.MODULATE);
            texsizecircle=8;

            %build the texture and temporarily store it to tx1.
            tx=permute(uint8(BF_make_hard_circle(texsizecircle)), [ 3 2 1]);

            % Assign image in matrix 'tx' to i'th texture:
            glTexImage2D(GL.TEXTURE_2D,0,GL.RGB,texsizecircle, texsizecircle,0,GL.RGB,GL.UNSIGNED_BYTE,tx);
            clear tx                  
            
%Texture 25
              % make a texture of a ring - bright dot with dark surrounding
              % & gray background
                glBindTexture(GL.TEXTURE_2D,texname_static(25));
            % Compute image in matlab matrix 'tx'
        %     f=max(min(128*(1+face{1}),255),0);
        %     tx=repmat(flipdim(f,1),[ 1 1 3 ]);
        %     tx=permute(flipdim(uint8(tx),1),[ 3 2 1 ]);



            % Setup texture wrapping behaviour:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_S,GL.REPEAT);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_T,GL.REPEAT);
            % Setup filtering for the textures:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MAG_FILTER,GL.LINEAR);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MIN_FILTER,GL.LINEAR);
            % Choose texture application function: It shall modulate the light
            % reflection properties of the the cubes face:
            glTexEnvfv(GL.TEXTURE_ENV,GL.TEXTURE_ENV_MODE,GL.MODULATE);
            texsizecircle=16;

            %build the texture and temporarily store it to tx1.
            tx=permute(uint8(BF_make_ring(texsizecircle,br_gray)), [ 3 2 1]);

            % Assign image in matrix 'tx' to i'th texture:
            glTexImage2D(GL.TEXTURE_2D,0,GL.RGB,texsizecircle, texsizecircle,0,GL.RGB,GL.UNSIGNED_BYTE,tx);
            clear tx                  
            
            
%Texture 26
              % make a texture of a ring - bright dot with dark surrounding
              % & gray background
                glBindTexture(GL.TEXTURE_2D,texname_static(26));
            % Compute image in matlab matrix 'tx'
        %     f=max(min(128*(1+face{1}),255),0);
        %     tx=repmat(flipdim(f,1),[ 1 1 3 ]);
        %     tx=permute(flipdim(uint8(tx),1),[ 3 2 1 ]);



            % Setup texture wrapping behaviour:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_S,GL.REPEAT);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_T,GL.REPEAT);
            % Setup filtering for the textures:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MAG_FILTER,GL.LINEAR);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MIN_FILTER,GL.LINEAR);
            % Choose texture application function: It shall modulate the light
            % reflection properties of the the cubes face:
            glTexEnvfv(GL.TEXTURE_ENV,GL.TEXTURE_ENV_MODE,GL.MODULATE);
            texsizerect=8;

            %build the texture and temporarily store it to tx1.
            tx=permute(uint8(BF_make_grayrect(texsizerect,br_gray)), [ 3 2 1]);

            % Assign image in matrix 'tx' to i'th texture:
            glTexImage2D(GL.TEXTURE_2D,0,GL.RGB,texsizerect, texsizerect,0,GL.RGB,GL.UNSIGNED_BYTE,tx);
            clear tx                  
            
%             
% %Texture 27
%               % make a texture of a ring - bright dot with dark surrounding
%               % & gray background
%                 glBindTexture(GL.TEXTURE_2D,texname_static(27));
%             % Compute image in matlab matrix 'tx'
%         %     f=max(min(128*(1+face{1}),255),0);
%         %     tx=repmat(flipdim(f,1),[ 1 1 3 ]);
%         %     tx=permute(flipdim(uint8(tx),1),[ 3 2 1 ]);
% 
% 
% 
%             % Setup texture wrapping behaviour:
%             glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_S,GL.REPEAT);
%             glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_T,GL.REPEAT);
%             % Setup filtering for the textures:
%             glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MAG_FILTER,GL.LINEAR);
%             glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MIN_FILTER,GL.LINEAR);
%             % Choose texture application function: It shall modulate the light
%             % reflection properties of the the cubes face:
%             glTexEnvfv(GL.TEXTURE_ENV,GL.TEXTURE_ENV_MODE,GL.MODULATE);
%             texsizerect=8;
% 
%             %build the texture and temporarily store it to tx1.
%             tx=permute(uint8(BF_make_grayrect(texsizerect,255)), [ 3 2 1]);
% 
%             % Assign image in matrix 'tx' to i'th texture:
%             glTexImage2D(GL.TEXTURE_2D,0,GL.RGB,texsizerect, texsizerect,0,GL.RGB,GL.UNSIGNED_BYTE,tx);
%             clear tx                  
%             
% % Texture 28
% 			% make a texture for far plane - for specularity experiment
% 			glBindTexture(GL.TEXTURE_2D,texname_static(28));
% 			
%             % Setup texture wrapping behaviour:
%             glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_S,GL.REPEAT);
%             glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_T,GL.REPEAT);
%             % Setup filtering for the textures:
%             glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MAG_FILTER,GL.LINEAR);
%             glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MIN_FILTER,GL.LINEAR);
%             % Choose texture application function: It shall modulate the light
%             % reflection properties of the the cubes face:
%             glTexEnvfv(GL.TEXTURE_ENV,GL.TEXTURE_ENV_MODE,GL.MODULATE);
% 
%             %build the texture and temporarily store it to tx1.
%             tx=permute(uint8(BF_make_leftfarplaneimage), [ 3 2 1]);
% 
%             % Assign image in matrix 'tx' to i'th texture:
%             glTexImage2D(GL.TEXTURE_2D,0,GL.RGB,512,512,0,GL.RGB,GL.UNSIGNED_BYTE,tx);
%             clear tx                  
%             
% % Texture 29
% 			% make a texture for farmid plane - for specularity experiment
% 			glBindTexture(GL.TEXTURE_2D,texname_static(29));
% 			
%             % Setup texture wrapping behaviour:
%             glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_S,GL.REPEAT);
%             glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_T,GL.REPEAT);
%             % Setup filtering for the textures:
%             glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MAG_FILTER,GL.LINEAR);
%             glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MIN_FILTER,GL.LINEAR);
%             % Choose texture application function: It shall modulate the light
%             % reflection properties of the the cubes face:
%             glTexEnvfv(GL.TEXTURE_ENV,GL.TEXTURE_ENV_MODE,GL.MODULATE);
% 
%             %build the texture and temporarily store it to tx1.
%             tx=permute(uint8(BF_make_leftfarmidplaneimage), [ 3 2 1]);
% 
%             % Assign image in matrix 'tx' to i'th texture:
%             glTexImage2D(GL.TEXTURE_2D,0,GL.RGB,512,512,0,GL.RGB,GL.UNSIGNED_BYTE,tx);
%             clear tx                  
%             
% % Texture 30
% 			% make a texture for midnear plane - for specularity experiment
% 			glBindTexture(GL.TEXTURE_2D,texname_static(30));
% 			
%             % Setup texture wrapping behaviour:
%             glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_S,GL.REPEAT);
%             glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_T,GL.REPEAT);
%             % Setup filtering for the textures:
%             glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MAG_FILTER,GL.LINEAR);
%             glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MIN_FILTER,GL.LINEAR);
%             % Choose texture application function: It shall modulate the light
%             % reflection properties of the the cubes face:
%             glTexEnvfv(GL.TEXTURE_ENV,GL.TEXTURE_ENV_MODE,GL.MODULATE);
% 
%             %build the texture and temporarily store it to tx1.
%             tx=permute(uint8(BF_make_leftmidnearplaneimage), [ 3 2 1]);
% 
%             % Assign image in matrix 'tx' to i'th texture:
%             glTexImage2D(GL.TEXTURE_2D,0,GL.RGB,512,512,0,GL.RGB,GL.UNSIGNED_BYTE,tx);
%             clear tx                  
%             
% % Texture 31
% 			% make a texture for near plane - for specularity experiment
% 			glBindTexture(GL.TEXTURE_2D,texname_static(31));
% 			
%             % Setup texture wrapping behaviour:
%             glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_S,GL.REPEAT);
%             glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_T,GL.REPEAT);
%             % Setup filtering for the textures:
%             glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MAG_FILTER,GL.LINEAR);
%             glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MIN_FILTER,GL.LINEAR);
%             % Choose texture application function: It shall modulate the light
%             % reflection properties of the the cubes face:
%             glTexEnvfv(GL.TEXTURE_ENV,GL.TEXTURE_ENV_MODE,GL.MODULATE);
% 
%             %build the texture and temporarily store it to tx1.
%             tx=permute(uint8(BF_make_leftnearplaneimage), [ 3 2 1]);
% 
%             % Assign image in matrix 'tx' to i'th texture:
%             glTexImage2D(GL.TEXTURE_2D,0,GL.RGB,512,512,0,GL.RGB,GL.UNSIGNED_BYTE,tx);
%             clear tx                  
%             
% % Texture 32
% 			% make a texture for far plane - for specularity experiment
% 			glBindTexture(GL.TEXTURE_2D,texname_static(32));
% 			
%             % Setup texture wrapping behaviour:
%             glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_S,GL.REPEAT);
%             glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_T,GL.REPEAT);
%             % Setup filtering for the textures:
%             glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MAG_FILTER,GL.LINEAR);
%             glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MIN_FILTER,GL.LINEAR);
%             % Choose texture application function: It shall modulate the light
%             % reflection properties of the the cubes face:
%             glTexEnvfv(GL.TEXTURE_ENV,GL.TEXTURE_ENV_MODE,GL.MODULATE);
% 
%             %build the texture and temporarily store it to tx1.
%             tx=permute(uint8(BF_make_rightfarplaneimage), [ 3 2 1]);
% 
%             % Assign image in matrix 'tx' to i'th texture:
%             glTexImage2D(GL.TEXTURE_2D,0,GL.RGB,512,512,0,GL.RGB,GL.UNSIGNED_BYTE,tx);
%             clear tx                  
%             
% % Texture 33
% 			% make a texture for farmid plane - for specularity experiment
% 			glBindTexture(GL.TEXTURE_2D,texname_static(33));
% 			
%             % Setup texture wrapping behaviour:
%             glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_S,GL.REPEAT);
%             glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_T,GL.REPEAT);
%             % Setup filtering for the textures:
%             glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MAG_FILTER,GL.LINEAR);
%             glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MIN_FILTER,GL.LINEAR);
%             % Choose texture application function: It shall modulate the light
%             % reflection properties of the the cubes face:
%             glTexEnvfv(GL.TEXTURE_ENV,GL.TEXTURE_ENV_MODE,GL.MODULATE);
% 
%             %build the texture and temporarily store it to tx1.
%             tx=permute(uint8(BF_make_rightfarmidplaneimage), [ 3 2 1]);
% 
%             % Assign image in matrix 'tx' to i'th texture:
%             glTexImage2D(GL.TEXTURE_2D,0,GL.RGB,512,512,0,GL.RGB,GL.UNSIGNED_BYTE,tx);
%             clear tx                  
%             
% % Texture 34
% 			% make a texture for midnear plane - for specularity experiment
% 			glBindTexture(GL.TEXTURE_2D,texname_static(34));
% 			
%             % Setup texture wrapping behaviour:
%             glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_S,GL.REPEAT);
%             glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_T,GL.REPEAT);
%             % Setup filtering for the textures:
%             glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MAG_FILTER,GL.LINEAR);
%             glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MIN_FILTER,GL.LINEAR);
%             % Choose texture application function: It shall modulate the light
%             % reflection properties of the the cubes face:
%             glTexEnvfv(GL.TEXTURE_ENV,GL.TEXTURE_ENV_MODE,GL.MODULATE);
% 
%             %build the texture and temporarily store it to tx1.
%             tx=permute(uint8(BF_make_rightmidnearplaneimage), [ 3 2 1]);
% 
%             % Assign image in matrix 'tx' to i'th texture:
%             glTexImage2D(GL.TEXTURE_2D,0,GL.RGB,512,512,0,GL.RGB,GL.UNSIGNED_BYTE,tx);
%             clear tx                  
%             
% % Texture 35
% 			% make a texture for near plane - for specularity experiment
% 			glBindTexture(GL.TEXTURE_2D,texname_static(35));
% 			
%             % Setup texture wrapping behaviour:
%             glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_S,GL.REPEAT);
%             glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_T,GL.REPEAT);
%             % Setup filtering for the textures:
%             glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MAG_FILTER,GL.LINEAR);
%             glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MIN_FILTER,GL.LINEAR);
%             % Choose texture application function: It shall modulate the light
%             % reflection properties of the the cubes face:
%             glTexEnvfv(GL.TEXTURE_ENV,GL.TEXTURE_ENV_MODE,GL.MODULATE);
% 
%             %build the texture and temporarily store it to tx1.
%             tx=permute(uint8(BF_make_rightnearplaneimage), [ 3 2 1]);
% 
%             % Assign image in matrix 'tx' to i'th texture:
%             glTexImage2D(GL.TEXTURE_2D,0,GL.RGB,512,512,0,GL.RGB,GL.UNSIGNED_BYTE,tx);
%             clear tx                  
%             
return



function bitmap=BF_make_vert_nonius_tex

    bitmap=zeros(8,8,3);

    bitmap(:, 4:5,:)=255;

return

function bitmap=BF_make_vert_nonius_tex_low_lum

    bitmap=zeros(8,8,3);

    bitmap(:, 4:5,:)=128;

return

function bitmap=BF_make_horiz_nonius_tex

    bitmap=zeros(8,8,3);

    bitmap(4:5, :,:)=255;

return

function bitmap=BF_make_horiz_noniustab_tex

    bitmap=zeros(8,8,3);

    bitmap(4:5, :,:)=255;
    bitmap(:,8,:)=255;

return


function bitmap=BF_make_vert_noniustab_tex

    bitmap=zeros(8,8,3);

    bitmap(:, 4:5,:)=255;
    bitmap(1,:,:)=255;
return


function bitmap=BF_make_circle(texsize)
        texrad=(texsize+1)/2;
        checkrad=.95*(texsize+1)/2;
    bitmap(:,:,1)=255*(sqrt(((meshgrid(1:texsize)-texrad).^2+(meshgrid(1:texsize)'-texrad).^2))<=checkrad);
    bitmap(:,:,2)=255*(sqrt(((meshgrid(1:texsize)-texrad).^2+(meshgrid(1:texsize)'-texrad).^2))<=checkrad);
    bitmap(:,:,3)=255*(sqrt(((meshgrid(1:texsize)-texrad).^2+(meshgrid(1:texsize)'-texrad).^2))<=checkrad);

return


function bitmap=BF_make_hard_circle(texsize)
        texrad=(texsize+1)/2;
        checkrad=100*.95*(texsize+1)/2;
    bitmap(:,:,1)=255*(sqrt(((meshgrid(1:texsize)-texrad).^2+(meshgrid(1:texsize)'-texrad).^2))<=checkrad);
    bitmap(:,:,2)=255*(sqrt(((meshgrid(1:texsize)-texrad).^2+(meshgrid(1:texsize)'-texrad).^2))<=checkrad);
    bitmap(:,:,3)=255*(sqrt(((meshgrid(1:texsize)-texrad).^2+(meshgrid(1:texsize)'-texrad).^2))<=checkrad);

return

function bitmap=BF_make_ring(texsize,br_gray)
        texrad=(texsize+1)/2;
        checkrad_outer=.95*(texsize+1)/2;
% 		checkrad_inner=.30*(texsize+1)/2;
		br_inner=255;
		br_outer=0;
		br1=br_inner-br_outer;
        br2=br_gray-br_outer;
    bitmap1(:,:,1)=br1*(sqrt(((meshgrid(1:texsize)-texrad).^2+(meshgrid(1:texsize)'-texrad).^2))<=checkrad_outer)...
        .*(1-sqrt(((meshgrid(1:texsize)-texrad).^2+(meshgrid(1:texsize)'-texrad).^2))/checkrad_outer);
    bitmap1(:,:,2)=br1*(sqrt(((meshgrid(1:texsize)-texrad).^2+(meshgrid(1:texsize)'-texrad).^2))<=checkrad_outer)...
        .*(1-sqrt(((meshgrid(1:texsize)-texrad).^2+(meshgrid(1:texsize)'-texrad).^2))/checkrad_outer);
    bitmap1(:,:,3)=br1*(sqrt(((meshgrid(1:texsize)-texrad).^2+(meshgrid(1:texsize)'-texrad).^2))<=checkrad_outer)...
        .*(1-sqrt(((meshgrid(1:texsize)-texrad).^2+(meshgrid(1:texsize)'-texrad).^2))/checkrad_outer);
    bitmap2(:,:,1)=br2*(sqrt(((meshgrid(1:texsize)-texrad).^2+(meshgrid(1:texsize)'-texrad).^2))>checkrad_outer);
    bitmap2(:,:,2)=br2*(sqrt(((meshgrid(1:texsize)-texrad).^2+(meshgrid(1:texsize)'-texrad).^2))>checkrad_outer);
    bitmap2(:,:,3)=br2*(sqrt(((meshgrid(1:texsize)-texrad).^2+(meshgrid(1:texsize)'-texrad).^2))>checkrad_outer);
	bitmap=bitmap1+bitmap2+br_outer;

return

function bitmap=BF_make_grayrect(texsize,br_gray)
    bitmap(:,:,1)=br_gray*ones(texsize,texsize);
    bitmap(:,:,2)=br_gray*ones(texsize,texsize);
    bitmap(:,:,3)=br_gray*ones(texsize,texsize);

return


function bitmap=BF_make_target_tex

    bitmap=zeros(64,64,3);

    bitmap(:, 32:33,:)=255;
    bitmap(32:33, :,:)=255;
return

function bitmap=BF_make_target_tex_thick

    bitmap=zeros(64,64,3);

    bitmap(:, 29:36,:)=255;
    bitmap(29:36, :,:)=255;
return

function bitmap=BF_make_near_sample_tex

    bitmap=imread('sample_textures_near.bmp');
    for i=1:3
        bitmap(:,:,i)=flipud(bitmap(:,:,i));
        %bitmap(:,:,i)=fliplr(bitmap(:,:,i));
    end
return

function bitmap=BF_make_near_mid_sample_tex

    bitmap=imread('sample_textures_near_mid.bmp');
    for i=1:3
        bitmap(:,:,i)=flipud(bitmap(:,:,i));
        %bitmap(:,:,i)=fliplr(bitmap(:,:,i));
    end
return

function bitmap=BF_make_mid_far_sample_tex

    bitmap=imread('sample_textures_mid_far.bmp');
    for i=1:3
        bitmap(:,:,i)=flipud(bitmap(:,:,i));
        %bitmap(:,:,i)=fliplr(bitmap(:,:,i));
    end
return

function bitmap=BF_make_far_sample_tex

    bitmap=imread('sample_textures_far.bmp');
    for i=1:3
        bitmap(:,:,i)=flipud(bitmap(:,:,i));
        %bitmap(:,:,i)=fliplr(bitmap(:,:,i));
    end
return

function bitmap=BF_make_groundplane

    bitmap=imread('gridsm2.bmp');
    bitmap(:,:,3)=zeros(512);
    bitmap(:,:,1)=zeros(512);

return

function bitmap=BF_make_snellen
    bitmap=imread('snellen.bmp');
    bitmap(:,:,3)=zeros(512);
    bitmap(:,:,1)= flipud(bitmap(:,:,1));
    bitmap(:,:,2)= flipud(bitmap(:,:,2));
return

  
function bitmap=BF_make_cal_logo
    bitmap=imread('cal_logo.bmp');
  
    bitmap(:,:,1)= flipud(bitmap(:,:,1));
    bitmap(:,:,2)= flipud(bitmap(:,:, 2));
    bitmap(:,:,3)= flipud(bitmap(:,:,3));
return
  
function bitmap=BF_make_ruler
    bitmap2=imread('ruler_tex_stretch_bw.bmp');
    if length(size(bitmap2))==3
        bitmap(:,:,1)= flipud(bitmap(:,:,1));
        bitmap(:,:,2)= flipud(bitmap(:,:,2));
        bitmap(:,:,3)= flipud(bitmap(:,:,3));
    elseif length(size(bitmap2))==2
      for i=1:3
          bitmap(:,:,i)=flipud(bitmap2);
          %bitmap(:,:,i)=fliplr(bitmap(:,:,i));
	  end
    end
return
  
function bitmap=BF_makesquaretex
    bitmap2=imread('square_tex.bmp');
	if length(size(bitmap2))==3
        bitmap(:,:,1)= flipud(bitmap2(:,:,1));
        bitmap(:,:,2)= flipud(bitmap2(:,:,2));
        bitmap(:,:,3)= flipud(bitmap2(:,:,3));
    elseif length(size(bitmap2))==2
		for i=1:3
            bitmap(:,:,i)=flipud(bitmap2);
            %bitmap(:,:,i)=fliplr(bitmap(:,:,i));
		end
	end
    bitmap(bitmap<60)=0;  %damn illustrator won't save black values in center of the damn box
return
          
function bitmap=BF_make_leftfarplaneimage
	bitmap=imread('black.bmp');
    bitmap(:,:,1)= flipud(bitmap(:,:,1));
    bitmap(:,:,2)= flipud(bitmap(:,:,2));
    bitmap(:,:,3)= flipud(bitmap(:,:,3));
return

function bitmap=BF_make_leftfarmidplaneimage
	[a,map]=imread('spec-3.00.png');
    bitmap=ind2rgb(a,map);
    bitmap=uint8(255*bitmap);
%     size(bitmap)
    bitmap(:,:,1)= flipud(bitmap(:,:,1));
    bitmap(:,:,2)= flipud(bitmap(:,:,2));
    bitmap(:,:,3)= flipud(bitmap(:,:,3));
return

function bitmap=BF_make_leftmidnearplaneimage
	bitmap=imread('black.bmp');
    bitmap(:,:,1)= flipud(bitmap(:,:,1));
    bitmap(:,:,2)= flipud(bitmap(:,:,2));
    bitmap(:,:,3)= flipud(bitmap(:,:,3));
return

function bitmap=BF_make_leftnearplaneimage
	[a,map]=imread('left.png');
    bitmap=ind2rgb(a,map);
    bitmap=uint8(255*bitmap);
%     bitmap=repmat(bitmap,[1,1,3]);
%     bitmap=gray2rgb(bitmap);
    bitmap(:,:,1)= flipud(bitmap(:,:,1));
    bitmap(:,:,2)= flipud(bitmap(:,:,2));
    bitmap(:,:,3)= flipud(bitmap(:,:,3));
return

function bitmap=BF_make_rightfarplaneimage
	bitmap=imread('black.bmp');
    bitmap(:,:,1)= flipud(bitmap(:,:,1));
    bitmap(:,:,2)= flipud(bitmap(:,:,2));
    bitmap(:,:,3)= flipud(bitmap(:,:,3));
return

function bitmap=BF_make_rightfarmidplaneimage
	[a,map]=imread('spec3.00.png');
    bitmap=ind2rgb(a,map);
    bitmap=uint8(255*bitmap);
    bitmap(:,:,1)= flipud(bitmap(:,:,1));
    bitmap(:,:,2)= flipud(bitmap(:,:,2));
    bitmap(:,:,3)= flipud(bitmap(:,:,3));
return

function bitmap=BF_make_rightmidnearplaneimage
	bitmap=imread('black.bmp');
    bitmap(:,:,1)= flipud(bitmap(:,:,1));
    bitmap(:,:,2)= flipud(bitmap(:,:,2));
    bitmap(:,:,3)= flipud(bitmap(:,:,3));
return

function bitmap=BF_make_rightnearplaneimage
	[a,map]=imread('right.png');
    bitmap=ind2rgb(a,map);
    bitmap=uint8(255*bitmap);
%     bitmap=repmat(bitmap,[1,1,3]);
%     bitmap=gray2rgb(bitmap);
    bitmap(:,:,1)= flipud(bitmap(:,:,1));
    bitmap(:,:,2)= flipud(bitmap(:,:,2));
    bitmap(:,:,3)= flipud(bitmap(:,:,3));
return

