% This script displays the pre-loaded GL commands and waits for input

tic
a = 0;
while a == 0
    elapsedTime = toc;
    if (makeFix == 0) && (elapsedTime >= param.stim_duration)
        break
    end
    [a b c d] = KbCheck(-1);
    depthplane = depthplane + 1;
    if depthplane > 4
        depthplane = 1;
    end
    depthtex_handle = depthplane;
    for whichEye = renderviews
        Screen('SelectStereoDrawBuffer', windowPtr, whichEye);
        Screen('BeginOpenGL', windowPtr);
        if whichEye == 0
            glCallList(genlist_projection1(depthplane+whichEye*4));    %mandatory projection setup
            if static_mode  %optional mode for staic imagery
                glCallList(static_scene_disp_list1(depthplane+whichEye*4));
            end
        else
            glCallList(genlist_projection1(depthplane+whichEye*4));    %mandatory projection setup
            if static_mode  %optional mode for staic imagery
                glCallList(static_scene_disp_list1(depthplane+whichEye*4));
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
    % TRY REMOVING THIS LINE
    Screen('Flip', windowPtr, [], 2, 1);
end
onset=Screen('Flip', windowPtr, [], []);
