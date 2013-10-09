%BF_solid_square


        glBegin(GL.QUADS);
            %Draw rectangles in counter-clockwise order!
            %lower-left
            glVertex3f(-1, -1, 0.0);
            %lower-right
            glVertex3f(1, -1, 0.0);
            %upper-right
            glVertex3f(1, 1, 0.0);
            %upper-left
            glVertex3f(-1, 1, 0.0);
        glEnd;