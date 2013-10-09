
        
    if strcmp(stim_type, 'demomode')
             
                glTranslatef(-0.06,.060, -kinetic_dist);
                %glutWireSphere(0.04, 15, 15);
                    
                    glScalef(.05, .05, 1);
                    BF_bind_texture_to_square(texname_static,14);
%                 glTranslatef(-0.03,.03, +(kinetic_dist)-(.8+1.2-kinetic_dist));
%                 glutWireSphere(0.05, 20, 20);
                
    elseif strcmp(stim_type, 'cyl_structure')
        glDisable(GL.LIGHTING);

        glTranslatef(0,0, -vergdist);
        glRotatef(cyl_rotation, 0,1,0);
        glCallList(CYLDOTS_list_index);
    elseif strcmp(stim_type, 'fuse_stim')
        BF_make_rds_grating(kinetic_dist, 300, 90, 1.35, 4, 10, IPD, 1.5, texname_static);
	elseif strcmp(stim_type, 'timestudy_fuse_stim')
        glDisable(GL.LIGHTING);

		rds_scale_factor=vergence_dist*vergence_offset;
        glScalef(rds_scale_factor,rds_scale_factor,rds_scale_factor);
        glCallList(RDS_list_index);
% 		glPushMatrix();
% 		glTranslatef(0,0.1,0);
% 		glScalef(.01,.01,1);
% 		glTranslatef(0,0,-0.5);
% 		glRotatef(-10,0,0,1);
% 		BF_bind_texture_to_square(texname_static,14);
% 		glPopMatrix();
% 		glPushMatrix();
% 		glScalef(.01,.01,1);
% 		glTranslatef(0,10,-0.5);
% 		BF_bind_texture_to_square(texname_static,14);
% 		glPopMatrix();
	end
	
