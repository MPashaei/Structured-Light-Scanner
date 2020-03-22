function x =get_homg(x)
% h = vgg_get_homg(p)
%
% Convert a set of non-homogeneous points into homogeneous points
% Points are stored as column vectors, stacked horizontally, e.g.
%  [x0 x1 x2 x3 ... xn ;
%   y0 y1 y2 y3 ... yn]
% University of Tehran -- Faculty of Engineering
% (c) Mohammad Pashaee -- 2008

if isempty(x)
  return
end

x(end+1,:) = 1;

return
