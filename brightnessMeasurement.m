PsychImaging('PrepareConfiguration');
[wid wrect]=PsychImaging('OpenWindow',0,0,[],[],[],10);
[wid2 wrect2]=Screen('OpenWindow',1,0,[],[],[],10);
Screen('TextSize',wid,20);
%	screen-related parameters
colorMode='w';
rectSize=150;

useGammaTable = 1;

if useGammaTable
    %load('BF_params/BF_correctedLinearGammaNew.mat');
    load('BF_params/BF_correctedLinearGamma08_27.mat')
    origGamma=Screen('LoadNormalizedGammaTable', wid, correctedGammaNew{1});
    origGamma=Screen('LoadNormalizedGammaTable', wid2, correctedGammaNew{2});
    
    
else
    gammaRed = 2.2;
    gammaGreen = 2.2;
    gammaBlue = 2.2;
    rgb=0:255;
    gr = rgb.^(1/gammaRed);
    gr = gr/max(gr);
    gg = rgb.^(1/gammaGreen);
    gg = gg/max(gg);
    gb = rgb.^(1/gammaBlue);
    gb = gb/max(gb);
    glt(:,1) = gr;
    glt(:,2) = gg;
    glt(:,3) = gb; 
    origGamma=Screen('LoadNormalizedGammaTable', wid, glt);
    origGamma2=Screen('LoadNormalizedGammaTable', wid2, glt);
end

pValue=255;
tic;
tKeyPress=toc;
wIndex=0;

frameNum=0;
while(1)
    frameNum=frameNum+1;
    if strcmp(colorMode,'w')
        targetColor=uint8(pValue*[1 1 1]);
    elseif strcmp(colorMode,'r')
        targetColor=uint8(pValue*[1 0 0]);
    elseif strcmp(colorMode,'g')
        targetColor=uint8(pValue*[0 1 0]);
    elseif strcmp(colorMode,'b')
        targetColor=uint8(pValue*[0 0 1]);
    elseif strcmp(colorMode,'rb')
        targetColor=uint8(pValue*[1 0 1]);
    end
    Screen('SelectStereoDrawBuffer',wid,0);
    Screen('FillRect',wid,[0 0 0]);
    Screen('SelectStereoDrawBuffer',wid,1);
    Screen('FillRect',wid,[0 0 0]);
    Screen('SelectStereoDrawBuffer',wid,wIndex);
    Screen('FillRect',wid,targetColor,...
        [wrect(3)/2-rectSize/2 wrect(4)/2-rectSize/2 ...
        wrect(3)/2+rectSize/2 wrect(4)/2+rectSize/2]);
    grayIndex=pValue+1;
    onScreenMessage=['gray level: ' num2str(grayIndex)];
    Screen('DrawText',wid,onScreenMessage,100,100,[255 255 255]);
    Screen('Flip',wid,[],[],1);
    [a b c d]=KbCheck(-1);
    if a==1 && toc-tKeyPress>0.2
        tKeyPress=toc;
        iKeyIndex=find(c);
        strInputName=KbName(iKeyIndex);
        if iscell(strInputName)
            strInputName=strInputName{1};
        end

        switch strInputName
            case {'RightArrow','right'}
                pValue=pValue+0.1;
            case {'LeftArrow','left'}
                pValue=pValue-0.1;
            case {'UpArrow','up'}
                pValue=pValue+10;
            case {'DownArrow','down'}
                pValue=pValue-10;
            case {'ESCAPE'}
                break;
            case {'w','1!'}
                colorMode='w';
            case {'r','2@'}
                colorMode='r';
            case {'g','3#'}
                colorMode='g';
            case {'b','4$'}
                colorMode='b';
            case {'m','5%'}
                colorMode='rb';
            case {'0)'}
                pValue=0;
            case {'9('}
                pValue=255;
            case ',<'
                wIndex=0;
            case '.>'
                wIndex=1;
            case 'space'
                if strcmp(colorMode,'w')
                    colorMode='r';
                elseif strcmp(colorMode,'r')
                    colorMode='g';
                elseif strcmp(colorMode,'g')
                    colorMode='b';
                elseif strcmp(colorMode,'b')
                    colorMode='rb';
                elseif strcmp(colorMode,'rb')
                    colorMode='w';
                end
        end
        if pValue>255
            pValue=255;
        elseif pValue<0
            pValue=0;
        end
    end
end

Screen('LoadNormalizedGammaTable', wid, origGamma);
Screen('LoadNormalizedGammaTable', wid2, origGamma2);

Screen('CloseAll');