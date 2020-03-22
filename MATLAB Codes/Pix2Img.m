
function [Image_Coordinates]=Pix2Img(pixel_coordinates,u0,v0,PixelSize)

% format of pixel_coordinates mtrix is : [num x y]
%% University of Tehran -- Faculty of Engineering
% (c) Mohammad Pashaee -- 2008

[M,N]=size(pixel_coordinates);
u=pixel_coordinates(:,2);
v=pixel_coordinates(:,3);

    x=(u-u0*ones(M,1))*PixelSize;
    y=-(v-v0*ones(M,1))*PixelSize;

Image_Coordinates=[pixel_coordinates(:,1) x y];
