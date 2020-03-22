
%======================= Least Square =====================================
function Peak_LSM = CenterLine_SubPixel_LSM(DIMG,White_Col,Temp,r_max,pos,r,search,p_bf,YC);

% University of Tehran -- Faculty of Engineering
% (c) Mohammad Pashaee -- 2008

x=Temp;sz=size(x);
Num=size(White_Col,2);
for K=1:Num
    First_Col=White_Col{K};
    Num_Col=size(First_Col,1);
    LS_Col{K}=[];r_max1=r_max{K};pos1=pos{K};r1=r{K};search1=search{K};p_bf1=p_bf{K};Y1=YC{K};
    for i=1:Num_Col
        r_max2=r_max1(i,:);pos2=pos1(i,:);r2=r1(i,:);search2=search1(i,:);p_bf2=p_bf1(i,:);Y2=Y1(i,:);L=First_Col(i,2:3);
        x_init=L(2);
        y_init=L(1);
        [dx,s0,j,ResIm]=least_sq6_2(x,Y2,search2,p_bf2); 
        xLs=x_init-dx(1);
        LS_Col{K}=[LS_Col{K};First_Col(i,1) First_Col(1,2) xLs First_Col(i,4)];
    end;
end;
NUM2=size(LS_Col,2);

%=========================== Save =========================================
LS_Peak=[];
for i=1:size(LS_Col,2)
    LSP=LS_Col{i};
    LS_Peak=[LS_Peak LSP'];
end;
Peak_LSM=LS_Peak';
