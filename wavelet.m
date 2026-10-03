% Load the image
image = imread('autumn.tif');
image = im2double(image);

% Perform 2D wavelet decomposition
wavelet_level = 12; % Number of decomposition levels
wavelet_type = 'db4'; % Wavelet type
[C, S] = wavedec2(image, wavelet_level, wavelet_type);

% Set the compression ratio
compression_ratio = 0.5;

% Calculate the number of coefficients to keep
total_coeffs = sum(S(1:end-1).^2) + S(end)^2;
num_coeffs_keep = floor(compression_ratio * total_coeffs);

% Sort the absolute values of the wavelet coefficients
abs_coeffs = abs(C);
sorted_coeffs = sort(abs_coeffs, 'descend');

% Find the threshold value
threshold_index = sorted_coeffs(num_coeffs_keep);
threshold = threshold_index / sqrt(2 * log(num_coeffs_keep));

% Perform thresholding on the wavelet coefficients
C_new = C .* (abs_coeffs >= threshold);

% Perform 2D wavelet reconstruction
output_image = waverec2(C_new, S, wavelet_type);

% Display the original and compressed images
figure;
subplot(1, 2, 1);
imshow(image);
title('Original Image');
subplot(1, 2, 2);
imshow(output_image);
title('Compressed Image');

% Calculate compression ratio and bits per pixel
compressed_size = nnz(C_new);
compression_ratio_actual = compressed_size / total_coeffs;
bits_per_pixel = compressed_size / numel(image);

% Display compression information
fprintf('Compression Ratio: %.2f\n', compression_ratio_actual);
fprintf('Bits per Pixel: %.2f\n', bits_per_pixel);

% Calculate MSE and PSNR
mse = immse(image, output_image);
psnr = 10 * log10(1 / mse);
fprintf('MSE: %.4f\n', mse);
fprintf('PSNR: %.2f dB\n', psnr);
