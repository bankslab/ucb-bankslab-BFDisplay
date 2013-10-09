function BF_bind_texture_to_circle(texname_static, texture_index_num,use_offset,offset_x,offset_y)
global GL

% offset_x and offset_y are used to select sub-region within the texture.  Only used if use_offset == 1
if use_offset == 0
    proportion = 1;
    offset_x = 0;
    offset_y = 0;
else
    proportion = 0.5;
end

num_vertex = 128;    % Number of vertices making up the border of the circle
radius = 0.5;

% Enable 2D texture mapping
glEnable(GL.TEXTURE_2D);


% Bind (Select) texture 'tx' for drawing:
glBindTexture(GL.TEXTURE_2D,texname_static(texture_index_num));

% Assign n as normal vector for this polygons surface normal:
n=[0 0 4];
glNormal3dv(n);

delta_angle = 2*pi/num_vertex;

glPushMatrix();

glBegin(GL.TRIANGLE_FAN);
    % Draw the vertex at the center of the circle
    texcoord(1) = 0.5 - offset_x;
    texcoord(2) = 0.5 - offset_y;
    glTexCoord2dv(texcoord);

    vertex(1) = 0;
    vertex(2) = 0;
    vertex(3) = 0;
    vertex(4) = 1;        
    glVertex4fv(vertex);

    for i = 0:num_vertex-1

%         texcoord(1) = (cos(delta_angle*i) + 1.0)*0.5*proportion - offset_x;
%         texcoord(2) = (sin(delta_angle*i) + 1.0)*0.5*proportion - offset_y;
        texcoord(1) = (cos(delta_angle*i)*0.5*proportion) + 0.5 - offset_x;
        texcoord(2) = (sin(delta_angle*i)*0.5*proportion) + 0.5 - offset_y;

        glTexCoord2dv(texcoord);

        vertex(1) = cos(delta_angle*i) * radius;
        vertex(2) = sin(delta_angle*i) * radius;
        vertex(3) = 0.0;
        vertex(4) = 1.0;
        glVertex4dv(vertex);
    end


%     texcoord(1) = (1.0 + 1.0)*0.5 - offset_x;
%     texcoord(2) = (0.0 + 1.0)*0.5 - offset_y;
    texcoord(1) = (0.5*proportion) + 0.5 - offset_x;
    texcoord(2) = (0.5*proportion) + 0.5 - offset_y;


    glTexCoord2dv(texcoord);

    vertex(1) = 1.0 * radius;
    vertex(2) = 0.0 * radius;
    vertex(3) = 0.0;
    vertex(4) = 1.0;
    glVertex4dv(vertex);
glEnd();

glPopMatrix();

glDisable(GL.TEXTURE_2D);

