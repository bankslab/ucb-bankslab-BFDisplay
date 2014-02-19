% This script handles all keyboard input for the BF display
% It Gets Input and Changes Displayed Image
% 
% Example 1: Dynamically change the displayed image
% if strcmp(strInputName,'1!')
%     targetPosition = targetPosition + 1;
% end % Now BF_build_textures_optimizer will redraw the target
% 
%
% Example 2: Continue with response
% if strcmp(strInputName, 'SPACE')
%     response_given = 1;
%     break;
% end % Now it will continue to the next trial

% Draw blank screen

Screen('SelectStereoDrawBuffer',windowPtr,0);
Screen('FillRect',windowPtr,[0 0 0]);
Screen('SelectStereoDrawBuffer',windowPtr,1);
Screen('FillRect',windowPtr,[0 0 0]);
Screen('Flip',windowPtr);

iKeyIndex = find(c);
strInputName = KbName(iKeyIndex(1));
switch strInputName
    case '1!'
    case '2@'
    case '3#'
    case '4$'
    case 'RightArrow'
        response = 0;
        responded = 1;
    case 'LeftArrow'
        response = 1;
        responded = 1;
    case 'UpArrow'
    case 'DownArrow'
    case 'space'
    case 'Return'
    case 'ESCAPE'
        stop_flag = 1;
        responded = 1;
        break;
end