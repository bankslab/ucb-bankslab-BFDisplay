% make texture for the followings:
% surface of left sphere
% reflection on the left sphere
% surfact of right sphere
% reflection on the right sphere
here=1

%% left sphere surface texture
leftSurfaceTexture=glGenTextures(1);
glBindTexture(GL.TEXTURE_2D,leftSurfaceTexture);

% Setup texture wrapping behaviour:
glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_S,GL.REPEAT);
glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_T,GL.REPEAT);
% Setup filtering for the textures:
glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MAG_FILTER,GL.LINEAR);
glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MIN_FILTER,GL.LINEAR);
% Choose texture application function: It shall modulate the light
% reflection properties of the the cubes face:
glTexEnvfv(GL.TEXTURE_ENV,GL.TEXTURE_ENV_MODE,GL.MODULATE);

tx=imread(leftSurfaceTextureFileName);
% [a,map]=imread(leftSurfaceTextureFileName);
% bitmap=ind2rgb(a,map);
% bitmap=uint8(255*bitmap);
% %     bitmap=repmat(bitmap,[1,1,3]);
% %     bitmap=gray2rgb(bitmap);
% bitmap(:,:,1)= flipud(bitmap(:,:,1));
% bitmap(:,:,2)= flipud(bitmap(:,:,2));
% bitmap(:,:,3)= flipud(bitmap(:,:,3));
% %build the texture and temporarily store it to tx1.
% tx=permute(uint8(bitmap), [ 3 2 1]);

% Assign image in matrix 'tx' the texture:
glTexImage2D(GL.TEXTURE_2D,0,GL.RGB,512,512,0,GL.RGB,GL.UNSIGNED_BYTE,tx);
clear tx                  

%% right sphere surface texture
rightSurfaceTexture=glGenTextures(1);
glBindTexture(GL.TEXTURE_2D,rightSurfaceTexture);

% Setup texture wrapping behaviour:
glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_S,GL.REPEAT);
glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_T,GL.REPEAT);
% Setup filtering for the textures:
glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MAG_FILTER,GL.LINEAR);
glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MIN_FILTER,GL.LINEAR);
% Choose texture application function: It shall modulate the light
% reflection properties of the the cubes face:
glTexEnvfv(GL.TEXTURE_ENV,GL.TEXTURE_ENV_MODE,GL.MODULATE);

tx=imread(rightSurfaceTextureFileName);
glTexImage2D(GL.TEXTURE_2D,0,GL.RGB,512,512,0,GL.RGB,GL.UNSIGNED_BYTE,tx);
clear tx                  

%% left reflection texture
leftReflectionTexture=glGenTextures(1);
glBindTexture(GL.TEXTURE_2D,leftReflectionTexture);

% Setup texture wrapping behaviour:
glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_S,GL.REPEAT);
glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_T,GL.REPEAT);
% Setup filtering for the textures:
glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MAG_FILTER,GL.LINEAR);
glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MIN_FILTER,GL.LINEAR);
% Choose texture application function: It shall modulate the light
% reflection properties of the the cubes face:
glTexEnvfv(GL.TEXTURE_ENV,GL.TEXTURE_ENV_MODE,GL.MODULATE);

tx=imread(leftReflectionTextureFileName);
glTexImage2D(GL.TEXTURE_2D,0,GL.RGB,512,512,0,GL.RGB,GL.UNSIGNED_BYTE,tx);
clear tx                  

%% right reflection texture
rightReflectionTexture=glGenTextures(1);
glBindTexture(GL.TEXTURE_2D,rightReflectionTexture);

% Setup texture wrapping behaviour:
glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_S,GL.REPEAT);
glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_T,GL.REPEAT);
% Setup filtering for the textures:
glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MAG_FILTER,GL.LINEAR);
glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MIN_FILTER,GL.LINEAR);
% Choose texture application function: It shall modulate the light
% reflection properties of the the cubes face:
glTexEnvfv(GL.TEXTURE_ENV,GL.TEXTURE_ENV_MODE,GL.MODULATE);

tx=imread(rightReflectionTextureFileName);
glTexImage2D(GL.TEXTURE_2D,0,GL.RGB,512,512,0,GL.RGB,GL.UNSIGNED_BYTE,tx);
clear tx                  
             
here=2