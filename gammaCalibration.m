[win wrect]=Screen('OpenWindow',1,1,[],[],[],8);
rgb=0;
i=1;
out = [];
luminance=255;
while rgb>=0 && rgb<=255
    rgb = luminance;
    Screen('FillRect',win,[0 0 rgb],[])
    Screen('Flip',win);
    luminance = input('luminance?');
    %out(i,1:2) = [rgb luminance]; 
    %rgb = rgb+5;
    %i = i+1;
end
Screen('CloseAll');