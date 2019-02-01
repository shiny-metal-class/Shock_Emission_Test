clear all;
X = ShockWave; X.LT = 1; X.L = 165; X.Us = 7.25; X.E_0 = 3000; X.Qs = 0.2;
X.RZ = 1; %ns
X.Beta = 0;

x = linspace(0,X.L+10,100); 
t = linspace(0,100,100);

for j = 1:length(t)
    parfor i = 1:length(x)
        A(i,j) = X.Stream(x(i),t(j));
        E(i,j) = X.ABS(x(i),t(j));
    end
    

    I(j) = X.Int_En(t(j));
    figure(1); hold off; 
    plot(x,E(:,j),x,A(:,j));ylim([0,2000]);
    figure(2); hold off;
    plot(t(1:j),I); xlim([-5,max(t)]);
    label = sprintf('t = %g',t(j));
    legend(label);
    pause(0.0001);
    
    
end