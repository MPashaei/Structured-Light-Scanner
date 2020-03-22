function [R,T,E,py_initial,py_final] = LS_Rotation_matrix (R,T,left_Point,right_Point)
% University of Tehran -- Faculty of Engineering
% (c) Mohammad Pashaee -- 2008
TH=1e-8;
x1=left_Point(:,1);
y1=left_Point(:,2);
z1=left_Point(:,3);
x2=right_Point(:,1);
y2=right_Point(:,2);
z2=right_Point(:,3);

q=asin(R(1,3));
cq=cos(q);
k=atan2(-R(1,2)/cq,R(1,1)/cq);
w=atan2(-R(2,3)/cq,R(3,3)/cq);
   
bx=T(1);
by=T(2);
bz=T(3);
p=[w q k bx by bz]';
py_initial=diag([x1,y1,z1]*asym([bx by bz])*R*[x2 y2 z2]');


%LSE adjustment
% A=zeros(n,5);
% B=zeros(n,n*4);
% C=zeros(n,1);
itr=0; 
while 1
  itr=itr+1;
  cq=cos(q);sq=sin(q);cw=cos(w);sw=sin(w);ck=cos(k);sk=sin(k);
  R=[cq*ck,-cq*sk,sq;
    sw*sq*ck+cw*sk,-sw*sq*sk+cw*ck,-sw*cq;
    -cw*sq*ck+sw*sk,cw*sq*sk+sw*ck,cw*cq];
  b=[(-bz*R(2,1)+by*R(3,1))*x2+(-bz*R(2,2)+by*R(3,2))*y2-(bz*R(2,3)+by*R(3,3))*z2, ...
    (y1*bz-z1*by)*R(1,1)+(-x1*bz+z1*bx)*R(2,1)+(x1*by-y1*bx)*R(3,1), ...
    (bz*R(1,1)-bx*R(3,1))*x2+(bz*R(1,2)-bx*R(3,2))*y2+(bz*R(1,3)-bx*R(3,3))*z2, ...
    (y1*bz-z1*by)*R(1,2)+(-x1*bz+z1*bx)*R(2,2)+(x1*by-y1*bx)*R(3,2)];
  a=[(-z1*R(1,1)+x1*R(3,1)).*x2+(-z1*R(1,2)+x1*R(3,2)).*y2+(-z1*R(1,3)+x1*R(3,3)).*z2, ...
    (y1*R(1,1)-x1*R(2,1)).*x2+(y1*R(1,2)-x1*R(2,2)).*y2+(y1*R(1,3)-x1*R(2,3)).*z2, ...
    (-(-x1*bz+z1*bx)*R(3,1)+(x1*by-y1*bx)*R(2,1)).*x2+ ...
    (-(-x1*bz+z1*bx)*R(3,2)+(x1*by-y1*bx)*R(2,2)).*y2+ ...
    (-(-x1*bz+z1*bx)*R(3,3)+(x1*by-y1*bx)*R(2,3)).*z2, ...
    (-(y1*bz-z1*by)*sq*ck+(-x1*bz+z1*bx)*sw*cq*ck-(x1*by-y1*bx)*cw*cq*ck).*x2+ ...
    ((y1*bz-z1*by)*sq*sk-(-x1*bz+z1*bx)*sw*cq*sk+(x1*by-y1*bx)*cw*cq*sk).*y2+ ...
    ((y1*bz-z1*by)*cq+(-x1*bz+z1*bx)*sw*sq-(x1*by-y1*bx)*cw*sq).*z2, ...
    ((y1*bz-z1*by)*R(1,2)+(-x1*bz+z1*bx)*R(2,2)+(x1*by-y1*bx)*R(3,2)).*x2+ ...
    (-(y1*bz-z1*by)*R(1,1)-(-x1*bz+z1*bx)*R(2,1)-(x1*by-y1*bx)*R(3,1)).*y2];
  c=diag([x1,y1,z1]*asym([bx by bz])*R*[x2 y2 z2]');
  M=pinv(b*b');
  U=pinv(a'*M*a);
  vx=-U*a'*M*c;
  by=by+vx(1);bz=bz+vx(2);w=w+vx(3);q=q+vx(4);k=k+vx(5);
  if all(abs(vx)<TH);break;end,max(abs(vx));
end
T=[bx by bz]';T=T/norm(T);
% E=asym(T)*R;
E=asym([bx by bz])*R;
py_final=diag([x1,y1,z1]*asym([bx by bz])*R*[x2 y2 z2]');
p(:,2)=[w q k T']';
% 
% %intersection
% for i=1:n
%     x1p=R*[x1(i) y1(i) z1(i)]';
%     x2p=[x2(i) y2(i) z2(i)]';
%     s=pinv([x2p -x1p])*T;ss(i,:)=s';
%     X(i,1:3)=(s(2)*x1p+T)';
%     dX(i,1:3)=s(1)*x2p'-X(i,1:3);
% end
% quiver3(X(:,1),X(:,2),X(:,3),dX(:,1),dX(:,2),dX(:,3));
% hold on
% quiver3([0 T(1)]',[0 T(2)]',[0,T(3)]',[0 R(1,3)]',[0 R(2,3)]',[1 R(3,3)]')
% axis equal
% hold off


