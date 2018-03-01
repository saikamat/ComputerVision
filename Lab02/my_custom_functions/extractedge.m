function edgecurves = extractedge(inpic, scale, threshold, shape)

inpic_smooth = discgaussfft(inpic, scale);

lvv = Lvvtilde(inpic_smooth, shape);
lvvv = Lvvvtilde(inpic_smooth, shape);
lvvv_mask = ((lvvv > threshold) - 0.5)*2;

zero_crossing_curves = zerocrosscurves(lvv, lvvv_mask);

lv = sqrt(Lv(inpic_smooth, 2)); %since 2 => CDO
lv_mask = ((lv > threshold) - 0.5)*2;

edgecurves = thresholdcurves(zero_crossing_curves, lv_mask);

end

