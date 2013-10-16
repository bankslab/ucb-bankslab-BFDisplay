function [] = AdjustCameraVernier()
% open windows in stereo mode 10: 2 monitors regarded as composing one
% stereo view (left eye view and right eye view)
stereoMode=10;
clear GL;



if stereoMode==10

    PsychImaging('PrepareConfiguration');  
    
        %geometry correction
    PsychImaging('AddTask', 'RightView','GeometryCorrection','BVLCalibdata_1_800_600_180hz_08122013_MB_RA_JK.mat',0,37,27);
    PsychImaging('AddTask', 'LeftView','GeometryCorrection','BVLCalibdata_0_800_600_180hz_08142013_MB_JK.mat',0,37,27);
     
    %Screen('Preference', 'SkipSyncTests', 0);
    PsychImaging('AddTask', 'AllViews','FlipHorizontal');  
    PsychImaging('AddTask','General','FloatingPoint16Bit');
    PsychImaging('AddTask','General','UseFastOffscreenWindows');
    
    [wid wrect]=PsychImaging('OpenWindow',0,[],[],[],[],stereoMode, 8);
    [wid2 wrect2]=Screen('OpenWindow',1,0,[],[],[],stereoMode, 8);
    
    
    
    gammaCalibration = 1;
    if gammaCalibration
   
        %{
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
        %}
        
        load('BF_params/BF_correctedLinearGammaNew.mat');
        origGamma=Screen('LoadNormalizedGammaTable', wid, correctedGammaNew{2});
        origGamma=Screen('LoadNormalizedGammaTable', wid2, correctedGammaNew{1});

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

%AssertOpenGL;
%InitializeMatlabOpenGL(0,0);

ListenChar(2);
HideCursor(0);
HideCursor(1);

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
frameNum=1;
renderStartAt=GetSecs;
flipTimeStamp=[];


trh = [0 0 0 0];
sch = [1 1 1 1];
trv = [0 0 0 0];
scv = [1 1 1 1];

%50mm f/13 canon prime lens. Additional lenses 5.75 + 1.5,
trh = [-0.9375   -1.0938   -0.3125 0];
sch = [0.9250    0.9543    0.9734 1];
trv = [1.5625    0.9375    0.6738 0];
scv = [0.9250    0.9516    0.9719 1];

%Abdullah bitebar
trh = [1.0254    0.5859         0 0];
sch = [0.9375    0.9625    0.9805 1];
trv = [-2.8125   -1.7188   -0.1562 0];
scv = [0.9375    0.9625    0.9750 1];

%Rachel bitebar
trh = [2.5879    0.8984    0.3906 0];
sch = [0.9422    0.9688    0.9836 1];
trv = [4.7851    2.9687    1.4063 0];
scv = [0.9453    0.9656    0.9750 1];

testPlane = 3;%configuration plane 4 means furthest layer
stepTH = [5 5 5 5];
stepTV = [5 5 5 5];
stepSH = [5 5 5 5];
stepSV = [5 5 5 5];
%directions of hane for both translation and scale
directionTH = [0 0 0 0];
directionSH = [0 0 0 0];
directionTV = [0 0 0 0];
directionSV = [0 0 0 0];

tic;
tKeyPress=toc;

while(1)
    % Rendering part
    depthplane=mod(frameNum-1,4)+1;
    
    % Select left eye view
    whichEye = 0;
    Screen('SelectStereoDrawBuffer',wid,whichEye);
    % Paint the entire screen black
    Screen('FillRect',wid,[0 0 0]);
    % Paint the rectangle
    
    if depthplane==3
        Screen('FillRect',wid,[255 255 255],[0 500 100 600]);
    end
    
    % Select right eye view
    whichEye = 1;
    Screen('SelectStereoDrawBuffer',wid,whichEye);
    
    %apply observer's calibration parameters
    
    glMatrixMode(GL.MODELVIEW);
    glLoadIdentity();
    glPushMatrix();
    
    % Paint the entier screen black
    Screen('FillRect',wid,[0 0 0]);
    
    glTranslatef(trh(depthplane),trv(depthplane),0);
    glTranslatef(400,300,0);
    glScalef(sch(depthplane),scv(depthplane),1);
    glTranslatef(-400,-300,0);

    % Paint the rectangle
    onScreenMessage=['Current Test: ' num2str(testPlane)];
    Screen('DrawText',wid,onScreenMessage,100,100,[255 255 255]);
    
    left = 300;
    right = 500;
    top = 400;
    bottom = 200;
    cenx = 400;
    ceny = 300;
    size = 15;
    %{
    if depthplane == testPlane+1;
        %Screen('FillRect',wid,[255 255 255],[0 500 100 600]);
        
       
        Screen('FillRect',wid,[255 255 255],[left-0.5 top-size-0.5 left+0.5 top+0.5]);
        Screen('FillRect',wid,[255 255 255],[left-0.5 top-0.5 left+size+0.5 top+0.5]);
        Screen('FillRect',wid,[255 255 255],[left-0.5, bottom-0.5, left+size+0.5, bottom+0.5]);
        Screen('FillRect',wid,[255 255 255],[left-0.5, bottom-0.5, left+0.5, bottom+size+0.5]);
        Screen('FillRect',wid,[255 255 255],[cenx-size-0.5, ceny-0.5, cenx+size+0.5, ceny+0.5]);
        Screen('FillRect',wid,[255 255 255],[cenx-0.5, ceny-size-0.5, cenx+0.5, ceny+size+0.5]);
        Screen('FillRect',wid,[255 255 255],[right-size-0.5, top-0.5, right+0.5, top+0.5]);
        Screen('FillRect',wid,[255 255 255],[right-0.5, top-size-0.5, right+0.5, top+0.5]);
        Screen('FillRect',wid,[255 255 255],[right-size-0.5, bottom-0.5, right+0.5, bottom+0.5]);
        Screen('FillRect',wid,[255 255 255],[right-0.5, bottom-0.5, right+0.5, bottom+size+0.5]);
        
    end    
    if depthplane == testPlane;
        Screen('FillRect',wid,[255 255 255],[left+size-0.5, top-0.5, right-size+0.5, top+0.5]);
        Screen('FillRect',wid,[255 255 255],[left+size-0.5, bottom-0.5, right-size+0.5, bottom+0.5]);
        Screen('FillRect',wid,[255 255 255],[left-0.5, bottom+size-0.5, left+0.5, top-size+0.5]);
        Screen('FillRect',wid,[255 255 255],[right-0.5, bottom+size-0.5, right+0.5, top-size+0.5]);
        Screen('FillRect',wid,[255 255 255],[cenx-0.5, ceny+size-0.5, cenx+0.5,top+0.5 ]); 
        Screen('FillRect',wid,[255 255 255],[cenx-0.5, bottom-0.5, cenx+0.5, ceny-size+0.5]);
        Screen('FillRect',wid,[255 255 255],[left-0.5, ceny-0.5, cenx-size+0.5, ceny+0.5]);
        Screen('FillRect',wid,[255 255 255],[cenx+size-0.5, ceny-0.5, right+0.5, ceny+0.5]);
    end   
    %}
    
    if depthplane == 4;
        Screen('FillRect',wid,[255 255 255],[left-0.5 top-size-0.5 left+0.5 top+0.5]);
        Screen('FillRect',wid,[255 255 255],[left-0.5 top-0.5 left+size+0.5 top+0.5]);
        Screen('FillRect',wid,[255 255 255],[left-0.5, bottom-0.5, left+size+0.5, bottom+0.5]);
        Screen('FillRect',wid,[255 255 255],[left-0.5, bottom-0.5, left+0.5, bottom+size+0.5]);
        Screen('FillRect',wid,[255 255 255],[cenx-size-0.5, ceny-0.5, cenx+size+0.5, ceny+0.5]);
        Screen('FillRect',wid,[255 255 255],[cenx-0.5, ceny-size-0.5, cenx+0.5, ceny+size+0.5]);
        Screen('FillRect',wid,[255 255 255],[right-size-0.5, top-0.5, right+0.5, top+0.5]);
        Screen('FillRect',wid,[255 255 255],[right-0.5, top-size-0.5, right+0.5, top+0.5]);
        Screen('FillRect',wid,[255 255 255],[right-size-0.5, bottom-0.5, right+0.5, bottom+0.5]);
        Screen('FillRect',wid,[255 255 255],[right-0.5, bottom-0.5, right+0.5, bottom+size+0.5]);
        
        Screen('FillRect',wid,[255 255 255],[left+4*size-0.5, top-0.5, right-4*size+0.5, top+0.5]);
        Screen('FillRect',wid,[255 255 255],[left+4*size-0.5, bottom-0.5, right-4*size+0.5, bottom+0.5]);
        Screen('FillRect',wid,[255 255 255],[left-0.5, bottom+4*size-0.5, left+0.5, top-4*size+0.5]);
        Screen('FillRect',wid,[255 255 255],[right-0.5, bottom+4*size-0.5, right+0.5, top-4*size+0.5]);
        Screen('FillRect',wid,[255 255 255],[cenx-0.5, ceny+4*size-0.5, cenx+0.5,top+0.5 ]); 
        Screen('FillRect',wid,[255 255 255],[cenx-0.5, bottom-0.5, cenx+0.5, ceny-4*size+0.5]);
        Screen('FillRect',wid,[255 255 255],[left-0.5, ceny-0.5, cenx-4*size+0.5, ceny+0.5]);
        Screen('FillRect',wid,[255 255 255],[cenx+4*size-0.5, ceny-0.5, right+0.5, ceny+0.5]);
    
    end    
    if depthplane == 3;
        Screen('FillRect',wid,[255 255 255],[left+size-0.5, top-0.5, left+2*size-0.5, top+0.5]);
        Screen('FillRect',wid,[255 255 255],[right-2*size+0.5, top-0.5, right-size+0.5, top+0.5]);
        Screen('FillRect',wid,[255 255 255],[left+size-0.5, bottom-0.5, left+2*size+0.5, bottom+0.5]);
        Screen('FillRect',wid,[255 255 255],[right-2*size+0.5, bottom-0.5, right-size+0.5, bottom+0.5]);
        Screen('FillRect',wid,[255 255 255],[left-0.5, bottom+size-0.5, left+0.5, bottom+2*size-0.5]);
        Screen('FillRect',wid,[255 255 255],[left-0.5, top-2*size+0.5, left+0.5, top-size+0.5]);
        Screen('FillRect',wid,[255 255 255],[right-0.5, bottom+size-0.5, right+0.5, bottom+2*size-0.5]);
        Screen('FillRect',wid,[255 255 255],[right-0.5, top-2*size+0.5, right+0.5, top-size+0.5]);
        Screen('FillRect',wid,[255 255 255],[cenx-0.5, ceny+size-0.5, cenx+0.5,ceny+2*size-0.5 ]); 
        Screen('FillRect',wid,[255 255 255],[cenx-0.5, ceny-2*size+0.5, cenx+0.5, ceny-size+0.5]);
        Screen('FillRect',wid,[255 255 255],[cenx-2*size+0.5, ceny-0.5, cenx-size+0.5, ceny+0.5]);
        Screen('FillRect',wid,[255 255 255],[cenx+size-0.5, ceny-0.5, cenx+2*size-0.5, ceny+0.5]);
    end   
    if depthplane == 2;
        Screen('FillRect',wid,[255 255 255],[left+2*size-0.5, top-0.5, left+3*size-0.5, top+0.5]);
        Screen('FillRect',wid,[255 255 255],[right-3*size+0.5, top-0.5, right-2*size+0.5, top+0.5]);
        Screen('FillRect',wid,[255 255 255],[left+2*size-0.5, bottom-0.5, left+3*size+0.5, bottom+0.5]);
        Screen('FillRect',wid,[255 255 255],[right-3*size+0.5, bottom-0.5, right-2*size+0.5, bottom+0.5]);
        Screen('FillRect',wid,[255 255 255],[left-0.5, bottom+2*size-0.5, left+0.5, bottom+3*size-0.5]);
        Screen('FillRect',wid,[255 255 255],[left-0.5, top-3*size+0.5, left+0.5, top-2*size+0.5]);
        Screen('FillRect',wid,[255 255 255],[right-0.5, bottom+2*size-0.5, right+0.5, bottom+3*size-0.5]);
        Screen('FillRect',wid,[255 255 255],[right-0.5, top-3*size+0.5, right+0.5, top-2*size+0.5]);
        Screen('FillRect',wid,[255 255 255],[cenx-0.5, ceny+2*size-0.5, cenx+0.5,ceny+3*size-0.5 ]); 
        Screen('FillRect',wid,[255 255 255],[cenx-0.5, ceny-3*size+0.5, cenx+0.5, ceny-2*size+0.5]);
        Screen('FillRect',wid,[255 255 255],[cenx-3*size+0.5, ceny-0.5, cenx-2*size+0.5, ceny+0.5]);
        Screen('FillRect',wid,[255 255 255],[cenx+2*size-0.5, ceny-0.5, cenx+3*size-0.5, ceny+0.5]);
    end 
    if depthplane == 1;
        Screen('FillRect',wid,[255 255 255],[left+3*size-0.5, top-0.5, left+4*size-0.5, top+0.5]);
        Screen('FillRect',wid,[255 255 255],[right-4*size+0.5, top-0.5, right-3*size+0.5, top+0.5]);
        Screen('FillRect',wid,[255 255 255],[left+3*size-0.5, bottom-0.5, left+4*size+0.5, bottom+0.5]);
        Screen('FillRect',wid,[255 255 255],[right-4*size+0.5, bottom-0.5, right-3*size+0.5, bottom+0.5]);
        Screen('FillRect',wid,[255 255 255],[left-0.5, bottom+3*size-0.5, left+0.5, bottom+4*size-0.5]);
        Screen('FillRect',wid,[255 255 255],[left-0.5, top-4*size+0.5, left+0.5, top-3*size+0.5]);
        Screen('FillRect',wid,[255 255 255],[right-0.5, bottom+3*size-0.5, right+0.5, bottom+4*size-0.5]);
        Screen('FillRect',wid,[255 255 255],[right-0.5, top-4*size+0.5, right+0.5, top-3*size+0.5]);
        Screen('FillRect',wid,[255 255 255],[cenx-0.5, ceny+3*size-0.5, cenx+0.5,ceny+4*size-0.5 ]); 
        Screen('FillRect',wid,[255 255 255],[cenx-0.5, ceny-4*size+0.5, cenx+0.5, ceny-3*size+0.5]);
        Screen('FillRect',wid,[255 255 255],[cenx-4*size+0.5, ceny-0.5, cenx-3*size+0.5, ceny+0.5]);
        Screen('FillRect',wid,[255 255 255],[cenx+3*size-0.5, ceny-0.5, cenx+4*size-0.5, ceny+0.5]);
    end 
    
    
    glPopMatrix();
    if mod(frameNum,4)==3
        
        Screen('FillRect',wid,[255 255 255],[700 500 800 600]);
    end
    %Screen('Flip',wid);
    Screen('Flip',wid,[],[],1);
    
    if mod(frameNum,10) == 0
        % Handle keyboard input
        [a b c d]=KbCheck(-1);
        if a==1 && toc-tKeyPress>0.2
            tKeyPress=toc;
            iKeyIndex=find(c);
            strInputName=KbName(iKeyIndex);
            if iscell(strInputName)
                strInputName=strInputName{1};
            end

            switch strInputName
                case {'LeftArrow','left'}
                    trh(testPlane) = trh(testPlane)-stepTH(testPlane);
                    if(directionTH(testPlane) == 1)
                        stepTH(testPlane) = stepTH(testPlane)/2;
                    end
                    directionTH(testPlane) = -1;
                case {'RightArrow','right'}
                    trh(testPlane) = trh(testPlane)+stepTH(testPlane);
                    if(directionTH(testPlane) == -1)
                        stepTH(testPlane) = stepTH(testPlane)/2;
                    end
                    directionTH(testPlane) = 1;
                case {'DownArrow','down'}
                    trv(testPlane) = trv(testPlane)+stepTV(testPlane);
                    if(directionTV(testPlane) == -1)
                        stepTV(testPlane) = stepTV(testPlane)/2;
                    end
                    directionTV(testPlane) = 1;
                case {'UpArrow','up'}
                    trv(testPlane) = trv(testPlane)-stepTV(testPlane);
                    if(directionTV(testPlane) == 1)
                        stepTV(testPlane) = stepTV(testPlane)/2;
                    end
                    directionTV(testPlane) = -1;
                case {'ESCAPE'}
                    trh
                    trv
                    sch
                    scv
                    break;
                case {'w'}
                    scv(testPlane) = scv(testPlane)+stepSV(testPlane)/100;
                    if(directionSV(testPlane) == -1)
                        stepSV(testPlane) = stepSV(testPlane)/2;
                    end
                    directionSV(testPlane) = 1;
                case {'s'}
                    scv(testPlane) = scv(testPlane)-stepSV(testPlane)/100;
                    if(directionSH(testPlane) == 1)
                        stepSV(testPlane) = stepSV(testPlane)/2;
                    end
                    directionSV(testPlane) = -1;
                case {'d'}
                    sch(testPlane) = sch(testPlane)+stepSH(testPlane)/100;
                    if(directionSH(testPlane) == -1)
                        stepSH(testPlane) = stepSH(testPlane)/2;
                    end
                    directionSH(testPlane) = 1;
                case {'a'}
                    sch(testPlane) = sch(testPlane)-stepSH(testPlane)/100;
                    if(directionSH(testPlane) == 1)
                        stepSH(testPlane) = stepSH(testPlane)/2;
                    end
                    directionSH(testPlane) = -1;
                case {'1!'}
                    testPlane=1;
                case {'2@'}
                    testPlane=2;
                case {'3#'}
                    testPlane=3;
            end
        end
    end
    
    % Increase frame number
    frameNum=frameNum+1;
end

ListenChar(1);
ShowCursor(0);
ShowCursor(1);

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
