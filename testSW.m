X = ShockWave; X.LT = 5; X.L = 165; X.Us = 7.25; X.E_0 = 20000; 
x = 1:0.5:255; X.Alpha = 0.2; X.Beta = 0;
t = linspace(0,50,1000);
for j = 1:length(t)
    for i = 1:length(x)
        E(i,j) = X.ABS(x(i),t(j));
    end
end
figure(2); hold off;
plot(x,E(:,440),x,E(:,456),x,E(:,550));
I = 0;

for i = 1:length(t)
    I(i) = X.Integrate(t(i));
end
figure(1); hold off;
plot(t,I);