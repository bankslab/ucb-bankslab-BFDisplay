function [x,y]  = hexgrid(dotspacingx,dotspacingy,startx,eindx,starty,eindy)
% dotspacingpix = 3
% xnel = 20; % # elementen aan een zijde van o-punt
% ynel = 10;

    [x,y]       = meshgrid(startx:dotspacingx:eindx,starty.*(1/.866):dotspacingy:eindy.*(1/.866));

    x           = x + (((((cos(([1:size(y,1)]'./2)*2*pi)))+1)./4).*dotspacingx)*ones(1,size(x,2));

    y           = .866*y;


    % size(y)
    % 
    % plot(x,y,'.')
    % axis equal

return