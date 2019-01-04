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
classdef ShockWave
    properties
        Us %Shock Velocity
        L %Cell length
        E_0 %Initial streaming radiance
        LT %Radiation lifetime, proportionate to reaction rate
        Alpha % Abs (and scattering) coefficient, material dependent
        Beta %Shock wave light attenuation coeff.
    end
    methods
        function E = Stream(obj,x,t)
            if x < t*obj.Us 
                E = obj.E_0*exp((log(2)/obj.LT).*(x-obj.Us.*t));
            else
                E = 0;
            end
        end
        function A = ABS(obj,x,t)
            A = obj.Stream(x,t).*exp(-obj.Alpha*(obj.L-x));
            if x < obj.Us*t
                A = A*exp(-obj.Beta);
            end
        end
        function E_total = Integrate(obj,t)
            %{
            E = @(x) obj.ABS(x,t);
            E_total = integral(E,0,255);
            %}
            E = linspace(0,1000);
            En(1) = 0;
            for i = 2:length(E)
                En(i) = En(i-1) + obj.ABS(i,t);
            end
            E_total = En(end);
        end
    end
end