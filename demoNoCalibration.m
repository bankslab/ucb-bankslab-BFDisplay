drawFrameDuration=0;
stereoMode=10;
% clear GL;
% AssertOpenGL;
% InitializeMatlabOpenGL(0,0);

% open windows in stereo mode 10: 2 monitors regarded as composing one
% stereo view (left eye view and right eye view)

if stereoMode==4 || stereoMode==5
    [wid wrect]=Screen('OpenWindow',1,0,[],[],[],stereoMode);
elseif stereoMode==10
    PsychImaging('PrepareConfiguration');
    PsychImaging('AddTask','AllViews','FlipHorizontal');
    [wid wrect]=PsychImaging('OpenWindow',0,0,[],[],[],stereoMode);
    [wid2 wrect2]=Screen('OpenWindow',1,0,[],[],[],stereoMode);
end

% This code displays 4 rectangles in time-sequential manner.
% Define coordinate of the 4 rectangles.
% Coordinate format for Screen command is: [fromH fromV toH toV]
dioptricDistanceOffset=1;
focalDistances.diopters=[0 0.6 1.2 1.8]+dioptricDistanceOffset;
rectSize=80; % size at 1 meter
vanishingPointH=200; % horizontal displacement of vanishing point, ON THE SCREEN
displacementH=-150; % horizontal displacement at 1 meter
pixelVisualAngle=2/60; % assumption on pixel visual angle (1.4arcmin)
IPD=0.062; % assumption on IPD (62mm)

focalDistances.meters=1./focalDistances.diopters;
target=[];
for distance_i=1:length(focalDistances.meters)
    target{distance_i}.distance=focalDistances.meters(distance_i);
    target{distance_i}.size=rectSize/target{distance_i}.distance;
    target{distance_i}.displacementH=vanishingPointH+...
        displacementH*(1/target{distance_i}.distance-dioptricDistanceOffset);
    target{distance_i}.cyclopianRect=...
        [wrect(3)/2+target{distance_i}.displacementH-target{distance_i}.size/2 ...
        wrect(4)/2-target{distance_i}.size/2 ...
        wrect(3)/2+target{distance_i}.displacementH+target{distance_i}.size/2 ...
        wrect(4)/2+target{distance_i}.size/2];
    target{distance_i}.vergenceAngle=2*atand(0.5*IPD*(1/target{distance_i}.distance-dioptricDistanceOffset));
    target{distance_i}.disparity=target{distance_i}.vergenceAngle/pixelVisualAngle;
    target{distance_i}.leftRect=round(target{distance_i}.cyclopianRect...
        +target{distance_i}.disparity*[0.5 0 0.5 0]);
    target{distance_i}.rightRect=round(target{distance_i}.cyclopianRect...
        -target{distance_i}.disparity*[0.5 0 0.5 0]);
%     target{distance_i} % for debugging
end

frameNum=1;
renderStartAt=GetSecs;
flipTimeStamp=[];
simulatedComputationTime=0.002;
% targetImg=imread('BF_texture_files/cal_logo.bmp');
targetImg=imread('BF_texture_files/snellen.bmp');
targetImg(:,:,3)=0; % leave yellow
targetTx=Screen('MakeTexture',wid,targetImg);

while(1)
    % Rendering part
    whichRect=mod(frameNum-1,4)+1;
    whichFocalPlane=mod(frameNum-1,4)+1;

    % Select left eye view
    Screen('SelectStereoDrawBuffer',wid,0);
    % Paint the rectangle
    [srcFactorOld destFactorOld]=Screen('BlendFunction', wid, GL_ONE, GL_ZERO);
    Screen('DrawTexture',wid,targetTx,[],target{whichFocalPlane}.leftRect);
%     Screen('FillRect',wid,[255 0 0],target{whichFocalPlane}.leftRect);
%     Screen('BlendFunction', wid, GL_ONE, GL_ZERO);
    if whichFocalPlane<4 % occlusion, if not the closest plane
        Screen('FillRect',wid,[0 0 0],target{whichFocalPlane+1}.leftRect);
    end
    Screen('BlendFunction', wid, srcFactorOld, destFactorOld);
    if whichFocalPlane==3
        Screen('FillRect',wid,[255 255 255],[0 500 100 600]);
    end
    
    % Select right eye view
    Screen('SelectStereoDrawBuffer',wid,1);
    % Paint the rectangle
%     [srcFactorOld destFactorOld]=Screen('BlendFunction', wid, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    Screen('DrawTexture',wid,targetTx,[],target{whichFocalPlane}.rightRect);
%     Screen('FillRect',wid,[255 0 0],target{whichFocalPlane}.rightRect);
%     Screen('BlendFunction', wid, GL_ONE, GL_ZERO);
    if whichFocalPlane<4 % occlusion, if not the closest plane
        Screen('FillRect',wid,[0 0 0],target{whichFocalPlane+1}.rightRect);
    end
    Screen('BlendFunction', wid, srcFactorOld, destFactorOld);
    if whichFocalPlane==3
        Screen('FillRect',wid,[255 255 255],[700 500 800 600]);
    end
%     pause(simulatedComputationTime);
    % Flush the video memory, tell graphics card to draw it on screens.
    Screen('Flip',wid,[],[],1);
    flipTimeStamp(frameNum)=GetSecs;
    
    % Handle keyboard input
    [a b c d]=KbCheck(-1);
    if a==1
        inputstr=KbName(c);
        if strcmp(inputstr,'ESCAPE') || strcmp(inputstr,'esc')
            % Abort if 'esc' is pressed.
            break;
        end
    end
    
    % Increase frame number
    frameNum=frameNum+1;
end
% End Psychtoolbox
Screen('CloseAll');

% A debugging item. Plot the time taken for each frame.
if drawFrameDuration==1
    renderDuration=flipTimeStamp-[renderStartAt flipTimeStamp(1:end-1)];
    plot([0 length(renderDuration)],[1/180 1/180],'r--'); % reference value (1/180sec, time allocated for each frame)
    hold on;
    plot(renderDuration,'b-');
    axis([0 length(renderDuration) 0 0.02]);
    hold off;
end
