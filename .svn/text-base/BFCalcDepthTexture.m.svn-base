 function BFcalcDepthTexture(depthtex_handle, depthtex_id, nearClip, farClip, imageplanedist, DEPTHTEXSIZE)
 global GL;



       
                
                %David's implementation of a dioptric blend
                %in the future, make this matrix operation,
                %for now its done in load time, not runtime
                
                %This is also a place where we can eventually add other
                %types of depth blend filters (nudge, nudge, wink wink)
                
                


           texture=zeros(DEPTHTEXSIZE,1);     
       if (depthtex_handle==1)    %Farthest plane
           for i=1:DEPTHTEXSIZE
               dist=nearClip+(farClip-nearClip)*i/DEPTHTEXSIZE;
               if dist>=imageplanedist(2)+(imageplanedist(1)-imageplanedist(2))/DEPTHTEXSIZE && dist < imageplanedist(1)-(imageplanedist(1)-imageplanedist(2))/DEPTHTEXSIZE
                    texture(i)= 255*((1/imageplanedist(2))-(1/dist))/(1/imageplanedist(2)-1/imageplanedist(1));
               elseif dist>=imageplanedist(1)-(imageplanedist(1)-imageplanedist(2))/DEPTHTEXSIZE  % if we are simulating a distance behind the workspace, clampt the focal distance to far plane
                   texture(i)=255;
               end

           end
       elseif (depthtex_handle==2) %Far-mid plane
           for i=1:DEPTHTEXSIZE
               dist=nearClip+(farClip-nearClip)*i/DEPTHTEXSIZE;
               if dist>imageplanedist(2)+(imageplanedist(1)-imageplanedist(2))/DEPTHTEXSIZE && dist < imageplanedist(1)-(imageplanedist(1)-imageplanedist(2))/DEPTHTEXSIZE
                    texture(i)= 255*((1/dist)-(1/imageplanedist(1)))/(1/imageplanedist(2)-1/imageplanedist(1));
			   elseif dist<=imageplanedist(2)+(imageplanedist(1)-imageplanedist(2))/DEPTHTEXSIZE && dist>=imageplanedist(2)-(imageplanedist(2)-imageplanedist(3))/DEPTHTEXSIZE
				   texture(i)=255;
               elseif dist<imageplanedist(2)-(imageplanedist(2)-imageplanedist(3))/DEPTHTEXSIZE && dist > imageplanedist(3)+(imageplanedist(2)-imageplanedist(3))/DEPTHTEXSIZE
                   texture(i)= 255*((1/imageplanedist(3))-(1/dist))/(1/imageplanedist(3)-1/imageplanedist(2));
               end

           end           
       elseif (depthtex_handle==3)  %near-mid plane
           for i=1:DEPTHTEXSIZE
               dist=nearClip+(farClip-nearClip)*i/DEPTHTEXSIZE;
               if dist>imageplanedist(3)+(imageplanedist(2)-imageplanedist(3))/DEPTHTEXSIZE && dist < imageplanedist(2)-(imageplanedist(3)-imageplanedist(4))/DEPTHTEXSIZE
                    texture(i)= 255*((1/dist)-(1/imageplanedist(2)))/(1/imageplanedist(3)-1/imageplanedist(2));
			   elseif dist<=imageplanedist(3)+(imageplanedist(2)-imageplanedist(3))/DEPTHTEXSIZE && dist>=imageplanedist(3)-(imageplanedist(3)-imageplanedist(4))/DEPTHTEXSIZE
				   texture(i)=255;
               elseif dist<imageplanedist(3)-(imageplanedist(3)-imageplanedist(4))/DEPTHTEXSIZE && dist > imageplanedist(4)+(imageplanedist(3)-imageplanedist(4))/DEPTHTEXSIZE
                   texture(i)= 255*((1/imageplanedist(4))-(1/dist))/(1/imageplanedist(4)-1/imageplanedist(3));
               end

           end                

       elseif (depthtex_handle==4)   %near plane
           for i=1:DEPTHTEXSIZE
               dist=nearClip+(farClip-nearClip)*i/DEPTHTEXSIZE;
               if dist>imageplanedist(4)+(imageplanedist(3)-imageplanedist(4))/DEPTHTEXSIZE && dist < imageplanedist(3)-(imageplanedist(3)-imageplanedist(4))/DEPTHTEXSIZE
                    texture(i)= 255*((1/dist)-(1/imageplanedist(3)))/(1/imageplanedist(4)-1/imageplanedist(3));
               elseif dist<=imageplanedist(4)+(imageplanedist(3)-imageplanedist(4))/DEPTHTEXSIZE   %if we are simulating a point in front of the workspace, we clamp the focal distance near
                   texture(i)= 255;
               end

           end            
       elseif (depthtex_handle==5)
           for i=1:DEPTHTEXSIZE
               texture(i)=65;
           end
       elseif (depthtex_handle==6)
           for i=1:DEPTHTEXSIZE
               texture(i)=0;
           end
       elseif (depthtex_handle==7)
           for i=1:DEPTHTEXSIZE
               texture(i)=255;
           end
       end
       
%        if (depthtex_handle~=5)
%           figure(111)      
%          subplot(1,4,depthtex_handle)
%          plot(texture)
%        end


               charimage=uint8(texture); 
                %image is a 1D texture and should be from 0 to 255
                
                
                %different image should be accociated with each viewport, a
                %different depthtexid
                
               
       

                  glBindTexture(GL.TEXTURE_1D, depthtex_id(depthtex_handle));



                  glTexImage1D(GL.TEXTURE_1D, 0, GL.LUMINANCE8, DEPTHTEXSIZE, 0, GL.LUMINANCE, GL.UNSIGNED_BYTE, charimage)
                  glTexParameteri(GL.TEXTURE_1D, GL.TEXTURE_MIN_FILTER, GL.LINEAR);
                  glTexParameteri(GL.TEXTURE_1D, GL.TEXTURE_MAG_FILTER, GL.LINEAR);
                  glTexParameteri(GL.TEXTURE_1D, GL.TEXTURE_WRAP_S, GL.CLAMP);
                
        
        %Exit MakeDepthTexture
    
    
    %Exit MakeAllDepthTextures

