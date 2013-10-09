% make texture for the followings:
% surface of left sphere
% reflection on the left sphere
% surfact of right sphere
% reflection on the right sphere

%% left sphere surface texture
if ~exist('leftTexture','var')
    leftTexture=glGenTextures(3*numReflectionImageInOneSet);
    rightTexture=glGenTextures(3*numReflectionImageInOneSet);
end

for depthplaneIndex=2:4
    for eyeIndex=0:1
        surfaceTextureImageIndex=10;
        leftSurfaceImage=imread(leftSurfaceImageFileName{surfaceTextureImageIndex,depthplaneIndex-1});
        leftSurfaceImage=permute(leftSurfaceImage,[3 2 1]);

        rightSurfaceImage=imread(rightSurfaceImageFileName{surfaceTextureImageIndex,depthplaneIndex-1});
        rightSurfaceImage=permute(rightSurfaceImage,[3 2 1]);

        for ii=1:numReflectionImageInOneSet
            glBindTexture(GL.TEXTURE_2D,leftTexture(3*(ii-1)+depthplaneIndex-1));
            % Setup texture wrapping behaviour:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_S,GL.REPEAT);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_T,GL.REPEAT);
            % Setup filtering for the textures:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MAG_FILTER,GL.LINEAR);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MIN_FILTER,GL.LINEAR);
            % Choose texture application function: It shall modulate the light
            % reflection properties of the the cubes face:
            glTexEnvfv(GL.TEXTURE_ENV,GL.TEXTURE_ENV_MODE,GL.MODULATE);
            leftReflectionImage=imread(leftReflectionImageFileName{ii,depthplaneIndex-1});
            leftReflectionImage=permute(leftReflectionImage,[3 2 1]);
            leftImage=uint8((double(leftSurfaceImage)+double(leftReflectionImage))/2);
            glTexImage2D(GL.TEXTURE_2D,0,GL.RGB,512,512,0,GL.RGB,GL.UNSIGNED_BYTE,leftImage);
            clear leftReflectionImage;
            clear leftImage;

            glBindTexture(GL.TEXTURE_2D,rightTexture(3*(ii-1)+depthplaneIndex-1));
            % Setup texture wrapping behaviour:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_S,GL.REPEAT);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_T,GL.REPEAT);
            % Setup filtering for the textures:
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MAG_FILTER,GL.LINEAR);
            glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MIN_FILTER,GL.LINEAR);
            % Choose texture application function: It shall modulate the light
            % reflection properties of the the cubes face:
            glTexEnvfv(GL.TEXTURE_ENV,GL.TEXTURE_ENV_MODE,GL.MODULATE);
            rightReflectionImage=imread(rightReflectionImageFileName{ii,depthplaneIndex-1});
            rightReflectionImage=permute(rightReflectionImage,[3 2 1]);
            rightImage=uint8((double(rightSurfaceImage)+double(rightReflectionImage))/2);
            glTexImage2D(GL.TEXTURE_2D,0,GL.RGB,512,512,0,GL.RGB,GL.UNSIGNED_BYTE,rightImage);
            clear rightReflectionImage;
            clear rightImage;
        end
        clear leftSurfaceImage;
        clear rightSurfaceImage;
    end
    depthplaneIndex
end
