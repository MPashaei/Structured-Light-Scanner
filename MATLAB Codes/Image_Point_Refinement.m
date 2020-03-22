function [Refined_Image_Point]=Image_Point_Refinement(Image_Point,Calibration_Parameters)
        
%          Image_point : a n*3 matrix (n:number of image points ) incloude raw image coordinates in the form of
%                      [no.point x_image y_image]
%            Calibration_Parameters : a 10*1 vector in the form of [no.camera xo yo K1 K2 K3 P1 P2 B1 B2]'

%% University of Tehran -- Faculty of Engineering
% (c) Mohammad Pashaee -- 2008
                     
x=Image_Point(:,2);
y=Image_Point(:,3);
[m,n]=size(x);
num=m;
xo=Calibration_Parameters(2);
yo=Calibration_Parameters(3);
K1=Calibration_Parameters(4);
K2=Calibration_Parameters(5);
K3=Calibration_Parameters(6);
P1=Calibration_Parameters(7);
P2=Calibration_Parameters(8);
B1=Calibration_Parameters(9);
B2=Calibration_Parameters(10);
Refined_Image_Point=[];
XO=ones(m,1).*xo;
YO=ones(m,1).*yo;
r=sqrt((Image_Point(:,2)-XO).^2+(Image_Point(:,3)-YO).^2);
    
    x_Refined=x-XO+(x-XO).*(K1.*(r.^2));%+K2*r(i).^5+K3*r(i).^7)+P1*(r(i).^2+2*(x(i)-xo).^2)+2*P2*(x(i)-xo)*(y(i)-yo)+B1*x(i)+B2*y(i);
    y_Refined=y-YO+(y-YO).*(K1.*(r.^2));%+K2*r(i).^5+K3*r(i).^7)+P2*(r(i).^2+2*(y(i)-yo).^2)+2*P1*(x(i)-xo)*(y(i)-yo)+B2*(x(i));
    
Refined_Image_Point=[Image_Point(:,1) x_Refined y_Refined];


