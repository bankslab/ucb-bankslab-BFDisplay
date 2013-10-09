
function [x,y] = hexgridwithaperture(dotspacing,startx,eindx,starty,eindy,aperture)
    [x,y]  = hexgrid(dotspacing,startx,eindx,starty,eindy);

    q                       = sqrt(x.^2 + y.^2)<aperture;	% selectie van punten die binnen aperture vallen
    x              = x(q);                                  	% x coordinaten (deg) van punten binnen aperture
    y              = y(q);                                	% y coordinaten (deg) van punten binnen aperture



return



function [x,y]  = hexgrid(dotspacing,startx,eindx,starty,eindy)
% dotspacingpix = 3
% xnel = 20; % # elementen aan een zijde van o-punt
% ynel = 10;

    [x,y]       = meshgrid(startx:dotspacing:eindx,starty.*(1/.866):dotspacing:eindy.*(1/.866));

    x           = x + (((((cos(([1:size(y,1)]'./2)*2*pi)))+1)./4).*dotspacing)*ones(1,size(x,2));

    y           = .866*y;


    % size(y)
    % 
    % plot(x,y,'.')
    % axis equal

return