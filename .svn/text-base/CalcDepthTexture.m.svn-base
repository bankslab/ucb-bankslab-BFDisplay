function calcDepthTexture(depthtex_id, nearClip, farClip, imageplanedist, DEPTHTEXSIZE)
global GL;



       
                
                %David's implementation of a dioptric blend
                %in the future, make this matrix operation,
                %for now its done in load time, not runtime
                
                %This is also a place where we can eventually add other
                %types of depth blend filters
                
                

           texture=zeros(DEPTHTEXSIZE,1);     
       if (depthtex_id==1)    %Farthest plane
           for i=1:DEPTHTEXSIZE
               dist=nearClip+(farClip-nearClip)*i/DEPTHTEXSIZE;
               if dist>=imageplanedist(2) && dist < imageplanedist(1)
                    texture(i)= 255*((1/imageplanedist(2))-(1/dist))/(1/imageplanedist(2)-1/imageplanedist(1));
               elseif dist>=imageplanedist(1)
                   texture(i)=255;
               end

           end
       elseif (depthtex_id==2)
           for i=1:DEPTHTEXSIZE
               dist=nearClip+(farClip-nearClip)*i/DEPTHTEXSIZE;
               if dist>=imageplanedist(2) && dist < imageplanedist(1)
                    texture(i)= 255*((1/dist)-(1/imageplanedist(1)))/(1/imageplanedist(2)-1/imageplanedist(1));
               elseif dist<=imageplanedist(2) && dist > imageplanedist(3)
                   texture(i)= 255*((1/imageplanedist(3))-(1/dist))/(1/imageplanedist(3)-1/imageplanedist(2));
               end

           end           
       elseif (depthtex_id==3)
           for i=1:DEPTHTEXSIZE
               dist=nearClip+(farClip-nearClip)*i/DEPTHTEXSIZE;
               if dist>=imageplanedist(3) && dist < imageplanedist(2)
                    texture(i)= 255*((1/dist)-(1/imageplanedist(2)))/(1/imageplanedist(3)-1/imageplanedist(2));
               elseif dist<=imageplanedist(3) && dist > imageplanedist(4)
                   texture(i)= 255*((1/imageplanedist(4))-(1/dist))/(1/imageplanedist(4)-1/imageplanedist(3));
               end

           end                

       elseif (depthtex_id==4)
           for i=1:DEPTHTEXSIZE
               dist=nearClip+(farClip-nearClip)*i/DEPTHTEXSIZE;
               if dist>=imageplanedist(4) && dist < imageplanedist(3)
                    texture(i)= 255*((1/dist)-(1/imageplanedist(3)))/(1/imageplanedist(4)-1/imageplanedist(3));
               elseif dist<=imageplanedist(4)
                   texture(i)= 255;
               end

           end            
           
           
       end
          figure(111)      
         subplot(1,4,depthtex_id)
         plot(texture)


               charimage=uint8(texture); 
                %image is a 1D texture and should be from 0 to 255
                
                
                %different image should be accociated with each viewport, a
                %different depthtexid

                  glBindTexture(GL.TEXTURE_1D, depthtex_id)

                  glTexImage1D(GL.TEXTURE_1D, 0, GL.LUMINANCE8, DEPTHTEXSIZE, 0, GL.LUMINANCE, GL.UNSIGNED_BYTE, charimage)
                  glTexParameteri(GL.TEXTURE_1D, GL.TEXTURE_MIN_FILTER, GL.LINEAR);
                  glTexParameteri(GL.TEXTURE_1D, GL.TEXTURE_MAG_FILTER, GL.LINEAR);
                  glTexParameteri(GL.TEXTURE_1D, GL.TEXTURE_WRAP_S, GL.CLAMP);
                
        
        %Exit MakeDepthTexture
    
    
    %Exit MakeAllDepthTextures

