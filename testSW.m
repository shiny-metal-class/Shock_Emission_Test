clear all;
X = ShockWave; X.LT = 20; X.L = 165; X.Us = 7.25; X.E_0 = 20000; 
x = linspace(0,X.L+10); X.Alpha = 0.1; X.Beta = 0;
t = linspace(0,50);
for j = 1:length(t)
    for i = 1:length(x)
        A(i,j) = X.Stream(x(i),t(j));
        E(i,j) = X.ABS(x(i),t(j));
    end
    figure(1); hold off; 
    plot(x,E(:,j),x,A(:,j));ylim([0,20000]);
    label = sprintf('t = %g',t(j));
    legend(label);
    pause(0.05);
end

for i = 1:length(t)
    I(i) = X.Int_En(t(i));
    %I(i) = trapz(x,E(:,i));
end
figure(2); hold off;
plot(t,I); legend(sprintf('%g',X.L/X.Us));