clear all;
X = ShockWave; X.LT = 5; X.L = 165; X.Us = 7.25; X.E_0 = 7000; X.Qs = 0.7;
x = linspace(0,X.L+10,10000); X.Beta = 0;
t = linspace(0,30);
for j = 1:length(t)
    parfor i = 1:length(x)
        A(i,j) = X.Stream(x(i),t(j));
        E(i,j) = X.ABS(x(i),t(j));
    end
    figure(1); hold off; 
    plot(x,E(:,j),x,A(:,j));ylim([0,20000]);
    label = sprintf('t = %g',t(j));
    legend(label);
    pause(0.005);
end

parfor i = 1:length(t)
    I(i) = X.Int_En(t(i));
end
figure(2); hold off;
plot(t,I); legend(sprintf('%g',X.L/X.Us));