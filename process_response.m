
keyIsDown = 0; goodKey = 0; waitdone = 0;
while (~keyIsDown || ~waitdone)
    [ keyIsDown, seconds, keyCode ]  = KbCheck;
    
    answer = [];
    if keyIsDown && [GetSecs > (stTime  + 0.65) ]
        waitdone = 1;
        if keyCode(KbName('LeftArrow')) %if keyCode(KbName('DownArrow'))
            %flip because of the mirror
            response.key(trialNo) =  1;
        elseif keyCode(KbName('RightArrow')) %elseif keyCode(KbName('UpArrow'))
            %flip because of mirror in haploscope
            response.key(trialNo) =  -1;
        elseif keyCode(KbName('ESCAPE'))
            message='experimentcanceled';
            BF_disp_message

            message='turnlensoff';
            BF_disp_message                        
            Screen('CloseAll'); break;
        end
    end
    

%%need to tell scren which frames to draw, maybe pre-render the noise
%     f = ceil(rand(1) .* interval.nFrames);
%     
%     % Select left-eye image buffer for drawing:
%     Screen('SelectStereoDrawBuffer', windowPtr, 0);
%     
%     % Draw left stim:
%     Screen('Drawdots', windowPtr, interval.cords{f}, para.dotSize, 255,  halfScr, 1);
%     draw_background
%     % Select right-eye image buffer for drawing:
%     Screen('SelectStereoDrawBuffer', windowPtr, 1);
%     % Draw right stim:
%     Screen('Drawdots', windowPtr, interval.cords{f}, para.dotSize, 255,  halfScr, 1);
%     draw_background
%     % Tell PTB drawing is finished for this frame:
%     if mod(abcd, 10) == 0 || abcd == 1
%         Screen('DrawText', windowPtr, [num2str( abcd ), '/', num2str(maxTrials)], 100, 100, 128, 128, 0);
%     end
%     Screen('DrawingFinished', windowPtr);
%     
%     Screen('Flip', windowPtr, [], [], []);
end

store{ trialNo } = trial;