function [ out ] = generateAperture( fovA, apertureDepth_inDiopters, accommodationDepth_inDiopters, eye )
%generates an Aperture that has an openness of fovA degrees, depths
%are in Diopters
%
%Assumptions 4mm pupilSize 32.6 degrees for 800 by 600 image size
pupilSize = 0.004; %4mm in meters
ior = 0.061;
imageWidth = 800; %in pixels
imageHeight = 600; %in pixels
fovX = 32.6;
apertureDepth = 1/apertureDepth_inDiopters;
accommodationDepth = 1/accommodationDepth_inDiopters;

%find the radius assuming the monitor has 800 pixels in 32.6 degrees
radius = (imageWidth/2)*tan(toRadians('d',fovA/2))/tan(toRadians('d',fovX/2));

%generate a sharp aperture with radius
sharpAperture = fspecial('disk',radius);
%force it to have even size
apertureSize = size(sharpAperture);
if mod(apertureSize(1),2)==1
    sharpAperture(end+1,:) = 0;
    sharpAperture(2:end,:) = sharpAperture(2:end,:) + sharpAperture(1:end-1,:);
end
if mod(apertureSize(2),2)==1
    sharpAperture(:,end+1) = 0;
    sharpAperture(:,2:end) = sharpAperture(:,2:end) + sharpAperture(:,1:end-1);
end
apertureSize = size(sharpAperture);

%find the blur amount in pixels
necessaryShift = (pupilSize*imageWidth/2)/(accommodationDepth*tan(toRadians('d',fovX/2)));
apertureShift = (pupilSize*imageWidth/2)/(apertureDepth*tan(toRadians('d',fovX/2)));
%0.25 less because it is the natural disparity of mirrors 
disparityShift = (-2*(eye-0.5))*((ior/2)*imageWidth/2)/((apertureDepth)*tan(toRadians('d',fovX/2)));
disparityShiftNatural = (-2*(eye-0.5))*((ior/2)*imageWidth/2)/((0.4)*tan(toRadians('d',fovX/2)));
disparityShift
disparityShiftNatural
disparityShift = disparityShift-disparityShiftNatural;

blurRadius = apertureShift-necessaryShift;
blurKernel = 1;
if blurRadius > 0
    blurKernel = fspecial('disk',blurRadius);
end
    %blurKernel
out2 = padarray(sharpAperture,[(imageHeight-apertureSize(1))/2 (imageWidth-apertureSize(2))/2]);
out2 = out2/max(max(out2));

out3 = zeros(imageHeight,imageWidth);

if disparityShift > 0    
    out3(:,disparityShift+1:imageWidth) = out2(:,1:imageWidth-disparityShift);
else
    out3(:,1:imageWidth+disparityShift) = out2(:,1-disparityShift:imageWidth);
end

out = imfilter(out3,blurKernel);
out = repmat(out(51:550,101:700),[1 1 3]);


end

