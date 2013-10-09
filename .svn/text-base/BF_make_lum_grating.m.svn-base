
function bitmap=BF_make_lum_grating(res, grating_orientation, cycles, color)

% res=1024;
% grating_orientation=45;
% period=3;

x=[0.0001:2*pi/res:2*pi];
xcoord=repmat(x, res, 1);
y=[0.0001:2*pi/res:2*pi];
ycoord= repmat(y', 1, res);

xcycles=cycles*sin(grating_orientation*pi/180);
ycycles=cycles*cos(grating_orientation*pi/180);



        lum=255*(sin(xcoord*xcycles+ycoord*ycycles)+1)/2;

bitmap(:,:,1)=lum*color(1);
bitmap(:,:,2)=lum*color(2);
bitmap(:,:,3)=lum*color(3);

