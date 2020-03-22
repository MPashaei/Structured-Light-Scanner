clc
clear all
close all
%==========================================================================
[filename,filepath]=uigetfile('*.*','Open Scan Image');
IMG=imread(fullfile(filepath,filename));
[filename,filepath]=uigetfile('*.*','Open TH_1 Image');
Th_IMG_1=imread(fullfile(filepath,filename));
[filename,filepath]=uigetfile('*.*','Open TH_2 Image');
Th_IMG_2=imread(fullfile(filepath,filename));
IMG=IMG(:,:,1);
DIMG=double(IMG);
Th_IMG_1=Th_IMG_1(:,:,1);
DTh_IMG_1=double(Th_IMG_1);
Th_IMG_2=Th_IMG_2(:,:,1);
DTh_IMG_2=double(Th_IMG_2);
TH_IMG=(Th_IMG_1+Th_IMG_2)/2;
DTH_IMG=(DTh_IMG_1+DTh_IMG_2)/2;
%==========================================================================
IMG1=IMG-TH_IMG;
IMG=IMG1;
[nR,nC]=size(IMG);K=[1 1 1 1 -1 -1 -1 -1];

        

%==========================================================================
% winX=2;winY=2;
% mask_Y = exp(-((-winX:winX)'/(2)).^2);
% mask_X = (exp(-((-winX:winX)'/(2)).^2))';
% % mask = exp(-((-winX:winX)'/(winX)).^2) * exp(-((-winY:winY)/(winY)).^2);
% %==========================================================================
% gx=mask_Y*gradient(mask_X);
% gy=gradient(mask_Y)*mask_X;
% gxx=mask_Y*gradient(gradient(mask_X));
% gyy=gradient(gradient(mask_Y))*mask_X;
% gxy=gradient(mask_Y)*gradient(mask_X);
% %==========================================================================
% rx=conv2(gx,DIMG);
% ry=conv2(gy,DIMG);
% rxy=conv2(gxy,DIMG);
% rxx=conv2(gxx,DIMG);
% ryy=conv2(gyy,DIMG);
% Point=[];
% for r=1000:1100
%     for c=1100:1500
%         H=[rxx(r,c) rxy(r,c);rxy(r,c) ryy(r,c)];
%         [V,D] = eig(H);
%         if D(1,1)>D(2,2)
%             n=V(:,1);
%         else
%             n=V(:,2);
%         end
%         t=(n(1)*rx(r,c)+n(2)*ry(r,c))/((n(1).^2)*rxx(r,c)+2*n(1)*n(2)*rxy(r,c)+(n(2).^2)*ry(r,c));
%         if ((abs(t*n(1))<0.5)&(abs(t*n(2))<0.5))
%             P=[c+t*n(1) r+t*n(2)];
%             Point=[Point;P];
%         end
%     end;
% end;
END=1            

