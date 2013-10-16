function [ out ] = generateAperture( fovA, apertureDepth, accommodationDepth )
%generates an Aperture that has an openness of fovA degrees, depths
%are in Meters
%
%Assumptions 4mm pupilSize 36.4 degrees for 800 by 600 image size
pupilSize = 0.004; %4mm in meters
imageWidth = 800; %in pixels
imageHeight = 600; %in pixels
fovX = 36.4;

%find the radius assuming the monitor has 800 pixels in 36.4 degrees
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

blurRadius = apertureShift-necessaryShift;
blurKernel = fspecial('disk',blurRadius);
%blurKernel
out2 = padarray(sharpAperture,[(imageHeight-apertureSize(1))/2 (imageWidth-apertureSize(2))/2]);
out2 = out2/max(max(out2));
out = imfilter(out2,blurKernel);

end

