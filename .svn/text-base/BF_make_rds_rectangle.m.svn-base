
function BF_make_rds_rectangle(distance, numdots, cyclesperdegree, width_size_degrees, height_size_degrees, IPD, dotradius_arcmin, texname_static)
%                       (pedestal_distance.z, numdots, 90, 1.35, pink_noise_circle_diam_base/60, 0, IPD, dotradius_arcmin, texname_static);                   


    %  BF_make_rds_grating(distance, numdots, grating_orientation,...
    %  cyclesperdegree, diameter_size_degrees, arcmindisp, IPD, dotradius_arcmin, texname_static, rdsmode)
    %  spatial_half_size=.02;  % meters
    %  numdots=150;
    %  grating_orientation=45;
    %  cycles=4;
    %  dotsize=.0005;  %radius in meters
    %  depth=.002; %meters
    rdsmode= 2; % 1 is totally random, 2 is hexagonal with jitter
    global GL
    dotsize                     = dotradius_arcmin/60*pi/180*distance;
    spatial_half_size_width     = .5*distance*tan(width_size_degrees*pi/180);
    spatial_half_size_height    = .5*distance*tan(height_size_degrees*pi/180);
    xperiod                     = distance*tan(pi/180/cyclesperdegree);

    glTranslatef(0,0, -distance);  % translate the stereogram to the correct vergence distance
    rds_dot                     = 1;

    %Polar routine that uses vertex lists
    %Should be much more optimized for a large number of dots than the
    %cartesian approach commented out above
    %The vertex list approach is taken from Chris Burns Vertex Arrays example

    if rdsmode==1
            rcoord=sqrt(rand(1,numdots));
            thetacoord=2*pi*rand(1,numdots);
            xtranscoords= spatial_half_size.*rcoord.*cos(thetacoord);
            ytranscoords= spatial_half_size.*rcoord.*sin(thetacoord);
    elseif rdsmode==2

            dotspacingx                     = sqrt(pi*spatial_half_size_width^2/(.866*numdots));
            dotspacingy                     = sqrt(pi*spatial_half_size_height^2/(.866*numdots));
            [xtranscoords, ytranscoords]    = hexgrid(dotspacingx,dotspacingy,-spatial_half_size_width,spatial_half_size_width,-spatial_half_size_height,spatial_half_size_height);
            xtranscoords                    = xtranscoords(:);
            ytranscoords                    = ytranscoords(:);
            numdots                         = length(xtranscoords);
            xtranscoords                    = (xtranscoords+ (rand(numdots,1)-.5).*dotspacingx/1.5)';
            ytranscoords                    = (ytranscoords+ (rand(numdots,1)-.5).*dotspacingy/1.5)';
    end
    
    ztranscoords    = 0.*xtranscoords;
    xvertexcoords   = repmat(xtranscoords, 4, 1);
    yvertexcoords   = repmat(ytranscoords, 4, 1);
    zvertexcoords   = repmat(ztranscoords, 4, 1);
    xvertexcoords2  = reshape(xvertexcoords,1, 4*numdots);
    yvertexcoords2  = reshape(yvertexcoords,1, 4*numdots);
    zvertexcoords2  = reshape(zvertexcoords,1, 4*numdots);

    xyztransarraycoord          = zeros(1, numdots*3*4);
    xyztransarraycoord(1:3:end) = xvertexcoords2;
    xyztransarraycoord(2:3:end) = yvertexcoords2;
    xyztransarraycoord(3:3:end) = zvertexcoords2;

    quadLeft    = -dotsize;
    quadRight   =  dotsize;
    quadBottom  = -dotsize;
    quadTop     =  dotsize;

    v0  = [quadLeft     quadBottom      0.0];
    v1  = [quadRight    quadBottom      0.0];
    v2  = [quadRight    quadTop         0.0];
    v3  = [quadLeft     quadTop         0.0];

    % Assign our unit-quad vertices
    quadVerts       = [v0 v1 v2 v3];
    vertexshift     = repmat(quadVerts, 1, numdots);
    XYZvertexcoords = xyztransarraycoord+vertexshift;

    %tex coords
    t0          = [0.0  0.0];
    t1          = [1.0  0.0];
    t2          = [1.0  1.0];
    t3          = [0.0  1.0];
    vertexunit  = [t0 t1 t2 t3];
    texcoords   = repmat(vertexunit, 1, numdots);


    % Enable vertex arrays and texture coordinate arrays
    glEnableClientState(GL.VERTEX_ARRAY);
    glVertexPointer(3, GL.DOUBLE, 0, XYZvertexcoords);
    glEnableClientState(GL.TEXTURE_COORD_ARRAY);
    glTexCoordPointer(2, GL.DOUBLE, 0, texcoords);
    glEnable(GL.TEXTURE_2D);
    glBindTexture(GL.TEXTURE_2D,texname_static(24));
    glVertexPointer(3, GL.DOUBLE, 0, XYZvertexcoords);
    glDrawArrays(GL.QUADS, 0, length(XYZvertexcoords)/3);

return


