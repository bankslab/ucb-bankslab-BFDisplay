function BF_bind_texture_to_square(texname_static, texture_index_num)
global GL
% Setup the OpenGL rendering context of the onscreen window for use by
% OpenGL wrapper. After this command, all following OpenGL commands will
% draw into the onscreen window 'win':



% 
% % Turn on OpenGL local lighting model: The lighting model supported by
% % OpenGL is a local Phong model with Gouraud shading.
% glEnable(GL_LIGHTING);
% 
% % Enable the first local light source GL_LIGHT_0. Each OpenGL
% % implementation is guaranteed to support at least 8 light sources. 
% glEnable(GL_LIGHT0);
% 
% % Enable two-sided lighting - Back sides of polygons are lit as well.
% glLightModelfv(GL_LIGHT_MODEL_TWO_SIDE,GL_TRUE);
% 
% % Enable proper occlusion handling via depth tests:
% glEnable(GL_DEPTH_TEST);
% 
% % Define the cubes light reflection properties by setting up reflection
% % coefficients for ambient, diffuse and specular reflection:
% glMaterialfv(GL_FRONT_AND_BACK,GL_AMBIENT, [ .33 .22 .03 1 ]);
% glMaterialfv(GL_FRONT_AND_BACK,GL_DIFFUSE, [ .78 .57 .11 1 ]);
% glMaterialfv(GL_FRONT_AND_BACK,GL_SHININESS,27.8);

    
    
    % Enable 2D texture mapping, so the faces of the cube will show some nice
% images:
glEnable(GL.TEXTURE_2D);
    

%     % Calculate rotation angle for next frame:
%     theta=mod(theta+0.3,360);
%     rotatev=rotatev+0.1*[ sin((pi/180)*theta) sin((pi/180)*2*theta) sin((pi/180)*theta/5) ];
%     rotatev=rotatev/sqrt(sum(rotatev.^2));

    % Setup cubes rotation around axis:
    glPushMatrix();
 %   glRotated(theta,rotatev(1),rotatev(2),rotatev(3));
    
    % The subroutine cubeface (see below) draws one side of the cube, so we
    % call it six times with different settings

% % % % % % % %     i=[1 2 3 4 ];
% % % % % % % %     
% % % % % % % %     % Vector v maps indices to 3D positions of the corners of a face:
% % % % % % % % v=[ -1 -1 0 ; 1 -1 0 ; 1 1 0 ; -1 1 0 ; -1 -1 1 ; 1 -1 1 ; 1 1 1 ; -1 1 1 ]';
% % % % % % % % % Compute surface normal vector. Needed for proper lighting calculation:
% % % % % % % % n=cross(v(:,i(2))-v(:,i(1)),v(:,i(3))-v(:,i(2)));
% % % % % % % % 
% % % % % % % % % Bind (Select) texture 'tx' for drawing:
% % % % % % % % glBindTexture(GL.TEXTURE_2D,texname_static(texture_index_num));
% % % % % % % % % Begin drawing of a new polygon:
% % % % % % % % glBegin(GL.POLYGON);
% % % % % % % % 
% % % % % % % % % Assign n as normal vector for this polygons surface normal:
% % % % % % % % glNormal3dv(n);
% % % % % % % % 
% % % % % % % % % Define vertex 1 by assigning a texture coordinate and a 3D position:
% % % % % % % % glTexCoord2dv([ 0 0 ]);
% % % % % % % % glVertex3dv(v(:,i(1)));
% % % % % % % % % Define vertex 2 by assigning a texture coordinate and a 3D position:
% % % % % % % % glTexCoord2dv([ 1 0 ]);
% % % % % % % % glVertex3dv(v(:,i(2)));
% % % % % % % % % Define vertex 3 by assigning a texture coordinate and a 3D position:
% % % % % % % % glTexCoord2dv([ 1 1 ]);
% % % % % % % % glVertex3dv(v(:,i(3)));
% % % % % % % % % Define vertex 4 by assigning a texture coordinate and a 3D position:
% % % % % % % % glTexCoord2dv([ 0 1 ]);
% % % % % % % % glVertex3dv(v(:,i(4)));
% % % % % % % % % Done with this polygon:
% % % % % % % % glEnd;
% % % % % % % %     
   % i=[1 2 3 4 ];
    
% % % %     % Vector v maps indices to 3D positions of the corners of a face:
% % % % v=[ -1 -1 0 ; 1 -1 0 ; 1 1 0 ; -1 1 0 ; -1 -1 1 ; 1 -1 1 ; 1 1 1 ; -1 1 1 ]';
% % % % % Compute surface normal vector. Needed for proper lighting calculation:
% % % % n=cross(v(:,i(2))-v(:,i(1)),v(:,i(3))-v(:,i(2)));

n=[0 0 4];


% Bind (Select) texture 'tx' for drawing:
glBindTexture(GL.TEXTURE_2D,texname_static(texture_index_num));
% Begin drawing of a new polygon:
glBegin(GL.POLYGON);

% Assign n as normal vector for this polygons surface normal:
glNormal3dv(n);

% Define vertex 1 by assigning a texture coordinate and a 3D position:
glTexCoord2dv([ 0 0 ]);
glVertex3dv([-1 -1 0]);
% Define vertex 2 by assigning a texture coordinate and a 3D position:
glTexCoord2dv([ 1 0 ]);
glVertex3dv([1 -1 0]);
% Define vertex 3 by assigning a texture coordinate and a 3D position:
glTexCoord2dv([ 1 1 ]);
glVertex3dv([1 1 0]);
% Define vertex 4 by assigning a texture coordinate and a 3D position:
glTexCoord2dv([ 0 1 ]);
glVertex3dv([-1 1 0]);
% Done with this polygon:
glEnd;
    



    glPopMatrix;
    


glDisable(GL.TEXTURE_2D);

