function []=CYLDOTS_list_index(numberofdots, cylradius, cylheight, dotradius)

slices=6;
stacks=6;

                for i=1:numberofdots
                    glPushMatrix();
                    randangle=rand(1)*360;
                                glTranslatef(cylradius*sind(randangle), (rand(1)-.5)*cylheight, cylradius*cosd(randangle));
                                glutSolidSphere(dotradius, slices, stacks);
                    
                    glPopMatrix();
                    
                end
            
            