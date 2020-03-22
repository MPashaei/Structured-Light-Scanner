%==========================================================================
function [Essential_Matrix,R,T,meanE,stddevE,minimE,maximE,MinParalax,MaxParalax]=EssentialMtrix_Calculation(fL,fR,x1,x2,Optical_Center_L,Rotation_Vector_L,Optical_Center_R,Rotation_Vector_R)
% University of Tehran -- Faculty of Engineering
% (c) Mohammad Pashaee -- 2008
clc;
T_vect_L=Optical_Center_L;
R_vect_L=Rotation_Vector_L;
T_vect_R=Optical_Center_R;
R_vect_R=Rotation_Vector_R;
omega1=R_vect_L(1);
phi1=R_vect_L(2);
kappa1=R_vect_L(3);
omega2=R_vect_R(1);
phi2=R_vect_R(2);
kappa2=R_vect_R(3);
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

%==========================================================================
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
R0=M1*M2';
T0=M1*(T_vect_R-T_vect_L);
T0=T0/norm(T0);
T_Matrix=asym(T0);
E=T_Matrix*R0;
% E=M1*asym((T_vect_R-T_vect_L)/norm((T_vect_R-T_vect_L)))*M2';
% E=M1*asym((T_vect_R-T_vect_L))*M2';
%==========================================================================
TEST=diag(x1'*E*x2);
[meanE,stddevE,minimE,maximE]=funmatError([x1(1:2,:);x2(1:2,:)],E,fL,fR);
        disp('Essential Matrix')
        disp(E)
        disp(sprintf('Distance point-epipolar line\nmean: %f  stdev: %f  min: %f  max: %f\n',meanE,stddevE,minimE,maximE));
        disp(sprintf('Rank-2: %d',rank(E)==2)) 
[R0,T0,E,Paralax_y_initial,Paralax_y_final] = LS_Rotation_matrix (R0,T0,x1',x2');
[meanE,stddevE,minimE,maximE]=funmatError([x1(1:2,:);x2(1:2,:)],E,fL,fR);
        disp('Essential Matrix After Least Square Minimization')
        disp(E)
        disp(sprintf('Distance point-epipolar line\nmean: %f  stdev: %f  min: %f  max: %f\n',meanE,stddevE,minimE,maximE));
        disp(sprintf('Rank-2: %d',rank(E)==2)) 
R=R0;
T=T0;
Essential_Matrix=E;
MinParalax=min(abs((Paralax_y_final(:))));
MaxParalax=max(abs((Paralax_y_final(:))));
maximE=maximE;
%==========================================================================

