function [delta_x_kernel, delta_y_kernel] = get_dir_kernels_delta_type(kernel_type)

switch(kernel_type)
    case 1  % simple difference operator
        delta_x_kernel = [-1 0 1];
        delta_y_kernel = [-1 0 1]';
    case 2  % central differences operator
        delta_x_kernel = [-0.5 0 0.5];
        delta_y_kernel = [-0.5 0 0.5];
    case 3  % robert's cross edge operator
        delta_x_kernel = [1 0; 0 -1];
        delta_y_kernel = [0 1; -1 0];
    case 4  % sobel operator
        delta_x_kernel = [-1 0 1; -2 0 2; -1 0 1];
        delta_y_kernel = [1 2 1; 0 0 0; -1 -2 -1];
    case 5  % second order central difference operator
        delta_x_kernel = [1 -2 1];
        delta_y_kernel = [1; -2; 1];
    otherwise
        delta_x_kernel = [-1 0 1];
        delta_y_kernel = [-1 0 1]';
end
        