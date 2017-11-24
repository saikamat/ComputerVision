clear;

% Input image
tools = few256;

[tools_size_x tools_size_y] = size(tools)

% 1 for the simple differences operator
% 2 for the central differences operator
% 3 for the Roberts cross edge operator
% 4 for the Sobel operator
[dxtools_1 dytools_1] = deriv(tools, 1, 'valid');
[dxtools_2 dytools_2] = deriv(tools, 2, 'valid');
[dxtools_3 dytools_3] = deriv(tools, 3, 'valid');
[dxtools_4 dytools_4] = deriv(tools, 4, 'valid');

figure

subplot(4,2,1);
showgrey(dxtools_1);
title('SDO: X-wise derivative')

subplot(4,2,2);
showgrey(dytools_1);
title('SDO: Y-wise derivative')

[dxtools_1_size_x dxtools_1_size_y] = size(dxtools_1)
[dytools_1_size_x dytools_1_size_y] = size(dytools_1)


subplot(4,2,3);
showgrey(dxtools_2);
title('CDO: X-wise derivative')

subplot(4,2,4);
showgrey(dytools_2);
title('CDO: Y-wise derivative')

[dxtools_2_size_x dxtools_2_size_y] = size(dxtools_2)
[dytools_2_size_x dytools_2_size_y] = size(dytools_2)


subplot(4,2,5);
showgrey(dxtools_3);
title('Roberts: X-wise derivative')

subplot(4,2,6);
showgrey(dytools_3);
title('Roberts: Y-wise derivative')

[dxtools_3_size_x dxtools_3_size_y] = size(dxtools_3)
[dytools_3_size_x dytools_3_size_y] = size(dytools_3)


subplot(4,2,7);
showgrey(dxtools_4);
title('Sobel: X-wise derivative')

subplot(4,2,8);
showgrey(dytools_4);
title('Sobel: Y-wise derivative')

[dxtools_4_size_x dxtools_4_size_y] = size(dxtools_4)
[dytools_4_size_x dytools_4_size_y] = size(dytools_4)
