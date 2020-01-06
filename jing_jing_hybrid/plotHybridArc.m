function plotHybridArc(t,j,x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab M-file                Author: Ricardo Sanfelice
%
% Project: Simulation of a hybrid system 
%
%
% Name: plotHybridArc.m
%
% Description: plots a hybrid arc in hybrid time domain
%
% Version: 0.6
% Required files: -
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% hybrid arc plot

% max (t,j) in simulation

T = t(length(t));
J = j(length(j));


% variables
Xarc = cell(J+1,1);
Tarc = cell(J+1,1);
Jarc = cell(J+1,1);
i = 1;
k = 1;
while i <= length(j),
   jcurrent = j(i);
   l = 0;
   clear xk tk jk;
   if (jcurrent < J)
      while (j(i+l) == jcurrent)
        xk(l+1) = x(i+l);
	tk(l+1) = t(i+l);
	jk(l+1) = j(i+l);
        l = l+1;
      end
   else
      for l=0:length(j)-i,
        xk(l+1) = x(i+l);
	tk(l+1) = t(i+l);
	jk(l+1) = j(i+l);
      end
      l = length(j)-i+1;
   end
   Xarc(jcurrent+1) = {xk};
   Tarc(jcurrent+1) = {tk};
   Jarc(jcurrent+1) = {jk};
   jcurrent;
   i = i+l;
end

gca = figure();
clf;
%for i = 1:jnew(jSize),
for i = 1:J+1,
   xith = cell2mat(Xarc(i));
   tith = cell2mat(Tarc(i));
   tmax = tith(length(tith));
   jith = cell2mat(Jarc(i));
   jmax = jith(length(jith));
   plot3(jith,tith,xith,'b--','LineWidth',1)
   hold on;
   plot3(jith,tith,zeros(1,length(tith)),'r','LineWidth',1)
end

axis equal
grid on