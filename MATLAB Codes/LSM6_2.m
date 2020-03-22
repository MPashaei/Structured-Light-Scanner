function [dx,s0,Q]=LSM6_2(t,s);

% Least squares matching
% Calculatin corrections of transformation parameters of Affine transformation

% t ... template
% s ... search area
% dx ... corrections of transformation parameters
% s0 ... standard deviation of a unit weight (from least squares adjustment)
% Q ... cofactor matrix

% University of Tehran -- Faculty of Engineering
% (c) Mohammad Pashaee -- 2008
[K,L]=size(t);
px=1;

A=ones(K*L,4);
ll=ones(K*L,1);

%================= Fill A-Matrix ==========================================
for j=1:K
    for i=2:(L-1)
        A(L*(j-1)+i,1)=(s(j,i)-s(j,i+1))/(2*px);
    end
end
A(K,1)=(s(K,2)-s(K,1));
A(L,1)=(s(K,L)-s(K,L-1));

for i=1:L
    for j=1:K
        A(L*(j-1)+i,2)=A(L*(j-1)+i,1)*i;
    end
end
for j=1:K
    for i=1:L
        A(L*(j-1)+i,3)=s(j,i);
        ll(L*(j-1)+i,1)=t(j,i)-s(j,i);
    end
end


Q=pinv(A'*A);
dx=Q*A'*ll;
v=A*dx-ll;
s0=sqrt(v'*v/(K*L-4));