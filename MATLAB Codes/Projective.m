function [projective_param,Residual_projective]=Projective(calib_coord,fid_coord)

% University of Tehran -- Faculty of Engineering
% (c) Mohammad Pashaee -- 2008

if nargin<2
    disp('??? Error using ==> Projective');
    disp('Not enough input arguments.');
    return
else
    calib_coord=[[1:4]' calib_coord];
    Residual_projective=[[1:4]' zeros(4,2)];
    [m,n]=size(calib_coord);
    if m>3
        for i=1:m
            X(i)=calib_coord(i,2);
            Y(i)=calib_coord(i,3);
            x(i)=fid_coord(i,1);
            y(i)=fid_coord(i,2);
            %%%%%%%%%%%%%      projective
            F(2*i-1,1)=x(i);
            F(2*i,1)=y(i);
            A(2*i-1,:)=[X(i) Y(i) 1 0 0 0 -x(i)*X(i) -x(i)*Y(i)];
            A(2*i,:)=[0 0 0 X(i) Y(i) 1 -X(i)*y(i) -y(i)*Y(i)];
        end
        projective_param=inv(A'*A)*A'*F;
        V=A*projective_param-F;
        if m>4
            for i=1:m
                Residual_projective(calib_coord(i,1),2)=V(2*i-1);
                Residual_projective(calib_coord(i,1),3)=V(2*i);
            end
        end
    else
        disp('Projective>The Point Number is not enough');
        return
    end
end
