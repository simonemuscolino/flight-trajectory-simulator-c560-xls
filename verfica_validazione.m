%% verifica e validazione
clear; clc; close all;

%% dati che variano per i test
altitudine_ft = [3000, 4000, 20000]; 
Mach_des = [0.3, 0.4, 0.7];     
thetaGuess = (2 * pi) / 180; 
gammaT = 0; 
phiT = 0;  

%% dati dell'aereo, aerodinamici e atmosferici
rho0 = 1.225;
lambda = -0.0065;
R = 287.05;
T0 = 288.15;
g = 9.8066;
wing_area = 34.4;
wing_span = 17.17;
MTOM = 9163;
W = MTOM * g;
lambdaD = (wing_span^2) / wing_area;
cd0 = 0.01;
e_des = [0.1, 0.9, 1]; 

%% calcolo dei valori massimi e minimi di Cl e poi i corrispondenti alpha
cl_alpha;
x = alpharad;
y = Cl;
[y_max, iM] = max(y);
[y_min, im] = min(y);
x_cut = x(im:iM);
y_cut = y(im:iM);

%% Risultati
risultati = [];

for e = e_des
    for h_ft = altitudine_ft
        for Mach = Mach_des
            height_trim = h_ft * 0.3048; % conversione in metri
            alphaT = thetaGuess-gammaT;
            rhoz = rho0 * (1 + (lambda * height_trim) / T0)^(-(1 + g / (R * lambda)));
            Temp = T0 + (height_trim * lambda);
            gamma = 1.4;   % perchè l'aria è un gas biatomico
            Vs = sqrt(gamma * R * Temp); 
            v = Mach * Vs;

            for j = 1:20
                Cl1 = interp1(x_cut, y_cut, alphaT);
                Cd = cd0 + (Cl1^2 / (pi * lambdaD * e));
                D = 0.5 * rhoz * v^2 * wing_area * Cd;
                T = (D + W * sin(gammaT)) / cos(alphaT);
                L = (W * cos(gammaT) - T * sin(alphaT) * cos(phiT)) / cos(phiT);
                Cl1 = L / (0.5 * rhoz * v^2 * wing_area);
                Cl1 = min(max(Cl1, y_min), y_max);
                alphaT_tilde = interp1(y_cut, x_cut, Cl1);
               
                    alphaT = alphaT_tilde;
           end

            % Calcolo gamma_punto e v_punto
            gamma_punto = ((T * sin(alphaT) * cos(phiT) + L * cos(phiT) - W * cos(gammaT)) / (W * v / g));
            v_punto = ((T * cos(alphaT) - D - W * sin(gammaT)) / (W / g));
            risultati = [risultati; h_ft, Mach, alphaT, v_punto, gamma_punto, e, L, D, T];
        end
    end
end

%% Tabella dei Risultati
tabella = array2table(risultati, 'VariableNames', {'Altitudine_ft', 'Mach', 'alphaT', 'v_punto', 'gamma_punto', 'e', 'L', 'D', 'T'});
disp(tabella);

% Grafico gamma_punto vs Altitudine
figure;
plot(tabella.Altitudine_ft, tabella.gamma_punto, 'or');
title('\gamma punto rispetto all altitudine');
xlabel('Altitudine (ft)');
ylabel('\gamma punto');
grid on;

% Grafico v_punto vs Altitudine
figure;
plot(tabella.Altitudine_ft, tabella.v_punto, 's-');
title('v punto rispetto all altitudine');
xlabel('Altitudine (ft)');
ylabel('v punto');
grid on;

if L < 0 && D < 0
   disp('Portanza e resistenza non valide.');
   else disp ('Portanza e resistenza valide.')
end

if L < W
   disp('La portanza non è sufficiente ad equilibrare il peso');
   else disp('La portanza è sufficiente ad equilibrare il peso');
end

if T < D
   disp('La spinta disponibile non bilancia la resistenza.');
else disp('La spinta disponibile riesce a bilanciare la resistenza.');
end

if L>W && T>D && L>0 && D>0 
   disp('Il simulatore è conforme con gli standard di qualità');
else disp('Il simulatore non è conforme con gli standard di qualità'); 
end
