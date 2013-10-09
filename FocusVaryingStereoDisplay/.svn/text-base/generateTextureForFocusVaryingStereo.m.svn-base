clear all;

imageSize=[512 512];

% pattern=round(rand(imageSize/64)); % random pattern

% sinePhase=repmat((1:300)',[1 300]); % sinusoidal modulation pattern
% texturePhase=sinePhase+pattern;
% imagesc(0.5*sin(texturePhase)+0.5);
sampleSize=imageSize/64;
patternrow=repmat((1:sampleSize(1))',[1 sampleSize(2)]);
patterncol=repmat((1:sampleSize(2)),[sampleSize(1) 1]);
pattern=mod(patternrow+patterncol,2);

pattern=imresize(pattern,imageSize,'nearest');
textureImage(:,:,1)=pattern;
textureImage(:,:,2)=pattern;
textureImage(:,:,3)=1-pattern;
textureImage=uint8(255*textureImage);
imshow(textureImage);

imwrite(textureImage,'boxTextureForFocusVaryingStereo.bmp');