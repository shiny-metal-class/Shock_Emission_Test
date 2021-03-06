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
        Qs %scattering efficiency
        Beta %Shock wave light attenuation coeff.
        RZ %Rxn zone, ns
    end
    methods
        function E = Stream(obj,x,t)
            if (t)*obj.Us-obj.RZ*obj.Us <= obj.L
                E = obj.E_0*exp(-(log(2)/obj.LT)*(t-x/obj.Us));
                if (x)> obj.Us*t-(obj.RZ*obj.Us)& x< obj.L
                     E=0; %E = obj.E_0*(x-obj.Us*t+obj.RZ)^2;
                end
                if x > obj.L
                    E = 0;
                end
            elseif (t)*obj.Us-obj.RZ*obj.Us > obj.L
                %E0 = obj.E_0*exp((obj.L/obj.Us-t));
                E = obj.E_0*exp(-(log(2)/obj.LT)*(t-x/obj.Us));
                if (x) > obj.L
                    E = 0;
                end
            end
        end
        
        function A = ABS(obj,x,t)
            if obj.Us*t < obj.L
                %A = obj.Stream(x,t).*exp(-(obj.L-x)/(4.816/obj.Qs))*exp(-obj.Beta);
                 A = obj.Stream(x,t)*exp(-obj.Beta)*exp(-(obj.L-x)*obj.Qs);
            else
                A = obj.Stream(x,t)*exp(-(obj.L-x)*obj.Qs); %.*exp(-(obj.L-x)./(4.816/obj.Qs));
            end
        end
        
        function f = Int_En(obj,t)
            E = [];
            x = linspace(0,obj.L,10000);
            for i = 1:length(x)
                E(i) = obj.ABS(x(i),t);
            end
            f = trapz(x,E);
        end
    end
end