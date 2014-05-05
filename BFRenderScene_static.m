%Render the Scene

glDisable(GL.LIGHTING);
glDisable(GL.DEPTH_TEST);
glPushMatrix();
glTranslatef(0, 0, -imageplanedist(depthplane));
vertFOV = 23.3;
horizFOV = 32.6;
glScalef(tan((horizFOV/2)*pi/180), tan((vertFOV/2)*pi/180), 1);
BF_bind_texture_to_square(texname_static, (anim-1)*8+depthplane+whichEye*4);
glPopMatrix();
