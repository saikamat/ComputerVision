function[pixels] = gaussfft(pic, t)
%pic = input image, t = arbitrarily chosen variance, ranging from 0.1, 0.3,
%1.0, 10.0 and 100.0

%With spatial discretization and convolution via FFT:
%1. Generate a Filter based on a sampled version of the Gaussian function.
[x_pic, y_pic] = size(pic);
[x, y] = meshgrid(-x_pic/2:x_pic/2 - 1, -y_pic/2: y_pic/2 - 1);
gaus_fn = 1/(2*pi*t)*exp(-(x.*x + y.*y)./(2*t));
 
%2. Fourier transform the original image and the Gaussian Filter.
fourier_transform = fft2(pic);
gaussian_transform = fft2(fftshift(gaus_fn));

%3. Multiply the Fourier transforms.
Fhat = fourier_transform .* gaussian_transform;

%4. Invert the resulting Fourier transform.
pixels = real(ifft2(Fhat));
end