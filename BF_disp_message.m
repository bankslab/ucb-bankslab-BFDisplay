% This script will display a message to the user

for whichEye=[0 1]
    Screen('SelectStereoDrawBuffer', windowPtr, whichEye);
    glClear();
end
Screen('Flip', windowPtr, [], 2, 1);

displaymessage = 1;
depthplane = 0;
while (displaymessage==1)
    depthplane = depthplane + 1;
    if depthplane > 4
        depthplane = 1;
    end
    depthtex_handle = depthplane;
    
    for whichEye=1
        Screen('SelectStereoDrawBuffer', windowPtr, whichEye);
        glClear;
        
        % Display white squares
        if depthplane==3
            if whichEye==1
                Screen('FillRect', windowPtr, [255 255 255], [winRect(3)*.85, winRect(4)*.85, winRect(3) , winRect(4)]);
            else
                Screen('FillRect', windowPtr, [255 255 255], [0, winRect(4)*.85, winRect(3)*.15 , winRect(4)]);
            end
        end
        
        messageplane = 1; % Farthest plane
        
        if depthplane == messageplane
            if strcmp(message, 'endofblock')
                Screen('TextSize', windowPtr, 25);
                Screen('DrawText', windowPtr, ['Take a break'], 300, 100, [255, 255, 255, 255]);
                Screen('DrawText', windowPtr, ['Press ENTER to continue'], 300, 200, [255, 255, 255, 255]);
                Screen('DrawText', windowPtr, ['Hold down ESCAPE to stop'], 300, 300, [255, 255, 255, 255]);
                Screen('DrawText', windowPtr, [disp_message_text], 300, 400, [255, 255, 255, 255]);
                Screen('Flip', windowPtr, [], 2, 1);
                WaitSecs(1);
            elseif strcmp(message, 'displayquestion')
                Screen('TextSize', windowPtr, 25);
                Screen('DrawText', windowPtr, [questionText], 150, 300, [255, 255, 255, 255]);
                Screen('Flip', windowPtr, [], 2, 1);
                WaitSecs(param.question_duration);
            elseif strcmp(message, 'takeabreak')
                Screen('TextSize',windowPtr, 25);
                Screen('DrawText', windowPtr, ['Take a break'], 300, 200, [255, 255, 255, 255]);
                Screen('DrawText', windowPtr, ['Press any key to continue'], 200, 300, [255, 255, 255, 255]);
                Screen('DrawText', windowPtr, ['trial' num2str(trial_counter)], 200, 350, [255, 255, 255, 255]);
            elseif strcmp(message, 'readytobegin')
                Screen('TextSize',windowPtr, 35);
                Screen('DrawText', windowPtr, ['Ready to begin?'], 300, 200, [255, 255, 255, 255]);
                Screen('DrawText', windowPtr, ['Push mouse out of the way.'], 250, 275, [255, 255, 255, 255]);
                Screen('DrawText', windowPtr, ['Press any key to continue'], 200, 350, [255, 255, 255, 255]);
            elseif strcmp(message, 'experimentcomplete')
                Screen('TextSize',windowPtr, 35);
                Screen('DrawText', windowPtr, ['Experiment Complete'], 300, 200, [255, 255, 255, 255]);
            elseif strcmp(message, 'turnlensoff')
                Screen('TextSize',windowPtr, 35);
                Screen('DrawText', windowPtr, ['!!!!!Turn off lens NOW !!!!!'], 200, 200, [255, 255, 255, 255]);
            elseif strcmp(message, 'turnlenson')
                Screen('TextSize',windowPtr, 35);
                Screen('DrawText', windowPtr, ['Turn lens on now'], 300, 200, [255, 255, 255, 255]);
            end
        end
    end
    
    onset = Screen('Flip', windowPtr, [], 2, 1);
    
    if strcmp(message, 'displayquestion') ~= 1
        [strInputName2, x, y] = BFWaitForInput(0.000001);
    end
    
    for whichEye = [0 1]
        Screen('SelectStereoDrawBuffer', windowPtr, whichEye);
        glClear();
    end
    
    Screen('Flip', windowPtr, [], 2, 1);
    
    if strcmp(strInputName2, '')==0 && strcmp(message, 'turnlensoff')~=1
        displaymessage = 0;
        for whichEye = [0 1]
            Screen('SelectStereoDrawBuffer', windowPtr, whichEye);
            glClear;
            onset=Screen('Flip', windowPtr, [], 2, 1);
        end
        break;
        
    elseif strcmp(strInputName2, 'q') == 1 && strcmp(message, 'turnlensoff')
        displaymessage = 0;
        break;
        
    elseif strcmp(message, 'pressentertocontinue') && strcmp(strInputName2, 'Return')
        displaymessage = 0;
        break;

    elseif strcmp(strInputName2, 'ESCAPE')
        displaymessage = 0;
        stop_flag = 1;
        for whichEye = [0 1]
            Screen('SelectStereoDrawBuffer', windowPtr, whichEye);
            glClear;
            onset=Screen('Flip', windowPtr, [], 2, 1);
        end
        break;
    end
end
