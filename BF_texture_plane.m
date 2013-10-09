
%This is a real time texture generation and mapping routine that works

%function b=BF_texture_object(win)
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

% Generate 6 textures and store their handles in vecotr 'texname'
texname=glGenTextures(1);

% % Load a binary file which contains binary pixel data for the six textures:
%  matdemopath = [PsychtoolboxRoot 'PsychDemos/OpenGL4MatlabDemos/mogldemo.mat'];
%  load(matdemopath, 'face')

% Setup textures for all six sides of cube:

    % Enable i'th texture by binding it:
    glBindTexture(GL.TEXTURE_2D,texname);
    % Compute image in matlab matrix 'tx'
%     f=max(min(128*(1+face{1}),255),0);
%     tx=repmat(flipdim(f,1),[ 1 1 3 ]);
%     tx=permute(flipdim(uint8(tx),1),[ 3 2 1 ]);
    
    
    tx=permute((uint8(BF_make_lum_grating(256, 45,6, [1,1,.5]))), [3 2 1]);
    
    % Assign image in matrix 'tx' to i'th texture:
    glTexImage2D(GL.TEXTURE_2D,0,GL.RGB,256,256,0,GL.RGB,GL.UNSIGNED_BYTE,tx);
    % Setup texture wrapping behaviour:
    glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_S,GL.REPEAT);
    glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_WRAP_T,GL.REPEAT);
    % Setup filtering for the textures:
    glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MAG_FILTER,GL.NEAREST);
    glTexParameterfv(GL.TEXTURE_2D,GL.TEXTURE_MIN_FILTER,GL.NEAREST);
    % Choose texture application function: It shall modulate the light
    % reflection properties of the the cubes face:
    glTexEnvfv(GL.TEXTURE_ENV,GL.TEXTURE_ENV_MODE,GL.MODULATE);



%     % Calculate rotation angle for next frame:
%     theta=mod(theta+0.3,360);
%     rotatev=rotatev+0.1*[ sin((pi/180)*theta) sin((pi/180)*2*theta) sin((pi/180)*theta/5) ];
%     rotatev=rotatev/sqrt(sum(rotatev.^2));

    % Setup cubes rotation around axis:
    glPushMatrix();
 %   glRotated(theta,rotatev(1),rotatev(2),rotatev(3));
    
    % The subroutine cubeface (see below) draws one side of the cube, so we
    % call it six times with different settings

    i=[5 6 7 8 ];
    
    % Vector v maps indices to 3D positions of the corners of a face:
v=[ 0 0 0 ; 1 0 0 ; 1 1 0 ; 0 1 0 ; 0 0 1 ; 1 0 1 ; 1 1 1 ; 0 1 1 ]'-0.5;
% Compute surface normal vector. Needed for proper lighting calculation:
n=cross(v(:,i(2))-v(:,i(1)),v(:,i(3))-v(:,i(2)));

% Bind (Select) texture 'tx' for drawing:
glBindTexture(GL.TEXTURE_2D,texname(1));
% Begin drawing of a new polygon:
glBegin(GL.POLYGON);

% Assign n as normal vector for this polygons surface normal:
glNormal3dv(n);

% Define vertex 1 by assigning a texture coordinate and a 3D position:
glTexCoord2dv([ 0 0 ]);
glVertex3dv(v(:,i(1)));
% Define vertex 2 by assigning a texture coordinate and a 3D position:
glTexCoord2dv([ 1 0 ]);
glVertex3dv(v(:,i(2)));
% Define vertex 3 by assigning a texture coordinate and a 3D position:
glTexCoord2dv([ 1 1 ]);
glVertex3dv(v(:,i(3)));
% Define vertex 4 by assigning a texture coordinate and a 3D position:
glTexCoord2dv([ 0 1 ]);
glVertex3dv(v(:,i(4)));
% Done with this polygon:
glEnd;
    

    glPopMatrix;
    

% Delete all allocated OpenGL textures:
glDeleteTextures(length(texname),texname);

glDisable(GL.TEXTURE_2D);

