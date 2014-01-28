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
if strcmp(strInputName,'1!')
    show_image = 1;
elseif strcmp(strInputName,'2@')
    show_image = 2;
elseif strcmp(strInputName,'3#')
elseif strcmp(strInputName,'4$')
elseif strcmp(strInputName, 'RightArrow')
elseif strcmp(strInputName, 'LeftArrow')
elseif strcmp(strInputName, 'UpArrow')
elseif strcmp(strInputName, 'DownArrow')
elseif strcmp(strInputName, 'SPACE')
elseif strcmp(strInputName, 'Return')
    response_given = 1;
    break;
elseif strcmp(strInputName,'ESCAPE')||strcmp(strInputName,'esc')
    stop_flag = 1;
    response_given = 1;
    break;
end