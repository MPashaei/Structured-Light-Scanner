function [dx,s0,j,y]=least_sq6_2(x,Y,search,p_bf)

% Least squares matching, geometric model = Affine transformation parameters,
%                         radiometric model = 2 radiometric parameters

% x, Y, search, p_bf ... see correl_coef.m
% dx ... calculated shifts, final position of the best fit of the centre of the etemplate with
% respect to the search area = p_bf+floor(sz/2)-dx
% sz ... size of the template
% s0 ... standard deviation of a unit weight (from least squares adjustment)
% s_u ... [std(dx(1)) std(dx(2)) std(par(3)) std(par(4))]
%     ... standard deviations of determined position and shift parameters of Affine transformation
% j ... number of iterations

% s_cr ... stop criterion for an iterative process, difference in determined position between j
% and j+1 iterations; see while loop, set to 0.1 px

% University of Tehran -- Faculty of Engineering
% (c) Mohammad Pashaee -- 2008

sz=size(x);

j=1;
s_cr=[10];
p0=ceil(sz/2);
p0=p0(2);
par=[0 1 1 0];
p=p0;
y=search;

while ((abs(s_cr)>0.1)) & (j<=20)
    [dx,s0,Q]=LSM6_2(x,y);
    par=par+dx';
    v=[par(1)+par(2)*p0];
    p=[p;v];
    y=resampling6_2(par,p_bf(2),Y,sz);
    TF=sum(sum(isnan(y)));
    if TF==0
        j=j+1; 
        s_cr=p(j,:)-p(j-1,:);
    else
        j=501;
        dx=[0,0]';
        s_u=[0 0];
    end
end

if TF==0
    dx=[p(1,:)-p(j,:)]';
%     B=[1 p(j,1) p(j,2) 0 0 0; 0 0 0 1 p(j,1) p(j,2)];
%     s_u=B*Q(1:6,1:6)*B';
%     s_u=s0*[sqrt(s_u(1,1)) sqrt(s_u(2,2)) sqrt(Q(1,1)) sqrt(Q(4,4))];
end
