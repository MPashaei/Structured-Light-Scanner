% [X,lambda] = compute3DStructure(x,xp,R,T)
%
% The basic triangulation algorithm 
% for recovering the depth of a point given the projection onto
% two images and the relative pose of the cameras,
% as described in Chapter 5, "An introduction to 3-D Vision"
% by Y. Ma, S. Soatto, J. Kosecka, S. Sastry (MASKS)
%
% Code distributed free for non-commercial use
% Copyright (c) MASKS, 2003
%
% Last modified 5/5/2003
%
%

function [XP, lambda] = compute3DStructure(p, q, R, T);
nc = size(q, 2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % linear triangulation method
   M = [];
   for i=1:nc
     A = [ 0 -1  p(2,i) 0;
           -1  0 p(1,i) 0;
          (-R(2,:) + q(2,i)*R(3,:)) -T(2) + q(2,i)*T(3);
          (-R(1,:) + q(1,i)*R(3,:)) -T(1) + q(1,i)*T(3)];
    [ua,sa,va] = svd(A);
    X(:,i) = va(:,4);
   end
   XP(:,:,1) = [X(1,:)./X(4,:);X(2,:)./X(4,:);X(3,:)./X(4,:)];
   lambda = XP(3,:,1);
   tt = [R, T; 0 0 0 1]*[XP(:,:,1); ones(1,nc)];
   XP(:,:,2) = tt(1:3,:);





