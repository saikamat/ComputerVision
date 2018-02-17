% Create two difference operators deltax and deltay that approximate the 
% first order partial derivatives in two orthogonal directions.

function [dxtools dytools] = deriv(input_image, kernel_type, shape)

[delta_x, delta_y] = get_dir_kernels_delta_type(kernel_type);

dxtools = conv2(input_image, delta_x, shape);
dytools = conv2(input_image, delta_y, shape);

end
% end maks termination of a function. it's optional, but better for code 
% reusability. this is esssential, if there are nested statements, private
% and inbuilt local functions.