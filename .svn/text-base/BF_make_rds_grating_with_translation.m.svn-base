
function BF_make_rds_grating_with_traslation(distance, htranslation, vtranslation, numdots, grating_orientation, cyclesperdegree, diameter_size_degrees, arcmindisp, IPD, dotradius_arcmin, texname_static)
    %  BF_make_rds_grating(distance, htranslation, vtranslation, numdots, grating_orientation,...
    %  cyclesperdegree, diameter_size_degrees, arcmindisp, IPD, dotradius_arcmin, texname_static, rdsmode)
    %  spatial_half_size=.02;  % meters
    %  numdots=150;
    %  grating_orientation=45;
    %  cycles=4;
    %  dotsize=.0005;  %radius in meters
    %  depth=.002; %meters
      rdsmode= 2; % 1 is totally random, 2 is hexagonal with jitter
    global GL
    dotsize=dotradius_arcmin/60*pi/180*distance;
    spatial_half_size=.5*distance*tan(diameter_size_degrees*pi/180);

    xperiod=distance*tan(pi/180/cyclesperdegree);

    theta=atan((IPD/2)/distance)+0.5*arcmindisp/60*pi/180; %absolute disparity of the near point of the corrugation
    depth=distance-.5*IPD/tan(theta);

    glTranslatef(htranslation,vtranslation, -distance);  % translate the stereogram to the correct vergence distance
    glRotatef(grating_orientation, 0, 0, 1);  %rotate the stereogram about the z axis
    rds_dot=1;

    % %Cartesian method
    % while rds_dot<numdots
    %         %Random element must be common to all 8 views, recalculate it prior
    %         %to a trial
    %         xcoord=2*(rand(1, 1)-.5)*spatial_half_size;
    %         ycoord=2*(rand(1, 1)-.5)*spatial_half_size;
    %             if sqrt(xcoord^2+ycoord^2)<=spatial_half_size
    %
    %                 %zcoord=depth*(sin(xcoord*pi/spatial_half_size*xperiod+ycoord*pi/spatial_half_size*yperiod));
    %                 zcoord = depth*(1+sin(2*pi*xcoord/xperiod))/2;
    %                 glPushMatrix();
    %                 glTranslatef(xcoord, ycoord, zcoord);
    %                         % glutSolidSphere(dotsize, 8, 2)
    %                          glScalef(dotsize, dotsize,1)
    %                          BF_bind_texture_to_square(texname_static,5);% Precomputed circle tex
    %                 glPopMatrix();
    %                 rds_dot=rds_dot+1;
    %
    %             end
    % end

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

            dotspacing=sqrt(pi*spatial_half_size^2/(.866*numdots));

                [xtranscoords, ytranscoords]= hexgridwithaperture(dotspacing,-spatial_half_size,spatial_half_size,-spatial_half_size,spatial_half_size,spatial_half_size);
                numdots=length(xtranscoords);
                 xtranscoords=(xtranscoords+ (rand(numdots, 1)-.5)*dotspacing/1.5)';
                 ytranscoords=(ytranscoords+ (rand(numdots, 1)-.5)*dotspacing/1.5)';
    end


    
    ztranscoords= depth*(sin(2*pi*xtranscoords/xperiod));  %This modulates the disparity about the distance.  It used to be in front of the distance
    xvertexcoords= repmat(xtranscoords, 4, 1);
    yvertexcoords= repmat(ytranscoords, 4, 1);
    zvertexcoords= repmat(ztranscoords, 4, 1);
    xvertexcoords2= reshape(xvertexcoords,1, 4*numdots);

    yvertexcoords2= reshape(yvertexcoords,1, 4*numdots);
    zvertexcoords2= reshape(zvertexcoords,1, 4*numdots);

    xyztransarraycoord=zeros(1, numdots*3*4);


    xyztransarraycoord(1:3:end)=xvertexcoords2;
    xyztransarraycoord(2:3:end)=yvertexcoords2;
    xyztransarraycoord(3:3:end)=zvertexcoords2;



    quadLeft    = -dotsize;
    quadRight   =  dotsize;
    quadBottom  = -dotsize;
    quadTop     =  dotsize;

    v0  = [quadLeft     quadBottom      0.0];
    v1  = [quadRight    quadBottom      0.0];
    v2  = [quadRight    quadTop         0.0];
    v3  = [quadLeft     quadTop         0.0];

    % Assign our unit-quad vertices
    quadVerts = [v0 v1 v2 v3];
    vertexshift = repmat(quadVerts, 1, numdots);
    XYZvertexcoords= xyztransarraycoord+vertexshift;

    %tex coords
    t0  = [0.0  0.0];
    t1  = [1.0  0.0];
    t2  = [1.0  1.0];
    t3  = [0.0  1.0];
    vertexunit=[t0 t1 t2 t3];
    texcoords=repmat(vertexunit, 1, numdots);



    % Enable vertex arrays and texture coordinate arrays
    glEnableClientState(GL.VERTEX_ARRAY);
    glVertexPointer(3, GL.DOUBLE, 0, XYZvertexcoords);
    glEnableClientState(GL.TEXTURE_COORD_ARRAY);
    glTexCoordPointer(2, GL.DOUBLE, 0, texcoords);

    %     plot3(xtranscoords, ytranscoords, ztranscoords, '.')


    glEnable(GL.TEXTURE_2D);

    glBindTexture(GL.TEXTURE_2D,texname_static(5));
    glVertexPointer(3, GL.DOUBLE, 0, XYZvertexcoords);
    glDrawArrays(GL.QUADS, 0, length(XYZvertexcoords)/3);

return


