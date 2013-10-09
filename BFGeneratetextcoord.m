function [xyzcalibpos, xytexcoords]=BFGeneratetextcoord(yLoomSize, xLoomSize, texWidth, texHeight,vertexCoords , vertexCoordsFit)




numVerts=(xLoomSize-1)*(yLoomSize-1)*4;
xyzcalibpos = zeros(1, numVerts*3);
xytexcoords = zeros(1,numVerts*2);
xtemp=zeros(1,numVerts);
ytemp=zeros(1, numVerts);
zverts=zeros(1,numVerts);

xverts=zeros(1,numVerts);
yverts=zeros(1, numVerts);

%vertexCoordsFit(:,1)= (vertexCoordsFit(:,1)/1280);
%vertexCoordsFit(:,2)= (vertexCoordsFit(:,2)/1024);

%vertexCoords=flipud(vertexCoords);

vectaddress=0;

%texWidth=1;
%texHeight=1;

figure(55)
plot(vertexCoords(:,1), vertexCoords(:,2), 'r.')
hold on
plot(vertexCoordsFit(:,1), vertexCoordsFit(:,2), 'b.')





               for y=1:(yLoomSize-1)
                    for x=1:(xLoomSize-1)
    
                  
                
                        index = ((y-1) * xLoomSize) + x;

                        vectaddress=vectaddress+1;
                        
                        xtemp(vectaddress)    = (vertexCoords(index, 1) / texWidth);  %LowerLeftXTex
                        ytemp(vectaddress)    = (vertexCoords(index, 2) / texHeight);  %LowerLeftYTex

                        xverts(vectaddress) = vertexCoordsFit(index, 1);  % Lower left fit coord  x
                        yverts(vectaddress) = vertexCoordsFit(index, 2);  % lower left fit coord  y
                        
                        vectaddress=vectaddress+1;
                        
                        xtemp(vectaddress)   = (vertexCoords(index+1, 1) / texWidth);  %LowerrightXTex
                        ytemp(vectaddress)   = (vertexCoords(index+1, 2) / texHeight); %LowerrightYTex

                        xverts(vectaddress)    = vertexCoordsFit(index+1, 1);   %lower right fit coord  x
                        yverts(vectaddress)    = vertexCoordsFit(index+1, 2);   %lower right fit coord  y
                        
                        vectaddress=vectaddress+1;
                        
                        xtemp(vectaddress)   = (vertexCoords(index+xLoomSize+1, 1) / texWidth);  %UpperRightXTex  
                        ytemp(vectaddress)   = (vertexCoords(index+xLoomSize+1, 2) / texHeight);  %UpperRightYTex

                        xverts(vectaddress)    = vertexCoordsFit(index+xLoomSize+1, 1);  %Upper right fit coord  x
                        yverts(vectaddress)    = vertexCoordsFit(index+xLoomSize+1, 2);  %upper right fit coord  y
                        
                        vectaddress=vectaddress+1;
                        
                        xtemp(vectaddress)    = (vertexCoords(index+xLoomSize, 1) / texWidth) ;  %UpperLeft X Tex
                        ytemp(vectaddress)    = (vertexCoords(index+xLoomSize, 2) / texHeight);  %Upperleft Y tex

                        
                        xverts(vectaddress) = vertexCoordsFit(index+xLoomSize, 1);   %upper left fit coord   x
                        yverts(vectaddress) = vertexCoordsFit(index+xLoomSize, 2);   %upper left fit coord   y


                        


                        
    
                   
%                         % lower-left
%                         glTexCoord2f(lowerLeftTex(1),   lowerLeftTex(2));
%                         glVertex2f(lowerLeftVert(1),    lowerLeftVert(2));
%                         % lower-right
%                         glTexCoord2f(lowerRightTex(1),  lowerRightTex(2));
%                         glVertex2f(lowerRightVert(1),   lowerRightVert(2));
%                         % upper-right
%                         glTexCoord2f(upperRightTex(1),  upperRightTex(2));
%                         glVertex2f(upperRightVert(1),   upperRightVert(2));
%                         % upper-left
%                         glTexCoord2f(upperLeftTex(1),   upperLeftTex(2));
%                         glVertex2f(upperLeftVert(1),    upperLeftVert(2));
  
                    end
               end
               
               
               
xyzcalibpos(1:3:end) = xverts;
xyzcalibpos(2:3:end) = yverts;
xyzcalibpos(3:3:end) = zverts;
xytexcoords(1:2:end) = xtemp;
xytexcoords(2:2:end) = ytemp;



