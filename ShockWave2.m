%%
%{
Simulation of emitted light going through an explosive charge being
shocked. By assumption we'll say:

1. light produced by shock wave comes out instantaneously and follows first
order reaction w/ parameterized rate determined by emission lifetime.

2. Total radiance is simply the result of emission and absorption,
scattering processes will be considered at a later time, but for now, all
that's important is visible light transmittance. For all intents and
purposes, the 'absorption' can be treated as an amalgom of absorption and
scattering.

3. Shock wave infinitely thin and has absorption coefficient Beta. This
will be addressed in later systems.

%}

%%
classdef ShockWave2
    properties
        Us %Shock Velocity
        L %Cell length
        E_0 %Initial streaming radiance
        A %Absorption factor
        a = 500
        b = 0.05
    end
    methods(Access = public)
        function obj = ShockWave2(Us,L,E_0,A)
            obj.Us = Us; obj.L = L; obj.E_0 = E_0;
            obj.A = A;
        end
        function [x,I,E] = simulate(obj,L,t)
            x = linspace(-5,L,1000);
            I = obj.Intensity(x,t);
            Absorb = obj.Absorption(x,L);
            I = I.*Absorb';
            E = obj.totRad(x,I);
        end
    end
    methods(Access = private)
        function I = Intensity(obj,x,t)
            I = zeros(length(x),1);
            
            for k = 1:length(x)
                x_rel = x(k)-obj.Us*t;
                if x_rel <0
                    I(k) = obj.a*(-x_rel)^2*exp(obj.b*x_rel);
                else
                    I(k) = 0;
                end
            end
        end
        function A = Absorption(obj,x,L)
            for k = 1:length(x)
                A(k) = exp(-obj.A*(L-x(k)));
            end
        end
        function Energy = totRad(~,x,I)
            Energy = trapz(x,I);
        end
    end
        
end