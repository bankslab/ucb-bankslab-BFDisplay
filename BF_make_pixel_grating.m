function BF_make_pixel_grating(width,num_lines)
global GL;
% Creates a Maltese cross in OpenGL
% Assume the OpenGL environment has already been initialized

for i = 1:num_lines
    glBegin(GL.LINES)
        glVertex3f(-width/2 + (i-1)*width/(num_lines-1),-width/2,0);
        glVertex3f(-width/2 + (i-1)*width/(num_lines-1),width/2,0);
    glEnd();
end

% Make a horizontal line in the center
glBegin(GL.LINES)
        glVertex3f(-width/2,0,0);
        glVertex3f(width/2,0,0);
    glEnd()