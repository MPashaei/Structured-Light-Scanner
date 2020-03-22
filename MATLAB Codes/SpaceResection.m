function [Parameter,Residual,Cx]=SpaceResection(point,f,xo,yo,num)

% University of Tehran -- Faculty of Engineering
% (c) Mohammad Pashaee -- 2008
%%%%%%%%%%%%     point = Coodinates of Control Points in Image and Object Space with Following Formats
%%%%%%%%%%%%     point = [pointNumber xGroundCoo yGroundCoo zGroundCoo xImageCoo yImageCoo];
Iteration = 10;
X=point(:,2);
Y=point(:,3);
Z=point(:,4);
x=point(:,5);
y=point(:,6);
%%%%%%%%%%%%%%%%% Colculate initial value  for Parameters %%%%%%%%%%%%%%%%%%%
k=0;
for i=1:num
    for j=1:num
        k=k+1;
        L=sqrt((x(i)-x(j))^2+((y(i)-y(j))^2));
        dist(k,:)=[i j L];
    end
end
W=eye(2*num);

N = find(dist(:,3)==max(dist(:,3)));
xFirst=[x(dist(N(1),1));x(dist(N(1),2))];
yFirst=[y(dist(N(1),1));y(dist(N(1),2))];
XFirst=[X(dist(N(1),1));X(dist(N(1),2))];
YFirst=[Y(dist(N(1),1));Y(dist(N(1),2))];
ZFirst=[Z(dist(N(1),1));Z(dist(N(1),2))];

[P]=Conformal_1([[1:2]' XFirst YFirst],[xFirst yFirst]);

lambda=sqrt(P(1)^2+P(2)^2);
XC = P(3);
YC = P(4);
ZC = f*lambda+(sum(ZFirst)/2);
if P(1)>0 & P(2)>0
    kappa=-atan(abs(P(2)/P(1)));
elseif P(1)<0 & P(2)>0
    kappa=-pi/2-atan(abs(P(1)/P(2)));
elseif P(1)<0 & P(2)<0
    kappa=pi/2+atan(abs(P(1)/P(2)));
    
elseif P(1)>0 & P(2)<0
    kappa=atan(abs(P(2)/P(1)));
end
omega=0;
phi=0;
%======== original ============================
%  resectionParameter=[omega;phi;kappa;XC;YC;ZC];%%%%%%%%% sample: f=152.844
%===============================================
%============ my self ==========================
  resectionParameter=[XC;YC;ZC;omega;phi;kappa];
 %=============================================
iteration=0;
dP=ones(6,1);

 while (iteration<Iteration)&(max(abs(dP(1:3)))>10e-6)&(max(abs(dP(4:6)))>.001)
    iteration=iteration+1;
 %=========================================================================
 %=========================================================================
% 
A=[];F=[];
 for i=1:num
 %============ Rotation matrix #1===========================
M(1,1)=cos(phi)*cos(kappa);
M(1,2)=cos(omega)*sin(kappa)+sin(omega)*sin(phi)*cos(kappa);
M(1,3)=sin(omega)*sin(kappa)-cos(omega)*cos(kappa)*sin(phi);
M(2,1)=-cos(phi)*sin(kappa);
M(2,2)=cos(omega)*cos(kappa)-sin(omega)*sin(phi)*sin(kappa);
M(2,3)=sin(omega)*cos(kappa)+cos(omega)*sin(phi)*sin(kappa);
M(3,1)=sin(phi);
M(3,2)=-sin(omega)*cos(phi);
M(3,3)=cos(omega)*cos(phi);


%============================================================
 
m(i,1)= M(1,1)*(X(i)-XC)+M(1,2)*(Y(i)-YC)+M(1,3)*(Z(i)-ZC);
n(i,1)= M(2,1)*(X(i)-XC)+M(2,2)*(Y(i)-YC)+M(2,3)*(Z(i)-ZC);
q(i,1)= M(3,1)*(X(i)-XC)+M(3,2)*(Y(i)-YC)+M(3,3)*(Z(i)-ZC);
r(i,1)=m(i,1)/q(i,1);
s(i,1)=n(i,1)/q(i,1);
%=============================================================

C=[f/q(i,1) 0 -f*r(i,1)/q(i,1);0 f/q(i,1) -f*s(i,1)/q(i,1)];

%=============================================================

dm2dX0=-M(1,1);
dm2dY0=-M(1,2);
dm2dZ0=-M(1,3);
dm2domega=M(1,2)*(Z(i)-ZC)+M(1,3)*(YC-Y(i));
dm2dphi=-cos(kappa)*q(i,1);
dm2dkapa=n(i,1);
dn2dX0=-M(2,1);
dn2dY0=-M(2,2);
dn2dZ0=-M(2,3);
dn2domega=M(2,2)*(Z(i)-ZC)+M(2,3)*(YC-Y(i));
dn2dphi=sin(kappa)*q(i,1);
dn2dkapa=-m(i,1);
dq2dX0=-M(3,1);
dq2dY0=-M(3,2);
dq2dZ0=-M(3,3);
dq2domega=M(3,2)*(Z(i)-ZC)+M(3,3)*(YC-Y(i));
dq2dphi=cos(kappa)*m(i,1)-sin(kappa)*n(i,1);
dq2dkapa=0;
%============================================================
D=[  dm2dX0 dm2dY0 dm2dZ0 dm2domega dm2dphi dm2dkapa;...
     dn2dX0 dn2dY0 dn2dZ0 dn2domega dn2dphi dn2dkapa;...
     dq2dX0 dq2dY0 dq2dZ0 dq2domega dq2dphi dq2dkapa];

%===========================================================
F1=(x(i,1)-xo)+f*m(i,1)/q(i,1);
F2=(y(i,1)-yo)+f*n(i,1)/q(i,1);

F=[F;-F1;-F2];
Q=C*D;
A=[A;Q];
 end;
  dP=inv(A'*W*A)*A'*W*F;
        Residual=A*dP-F;
        resectionParameter=resectionParameter+dP;
        omega=resectionParameter(4,1);
        phi=resectionParameter(5,1);
        kappa=resectionParameter(6,1);
       
        XC=resectionParameter(1,1);
        YC=resectionParameter(2,1);
        ZC=resectionParameter(3,1);
 end
 resectionParameter(4,1)=resectionParameter(4,1);
 resectionParameter(5,1)=resectionParameter(5,1);
 resectionParameter(6,1)=resectionParameter(6,1);
 Parameter=[resectionParameter(4:6);resectionParameter(1:3)];
 %=========================================================================
 %=========================================================================
 
%  M=[ cos(phi)*cos(kappa)     cos(omega)*sin(kappa)+sin(omega)*sin(phi)*cos(kappa)      sin(omega)*sin(kappa)-cos(omega)*sin(phi)*cos(kappa)
%         -cos(phi)*sin(kappa)     cos(omega)*cos(kappa)-sin(omega)*sin(phi)*sin(kappa)      sin(omega)*cos(kappa)+cos(omega)*sin(phi)*sin(kappa)
%         sin(phi)                -sin(omega)*cos(phi)                                      cos(omega)*cos(phi)];
% 
% 
%     for i=1:num
%         A(2*i-1,:) = [  -f*((-sin(omega)*sin(kappa)+cos(omega)*sin(phi)*cos(kappa))*(Y(i)-YC)+(cos(omega)*sin(kappa)+sin(omega)*sin(phi)*cos(kappa))*(Z(i)-ZC))/(sin(phi)*(X(i)-XC)-sin(omega)*cos(phi)*(Y(i)-YC)+cos(omega)*cos(phi)*(Z(i)-ZC))+f*(cos(phi)*cos(kappa)*(X(i)-XC)+(cos(omega)*sin(kappa)+sin(omega)*sin(phi)*cos(kappa))*(Y(i)-YC)+(sin(omega)*sin(kappa)-cos(omega)*sin(phi)*cos(kappa))*(Z(i)-ZC))/(sin(phi)*(X(i)-XC)-sin(omega)*cos(phi)*(Y(i)-YC)+cos(omega)*cos(phi)*(Z(i)-ZC))^2*(-cos(omega)*cos(phi)*(Y(i)-YC)-sin(omega)*cos(phi)*(Z(i)-ZC)),        -f*(-sin(phi)*cos(kappa)*(X(i)-XC)+sin(omega)*cos(phi)*cos(kappa)*(Y(i)-YC)-cos(omega)*cos(phi)*cos(kappa)*(Z(i)-ZC))/(sin(phi)*(X(i)-XC)-sin(omega)*cos(phi)*(Y(i)-YC)+cos(omega)*cos(phi)*(Z(i)-ZC))+f*(cos(phi)*cos(kappa)*(X(i)-XC)+(cos(omega)*sin(kappa)+sin(omega)*sin(phi)*cos(kappa))*(Y(i)-YC)+(sin(omega)*sin(kappa)-cos(omega)*sin(phi)*cos(kappa))*(Z(i)-ZC))/(sin(phi)*(X(i)-XC)-sin(omega)*cos(phi)*(Y(i)-YC)+cos(omega)*cos(phi)*(Z(i)-ZC))^2*(cos(phi)*(X(i)-XC)+sin(omega)*sin(phi)*(Y(i)-YC)-cos(omega)*sin(phi)*(Z(i)-ZC)),                                                                                                                                                                                                                                                                     -f*(-cos(phi)*sin(kappa)*(X(i)-XC)+(cos(omega)*cos(kappa)-sin(omega)*sin(phi)*sin(kappa))*(Y(i)-YC)+(sin(omega)*cos(kappa)+cos(omega)*sin(phi)*sin(kappa))*(Z(i)-ZC))/(sin(phi)*(X(i)-XC)-sin(omega)*cos(phi)*(Y(i)-YC)+cos(omega)*cos(phi)*(Z(i)-ZC)),                                                                                                                                                              f*cos(phi)*cos(kappa)/(sin(phi)*(X(i)-XC)-sin(omega)*cos(phi)*(Y(i)-YC)+cos(omega)*cos(phi)*(Z(i)-ZC))-f*(cos(phi)*cos(kappa)*(X(i)-XC)+(cos(omega)*sin(kappa)+sin(omega)*sin(phi)*cos(kappa))*(Y(i)-YC)+(sin(omega)*sin(kappa)-cos(omega)*sin(phi)*cos(kappa))*(Z(i)-ZC))/(sin(phi)*(X(i)-XC)-sin(omega)*cos(phi)*(Y(i)-YC)+cos(omega)*cos(phi)*(Z(i)-ZC))^2*sin(phi),                                                                                                              -f*(-cos(omega)*sin(kappa)-sin(omega)*sin(phi)*cos(kappa))/(sin(phi)*(X(i)-XC)-sin(omega)*cos(phi)*(Y(i)-YC)+cos(omega)*cos(phi)*(Z(i)-ZC))+f*(cos(phi)*cos(kappa)*(X(i)-XC)+(cos(omega)*sin(kappa)+sin(omega)*sin(phi)*cos(kappa))*(Y(i)-YC)+(sin(omega)*sin(kappa)-cos(omega)*sin(phi)*cos(kappa))*(Z(i)-ZC))/(sin(phi)*(X(i)-XC)-sin(omega)*cos(phi)*(Y(i)-YC)+cos(omega)*cos(phi)*(Z(i)-ZC))^2*sin(omega)*cos(phi),                                                                                                              -f*(-sin(omega)*sin(kappa)+cos(omega)*sin(phi)*cos(kappa))/(sin(phi)*(X(i)-XC)-sin(omega)*cos(phi)*(Y(i)-YC)+cos(omega)*cos(phi)*(Z(i)-ZC))-f*(cos(phi)*cos(kappa)*(X(i)-XC)+(cos(omega)*sin(kappa)+sin(omega)*sin(phi)*cos(kappa))*(Y(i)-YC)+(sin(omega)*sin(kappa)-cos(omega)*sin(phi)*cos(kappa))*(Z(i)-ZC))/(sin(phi)*(X(i)-XC)-sin(omega)*cos(phi)*(Y(i)-YC)+cos(omega)*cos(phi)*(Z(i)-ZC))^2*cos(omega)*cos(phi)];
%         A(2*i,:) = [ -f*((-sin(omega)*cos(kappa)-cos(omega)*sin(phi)*sin(kappa))*(Y(i)-YC)+(cos(omega)*cos(kappa)-sin(omega)*sin(phi)*sin(kappa))*(Z(i)-ZC))/(sin(phi)*(X(i)-XC)-sin(omega)*cos(phi)*(Y(i)-YC)+cos(omega)*cos(phi)*(Z(i)-ZC))+f*(-cos(phi)*sin(kappa)*(X(i)-XC)+(cos(omega)*cos(kappa)-sin(omega)*sin(phi)*sin(kappa))*(Y(i)-YC)+(sin(omega)*cos(kappa)+cos(omega)*sin(phi)*sin(kappa))*(Z(i)-ZC))/(sin(phi)*(X(i)-XC)-sin(omega)*cos(phi)*(Y(i)-YC)+cos(omega)*cos(phi)*(Z(i)-ZC))^2*(-cos(omega)*cos(phi)*(Y(i)-YC)-sin(omega)*cos(phi)*(Z(i)-ZC)),        -f*(sin(phi)*sin(kappa)*(X(i)-XC)-sin(omega)*cos(phi)*sin(kappa)*(Y(i)-YC)+cos(omega)*cos(phi)*sin(kappa)*(Z(i)-ZC))/(sin(phi)*(X(i)-XC)-sin(omega)*cos(phi)*(Y(i)-YC)+cos(omega)*cos(phi)*(Z(i)-ZC))+f*(-cos(phi)*sin(kappa)*(X(i)-XC)+(cos(omega)*cos(kappa)-sin(omega)*sin(phi)*sin(kappa))*(Y(i)-YC)+(sin(omega)*cos(kappa)+cos(omega)*sin(phi)*sin(kappa))*(Z(i)-ZC))/(sin(phi)*(X(i)-XC)-sin(omega)*cos(phi)*(Y(i)-YC)+cos(omega)*cos(phi)*(Z(i)-ZC))^2*(cos(phi)*(X(i)-XC)+sin(omega)*sin(phi)*(Y(i)-YC)-cos(omega)*sin(phi)*(Z(i)-ZC)),                                                                                                                                                                                                                                                                   -f*(-cos(phi)*cos(kappa)*(X(i)-XC)+(-cos(omega)*sin(kappa)-sin(omega)*sin(phi)*cos(kappa))*(Y(i)-YC)+(-sin(omega)*sin(kappa)+cos(omega)*sin(phi)*cos(kappa))*(Z(i)-ZC))/(sin(phi)*(X(i)-XC)-sin(omega)*cos(phi)*(Y(i)-YC)+cos(omega)*cos(phi)*(Z(i)-ZC)),                                                                                                                                                            -f*cos(phi)*sin(kappa)/(sin(phi)*(X(i)-XC)-sin(omega)*cos(phi)*(Y(i)-YC)+cos(omega)*cos(phi)*(Z(i)-ZC))-f*(-cos(phi)*sin(kappa)*(X(i)-XC)+(cos(omega)*cos(kappa)-sin(omega)*sin(phi)*sin(kappa))*(Y(i)-YC)+(sin(omega)*cos(kappa)+cos(omega)*sin(phi)*sin(kappa))*(Z(i)-ZC))/(sin(phi)*(X(i)-XC)-sin(omega)*cos(phi)*(Y(i)-YC)+cos(omega)*cos(phi)*(Z(i)-ZC))^2*sin(phi),                                                                                                             -f*(-cos(omega)*cos(kappa)+sin(omega)*sin(phi)*sin(kappa))/(sin(phi)*(X(i)-XC)-sin(omega)*cos(phi)*(Y(i)-YC)+cos(omega)*cos(phi)*(Z(i)-ZC))+f*(-cos(phi)*sin(kappa)*(X(i)-XC)+(cos(omega)*cos(kappa)-sin(omega)*sin(phi)*sin(kappa))*(Y(i)-YC)+(sin(omega)*cos(kappa)+cos(omega)*sin(phi)*sin(kappa))*(Z(i)-ZC))/(sin(phi)*(X(i)-XC)-sin(omega)*cos(phi)*(Y(i)-YC)+cos(omega)*cos(phi)*(Z(i)-ZC))^2*sin(omega)*cos(phi),                                                                                                             -f*(-sin(omega)*cos(kappa)-cos(omega)*sin(phi)*sin(kappa))/(sin(phi)*(X(i)-XC)-sin(omega)*cos(phi)*(Y(i)-YC)+cos(omega)*cos(phi)*(Z(i)-ZC))-f*(-cos(phi)*sin(kappa)*(X(i)-XC)+(cos(omega)*cos(kappa)-sin(omega)*sin(phi)*sin(kappa))*(Y(i)-YC)+(sin(omega)*cos(kappa)+cos(omega)*sin(phi)*sin(kappa))*(Z(i)-ZC))/(sin(phi)*(X(i)-XC)-sin(omega)*cos(phi)*(Y(i)-YC)+cos(omega)*cos(phi)*(Z(i)-ZC))^2*cos(omega)*cos(phi)];
%         F(2*i-1,1) = x(i) - (-f)*((M(1,1)*(X(i)-XC)+M(1,2)*(Y(i)-YC)+M(1,3)*(Z(i)-ZC))/(M(3,1)*(X(i)-XC)+M(3,2)*(Y(i)-YC)+M(3,3)*(Z(i)-ZC)));
%         F(2*i,1) = y(i) - (-f)*((M(2,1)*(X(i)-XC)+M(2,2)*(Y(i)-YC)+M(2,3)*(Z(i)-ZC))/(M(3,1)*(X(i)-XC)+M(3,2)*(Y(i)-YC)+M(3,3)*(Z(i)-ZC)));
%     end
% 
%         dP=inv(A'*W*A)*A'*W*F;
%          Residual=A*dP-F;
%         resectionParameter=resectionParameter+dP;
%         omega=resectionParameter(1,1);
%         phi=resectionParameter(2,1);
%         kappa=resectionParameter(3,1);
%        
%         XC=resectionParameter(4,1);
%         YC=resectionParameter(5,1);
%         ZC=resectionParameter(6,1);
%  end
%  resectionParameter(1,1)=resectionParameter(1,1)*180/pi;
%  resectionParameter(2,1)=resectionParameter(2,1)*180/pi;
%  resectionParameter(3,1)=resectionParameter(3,1)*180/pi;
%  Parameter=resectionParameter;
  Cx=inv(A'*W*A);
  
END=1

%==========================================================================
%==========================================================================
 






