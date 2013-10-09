% make texture for the followings:
% surface of left sphere
% reflection on the left sphere
% surfact of right sphere
% reflection on the right sphere

%% left sphere surface texture
if ~exist('specularityTexture','var')
    specularityTexture=glGenTextures(8);
end

for depthplaneIndex=2:4
    for eyeIndex=0:1
        glBindTexture(GL.TEXTURE_2D,specularityTexture(eyeIndex*4+depthplaneIndex));
        % Setup texture wrapping behaviour:
        glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_S,GL.REPEAT);
        glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_T,GL.REPEAT);
        % Setup filtering for the textures:
        glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MAG_FILTER,GL.LINEAR);
        glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MIN_FILTER,GL.LINEAR);
        % Choose texture application function: It shall modulate the light
        % reflection properties of the the cubes face:
        glTexEnvfv(GL.TEXTURE_ENV,GL.TEXTURE_ENV_MODE,GL.MODULATE);

        if eyeIndex==0
            tx1=imread(leftTexFileName{surfaceScaleIndex,depthplaneIndex-1});
            tx2=imread(leftSpecFileName{reflectionScaleIndex,depthplaneIndex-1});
        elseif eyeIndex==1
            tx1=imread(rightTexFileName{surfaceScaleIndex,depthplaneIndex-1});
            tx2=imread(rightSpecFileName{reflectionScaleIndex,depthplaneIndex-1});
        end
        tx=permute(uint8((double(tx1)+double(tx2))/2), [3 2 1]);
        glTexImage2D(GL.TEXTURE_2D,0,GL.RGB,512,512,0,GL.RGB,GL.UNSIGNED_BYTE,tx);
        clear tx;
        clear tx1;
        clear tx2;
    end
end