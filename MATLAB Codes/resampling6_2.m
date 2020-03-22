function rIm=resampling6_0(par,p_bf,Y,sz);

% resampling of search area - Affine transformation

% par ... parameters of Helmert transformation
% p_bf,Y ... see correl_coef.m
% sz ... size of the template window
% rIm ... resampled image

% University of Tehran -- Faculty of Engineering
% (c) Mohammad Pashaee -- 2008

[m,n]=size(Y);

Y=Y*par(3)+par(4);

rIm=zeros(sz);

for P=1:sz(1)
    for Q=1:sz(2)
        v=[par(1)+par(2)*(Q)];
% 	    v=[par(1)+par(2)*(i)+par(3)*(j)...
% 		   par(4)+par(5)*(i)+par(6)*(j)];
        v=v+p_bf-1;
        c2=ceil(v(1));
 
		if ((c2)>n)|(c2<2)
           rIm(P,Q)=NaN;
        else
           dc=v(1)-(c2-1);
           rIm(P,Q)=Y(1,c2-1)*(1-dc)+Y(1,c2)*dc ;           
           end;
           
           
       end
    end
end

