% This script displays the pre-loaded GL commands and waits for input
if makeFix == 1
    [a b c d] = KbCheck(-1);
end
if makeFix == 1
    current_layers = 1;
elseif motion
    current_layers = round(abs(mod(floor((frameNo-1)/12),28)-14)+1);
else
    current_layers = 8;
end
depthplane = depthplane + 1;
if depthplane > 4
    depthplane = 1;
end
depthtex_handle = depthplane;

if (GetSecs-presentationStartedAt)<presentationTime
    for whichEye = renderviews
        Screen('SelectStereoDrawBuffer', windowPtr, whichEye);
        Screen('BeginOpenGL', windowPtr);
        if whichEye == 1 | (whichEye == 0 & stereo == 1)
            glCallList(genlist_projection1(depthplane+whichEye*4));    %mandatory projection setup
            if static_mode  %optional mode for staic imagery
                glCallList(static_scene_disp_list1((current_layers-1)*8+depthplane+whichEye*4));
            end
        end
        Screen('EndOpenGL', windowPtr);

        if depthplane==3
            if whichEye==1
                Screen('FillRect', windowPtr, [255 255 255], [winRect(3)*.85, winRect(4)*.85, winRect(3) , winRect(4)]);
            else
                Screen('FillRect', windowPtr, [255 255  255], [0, winRect(4)*.85, winRect(3)*.15 , winRect(4)]);
            end
        else
            if whichEye==1
                Screen('FillRect', windowPtr, [0 0 0], [winRect(3)*.85, winRect(4)*.85, winRect(3) , winRect(4)]);
            else
                Screen('FillRect', windowPtr, [0 0 0], [0, winRect(4)*.85, winRect(3)*.15 , winRect(4)]);
            end
        end
    end

    %go to next frame
    frameNo = frameNo+1;
else
    for whichEye = renderviews
        Screen('SelectStereoDrawBuffer', windowPtr, whichEye);
        Screen('BeginOpenGL', windowPtr);
        if whichEye == 1 | (whichEye == 0 & stereo == 1)
            glCallList(genlist_projection1(depthplane+whichEye*4));    %mandatory projection setup
            if static_mode  %optional mode for staic imagery
                glCallList(static_scene_disp_list1((current_layers-1)*8+depthplane+whichEye*4));
            end
        end
        Screen('EndOpenGL', windowPtr);
        %draw response
        Screen('FillRect',windowPtr,[0 0 0]);
        if(depthplane == 4 & whichEye == 1 & ~isnan(response(responsePhase)))
            Screen('DrawText',windowPtr,[phaseMessage{responsePhase} num2str(response(responsePhase))], 300, 300, [255 255 255] );
        elseif (depthplane==4 & whichEye==1 & isnan(response(responsePhase)))
            %response=0;
            Screen('DrawText',windowPtr,[phaseMessage{responsePhase} ' -'], 300, 300, [255 255 255] );
        end
    end
    
    [a b c d]=KbCheck();
    if depthplane~=3 & a==1 
        responseTime = toc;
        if( responseTime-lastResponseTime > 0.3)
            inputstr=KbName(c);

            iKeyIndex=find(c);
            strInputName=KbName(iKeyIndex);
            if iscell(strInputName)
                strInputName=strInputName{1};
            end
            if strcmp(strInputName,'1')
                response(responsePhase) = 1;
            elseif strcmp(strInputName,'2')
                response(responsePhase) = 2;
            elseif strcmp(strInputName,'3')
                response(responsePhase) = 3;
            elseif strcmp(strInputName,'4')
                response(responsePhase) = 4;
            elseif strcmp(strInputName,'5')
                response(responsePhase) = 5;
            elseif strcmp(strInputName,'6')
                response(responsePhase) = 6;
            elseif strcmp(strInputName,'7')
                response(responsePhase) = 7;
            elseif strcmp(strInputName,'8')
                response(responsePhase) = 8;
            elseif strcmp(strInputName,'9')
                response(responsePhase) = 9;
            elseif strcmp(strInputName,'0')
                response(responsePhase) = 0;
            elseif strcmp(strInputName,'ESCAPE')
                escPressed=1;
            elseif strcmp(strInputName,'DELETE') % present the stimulus again
                presentationStartedAt=GetSecs;
            elseif strcmp(strInputName,'RightArrow')
                if(isnan(response(responsePhase)))
                    response(responsePhase)=0;
                end
                response(responsePhase) = response(responsePhase)+1;
            elseif strcmp(strInputName,'LeftArrow')
                if(isnan(response(responsePhase)))
                    response(responsePhase)=0;
                end
                response(responsePhase) = response(responsePhase)-1;
            elseif strcmp(strInputName,'UpArrow')
                if(isnan(response(responsePhase)))
                    response(responsePhase)=0;
                end
                response(responsePhase) = response(responsePhase)+1;
            elseif strcmp(strInputName,'DownArrow')
                if(isnan(response(responsePhase)))
                    response(responsePhase)=0;
                end
                response(responsePhase) = response(responsePhase)-1;
            end
            if ~isnan(response(responsePhase))
                response(responsePhase) = min(response(responsePhase),9);
                response(responsePhase) = max(response(responsePhase),0);
            end
            % space check is the last because it effects others
            if strcmp(strInputName,'space')
                if ~isnan(response(responsePhase))
                    responsePhase=responsePhase+1;
                end
            end
            lastResponseTime = responseTime;
        end
    end
end

% TRY REMOVING THIS LINE
Screen('Flip', windowPtr, [], 2, 1);
