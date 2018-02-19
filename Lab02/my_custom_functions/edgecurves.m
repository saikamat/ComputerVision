function edgecurves = extractedge(inpic, scale, threshold, shape)

  inpic_smoothed = discgaussfft(inpic, scale);

  % 1 for the simple differences operator
  % 2 for the central differences operator
  % 3 for the Roberts cross edge operator
  % 4 for the Sobel operator
  lv = sqrt(Lv(inpic_smoothed, 2));

  %figure
  %showgrey(lv)

  % The mask for the threshold on the strength of the gradient.

  % For fuck's sake
  % The line below does not work -> zerocrosscurves needs NON-NEGATIVE
  % values for the mask, not positive.
  % lv_mask = (lv > threshold);
	
  % So, we map zero values to negative ones. Ones remain the same.
  lv_mask = ((lv > threshold) - 0.5) * 2;

  %figure
  %showgrey(lv_mask);

  % Second order derivative of smoothed inpic
  Lvv = Lvvtilde(inpic_smoothed, shape);

  %figure
  %contour(Lvv)
  %axis('ij')

  % Third order derivative of smoothed inpic
  Lvvv = Lvvvtilde(inpic_smoothed, shape);

  % The mask for the sign of the third derivative.
  % Also needs mapping to negative and positive values
  Lvvv_mask = ((Lvvv < 0) - 0.5) * 2;

  %figure
  %showgrey(Lvvv_mask)

  zerocross = zerocrosscurves(Lvv, Lvvv_mask);

  edgecurves = thresholdcurves(zerocross, lv_mask);

%   if (verbose > 0)
%     figure
%     overlaycurves(inpic, edgecurves);
%   end

end
