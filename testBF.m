function [] = testBF(geometryCalibration, gammaCalibration, vernierAdjustment)
% open windows in stereo mode 10: 2 monitors regarded as composing one
% stereo view (left eye view and right eye view)
stereoMode=4;
clear GL;
calibratingVernier=0;

AssertOpenGL;
InitializeMatlabOpenGL(0,0);

if stereoMode==4

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
    %[wid2 wrect2]=Screen('OpenWindow',1,0,[],[],[],stereoMode, 8);
    
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
        %load('BF_params/BF_correctedLinearGammaNew.mat');
        %origGamma=Screen('LoadNormalizedGammaTable', wid, correctedGammaNew{1});
        %origGamma=Screen('LoadNormalizedGammaTable', wid2, correctedGammaNew{2});
        %load('BF_params/correctedLinearGamma_256steps_zeroOffset.mat');
        %origGamma=Screen('LoadNormalizedGammaTable', wid, correctedGamma{2});
        %origGamma=Screen('LoadNormalizedGammaTable', wid2, correctedGamma{2});
        BF_CLUT_L(:,1)=0:1:255;
        BF_CLUT_L(:,2)=0:1:255;
        BF_CLUT_L(:,3)=0:1:255;
        BF_CLUT_L= (BF_CLUT_L)/255;
        BF_CLUT_R=BF_CLUT_L;
        origGamma=Screen('LoadNormalizedGammaTable', wid, BF_CLUT_L);
   
        load('BF_params/correctedLinearGamma_256steps_zeroOffset.mat');
        for monitor = 1:2
            cGamma1{monitor} = correctedGamma{monitor}(:,1);
            cGamma2{monitor} = correctedGamma{monitor}(:,2);
            cGamma3{monitor} = correctedGamma{monitor}(:,3);
        end
    else
        BF_CLUT_L(:,1)=0:1:255;
        BF_CLUT_L(:,2)=0:1:255;
        BF_CLUT_L(:,3)=0:1:255;
        BF_CLUT_L= (BF_CLUT_L)/255;
        BF_CLUT_R=BF_CLUT_L;
        origGamma=Screen('LoadNormalizedGammaTable', wid, BF_CLUT_L);
        %origGamma=Screen('LoadNormalizedGammaTable', wid2, BF_CLUT_R);
    end
else
    [wid wrect]=Screen('OpenWindow',1,[],[],[],[],stereoMode,4);
end



global GL;

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

test1_depth1 = imresize((imread('BF_texture_files/reflections/siemens_star/siemens_star_p1.bmp')), 0.5);
test1_depth2 = imresize((imread('BF_texture_files/reflections/siemens_star/siemens_star_p2.bmp')), 0.5);
test1_depth3 = imresize((imread('BF_texture_files/reflections/siemens_star/siemens_star_p3.bmp')), 0.5);
test1_depth4 = imresize((imread('BF_texture_files/reflections/siemens_star/siemens_star_p4.bmp')), 0.5);

prefix = 'BF_texture_files/reflections/hdr/'
sets = {'spheres' 'supels' 'supels2' 'hinge2D' 'hinge0.8D'};
currentSet = 1;
algorithm = 1; %2 blending, 3 optimized 
algNames = {'single' 'blending' 'optimized'};
eyeNames = {'left' 'right'};

%how many pixels 20 degrees cover in the monitor / image size
imageScale = (800*tan(toRadians('degrees',20))/tan(toRadians('degrees',36.4)))/1024;
apertureOn = 0;

textures = cell(length(sets),length(algNames),8);
for j = 1:length(sets)
    for i = 1:4 %each depth plane 
        for eye = 0:1 %right or left 1 means right
            for a = 1:length(algNames) %algorithm single, blending, optimized
                fn = [prefix sets{j} '-stereo/' sets{j} '-' eyeNames{eye+1} '/' algNames{a} '_layers_' num2str(i) '.bmp'];
                if exist(fn,'file');
                    textures{j}{a}{eye*4+i} = imresize(((imread(fn ))), imageScale);
                else
                    textures{j}{a}{eye*4+i} = zeros(8,8,3);
                end
            end
        end
    end
end

test7_depth1_l = zeros(8,8,3);%imresize((double(imread('BF_texture_files/reflections/hinge_right_glasses.bmp')).^(2.2)),2);
test7_depth2_l = zeros(8,8,3);
test7_depth3_l = zeros(8,8,3);
test7_depth4_l = zeros(8,8,3);

test7_depth1_r = imresize(uint8(255*((double(imread('BF_texture_files/reflections/real_photo/input_focus_6.png'))/255).^2.2)),0.85);
test7_depth2_r = zeros(8,8,3);
test7_depth3_r = zeros(8,8,3);
test7_depth4_r = zeros(8,8,3);


test8_depth1_r = imresize(uint8(255*((double(imread('BF_texture_files/reflections/real_photo/optimized_layers_1.png'))/255).^2.2)),0.85);
test8_depth2_r = imresize(uint8(255*((double(imread('BF_texture_files/reflections/real_photo/optimized_layers_2.png'))/255).^2.2)),0.85);
test8_depth3_r = imresize(uint8(255*((double(imread('BF_texture_files/reflections/real_photo/optimized_layers_3.png'))/255).^2.2)),0.85);
test8_depth4_r = imresize(uint8(255*((double(imread('BF_texture_files/reflections/real_photo/optimized_layers_4.png'))/255).^2.2)),0.85);

test8_depth1_l = zeros(8,8,3);%(imread('BF_texture_files/reflections/hinge_stereo800/hinge_left_800_p1.bmp'));
test8_depth2_l = zeros(8,8,3);%(imread('BF_texture_files/reflections/hinge_stereo800/hinge_left_800_p2.bmp'));
test8_depth3_l = zeros(8,8,3);%(imread('BF_texture_files/reflections/hinge_stereo800/hinge_left_800_p3.bmp'));
test8_depth4_l = zeros(8,8,3);%(imread('BF_texture_files/reflections/hinge_stereo800/hinge_left_800_p4.bmp'));

[h,w,temp3] = size( test7_depth1_r);
test9_depth1_l = zeros(h,w,3);%imresize((imread('BF_texture_files/reflections/hinge_right_800.bmp')),1);
test9_depth2_l = zeros(h,w,3);
test9_depth3_l = zeros(h,w,3);
test9_depth4_l = zeros(h,w,3);

calibrationStimuli = zeros(h,w,3);

calibrationStimuli([round(h/3), round(h/2), round(2*h/3)],:,:) = 255;
calibrationStimuli(:,[round(w/3), round(w/2), round(2*w/3)],:) = 255;
test9_depth1_r = calibrationStimuli;%imresize((imread('BF_texture_files/reflections/hinge_right_800.bmp')),1);
test9_depth2_r = calibrationStimuli;
test9_depth3_r = calibrationStimuli;
test9_depth4_r = calibrationStimuli;


test0_depth1 = imresize(imread('BF_texture_files/reflections/faces_with_1_gap0.3ideal4.png'), 0.5);
test0_depth2 = imresize(imread('BF_texture_files/reflections/faces_with_1_gap0.3ideal3.png'), 0.5);
test0_depth3 = imresize(imread('BF_texture_files/reflections/faces_with_1_gap0.3ideal2.png'), 0.5);
test0_depth4 = imresize(imread('BF_texture_files/reflections/faces_with_1_gap0.3ideal1.png'), 0.5);

tex = double(4);
tex_l = double(4);
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

%Rachel bitebar
trh = [2.5879    0.8984    0.3906 0];
sch = [0.9422    0.9688    0.9836 1];
trv = [4.7851    2.9687    1.4063 0];
scv = [0.9453    0.9656    0.9750 1];

%Abdullah bitebar
trh = [1.0254    0.5859         0 0];
sch = [0.9375    0.9625    0.9805 1];
trv = [-2.8125   -1.7188   -0.1562 0];
scv = [0.9375    0.9625    0.9750 1];


additionalScaleFactor = 0;
%aperture(:,:,1) = generateAperture(20,0.05,1);
%aperture(:,:,2) = generateAperture(20,0.05,1);
%aperture(:,:,3) = generateAperture(20,0.05,1);
function [] = setLayers(fname)
    load(fname);
    
    
    
    
    for ind = 1:4
        Screen('Close',tex(ind));
        Screen('Close',tex_l(ind));
        
            
        % upside down compensation
        %hdr(550:-1:51,101:700,:) = uint8(double(layers{eye*4+plane}).*generateAperture(18,2.6,2,eye));
        hdr = double(layers{ind+4});

        % Implement Gamma Correction

        hdr1 = uint8(255*cGamma1{2}(hdr(:,:,1)+1));
        hdr2 = uint8(255*cGamma2{2}(hdr(:,:,2)+1));
        hdr3 = uint8(255*cGamma3{2}(hdr(:,:,3)+1));

        hdr(:,:,1) = hdr1;
        hdr(:,:,2) = hdr2;
        hdr(:,:,3) = hdr3;
        
        tex(ind) = Screen('MakeTexture',wid,uint8(hdr));
        
        hdr = double(layers{ind});

        % Implement Gamma Correction

        hdr1 = uint8(255*cGamma1{1}(hdr(:,:,1)+1));
        hdr2 = uint8(255*cGamma2{1}(hdr(:,:,2)+1));
        hdr3 = uint8(255*cGamma3{1}(hdr(:,:,3)+1));

        hdr(:,:,1) = hdr1;
        hdr(:,:,2) = hdr2;
        hdr(:,:,3) = hdr3;
        
        tex_l(ind) = Screen('MakeTexture',wid,uint8(hdr));
    end    
end
function [] = setTextures()
    
    for i = 1:4
        Screen('Close',tex(i));
        Screen('Close',tex_l(i));
    end
    
    for i = 1:4
        if apertureOn
            [h w d] = size(textures{currentSet}{algorithm}{1*4+i}(:,:,:));
            %taperture = imresize(aperture,[h w]);
            % burada kaldim abdullah
            tex(i) = Screen('MakeTexture',wid,uint8(double(textures{currentSet}{algorithm}{1*4+i}(:,:,:))));
            tex_l(i) = Screen('MakeTexture',wid,uint8(double(textures{currentSet}{algorithm}{0*4+i}(:,:,:))));
        else
            tex(i) = Screen('MakeTexture',wid,textures{currentSet}{algorithm}{1*4+i}(:,:,:));
            tex_l(i) = Screen('MakeTexture',wid,textures{currentSet}{algorithm}{0*4+i}(:,:,:));
        end   
    end 
end

while(1)
    % Rendering part
    depthplane=mod(frameNum-1,4)+1;
    eye = 0;
    
    % Select left eye view
    Screen('SelectStereoDrawBuffer',wid,eye);
    % Paint the entire screen black
    Screen('FillRect',wid,[0 0 0]);
    % Paint the rectangle
    
    glMatrixMode(GL.MODELVIEW);
    glLoadIdentity();
    glPushMatrix();
    
    
    % Paint the entier screen black
    Screen('FillRect',wid,[0 0 0]);
    
    glTranslatef(400,300,0);
    glScalef(globalScale,globalScale,1);
    glScalef((4-depthplane)*additionalScaleFactor+1,(4-depthplane)*additionalScaleFactor+1,1);
    glTranslatef(-400,-300,0);
    
    % Paint the rectangle
    Screen('DrawTexture',wid,tex_l(depthplane));
    glPopMatrix();
    
    %Screen('FillRect',wid,[255 255 255],target{whichRect});
    if depthplane==3
        Screen('FillRect',wid,[255 255 255],[0 500 100 600]);
    else
        Screen('FillRect',wid,[0 0 0],[0 500 100 600]);
    end
    
    
    % Select right eye view
    eye=1;
    Screen('SelectStereoDrawBuffer',wid,eye);
    
    %apply observer's calibration parameters

    
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
            elseif strcmp(strInputName,'a') 
                apertureOn = 1 - apertureOn;
                setTextures;
            elseif strcmp(strInputName,'RightArrow')
                globalScale = globalScale+0.01;
            elseif strcmp(strInputName,'LeftArrow')
                globalScale = globalScale-0.01;
            elseif strcmp(strInputName,'UpArrow')
                additionalScaleFactor = additionalScaleFactor+0.001;
            elseif strcmp(strInputName,'DownArrow')
                additionalScaleFactor = additionalScaleFactor-0.001;
            else

                

                if strcmp(strInputName,'space') 
                    algorithm = mod(algorithm,3)+1;
                    setTextures;
                elseif strcmp(inputstr,'1!')
                    Screen('Close',tex(1));
                    Screen('Close',tex(2));
                    Screen('Close',tex(3));
                    Screen('Close',tex(4));
                    tex(1) = Screen('MakeTexture',wid,test1_depth1(:,:,:));
                    tex(2) = Screen('MakeTexture',wid,zeros(600,800,3));
                    tex(3) = Screen('MakeTexture',wid,zeros(600,800,3));
                    tex(4) = Screen('MakeTexture',wid,zeros(600,800,3));
                    Screen('Close',tex_l(1));
                    Screen('Close',tex_l(2));
                    Screen('Close',tex_l(3));
                    Screen('Close',tex_l(4));
                    tex_l(1) = Screen('MakeTexture',wid,test1_depth1(:,:,:));
                    tex_l(2) = Screen('MakeTexture',wid,zeros(600,800,3));
                    tex_l(3) = Screen('MakeTexture',wid,zeros(600,800,3));
                    tex_l(4) = Screen('MakeTexture',wid,zeros(600,800,3));
                    setLayers('BF_texture_files/optimizer/cardboard/0.061/optimization/optimization_trial_1.mat');
                    
                elseif strcmp(inputstr,'2@')
                    Screen('Close',tex(1));
                    Screen('Close',tex(2));
                    Screen('Close',tex(3));
                    Screen('Close',tex(4));
                    tex(1) = Screen('MakeTexture',wid,zeros(600,800,3));
                    tex(2) = Screen('MakeTexture',wid,test1_depth2(:,:,:));
                    tex(3) = Screen('MakeTexture',wid,zeros(600,800,3));
                    tex(4) = Screen('MakeTexture',wid,zeros(600,800,3));
                    Screen('Close',tex_l(1));
                    Screen('Close',tex_l(2));
                    Screen('Close',tex_l(3));
                    Screen('Close',tex_l(4));
                    tex_l(1) = Screen('MakeTexture',wid,zeros(600,800,3));
                    tex_l(2) = Screen('MakeTexture',wid,test1_depth2(:,:,:));
                    tex_l(3) = Screen('MakeTexture',wid,zeros(600,800,3));
                    tex_l(4) = Screen('MakeTexture',wid,zeros(600,800,3));
                    %currentSet = 1; 
                    %setTextures();
                    
                    setLayers('BF_texture_files/optimizer/cardboard/0.061/optimization/optimization_trial_0.mat');
                elseif strcmp(inputstr,'3#')
                    Screen('Close',tex(1));
                    Screen('Close',tex(2));
                    Screen('Close',tex(3));
                    Screen('Close',tex(4));
                    tex(1) = Screen('MakeTexture',wid,zeros(600,800,3));
                    tex(2) = Screen('MakeTexture',wid,zeros(600,800,3));
                    tex(3) = Screen('MakeTexture',wid,test1_depth3(:,:,:));
                    tex(4) = Screen('MakeTexture',wid,zeros(600,800,3));
                    Screen('Close',tex_l(1));
                    Screen('Close',tex_l(2));
                    Screen('Close',tex_l(3));
                    Screen('Close',tex_l(4));
                    tex_l(1) = Screen('MakeTexture',wid,zeros(600,800,3));
                    tex_l(2) = Screen('MakeTexture',wid,zeros(600,800,3));
                    tex_l(3) = Screen('MakeTexture',wid,test1_depth3(:,:,:));
                    tex_l(4) = Screen('MakeTexture',wid,zeros(600,800,3));
                    %currentSet = 2; 
                    %setTextures();
                    setLayers('BF_texture_files/optimizer/cardboard/0.061/blending/blending_trial_1.mat');
                elseif strcmp(inputstr,'4$')
                    Screen('Close',tex(1));
                    Screen('Close',tex(2));
                    Screen('Close',tex(3));
                    Screen('Close',tex(4));
                    tex(1) = Screen('MakeTexture',wid,zeros(600,800,3));
                    tex(2) = Screen('MakeTexture',wid,zeros(600,800,3));
                    tex(3) = Screen('MakeTexture',wid,zeros(600,800,3));
                    tex(4) = Screen('MakeTexture',wid,test1_depth4(:,:,:));
                    Screen('Close',tex_l(1));
                    Screen('Close',tex_l(2));
                    Screen('Close',tex_l(3));
                    Screen('Close',tex_l(4));
                    tex_l(1) = Screen('MakeTexture',wid,zeros(600,800,3));
                    tex_l(2) = Screen('MakeTexture',wid,zeros(600,800,3));
                    tex_l(3) = Screen('MakeTexture',wid,zeros(600,800,3));
                    tex_l(4) = Screen('MakeTexture',wid,test1_depth4(:,:,:));
                    %currentSet = 3; 
                    %setTextures();
                    setLayers('BF_texture_files/optimizer/cardboard/0.061/blending/blending_trial_0.mat');
                elseif strcmp(inputstr,'5%')
                    setLayers('BF_texture_files/optimizer/cardboard/0.061/optimization/optimization_trial2_1.mat');
                    
                    %currentSet = 4; 
                    %setTextures();
                elseif strcmp(inputstr,'6^')
                    setLayers('BF_texture_files/optimizer/cardboard/0.061/optimization/optimization_trial2_0.mat');
                    
                    %currentSet = 5; 
                    %setTextures();
                elseif strcmp(inputstr,'7&')
                    Screen('Close',tex(1));
                    Screen('Close',tex(2));
                    Screen('Close',tex(3));
                    Screen('Close',tex(4));
                    Screen('Close',tex_l(1));
                    Screen('Close',tex_l(2));
                    Screen('Close',tex_l(3));
                    Screen('Close',tex_l(4));
                    tex(1) = Screen('MakeTexture',wid,test7_depth1_r(:,:,:));
                    tex(2) = Screen('MakeTexture',wid,test7_depth2_r(:,:,:));
                    tex(3) = Screen('MakeTexture',wid,test7_depth3_r(:,:,:));
                    tex(4) = Screen('MakeTexture',wid,test7_depth4_r(:,:,:));

                
                    tex_l(1) = Screen('MakeTexture',wid,test7_depth1_l(:,:,:));
                    tex_l(2) = Screen('MakeTexture',wid,test7_depth2_l(:,:,:));
                    tex_l(3) = Screen('MakeTexture',wid,test7_depth3_l(:,:,:));
                    tex_l(4) = Screen('MakeTexture',wid,test7_depth4_l(:,:,:));
                    setLayers('BF_texture_files/optimizer/cardboard/0.061/blending/blending_trial2_1.mat');
                    
                elseif strcmp(inputstr,'8*')
                    Screen('Close',tex(1));
                    Screen('Close',tex(2));
                    Screen('Close',tex(3));
                    Screen('Close',tex(4));
                    Screen('Close',tex_l(1));
                    Screen('Close',tex_l(2));
                    Screen('Close',tex_l(3));
                    Screen('Close',tex_l(4));
                    tex(1) = Screen('MakeTexture',wid,test8_depth1_r(:,:,:));
                    tex(2) = Screen('MakeTexture',wid,test8_depth2_r(:,:,:));
                    tex(3) = Screen('MakeTexture',wid,test8_depth3_r(:,:,:));
                    tex(4) = Screen('MakeTexture',wid,test8_depth4_r(:,:,:));

                    tex_l(1) = Screen('MakeTexture',wid,test8_depth1_l(:,:,:));
                    tex_l(2) = Screen('MakeTexture',wid,test8_depth2_l(:,:,:));
                    tex_l(3) = Screen('MakeTexture',wid,test8_depth3_l(:,:,:));
                    tex_l(4) = Screen('MakeTexture',wid,test8_depth4_l(:,:,:));
                    setLayers('BF_texture_files/optimizer/cardboard/0.061/blending/blending_trial2_0.mat');
                elseif strcmp(inputstr,'9(')
                    Screen('Close',tex(1));
                    Screen('Close',tex(2));
                    Screen('Close',tex(3));
                    Screen('Close',tex(4));
                    Screen('Close',tex_l(1));
                    Screen('Close',tex_l(2));
                    Screen('Close',tex_l(3));
                    Screen('Close',tex_l(4));
                    tex(1) = Screen('MakeTexture',wid,test9_depth1_r(:,:,:));
                    tex(2) = Screen('MakeTexture',wid,test9_depth2_r(:,:,:));
                    tex(3) = Screen('MakeTexture',wid,test9_depth3_r(:,:,:));
                    tex(4) = Screen('MakeTexture',wid,test9_depth4_r(:,:,:));
                    
                    tex_l(1) = Screen('MakeTexture',wid,test9_depth1_l(:,105:end,:));
                    tex_l(2) = Screen('MakeTexture',wid,test9_depth2_l(:,:,:));
                    tex_l(3) = Screen('MakeTexture',wid,test9_depth3_l(:,:,:));
                    tex_l(4) = Screen('MakeTexture',wid,test9_depth4_l(:,:,:));
                else
                    Screen('Close',tex(1));
                    Screen('Close',tex(2));
                    Screen('Close',tex(3));
                    Screen('Close',tex(4));
                    tex(1) = Screen('MakeTexture',wid,test0_depth1(:,1:end-105,:));
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
end
