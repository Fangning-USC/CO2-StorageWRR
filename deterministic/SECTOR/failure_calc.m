function F=failure_calc(STRESSMAX,Pressure,STRESSMIN,FRICANGLE,COHESION)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
for TT =1: size(STRESSMAX,2)
% STRESSMAXP(:,TT) = STRESSMAX(:,TT) +Pressure(:,TT);
% STRESSMINP(:,TT) = STRESSMIN(:,TT) +Pressure(:,TT);
stress_dif(:,TT) = (STRESSMAX(:,TT)-STRESSMIN(:,TT));
F(:,TT) = ((STRESSMAX(:,TT)+STRESSMIN(:,TT))/2).*sin(FRICANGLE*pi/360) - ((STRESSMAX(:,TT)-STRESSMIN(:,TT))/2) + COHESION.*cos(FRICANGLE*pi/360);
% Psct (:,TT) = F1(:,TT)./sin(FRICANGLE*pi/360);
% F(:,TT) = Psct (:,TT) - Pressure(:,TT) ;
% F(:,TT) = Psct (:,TT)  ;
Ft(:,TT) =  STRESSMIN(:,TT);
end

end

