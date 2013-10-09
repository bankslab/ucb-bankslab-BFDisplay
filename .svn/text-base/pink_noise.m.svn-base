function [output] = pink_noise(imSize)
% Create noisy image
im_size = [imSize imSize];
image = randn(im_size);

% Calculate 2D FFT and separate its components
im_fft = fft2(image);
im_phase = fftshift(angle(im_fft));
im_mag = fftshift(abs(im_fft));

% Calculate distances from center of fft
[X Y] = meshgrid(1:im_size(2),1:im_size(1)); 
distances = sqrt((X - im_size(2)/2).^2 + (Y - im_size(1)/2).^2);
% Calculate pink-noise magnitude weighting
distance_recip_square = 1./sqrt(distances);
distance_recip_square(ceil(im_size(1)/2), ceil(im_size(2)/2)) = 1;
 
% Recombine FFT info
fft_out = fftshift(distance_recip_square.*cos(im_phase) + i*distance_recip_square.*sin(im_phase));

% Inverse 2D-FFT
output = real(ifft2(fft_out));
output = output + abs(min(min(output)));
output = output / max(max(output));
% imagesc(output); colormap(gray); axis equal;
% title('Pink Noise Image');
% % Calculate power spectrum of new image
% power = (abs(fftshift(fft2(im_out)))).^2;
% figure;
% loglog(power(ceil(im_size(1)/2),ceil(im_size(2)/2):im_size(2)));
% title('Power Spectrum');
% xlabel('Spatial Frequency');
% ylabel('Power');
