stereoMode=10;

if stereoMode==10
    PsychImaging('PrepareConfiguration');
    PsychImaging('AddTask','AllViews','FlipHorizontal');
    load([pwd '/BF_params/BF_CLUTlookuptables.mat']);
    noGammaAdjustment = 0;
    if noGammaAdjustment
        BF_CLUT_L(:,1)=0:1:255;
        BF_CLUT_L(:,2)=0:1:255;
        BF_CLUT_L(:,3)=0:1:255;
        BF_CLUT_R=BF_CLUT_L;
    end
    BF_CLUT_L= (BF_CLUT_L)/255;
    BF_CLUT_R=BF_CLUT_R/255;
    load('gammalookuptable.mat');
    [wid wrect]=PsychImaging('OpenWindow',0,[],[],[],[],stereoMode);
    [wid2 wrect2]=Screen('OpenWindow',1,[],[],[],[],stereoMode);
    
	origGamma=Screen('LoadNormalizedGammaTable', wid, BF_CLUT_L);
	origGamma=Screen('LoadNormalizedGammaTable', wid2, gammaLookupTable);
else
    [wid wrect]=Screen('OpenWindow',1,[],[],[],[],stereoMode);
end


%this code draws two circles for calibrating depth position of the camera

x = [400 600];
y = [300 300];
stepSize = 0.1;
fid = fopen('circles.txt', 'r');
if fid < 0, 
    disp('Cannot open file, using default values'); 
else
    v = textscan(fid,'%f %f %f %f');
    x(1) = v{1};
    y(1) = v{2};
    x(2) = v{3};
    y(2) = v{4};
    fclose(fid);
end

currentCircle = 1;

frameNum=1;
renderStartAt=GetSecs;
flipTimeStamp=[];
while(1)
    % Rendering part
    currentPlane=mod(frameNum-1,4)+1;
    
    % Select left eye view
    Screen('SelectStereoDrawBuffer',wid,0);
    % Paint the entier screen black
    Screen('FillRect',wid,[0 0 0]);
    % Paint the rectangle
    Screen('FillRect',wid,[255 255 255],[100 0 800 600]);
    
    if currentPlane==3
        Screen('FillRect',wid,[255 255 255],[0 500 100 600]);
    end
    
    % Select right eye view
    Screen('SelectStereoDrawBuffer',wid,1);
    % Paint the entier screen black
    Screen('FillRect',wid,[0 0 0]);
    
    grayLevel = 252;
    Screen('FillRect',wid,[grayLevel/4 grayLevel/4 grayLevel/4],[0 0 230 600]);
    if(currentPlane > 2 )
        Screen('FillRect',wid,[grayLevel/2 grayLevel/2 grayLevel/2],[230 0 470 600]);
    end
    
    %only render to the furthest plane
    if(currentPlane == 4 )
        
        Screen('FillRect',wid,[grayLevel grayLevel grayLevel],[470 0 700 600]);
        %mark current circle
        Screen('FrameRect',wid,[0 0 0],[x(currentCircle)-15,y(currentCircle)-15,x(currentCircle)+15,y(currentCircle)+15]);
        
        %draw first circle
        Screen('FillOval',wid,[0 0 0],[x(1)-10,y(1)-10,x(1)+10,y(1)+10]);
        Screen('FillOval',wid,[255 255 255],[x(1)-3,y(1)-3,x(1)+3,y(1)+3]);
        
        %draw second circle
        Screen('FillOval',wid,[0 0 0],[x(2)-10,y(2)-10,x(2)+10,y(2)+10]);
        Screen('FillOval',wid,[255 255 255],[x(2)-3,y(2)-3,x(2)+3,y(2)+3]);
        
    end
    
    
    if currentPlane==3
        Screen('FillRect',wid,[255 255 255],[700 500 800 600]);
    end
    
    % Flush the video memory, tell graphics card to draw it on screens.
    Screen('Flip',wid);
    flipTimeStamp(frameNum)=GetSecs;
    
    % Handle keyboard input
    [a b c d]=KbCheck(-1);
    if a==1
        inputstr=KbName(c);
        if strcmp(inputstr,'ESCAPE') || strcmp(inputstr,'esc')
            fid = fopen('circles.txt', 'w');
            if fid < 0, 
                disp('Cannot open file for writing'); 
            else
                fprintf(fid,'%f %f %f %f', x(1), y(1), x(2), y(2));
                fclose(fid);
            end
            % Abort if 'esc' is pressed.
            break;
        elseif strcmp(inputstr,'1!') %change the moving circle
            currentCircle = 1;
        elseif strcmp(inputstr,'2@')
            currentCircle = 2;
        elseif strcmp(inputstr,'RightArrow') %move the currently movable circle
            x(currentCircle) = x(currentCircle)+stepSize;
        elseif strcmp(inputstr,'LeftArrow')
            x(currentCircle) = x(currentCircle)-stepSize;
        elseif strcmp(inputstr,'UpArrow') %move the currently movable circle
            y(currentCircle) = y(currentCircle)-stepSize;
        elseif strcmp(inputstr,'DownArrow')
            y(currentCircle) = y(currentCircle)+stepSize;
        end
    end
    
    % Increase frame number
    frameNum=frameNum+1;
end
% End Psychtoolbox
Screen('CloseAll');

