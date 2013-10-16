function [] = testBF(geometryCalibration, gammaCalibration, vernierAdjustment)
% open windows in stereo mode 10: 2 monitors regarded as composing one
% stereo view (left eye view and right eye view)
stereoMode=10;

  

if stereoMode==10
    
    if geometryCalibration
        PsychImaging('PrepareConfiguration');
        %geometry correction
        PsychImaging('AddTask', 'RightView' , 'GeometryCorrection', 'BVLCalibdata_CAM20130425_1_800_600_180.mat', 0, 37, 27);
        %PsychImaging('AddTask', 'LeftView', 'GeometryCorrection', 'BVLCalibdata_T_S20090908_0_800_600_180.mat', 0, 37, 27);
    
    end
    
        PsychImaging('AddTask', 'AllViews','FlipHorizontal');  
    [wid wrect]=PsychImaging('OpenWindow',0,[],[],[],[],stereoMode, 4);
    [wid2 wrect2]=Screen('OpenWindow',1,[],[],[],[],stereoMode, 4);
    
    if gammaCalibration
        load('gammalookuptable.mat');
        origGamma=Screen('LoadNormalizedGammaTable', wid, gammaLookupTable);
        origGamma=Screen('LoadNormalizedGammaTable', wid2, gammaLookupTable);
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
    [wid wrect]=Screen('OpenWindow',1,[],[],[],[],stereoMode);
end


InitializeMatlabOpenGL(0,0);

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


img1 = imread('faces_with_1_gap0.3p1.png');
img2 = imread('faces_with_1_gap0.3p2.png');
img3 = imread('faces_with_1_gap0.3p3.png');
img4 = imread('faces_with_1_gap0.3p4.png');

%{
img1 = imread('faces_256_p1.png');
img2 = imread('faces_256_p2.png');
img3 = imread('faces_256_p3.png');
img4 = imread('faces_256_p4.png');
%}
tex(1) = Screen('MakeTexture',wid,img1(:,:,1:3));
tex(2) = Screen('MakeTexture',wid,img2(:,:,1:3));
tex(3) = Screen('MakeTexture',wid,img3(:,:,1:3));
tex(4) = Screen('MakeTexture',wid,img4(:,:,1:3));

 
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



    
ideal_img1 = imread('faces_with_1_gap0.3ideal1.png');
ideal_img2 = imread('faces_with_1_gap0.3ideal2.png');
ideal_img3 = imread('faces_with_1_gap0.3ideal3.png');
ideal_img4 = imread('faces_with_1_gap0.3ideal4.png');
ideal_tex(1) = Screen('MakeTexture',wid,ideal_img1(:,:,1:3));
ideal_tex(2) = Screen('MakeTexture',wid,ideal_img2(:,:,1:3));
ideal_tex(3) = Screen('MakeTexture',wid,ideal_img3(:,:,1:3));
ideal_tex(4) = Screen('MakeTexture',wid,ideal_img4(:,:,1:3));

ideal=0;
frameNum=1;
renderStartAt=GetSecs;
flipTimeStamp=[];

%for hor pos 200
trh = [0 0 4.2515 0];
sch = [1 1 1 1];
trv = [0 0 0 0];
scv = [1 1 1 1];
step = 0.5;
direction = 1;

while(1)
    % Rendering part
    whichRect=mod(frameNum-1,4)+1;
    
    % Select left eye view
    Screen('SelectStereoDrawBuffer',wid,0);
    % Paint the entier screen black
    Screen('FillRect',wid,[0 0 0]);
    % Paint the rectangle
    Screen('DrawTexture',wid,ideal_tex(whichRect));
    
    %Screen('FillRect',wid,[255 255 255],target{whichRect});
    if mod(frameNum,4)==3
        Screen('FillRect',wid,[255 255 255],[0 500 100 600]);
    end
    
    
    % Select right eye view
    Screen('SelectStereoDrawBuffer',wid,1);
    
    %apply observer's calibration parameters

    depthplane = whichRect;
    whichEye = 1;
    
    glMatrixMode(GL.MODELVIEW);
    glLoadIdentity();
    
    if vernierAdjustment
        left=tan((-horizFOV/2+deghorizoffset(depthplane+whichEye*4)-horizFOVoffset(depthplane+whichEye*4))*pi/180);
        right=tan((+horizFOV/2+deghorizoffset(depthplane+whichEye*4)+horizFOVoffset(depthplane+whichEye*4))*pi/180);
        top=tan((+vertFOV/2+degvertoffset(depthplane+whichEye*4)+vertFOVoffset(depthplane+whichEye*4))*pi/180);
        bottom=tan((-vertFOV/2+degvertoffset(depthplane+whichEye*4)-vertFOVoffset(depthplane+whichEye*4))*pi/180);
        leftOrig=tan((-horizFOV/2)*pi/180);
        rightOrig=tan((+horizFOV/2)*pi/180);
        topOrig=tan((+vertFOV/2)*pi/180);
        bottomOrig=tan((-vertFOV/2)*pi/180);

        left = 400-400*(left/leftOrig); %leftmost part of display
        right = 400+400*(right/rightOrig); %rightmost part of display
        scaleH = 800/(right-left);
        transH = -left; 

        top = 300-300*(top/topOrig); %topmost part of display
        bottom = 300+300*(bottom/bottomOrig); %bottommost part of display
        scaleV = 600/(bottom-top);
        transV = -top;
        
        glTranslatef(transH,transV,0);
        glScalef(scaleH,scaleV,1);
    end
    
    
    % Paint the entier screen black
    Screen('FillRect',wid,[0 0 0]);
    
    glTranslatef(trh(depthplane),trv(depthplane),0);
    glScalef(sch(depthplane),scv(depthplane),1);
    % Paint the rectangle
    if ideal == 1
        Screen('DrawTexture',wid,ideal_tex(whichRect));
    else
        Screen('DrawTexture',wid,tex(whichRect));
    end
    
    
    if depthplane == 4;
        %Screen('FillRect',wid,[255 255 255],[599.5 200 600.5 300]);
        Screen('FillRect',wid,[255 255 255],[199.5 200 200.5 300]);
        %Screen('FillRect',wid,[255 255 255],[199.5 200 200.5 300]);
    end    
    if depthplane == 3;
        %Screen('FillRect',wid,[255 255 255],[599.5 300 600.5 400]);
        Screen('FillRect',wid,[255 255 255],[199.5 300 200.5 400]);
        %Screen('FillRect',wid,[255 255 255],[199.5 300 200.5 400]);
    end
    
    % cross showing calibration effect
    %Screen('FillRect',wid,[255 255 255],[300 200 301 400]);
    %Screen('FillRect',wid,[255 255 255],[200 300 400 301]);
    
    %Screen('FillRect',wid,[255 255 255],[500 200 501 400]);
    %Screen('FillRect',wid,[255 255 255],[400 300 600 301]);
    %Screen('FillRect',wid,[255 255 255],target{whichRect});
    % Flush the video memory, tell graphics card to draw it on screens.
    %if vernierAdjustment
    
    %end
    if mod(frameNum,4)==3
        Screen('FillRect',wid,[255 255 255],[700 500 800 600]);
    end
    Screen('Flip',wid);
    flipTimeStamp(frameNum)=GetSecs;
    
    % Handle keyboard input
    [a b c d]=KbCheck(-1);
    if a==1
        inputstr=KbName(c);
        if strcmp(inputstr,'ESCAPE') || strcmp(inputstr,'esc')
            % Abort if 'esc' is pressed.
            break;
        end
        
        if strcmp(inputstr,'RightArrow')
            ideal = 1;
            trh(3) = trh(3)-step; 
            if direction == 1
                step = step/2;
                direction = 0;
            end
        end
        if strcmp(inputstr,'LeftArrow')
            ideal = 0;
            trh(3) = trh(3)+step;
            if direction == 0
                step = step/2;
                direction = 1;
            end
        end
        
    end
    
    % Increase frame number
    frameNum=frameNum+1;
end

trh
sch

% End Psychtoolbox
Screen('CloseAll');

% A debugging item. Plot the time taken for each frame.
%{
renderDuration=flipTimeStamp-[renderStartAt flipTimeStamp(1:end-1)];
plot([0 length(renderDuration)],[1/180 1/180],'r--'); % reference value (1/180sec, time allocated for each frame)
hold on;
plot(renderDuration,'b-');
axis([0 length(renderDuration) 0 0.02]);
hold off;
%}
