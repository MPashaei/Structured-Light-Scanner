function [conformal_param]=Conformal(GCP_coord,img_coord)

% University of Tehran -- Faculty of Engineering
% (c) Mohammad Pashaee -- 2008
if nargin<2
    disp('??? Error using ==> Conformal');
    disp('Not enough input arguments.');
    return
else
       
        [m,n]=size(GCP_coord);
%   Po=inv(ones(2*m,2*m)*(30e10-6));
    if m>1
        for i=1:m
            X(i)=GCP_coord(i,2);
            Y(i)=GCP_coord(i,3);
            x(i)=img_coord(i,1);
            y(i)=img_coord(i,2);
            %%%%%%%%%%%%%      conformal
            F(2*i-1,1)=X(i);
            F(2*i,1)=Y(i);
            A(2*i-1,:)=[x(i) y(i) 1 0 ];
            A(2*i,:)=[y(i) -x(i) 0 1 ];
        end
        conformal_param=inv(A'*A)*A'*F;
              
    end;
end
