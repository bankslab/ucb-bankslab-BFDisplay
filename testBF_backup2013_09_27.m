function [] = testBF(geometryCalibration, gammaCalibration, vernierAdjustment)
% open windows in stereo mode 10: 2 monitors regarded as composing one
% stereo view (left eye view and right eye view)
stereoMode=10;
clear GL;
calibratingVernier=0;

AssertOpenGL;
InitializeMatlabOpenGL(0,0);

if stereoMode==10

    PsychImaging('PrepareConfiguration');  
    
    if geometryCalibration
        %geometry correction
        PsychImaging('AddTask', 'RightView','GeometryCorrection','BVLCalibdata_1_800_600_180hz_08122013_MB_RA_JK.mat',0,37,27);
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
        origGamma=Screen('LoadNormalizedGammaTable', wid, correctedGammaNew{1});
        origGamma=Screen('LoadNormalizedGammaTable', wid2, correctedGammaNew{2});
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
globalScale = 1;
 
target{1}=[wrect(3)/2-2*rectSize wrect(4)/2-0.5*rectSize ...
    wrect(3)/2-1*rectSize wrect(4)/2+0.5*rectSize];
target{2}=[wrect(3)/2-rectSize wrect(4)/2-0.5*rectSize ...
    wrect(3)/2 wrect(4)/2+0.5*rectSize];
target{3}=[wrect(3)/2 wrect(4)/2-0.5*rectSize ...
    wrect(3)/2+1*rectSize wrect(4)/2+0.5*rectSize];
target{4}=[wrect(3)/2+1*rectSize wrect(4)/2-0.5*rectSize ...
    wrect(3)/2+2*rectSize wrect(4)/2+0.5*rectSize];

test1_depth1 = imresize(uint8(255*hdrread('BF_texture_files/reflections/siemens_star/siemens_star_p1.hdr')), 0.5);
test1_depth2 = imresize(uint8(255*hdrread('BF_texture_files/reflections/siemens_star/siemens_star_p2.hdr')), 0.5);
test1_depth3 = imresize(uint8(255*hdrread('BF_texture_files/reflections/siemens_star/siemens_star_p3.hdr')), 0.5);
test1_depth4 = imresize(uint8(255*hdrread('BF_texture_files/reflections/siemens_star/siemens_star_p4.hdr')), 0.5);

test2_depth1 = imresize(uint8(255*hdrread('BF_texture_files/reflections/hdr/depths_p1.hdr')), 0.25);
test2_depth2 = imresize(uint8(255*hdrread('BF_texture_files/reflections/hdr/depths_p2.hdr')), 0.25);
test2_depth3 = imresize(uint8(255*hdrread('BF_texture_files/reflections/hdr/depths_p3.hdr')), 0.25);
test2_depth4 = imresize(uint8(255*hdrread('BF_texture_files/reflections/hdr/depths_p4.hdr')), 0.25);

%{
test3_depth1 = imresize(uint8(255*hdrread('BF_texture_files/reflections/hdr/matpreview_p1.hdr')), 0.25);
test3_depth2 = imresize(uint8(255*hdrread('BF_texture_files/reflections/hdr/matpreview_p2.hdr')), 0.25);
test3_depth3 = imresize(uint8(255*hdrread('BF_texture_files/reflections/hdr/matpreview_p3.hdr')), 0.25);
test3_depth4 = imresize(uint8(255*hdrread('BF_texture_files/reflections/hdr/matpreview_p4.hdr')), 0.25);

test4_depth1 = imresize(uint8(255*hdrread('BF_texture_files/reflections/hdr/mirror_p1.hdr')), 0.25);
test4_depth2 = imresize(uint8(255*hdrread('BF_texture_files/reflections/hdr/mirror_p2.hdr')), 0.25);
test4_depth3 = imresize(uint8(255*hdrread('BF_texture_files/reflections/hdr/mirror_p3.hdr')), 0.25);
test4_depth4 = imresize(uint8(255*hdrread('BF_texture_files/reflections/hdr/mirror_p4.hdr')), 0.25);

test5_depth1 = imresize(uint8(255*hdrread('BF_texture_files/reflections/hdr/spheres_p1.hdr')), 0.25);
test5_depth2 = imresize(uint8(255*hdrread('BF_texture_files/reflections/hdr/spheres_p2.hdr')), 0.25);
test5_depth3 = imresize(uint8(255*hdrread('BF_texture_files/reflections/hdr/spheres_p3.hdr')), 0.25);
test5_depth4 = imresize(uint8(255*hdrread('BF_texture_files/reflections/hdr/spheres_p4.hdr')), 0.25);

test6_depth1 = imresize(uint8(255*hdrread('BF_texture_files/reflections/hdr/spheres2_p1.hdr')), 0.25);
test6_depth2 = imresize(uint8(255*hdrread('BF_texture_files/reflections/hdr/spheres2_p2.hdr')), 0.25);
test6_depth3 = imresize(uint8(255*hdrread('BF_texture_files/reflections/hdr/spheres2_p3.hdr')), 0.25);
test6_depth4 = imresize(uint8(255*hdrread('BF_texture_files/reflections/hdr/spheres2_p4.hdr')), 0.25);

test3_depth1 = imresize(uint8(255*hdrread('BF_texture_files/reflections/hdr/spheres/blending_layers_1.hdr')), 0.25);
test3_depth2 = imresize(uint8(255*hdrread('BF_texture_files/reflections/hdr/spheres/blending_layers_2.hdr')), 0.25);
test3_depth3 = imresize(uint8(255*hdrread('BF_texture_files/reflections/hdr/spheres/blending_layers_3.hdr')), 0.25);
test3_depth4 = imresize(uint8(255*hdrread('BF_texture_files/reflections/hdr/spheres/blending_layers_4.hdr')), 0.25);

test4_depth1 = imresize(uint8(255*hdrread('BF_texture_files/reflections/hdr/spheres/optimized_layers_1.hdr')), 0.25);
test4_depth2 = imresize(uint8(255*hdrread('BF_texture_files/reflections/hdr/spheres/optimized_layers_2.hdr')), 0.25);
test4_depth3 = imresize(uint8(255*hdrread('BF_texture_files/reflections/hdr/spheres/optimized_layers_3.hdr')), 0.25);
test4_depth4 = imresize(uint8(255*hdrread('BF_texture_files/reflections/hdr/spheres/optimized_layers_4.hdr')), 0.25);

test5_depth1 = imresize(imread('BF_texture_files/reflections/hdr/spheres/input_focus_12.png'), 0.25);
test5_depth2 = zeros(8,8,3);
test5_depth3 = zeros(8,8,3);
test5_depth4 = zeros(8,8,3);
%}

prefix = 'BF_texture_files/reflections/hdr/'
sets = {'spheres' 'supels' 'supels2'};
currentSet = sets{1};
for i = 1:4
    optimized{1} = imresize(uint8(255*hdrread([prefix currentSet '/optimized_layers_' num2str(i) '.hdr'] )), 0.25);
    blending{1} = imresize(uint8(255*hdrread([prefix currentSet '/optimized_layers_' num2str(i) '.hdr'] )), 0.25);
end    

test6_depth1 = imresize(uint8(255*hdrread('BF_texture_files/reflections/hdr/spheres2_p1.hdr')), 0.25);
test6_depth2 = imresize(uint8(255*hdrread('BF_texture_files/reflections/hdr/spheres2_p2.hdr')), 0.25);
test6_depth3 = imresize(uint8(255*hdrread('BF_texture_files/reflections/hdr/spheres2_p3.hdr')), 0.25);
test6_depth4 = imresize(uint8(255*hdrread('BF_texture_files/reflections/hdr/spheres2_p4.hdr')), 0.25);


test7_depth1 = imresize(uint8(255*hdrread('BF_texture_files/reflections/hdr/supels_p1.hdr')), 0.25);
test7_depth2 = imresize(uint8(255*hdrread('BF_texture_files/reflections/hdr/supels_p2.hdr')), 0.25);
test7_depth3 = imresize(uint8(255*hdrread('BF_texture_files/reflections/hdr/supels_p3.hdr')), 0.25);
test7_depth4 = imresize(uint8(255*hdrread('BF_texture_files/reflections/hdr/supels_p4.hdr')), 0.25);

test8_depth1_r = uint8(255*hdrread('BF_texture_files/reflections/hinge_stereo800/hinge_right_800_p1.hdr'));
test8_depth2_r = uint8(255*hdrread('BF_texture_files/reflections/hinge_stereo800/hinge_right_800_p2.hdr'));
test8_depth3_r = uint8(255*hdrread('BF_texture_files/reflections/hinge_stereo800/hinge_right_800_p3.hdr'));
test8_depth4_r = uint8(255*hdrread('BF_texture_files/reflections/hinge_stereo800/hinge_right_800_p4.hdr'));

test8_depth1_l = uint8(255*hdrread('BF_texture_files/reflections/hinge_stereo800/hinge_left_800_p1.hdr'));
test8_depth2_l = uint8(255*hdrread('BF_texture_files/reflections/hinge_stereo800/hinge_left_800_p2.hdr'));
test8_depth3_l = uint8(255*hdrread('BF_texture_files/reflections/hinge_stereo800/hinge_left_800_p3.hdr'));
test8_depth4_l = uint8(255*hdrread('BF_texture_files/reflections/hinge_stereo800/hinge_left_800_p4.hdr'));

test9_depth1_l = imresize(uint8(255*hdrread('BF_texture_files/reflections/hinge_left_glasses.hdr')),1);
test9_depth2_l = zeros(8,8,3);
test9_depth3_l = zeros(8,8,3);
test9_depth4_l = zeros(8,8,3);

test9_depth1_r = imresize(uint8(255*hdrread('BF_texture_files/reflections/hinge_right_glasses.hdr')),1);
test9_depth2_r = zeros(8,8,3);
test9_depth3_r = zeros(8,8,3);
test9_depth4_r = zeros(8,8,3);

test0_depth1 = imresize(imread('BF_texture_files/reflections/faces_with_1_gap0.3ideal4.png'), 0.5);
test0_depth2 = imresize(imread('BF_texture_files/reflections/faces_with_1_gap0.3ideal3.png'), 0.5);
test0_depth3 = imresize(imread('BF_texture_files/reflections/faces_with_1_gap0.3ideal2.png'), 0.5);
test0_depth4 = imresize(imread('BF_texture_files/reflections/faces_with_1_gap0.3ideal1.png'), 0.5);

tex(1) = Screen('MakeTexture',wid,test0_depth1(:,:,:));
tex(2) = Screen('MakeTexture',wid,test0_depth2(:,:,:));
tex(3) = Screen('MakeTexture',wid,test0_depth3(:,:,:));
tex(4) = Screen('MakeTexture',wid,test0_depth4(:,:,:));


tex_l(1) = Screen('MakeTexture',wid,test8_depth1_l(:,:,:));
tex_l(2) = Screen('MakeTexture',wid,test8_depth2_l(:,:,:));
tex_l(3) = Screen('MakeTexture',wid,test8_depth3_l(:,:,:));
tex_l(4) = Screen('MakeTexture',wid,test8_depth4_l(:,:,:));

frameNum=1;
renderStartAt=GetSecs;
flipTimeStamp=[];


%50mm f/13 canon prime lens. Additional lenses 5.75 + 1.5,
trh = [-0.9375   -1.0938   -0.3125 0];
sch = [0.9250    0.9543    0.9734 1];
trv = [1.5625    0.9375    0.6738 0];
scv = [0.9250    0.9516    0.9719 1];

additionalScaleFactor = 0;

while(1)
    % Rendering part
    depthplane=mod(frameNum-1,4)+1;
    
    % Select left eye view
    Screen('SelectStereoDrawBuffer',wid,0);
    % Paint the entire screen black
    Screen('FillRect',wid,[0 0 0]);
    % Paint the rectangle
    
    
    whichEye = 1;
    
    glMatrixMode(GL.MODELVIEW);
    glLoadIdentity();
    glPushMatrix();
    
    
    % Paint the entier screen black
    Screen('FillRect',wid,[0 0 0]);
    
    
    % Paint the rectangle
    Screen('DrawTexture',wid,tex_l(depthplane));
    
    %Screen('FillRect',wid,[255 255 255],target{whichRect});
    if depthplane==3
        Screen('FillRect',wid,[255 255 255],[0 500 100 600]);
    else
        Screen('FillRect',wid,[0 0 0],[0 500 100 600]);
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
        glTranslatef(400,300,0);
        glScalef(sch(depthplane),scv(depthplane),1);
        glTranslatef(-400,-300,0);
    end
    
    glTranslatef(400,300,0);
    glScalef(globalScale,globalScale,1);
    glScalef((4-depthplane)*additionalScaleFactor+1,(4-depthplane)*additionalScaleFactor+1,1);
    glTranslatef(-400,-300,0);
    
    % Paint the rectangle
    Screen('DrawTexture',wid,tex(depthplane));
    %{
    if ideal == 1
        Screen('DrawText',wid,'separated',390,170,[255 255 255]);
    elseif ideal == 2
        Screen('DrawText',wid,'in between',390,170,[255 255 255]);
    else
        Screen('DrawText',wid,'occluding',390,170,[255 255 255]);
    end
    %}
    
    % Flush the video memory, tell graphics card to draw it on screens.
    
    glPopMatrix();
    if mod(frameNum,4)==3
        
        Screen('FillRect',wid,[255 255 255],[700 500 800 600]);
    else
        Screen('FillRect',wid,[0 0 0],[700 500 800 600]);
    end
    Screen('Flip',wid,[],[],1);
    %flipTimeStamp(frameNum)=GetSecs;
    
    % Handle keyboard input
    
    if mod(frameNum,10) == 0
        [a b c d]=KbCheck(-1);
        if a==1
            inputstr=KbName(c);
            if strcmp(inputstr,'ESCAPE') || strcmp(inputstr,'esc')
                % Abort if 'esc' is pressed.
                break;
            end
            
            iKeyIndex=find(c);
            strInputName=KbName(iKeyIndex);
            if iscell(strInputName)
                strInputName=strInputName{1};
            end
            if strcmp(strInputName,'v') 
                vernierAdjustment = 1 - vernierAdjustment;
            elseif strcmp(strInputName,'RightArrow')
                globalScale = globalScale+0.01;
            elseif strcmp(strInputName,'LeftArrow')
                globalScale = globalScale-0.01;
            elseif strcmp(strInputName,'UpArrow')
                additionalScaleFactor = additionalScaleFactor+0.001;
            elseif strcmp(strInputName,'DownArrow')
                additionalScaleFactor = additionalScaleFactor-0.001;
            else

                Screen('Close',tex(1));
                Screen('Close',tex(2));
                Screen('Close',tex(3));
                Screen('Close',tex(4));

                if strcmp(inputstr,'1!')
                    tex(1) = Screen('MakeTexture',wid,test1_depth1(:,:,:));
                    tex(2) = Screen('MakeTexture',wid,test1_depth2(:,:,:));
                    tex(3) = Screen('MakeTexture',wid,test1_depth3(:,:,:));
                    tex(4) = Screen('MakeTexture',wid,test1_depth4(:,:,:));
                elseif strcmp(inputstr,'2@')
                    tex(1) = Screen('MakeTexture',wid,test2_depth1(:,:,:));
                    tex(2) = Screen('MakeTexture',wid,test2_depth2(:,:,:));
                    tex(3) = Screen('MakeTexture',wid,test2_depth3(:,:,:));
                    tex(4) = Screen('MakeTexture',wid,test2_depth4(:,:,:));
                elseif strcmp(inputstr,'3#')
                    
                    
                    tex(1) = Screen('MakeTexture',wid,test3_depth1(:,:,:));
                    tex(2) = Screen('MakeTexture',wid,test3_depth2(:,:,:));
                    tex(3) = Screen('MakeTexture',wid,test3_depth3(:,:,:));
                    tex(4) = Screen('MakeTexture',wid,test3_depth4(:,:,:));
                elseif strcmp(inputstr,'4$')
                    tex(1) = Screen('MakeTexture',wid,test4_depth1(:,:,:));
                    tex(2) = Screen('MakeTexture',wid,test4_depth2(:,:,:));
                    tex(3) = Screen('MakeTexture',wid,test4_depth3(:,:,:));
                    tex(4) = Screen('MakeTexture',wid,test4_depth4(:,:,:));
                elseif strcmp(inputstr,'5%')
                    tex(1) = Screen('MakeTexture',wid,test5_depth1(:,:,:));
                    tex(2) = Screen('MakeTexture',wid,test5_depth2(:,:,:));
                    tex(3) = Screen('MakeTexture',wid,test5_depth3(:,:,:));
                    tex(4) = Screen('MakeTexture',wid,test5_depth4(:,:,:));
                elseif strcmp(inputstr,'6^')
                    tex(1) = Screen('MakeTexture',wid,test6_depth1(:,:,:));
                    tex(2) = Screen('MakeTexture',wid,test6_depth2(:,:,:));
                    tex(3) = Screen('MakeTexture',wid,test6_depth3(:,:,:));
                    tex(4) = Screen('MakeTexture',wid,test6_depth4(:,:,:));
                elseif strcmp(inputstr,'7&')
                    tex(1) = Screen('MakeTexture',wid,test7_depth1(:,:,:));
                    tex(2) = Screen('MakeTexture',wid,test7_depth2(:,:,:));
                    tex(3) = Screen('MakeTexture',wid,test7_depth3(:,:,:));
                    tex(4) = Screen('MakeTexture',wid,test7_depth4(:,:,:));
                elseif strcmp(inputstr,'8*')
                    tex(1) = Screen('MakeTexture',wid,test8_depth1_r(:,:,:));
                    tex(2) = Screen('MakeTexture',wid,test8_depth2_r(:,:,:));
                    tex(3) = Screen('MakeTexture',wid,test8_depth3_r(:,:,:));
                    tex(4) = Screen('MakeTexture',wid,test8_depth4_r(:,:,:));

                    tex_l(1) = Screen('MakeTexture',wid,test8_depth1_l(:,:,:));
                    tex_l(2) = Screen('MakeTexture',wid,test8_depth2_l(:,:,:));
                    tex_l(3) = Screen('MakeTexture',wid,test8_depth3_l(:,:,:));
                    tex_l(4) = Screen('MakeTexture',wid,test8_depth4_l(:,:,:));
                elseif strcmp(inputstr,'9(')
                    tex(1) = Screen('MakeTexture',wid,test9_depth1_r(:,:,:));
                    tex(2) = Screen('MakeTexture',wid,test9_depth2_r(:,:,:));
                    tex(3) = Screen('MakeTexture',wid,test9_depth3_r(:,:,:));
                    tex(4) = Screen('MakeTexture',wid,test9_depth4_r(:,:,:));

                    tex_l(1) = Screen('MakeTexture',wid,test9_depth1_l(:,:,:));
                    tex_l(2) = Screen('MakeTexture',wid,test9_depth2_l(:,:,:));
                    tex_l(3) = Screen('MakeTexture',wid,test9_depth3_l(:,:,:));
                    tex_l(4) = Screen('MakeTexture',wid,test9_depth4_l(:,:,:));
                else
                    tex(1) = Screen('MakeTexture',wid,test0_depth1(:,:,:));
                    tex(2) = Screen('MakeTexture',wid,test0_depth2(:,:,:));
                    tex(3) = Screen('MakeTexture',wid,test0_depth3(:,:,:));
                    tex(4) = Screen('MakeTexture',wid,test0_depth4(:,:,:));
                end
            end
        end
    end
    
    % Increase frame number
    frameNum=frameNum+1;
end


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

