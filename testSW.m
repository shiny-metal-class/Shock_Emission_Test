clear all;
X = ShockWave; X.LT = 5; X.L = 165; X.Us = 7.25; X.E_0 = 3000; X.Qs = 0.025;
X.RZ = 5; %ns
X.Beta = 25;

Y = ShockWave; Y.LT = 25; Y.L = 165; Y.Us = 7.25; Y.E_0 = 700; Y.Qs = 0.025;
Y.RZ = 5; Y.Beta = 0;
x = linspace(0,X.L+10,1000); 
t = linspace(0,100);
for j = 1:length(t)
    parfor i = 1:length(x)
        A(i,j) = X.Stream(x(i),t(j));
        E(i,j) = X.ABS(x(i),t(j));
    end
    I(j) = X.Int_En(t(j));
    I2(j) = Y.Int_En(t(j));
    figure(1); hold off; 
    plot(x,E(:,j),x,A(:,j));ylim([0,2000]);
    label = sprintf('t = %g',t(j));
    figure(2); hold off;
    plot(t(1:j),I,t(1:j),I2); xlim([0,max(t)]);ylim([0,1E5]); 
    label = sprintf('t = %g',t(j));
    legend(label);
    pause(0.0001);
    
end
%{
parfor i = 1:length(t)
    I(i) = X.Int_En(t(i));
end

figure(2); hold off;
plot(t,I); legend(sprintf('%g',X.L/X.Us));
%}