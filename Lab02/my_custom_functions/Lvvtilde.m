function pixels = Lvvtilde(inpic, shape);

if (nargin < 2)
    shape = 'same';
end

%get first order derivative kernels
% 2 corresponds to first order CDO
[dxmask, dymask] = get_dir_kernels_delta_type(2);

%including the kernel in a 5x5 matrix
dxmask_5 = zeros(5,5);
dxmask_5(3, 2:4) = dxmask;

dymask_5 = zeros(5,5);
dymask_5(2:4, 3) = dymask;

Lx = filter2(dxmask_5, inpic, shape);
Ly = filter2(dymask_5, inpic, shape);

%get 2nd order derivative kernel
% 5 corresponds to second order CDO
[dxxmask, dyymask] = get_dir_kernels_delta_type(5);

%include them in a 5x5 matrix
dxxmask_5 = zeros(5,5);
dxxmask_5(3, 2:4) = dxxmask;

dyymask_5 = zeros(5,5);
dyymask_5(2:4, 3) = dyymask;

Lxx = filter2(dxxmask_5, inpic, shape);
Lyy = filter2(dyymask_5, inpic, shape);

dxymask_5 = conv2(dxmask_5, dymask_5, 'same');
Lxy = filter2(dxymask_5, inpic, shape);

pixels = Lx.^2.*Lxx + Ly.^2.*Lyy + 2.*Lx.*Ly.*Lxy;

end