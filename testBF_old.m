function [] = testBF(geometryCalibration, gammaCalibration, vernierAdjustment)
% open windows in stereo mode 10: 2 monitors regarded as composing one
% stereo view (left eye view and right eye view)
stereoMode=10;
clear GL;
calibratingVernier=1;

AssertOpenGL;
InitializeMatlabOpenGL(0,0);

if stereoMode==10

    PsychImaging('PrepareConfiguration');  
    
    if geometryCalibration
        %geometry correction
        PsychImaging('AddTask', 'RightView' , 'GeometryCorrection', 'BVLCalibdata_CAM20130425_1_800_600_180.mat', 0, 37, 27);
        %PsychImaging('AddTask', 'LeftView', 'GeometryCorrection', 'BVLCalibdata_T_S20090908_0_800_600_180.mat', 0, 37, 27);
    
    end
    
    Screen('Preference', 'SkipSyncTests', 0);
    PsychImaging('AddTask', 'AllViews','FlipHorizontal');  
    PsychImaging('AddTask','General','FloatingPoint16Bit');
    PsychImaging('AddTask','General','UseFastOffscreenWindows');
    
    [wid wrect]=PsychImaging('OpenWindow',0,[],[],[],[],stereoMode, 8);
    [wid2 wrect2]=Screen('OpenWindow',1,0,[],[],[],stereoMode, 8);
    
    if gammaCalibration
        %glt = load('gammalookuptable.mat');
        %glt = load('piecewiseLookUpTable.mat');
        
        
        gammaRed = 2.32345;%2.324;%2.37;
        gammaGreen = 2.22135;%2.223;%2.22;%2.14;
        gammaBlue = 2.277;%2.324;%2.29;
        rgb=1:255;
        gr = rgb.^(1/gammaRed);
        gr = gr/max(gr);
        glt(:,1) = gr;
        
        gg = rgb.^(1/gammaGreen);
        gg = gg/max(gg);
        glt(:,2) = gg;
        
        gb = rgb.^(1/gammaBlue);
        gb = gb/max(gb);
        glt(:,3) = gb;
        
        origGamma=Screen('LoadNormalizedGammaTable', wid, glt);
        origGamma=Screen('LoadNormalizedGammaTable', wid2, glt);
    else
        BF_CLUT_L(:,1)=0:1:255;
        BF_CLUT_L(:,2)=0:1:255;
        BF_CLUT_L(:,3)=0:1:255;
        BF_CLUT_L= (BF_CLUT_L)/255;
        BF_CLUT_R=BF_CLUT_L;
        origGamma=Screen('LoadNormalizedGammaTable', wid, BF_CLUT_L);
        origGamma=Screen('LoadNormalizedGammaTable', wid2, BF_CLUT_R);
    end
else
    [wid wrect]=Screen('OpenWindow',1,[],[],[],[],stereoMode,4);
end



global IPD;
global nearClip;
global farClip;
global vertFOV;
global horizFOV;
global deghorizoffset;
global degvertoffset; 
global vertFOVoffset;
global horizFOVoffset; 
global GL;

eval(['CAM_0p2D']);

% This code displays 4 rectangles in time-sequential manner.
% Define coordinate of the 4 rectangles.
% Coordinate format for Screen command is: [fromH fromV toH toV]
rectSize=100;
 
target{1}=[wrect(3)/2-2*rectSize wrect(4)/2-0.5*rectSize ...
    wrect(3)/2-1*rectSize wrect(4)/2+0.5*rectSize];
target{2}=[wrect(3)/2-rectSize wrect(4)/2-0.5*rectSize ...
    wrect(3)/2 wrect(4)/2+0.5*rectSize];
target{3}=[wrect(3)/2 wrect(4)/2-0.5*rectSize ...
    wrect(3)/2+1*rectSize wrect(4)/2+0.5*rectSize];
target{4}=[wrect(3)/2+1*rectSize wrect(4)/2-0.5*rectSize ...
    wrect(3)/2+2*rectSize wrect(4)/2+0.5*rectSize];


img1 = imread('BF_texture_files/inbetween_zero/inbetween_zero_1.png');
img2 = imread('BF_texture_files/inbetween_zero/inbetween_zero_2.png');
img3 = imread('BF_texture_files/inbetween_zero/inbetween_zero_3.png');
img4 = imread('BF_texture_files/inbetween_zero/inbetween_zero_4.png');
img1 = rgb2gray(img1);
img2 = rgb2gray(img2);
img3 = rgb2gray(img3);
img4 = rgb2gray(img4);



%{
img1 = 255*double(hdrread('BF_texture_files/faces_with_kernels/faces_with_kernels_estimated_p1.hdr'));
img2 = 255*double(hdrread('BF_texture_files/faces_with_kernels/faces_with_kernels_estimated_p2.hdr'));
img3 = 255*double(hdrread('BF_texture_files/faces_with_kernels/faces_with_kernels_estimated_p3.hdr'));
img4 = 255*double(hdrread('BF_texture_files/faces_with_kernels/faces_with_kernels_estimated_p4.hdr'));

img1 = imread('faces_with_1_gap0.3p1.png');
img2 = imread('faces_with_1_gap0.3p2.png');
img3 = imread('faces_with_1_gap0.3p3.png');
img4 = imread('faces_with_1_gap0.3p4.png');
%}

%{
img1 = imread('faces_256_p1.png');
img2 = imread('faces_256_p2.png');
img3 = imread('faces_256_p3.png');
img4 = imread('faces_256_p4.png');
%}


act_img1 = double(imread('BF_texture_files/inbetween_sharp/inbetween_sharp_1.png'));
act_img2 = double(imread('BF_texture_files/inbetween_sharp/inbetween_sharp_2.png'));
act_img3 = double(imread('BF_texture_files/inbetween_sharp/inbetween_sharp_3.png'));
act_img4 = double(imread('BF_texture_files/inbetween_sharp/inbetween_sharp_4.png'));
act_img1 = rgb2gray(uint8(act_img1));
act_img2 = rgb2gray(uint8(act_img2));
act_img3 = rgb2gray(uint8(act_img3));
act_img4 = rgb2gray(uint8(act_img4));

%{
act_img1 =
255*double(hdrread('BF_texture_files/faces_with_kernels/faces_with_kernels_ideal_p1.hdr'));
act_img2 =
255*double(hdrread('BF_texture_files/faces_with_kernels/faces_with_kernels_ideal_p2.hdr'));
act_img3 =
255*double(hdrread('BF_texture_files/faces_with_kernels/faces_with_kernels_ideal_p3.hdr'));
act_img4 =
255*double(hdrread('BF_texture_files/faces_with_kernels/faces_with_kernels_ideal_p4.hdr'));
  
ideal_img1 = imread('faces_with_1_gap0.3ideal1.png'); ideal_img2 =
imread('faces_with_1_gap0.3ideal2.png'); ideal_img3 =
imread('faces_with_1_gap0.3ideal3.png'); ideal_img4 =
imread('faces_with_1_gap0.3ideal4.png');
%}


ideal_img1 = 255*double(hdrread('BF_texture_files/faces_with_kernels/ideal_p1.hdr'));
ideal_img2 = 255*double(hdrread('BF_texture_files/faces_with_kernels/ideal_p2.hdr'));
ideal_img3 = 255*double(hdrread('BF_texture_files/faces_with_kernels/ideal_p3.hdr'));
ideal_img4 = 255*double(hdrread('BF_texture_files/faces_with_kernels/ideal_p4.hdr'));
ideal_img1 = rgb2gray(uint8(ideal_img1));
ideal_img2 = rgb2gray(uint8(ideal_img2));
ideal_img3 = rgb2gray(uint8(ideal_img3));
ideal_img4 = rgb2gray(uint8(ideal_img4));  

tex(1) = Screen('MakeTexture',wid,ideal_img1(:,:,:));
tex(2) = Screen('MakeTexture',wid,ideal_img2(:,:,:));
tex(3) = Screen('MakeTexture',wid,ideal_img3(:,:,:));
tex(4) = Screen('MakeTexture',wid,ideal_img4(:,:,:));

ideal=0;
frameNum=1;
renderStartAt=GetSecs;
flipTimeStamp=[];

%for hor pos 200
trh200 = [11.5410 7.2441 4.2515 0];
trh200 = trh200+200;
%for hor pos 500
trh500 = [-14.6211 -9.8710 -4.9111 0];
trh500 = trh500+500;
%for ver pos 200
trv200 = [10.8467 7.0172 3.8750 0];
trv200 = trv200 + 200;
%for ver pos 500
trv500 = [-14.1250 -8.8826 -5.1097 0];
trv500 = trv500 + 500;

for i = 1:4
    trh(i) = trh200(i)-(trh500(i)-trh200(i))*2/3;
    sch(i) = (trh500(i)-trh200(i))/300;
    trv(i) = trv200(i)-(trv500(i)-trv200(i))*2/3;
    scv(i) = (trv500(i)-trv200(i))/300;
end
testPlane = 1;%configuration plane
step = 0;%0.5;
direction = 1;

while(1)
    % Rendering part
    depthplane=mod(frameNum-1,4)+1;
    
    % Select left eye view
    Screen('SelectStereoDrawBuffer',wid,0);
    % Paint the entier screen black
    Screen('FillRect',wid,[0 0 0]);
    % Paint the rectangle
    %Screen('DrawTexture',wid,ideal_tex(depthplane));
    
    %Screen('FillRect',wid,[255 255 255],target{whichRect});
    if depthplane==3
        Screen('FillRect',wid,[255 255 255],[0 500 100 600]);
    end
    
    
    % Select right eye view
    Screen('SelectStereoDrawBuffer',wid,1);
    
    %apply observer's calibration parameters

    whichEye = 1;
    
    glMatrixMode(GL.MODELVIEW);
    glLoadIdentity();
    glPushMatrix();
    
    
    % Paint the entier screen black
    Screen('FillRect',wid,[0 0 0]);
    
    if vernierAdjustment
        glTranslatef(trh(depthplane),trv(depthplane),0);
        glScalef(sch(depthplane),scv(depthplane),1);
    end
    
    % Paint the rectangle
    Screen('DrawTexture',wid,tex(depthplane));
    if ideal == 1
        Screen('DrawText',wid,'est',390,170,[255 255 255]);
    elseif ideal == 2
        Screen('DrawText',wid,'act',390,170,[255 255 255]);
    else
        Screen('DrawText',wid,'ideal',390,170,[255 255 255]);
    end
    
    
    if depthplane == 1;
        %for vertical adjustments
        Screen('FillRect',wid,[255 0 0],[300 200 500 201]);
        Screen('FillRect',wid,[255 0 0],[300 299.5 500 300.5]);
        Screen('FillRect',wid,[255 0 0],[300 399 500 400]);
        Screen('FillRect',wid,[255 0 0],[300 200 301 400]);
        %Screen('FillRect',wid,[255 0 0],[399.5 200 400.5 400]);
        %Screen('FillRect',wid,[255 0 0],[499 200 500 400]);
    end    
    if depthplane == 2;
        %for vertical adjustments
        Screen('FillRect',wid,[0 255 0],[300 200 500 201]);
        Screen('FillRect',wid,[0 255 0],[300 299.5 500 300.5]);
        Screen('FillRect',wid,[0 255 0],[300 399 500 400]);
        %Screen('FillRect',wid,[0 255 0],[300 200 301 400]);
        Screen('FillRect',wid,[0 255 0],[399.5 200 400.5 400]);
        %Screen('FillRect',wid,[0 255 0],[499 200 500 400]);
    end   
    if depthplane == 3;
        %for vertical adjustments
        Screen('FillRect',wid,[0 0 255],[300 200 500 201]);
        Screen('FillRect',wid,[0 0 255],[300 299.5 500 300.5]);
        Screen('FillRect',wid,[0 0 255],[300 399 500 400]);
        %Screen('FillRect',wid,[0 0 255],[300 200 301 400]);
        %Screen('FillRect',wid,[0 0 255],[399.5 200 400.5 400]);
        Screen('FillRect',wid,[0 0 255],[499 200 500 400]);
    end   
    
    if calibratingVernier
        if depthplane == testPlane+1;
            %for vertical adjustments
            Screen('FillRect',wid,[255 255 255],[300 199.5 400 200.5]);
            Screen('FillRect',wid,[255 255 255],[300 499.5 400 500.5]);
            %for horizontal adjustments
            Screen('FillRect',wid,[255 255 255],[499.5 200 500.5 300]);
            Screen('FillRect',wid,[255 255 255],[199.5 200 200.5 300]);
        end    
        if depthplane == testPlane;
            %for vertical adjustments
            Screen('FillRect',wid,[255 255 255],[400 199.5 500 200.5]);
            Screen('FillRect',wid,[255 255 255],[400 499.5 500 500.5]);
            %for horizontal adjustments
            Screen('FillRect',wid,[255 255 255],[499.5 300 500.5 400]);
            Screen('FillRect',wid,[255 255 255],[199.5 300 200.5 400]);
        end
    end
    
    
    % Flush the video memory, tell graphics card to draw it on screens.
    %if vernierAdjustment
    
    %end
    glPopMatrix();
    if mod(frameNum,4)==3
        
        Screen('FillRect',wid,[255 255 255],[700 500 800 600]);
    end
    Screen('Flip',wid);
    flipTimeStamp(frameNum)=GetSecs;
    
    % Handle keyboard input
    
    if mod(frameNum,2000) == 0
    [a b c d]=KbCheck(-1);
    if a==1
        inputstr=KbName(c);
        if strcmp(inputstr,'ESCAPE') || strcmp(inputstr,'esc')
            % Abort if 'esc' is pressed.
            break;
        end
        
        if strcmp(inputstr,'RightArrow')
            ideal = 1;

            Screen('Close',tex(1));
            Screen('Close',tex(2));
            Screen('Close',tex(3));
            Screen('Close',tex(4));
            tex(1) = Screen('MakeTexture',wid,img1(:,:,:));
            tex(2) = Screen('MakeTexture',wid,img2(:,:,:));
            tex(3) = Screen('MakeTexture',wid,img3(:,:,:));
            tex(4) = Screen('MakeTexture',wid,img4(:,:,:));
            if calibratingVernier
                trv(testPlane) = trv(testPlane)-step; 
                if direction == 1
                    step = step/2;
                    direction = 0;
                end
            end
        end
        if strcmp(inputstr,'LeftArrow')
            ideal = 2;
            Screen('Close',tex(1));
            Screen('Close',tex(2));
            Screen('Close',tex(3));
            Screen('Close',tex(4));
            tex(1) = Screen('MakeTexture',wid,act_img1(:,:,:));
            tex(2) = Screen('MakeTexture',wid,act_img2(:,:,:));
            tex(3) = Screen('MakeTexture',wid,act_img3(:,:,:));
            tex(4) = Screen('MakeTexture',wid,act_img4(:,:,:));
            
            if calibratingVernier
                trv(testPlane) = trv(testPlane)+step;
                if direction == 0
                    step = step/2;
                    direction = 1;
                end
            end
        end
        if strcmp(inputstr,'UpArrow')
            ideal = 0;
            Screen('Close',tex(1));
            Screen('Close',tex(2));
            Screen('Close',tex(3));
            Screen('Close',tex(4));
            tex(1) = Screen('MakeTexture',wid,ideal_img1(:,:,:));
            tex(2) = Screen('MakeTexture',wid,ideal_img2(:,:,:));
            tex(3) = Screen('MakeTexture',wid,ideal_img3(:,:,:));
            tex(4) = Screen('MakeTexture',wid,ideal_img4(:,:,:));
        end
        if strcmp(inputstr,'v')
            vernierAdjustment = 1-vernierAdjustment;
        end
        
    end
    end
    
    % Increase frame number
    frameNum=frameNum+1;
end

if calibratingVernier
    trv
    scv
end

% End Psychtoolbox
Screen('CloseAll');

% A debugging item. Plot the time taken for each frame.

renderDuration=flipTimeStamp-[renderStartAt flipTimeStamp(1:end-1)];
plot([0 length(renderDuration)],[1/180 1/180],'r--'); % reference value (1/180sec, time allocated for each frame)
hold on;
plot(renderDuration,'b-');
axis([0 length(renderDuration) 0 0.02]);
hold off;

