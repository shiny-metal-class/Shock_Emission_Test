X = ShockWave2(7.25,165,2000,0.001);
t = linspace(0,50,50);
L = 255; clear E
for i = 1:length(t)
    [d,I(:,i),E(i)] = X.simulate(L,t(i));
    figure(1);
    plot(d,I(:,i)); xlim([0,L+5]);ylim([0,2E4]);
    figure(2);
    plot(t(1:i),E);xlim([-5,100]); ylim([0,3E5]);
    pause(0.05)
end