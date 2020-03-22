function [r_max,pos,r,search,p_bf]=correl_coef(x,Y)

% cross correlation of two images x, Y
% x ... template (smaller)
% Y ... search area (larger)

% r_max ... max. correlation coefficient
% r ... discrete correlation function
% pos ... position of the best fit with respect to the search area (Y), centre of the template
% p_bf ... position of the best fit with respect to the search area (Y), upper left corner the template
% search ... section of y corresponding to the size of the template at the position of the best fit

% University of Tehran -- Faculty of Engineering
% (c) Mohammad Pashaee -- 2008

x=double(x);
Y=double(Y);

[m,n]=size(x);

[m1,n1]=size(Y);

r_max=-1;
p_bf=[-1,-1];

for rm=1:(m1-m+1)
   for s=1:(n1-n+1)
      y=Y(rm:(rm+m-1),s:(s+n-1));
		avx=mean(x(:));
		avy=mean(y(:));
		r1=0;
		r2=0;
		r3=0;
		for i=1:m
		   for j=1:n
      		r1=r1+(x(i,j)-avx)*(y(i,j)-avy);
		      r2=r2+(x(i,j)-avx)^2;
		      r3=r3+(y(i,j)-avy)^2;
		   end
		end
      r(rm,s)=r1/sqrt(r2*r3);
      if r(rm,s)>r_max
         r_max=r(rm,s);
         p_bf=[rm,s];
     end
   end
end
search=Y(p_bf(1):(p_bf(1)+m-1),p_bf(2):(p_bf(2)+n-1));
pos=[p_bf(1)+floor(m/2) p_bf(2)+floor(n/2)];