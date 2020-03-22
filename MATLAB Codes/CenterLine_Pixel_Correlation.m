
%=========================Cross-Correlation ===============================
function [Peak_Correlation,White_Col,Temp,r_max,pos,r,search,p_bf,YC] = CenterLine_Pixel_Correlation(DIMG,Row);
% University of Tehran -- Faculty of Engineering
% (c) Mohammad Pashaee -- 2008

Temp = exp(-((-2:2)'/(2)).^2);
 Temp=255*Temp';

Num=size(Row,2);
for K=1:Num
    First_Col=Row{K};
    Num_Col=size(First_Col,1);
    White_Col{K}=[];r_max{K}=[];pos{K}=[];r{K}=[];search{K}=[];p_bf{K}=[];YC{K}=[];
    for i=1:Num_Col
    XX=First_Col(i,2);
    x_start=First_Col(i,3)-4;
    x_stop=First_Col(i,3)+4;
    
    Y=DIMG(XX,x_start:x_stop);
        x=Temp;
        [r_max1,pos1,r1,search1,p_bf1]=correl_coef(x,Y);
        L1=x_start+pos1(2)-1;
        L2=XX+pos1(1)-1;
        White_Col{K}=[White_Col{K};First_Col(i,1) L2 L1 First_Col(i,4)];
        r_max{K}=[r_max{K};r_max1];
        pos{K}=[pos{K};pos1];
        r{K}=[r{K};r1];
        search{K}=[search{K};search1];
        p_bf{K}=[p_bf{K};p_bf1];
        YC{K}=[YC{K};Y];
    end;
end;
White_Peak=[];
for i=1:size(White_Col,2)
    WhiteP=White_Col{i};
    White_Peak=[White_Peak WhiteP'];
end;
Peak_Correlation=White_Peak';
%===================



