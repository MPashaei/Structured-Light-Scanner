% University of Tehran -- Faculty of Engineering
% (c) Mohammad Pashaee -- 2008
%
function [mean,stddev,minimum,maximum]=funmatError(M,E,fL,fR)

if (size(M,1)~=4) | (size(E,1)~=3)| (size(E,2)~=3),
   disp('Error: parametres incorrectes')
else
   aux=[];
   for i=1:size(M,2),
      m1 = [M(1,i) ; M(2,i); -fL];
      m2 = [M(3,i) ; M(4,i); -fR];
      
      l=E*m2;
      d=m1'*l/sqrt(l(1)^2+l(2)^2);
      dmod=abs(d);
      aux=[aux dmod];
      
      l=E'*m1;
      d=m2'*l/sqrt(l(1)^2+l(2)^2);
      dmod=abs(d);    
      aux=[aux dmod];
   end
   aux_2=aux.^2;
	mean=sum(aux)/(size(M,2)*2);
	stddev=sqrt((sum(aux_2)-sum(aux)^2/(size(M,2)*2))/(size(M,2)*2-1));
	maximum=max(aux);
	minimum=min(aux);
end

      
