%==========================================================================
function [Point3D]=SpaceIntersection(fL,fR,M_Point_L,M_Point_R,Exterrior_Parameters_Left,Exterrior_Parameters_Right)
% University of Tehran -- Faculty of Engineering
% (c) Mohammad Pashaee -- 2008
clc
P1=Exterrior_Parameters_Left;
P2=Exterrior_Parameters_Right;
    omega1=P1(1);
    phi1=P1(2);
    kappa1=P1(3);
    XC1=P1(4);
    YC1=P1(5);
    ZC1=P1(6);

    omega2=P2(1);
    phi2=P2(2);
    kappa2=P2(3);
    XC2=P2(4);
    YC2=P2(5);
    ZC2=P2(6);
x0=0;
y0=0;
Point3D=[];Object_Coordinate=[];
L=[M_Point_L M_Point_R];
tekrar=0;delta=1;
%==========================================================================
m111=cos(phi1)*cos(kappa1);
m121=cos(omega1)*sin(kappa1)+sin(omega1)*sin(phi1)*cos(kappa1);
m131=sin(omega1)*sin(kappa1)-cos(omega1)*cos(kappa1)*sin(phi1);
m211=-cos(phi1)*sin(kappa1);
m221=cos(omega1)*cos(kappa1)-sin(omega1)*sin(phi1)*sin(kappa1);
m231=sin(omega1)*cos(kappa1)+cos(omega1)*sin(phi1)*sin(kappa1);
m311=sin(phi1);
m321=-sin(omega1)*cos(phi1);
m331=cos(omega1)*cos(phi1);
M1=[m111 m121 m131;m211 m221 m231;m311 m321 m331];

%==================================
m112=cos(phi2)*cos(kappa2);
m122=cos(omega2)*sin(kappa2)+sin(omega2)*sin(phi2)*cos(kappa2);
m132=sin(omega2)*sin(kappa2)-cos(omega2)*cos(kappa2)*sin(phi2);
m212=-cos(phi2)*sin(kappa2);
m222=cos(omega2)*cos(kappa2)-sin(omega2)*sin(phi2)*sin(kappa2);
m232=sin(omega2)*cos(kappa2)+cos(omega2)*sin(phi2)*sin(kappa2);
m312=sin(phi2);
m322=-sin(omega2)*cos(phi2);
m332=cos(omega2)*cos(phi2);
M2=[m112 m122 m132;m212 m222 m232;m312 m322 m332];
%==========================================================================
x1=L(:,1);y1=L(:,2);
x2=L(:,3);y2=L(:,4);
a1=M1'*[x1';y1';-fL*ones(1,size(x1,1))];
a2=M2'*[x2';y2';-fR*ones(1,size(x2,1))];
Point3D=[];
for i=1:size(L,1)
    i;
    b1=a1(:,i);
    b2=a2(:,i);
    d=[b1(2)*b2(3)-b2(2)*b1(3);b2(1)*b1(3)-b1(1)*b2(3);b1(1)*b2(2)-b2(1)*b1(2)];
    Scale=inv([b1(1) d(1) -b2(1);b1(2) d(2) -b2(2);b1(3) d(3) -b2(3)])*[XC2-XC1;YC2-YC1;ZC2-ZC1];
    P=[XC1;YC1;ZC1]+Scale(1)*b1+Scale(2)/2*d;
    X=P(1);Y=P(2);Z=P(3);
    Ground=[X;Y;Z];
    %==========================================================================
while tekrar<5 & max(abs(delta))>0.001
        tekrar=tekrar+1;
%==========================================================================
m1= m111*(X-XC1)+m121*(Y-YC1)+m131*(Z-ZC1);
n1= m211*(X-XC1)+m221*(Y-YC1)+m231*(Z-ZC1);
q1= m311*(X-XC1)+m321*(Y-YC1)+m331*(Z-ZC1);
r1=m1/q1;
s1=n1/q1;
%=============================================================

C1=[fL/q1 0 -fL*r1/q1;0 fL/q1 -fL*s1/q1];

%=============================================================
m2= m112*(X-XC2)+m122*(Y-YC2)+m132*(Z-ZC2);
n2= m212*(X-XC2)+m222*(Y-YC2)+m232*(Z-ZC2);
q2= m312*(X-XC2)+m322*(Y-YC2)+m332*(Z-ZC2);
r2=m2/q2;
s2=n2/q2;
%=============================================================

C2=[fR/q2 0 -fR*r2/q2;0 fR/q2 -fR*s2/q2];
%=============================================================
dm2dX1=m111;
dm2dY1=m121;
dm2dZ1=m131;
dn2dX1=m211;
dn2dY1=m221;
dn2dZ1=m231;
dq2dX1=m311;
dq2dY1=m321;
dq2dZ1=m331;

dm2dX2=m112;
dm2dY2=m122;
dm2dZ2=m132;
dn2dX2=m212;
dn2dY2=m222;
dn2dZ2=m232;
dq2dX2=m312;
dq2dY2=m322;
dq2dZ2=m332;
%============================================================
D1=[ dm2dX1 dm2dY1 dm2dZ1;...
     dn2dX1 dn2dY1 dn2dZ1;...
     dq2dX1 dq2dY1 dq2dZ1];

%===========================================================
D2=[ dm2dX2 dm2dY2 dm2dZ2;...
     dn2dX2 dn2dY2 dn2dZ2;...
     dq2dX2 dq2dY2 dq2dZ2];
%===========================================================
f11=(x1(i)-x0)+fL*m1/q1;
f21=(y1(i)-y0)+fL*n1/q1;

f12=(x2(i)-x0)+fR*m2/q2;
f22=(y2(i)-y0)+fR*n2/q2;
%===========================================================
Q1=C1*D1;      L1=[-f11;-f21]; 
Q2=C2*D2;      L2=[-f12;-f22];
A=[Q1;Q2];     F=[L1;L2];
%===========================================================
 delta=inv(A'*A)*A'*F;
 Ground=Ground+delta;
        X=Ground(1);
        Y=Ground(2);
        Z=Ground(3);
  end;
   Point3D=[Point3D;X Y Z];
   Cx{i}=inv(A'*A);
   Residual{i}=A*delta-F;
end;