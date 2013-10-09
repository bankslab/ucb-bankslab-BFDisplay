% make texture for the followings:
% surface of left sphere
% reflection on the left sphere
% surfact of right sphere
% reflection on the right sphere

Screen('EndOpenGL', windowPtr);

%% sphere surface texture
tempimg = imread(surfaceTextureFileName);
temptex = Screen('MakeTexture', windowPtr, tempimg,[],1);
[surfaceGLTexture, surfaceGLTextureTarget] = Screen('GetOpenGLTexture', windowPtr, temptex);
clear tempimg;
clear temptex;

%% sphere reflection texture
tempimg = imread(reflectionTextureFileName);
tempimg2=uint8(zeros(size(tempimg,1),size(tempimg,2),4));
tempimg2(:,:,1:3)=tempimg;
% tempimg2(:,:,4)=uint8(50*ones(size(tempimg,1),size(tempimg,2)));
tempimg2(:,:,4)=uint8(128*ones(size(tempimg,1),size(tempimg,2)));
temptex = Screen('MakeTexture', windowPtr, tempimg2,[],1);
[reflectionGLTexture, reflectionGLTextureTarget] = Screen('GetOpenGLTexture', windowPtr, temptex);
clear tempimg;
clear tempimg2;
clear temptex;

Screen('BeginOpenGL',windowPtr);