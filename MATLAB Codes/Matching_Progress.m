%==========================================================================
function Match_Set = Matching_Progress (Ref_Edge_Points_Left,Ref_Edge_Points_Right,E,fL,fR,maximE)
% University of Tehran -- Faculty of Engineering
% (c) Mohammad Pashaee -- 2008
MaxL=max(Ref_Edge_Points_Left(:,4));
MaxR=max(Ref_Edge_Points_Right(:,4));

MAX=max(MaxL,MaxR)
for i=1:MAX
C_L{i}=[];
end
for i=1:MAX
C_R{i}=[];
end
C_L{MAX+1}=[];
for i=1:MAX
PosL=find(Ref_Edge_Points_Left(:,4)==i);
for K=1:size(PosL)
C_L{i}=[C_L{i};Ref_Edge_Points_Left(PosL(K),2) Ref_Edge_Points_Left(PosL(K),3)];
end
end
PosL=find(Ref_Edge_Points_Left(:,4)==0);
for K=1:size(PosL)
C_L{MAX+1}=[C_L{MAX+1};Ref_Edge_Points_Left(PosL(K),2) Ref_Edge_Points_Left(PosL(K),3)];
end
C_R{MAX+1}=[];
for i=1:MAX
PosR=find(Ref_Edge_Points_Right(:,4)==i);
for K=1:size(PosR)
C_R{i}=[C_R{i};Ref_Edge_Points_Right(PosR(K),2) Ref_Edge_Points_Right(PosR(K),3)];
end
end
PosR=find(Ref_Edge_Points_Right(:,4)==0);
for K=1:size(PosR)
C_R{MAX+1}=[C_R{MAX+1};Ref_Edge_Points_Right(PosR(K),2) Ref_Edge_Points_Right(PosR(K),3)];
end
%-------------
Match_Set=[];
for i=1:MAX+1
    i
    CL=C_L{i};
    CR=C_R{i};
    if ((~isempty(CL))&(~isempty(CR)))
    for j=1:size(CL,1)
        x1=CL(j,:);
        x2=CR;
        m1 = [x1(1) ; x1(2); -fL];
        m2 = [x2(:,1)' ; x2(:,2)'; ones(size(x2,1),1)'*(-fR)];
       l=E'*m1;
       d=m2'*l/sqrt(l(1)^2+l(2)^2);
       [dist1,b1]=min(abs(d));L1=(1-dist1);
       if (dist1<maximE & b1>1 & b1<size(d,1))
           if ((d(b1)>0 & d(b1-1)<0)|(d(b1)<0 & d(b1-1)>0))
               dist2=abs(d(b1-1));b2=b1-1;L2=(1-dist2);
           elseif ((d(b1)>0 & d(b1+1)<0)|(d(b1)<0 & d(b1+1)>0))
               dist2=abs(d(b1+1));b2=b1+1;L2=(1-dist2);
           else
               dist2=dist1;b2=b1;L2=L1;
           end 
           x=m2';
           x2_Match1=[x(b1,1:2) d(b1)];
           x2_Match2=[x(b2,1:2) d(b2)];
           x2_Match=(L1*x2_Match1(1,1:2)+L2*x2_Match2(1,1:2))/(L1+L2);
           Match_Set=[Match_Set; x1  x2_Match d(b1) d(b2)];
       end
    end
    end
end
