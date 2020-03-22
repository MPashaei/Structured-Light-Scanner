
function [Peak,Row] = CenterLine_Pixel_SimplePeak(DIMG,xmin,xmax,ymin,ymax,THR1,THR2,Code_IMG);
% University of Tehran -- Faculty of Engineering
% (c) Mohammad Pashaee -- 2008
clc

Count=0;

for i=ymin:ymax
    Kernel=[0 0 1 0 0];MAX1=THR1;MAX2=0;Row{i-ymin+1}=[];Count=Count;old_col=0;
    for j=xmin:xmax
        T=DIMG(i,j-2:j+2)*Kernel';
        if (T>MAX1)
            MAX1=T;
        end;
        if (T>MAX2)
            MAX2=T;col=j;
        end;
        if ((T<MAX2)&(MAX2>THR2)&(abs(col-old_col)>4))
                Count=Count+1;old_col=col;
                Row{i-ymin+1}=[Row{i-ymin+1};Count i col Code_IMG(i,col)];
                MAX1=THR1;MAX2=0;
        end;
    end; 
end;

Peak=[];
S1=size(Row,2);
for i=1:S1
    R=Row{i};
    Peak=[Peak;R];
end;

%==========================================================================











