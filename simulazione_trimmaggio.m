%% dati di trimmaggio
format short g

thetaGuess=(2*pi)/180;   % scelgo 2° che converto in radianti
gammaT=0 *pi/180;
phiT=0*pi/180;
alphaT=thetaGuess-gammaT;

height_trim=3000*0.3048;   % altezza di trimmaggio convertita in metri
Mach=0.4;
height_des=height_trim+(1000*0.3048);

%% calcolo dei valori massimi e minimi di Cl e poi i corrispondenti alpha
cl_alpha;

x=alpharad;
y=Cl;
plot(x,y)

[y_max,iM]=max(y);
[y_min,im]=min(y);
hold on
plot(x(im:iM),y(im:iM))

x_cut=x(im:iM);
y_cut=y(im:iM);

%% atmosfera standard
rho0=1.225;
lambda=-0.0065;
R=287.05;
T0=288.15;
g=9.8066;

rhoz = rho0*(1+(lambda.*height_trim)/T0)^(-(1+g/(R*lambda)))

%% modello velocità

gamma=1.4;                   % perchè l'aria è un gas biatomico
Temp=T0+(height_trim*lambda);    
Vs=sqrt(gamma*R*Temp);          % velocità del suono
v=Mach*Vs     

%% aircraft data
wing_area=34.4; % area ala
wing_span=17.17; % apertura alare b
MTOM=9163;
MFC=(2144+2122)*0.4535; % Massa carburante 
n_engine=2;
W=(MTOM)*g    % il carburante è già incluso

SFC=0.44*0.45/(0.45*9.81/1000*3600);

lambdaD=(wing_span^2)/wing_area;
e=0.9;
cd0=0.01;

%% ciclo for
for j=1:20 
Cl1=interp1(x_cut,y_cut,alphaT);  % cl provvisorio 

Cd=cd0+((Cl1^2)/ (pi*lambdaD*e));
D=((1/2)*rhoz*v^2*wing_area*Cd);

T=(D+W*sin(gammaT))/(cos(alphaT));  % calcolo la T dalla 1° equazione 

%Calcolo la lift dalla 2° equazione 
L=((W*cos(gammaT))-(T*sin(alphaT)*cos(phiT)))/(cos(phiT));

%Adesso calcolo il Cl con la Lift trovata: è il primo cl dei tanti
Cl1=L/((1/2)*rhoz*v^2*wing_area);
if Cl1>y_max
    Cl1=y_max;
end
if Cl1<y_min
    Cl1=y_min;
end

% calcoliamo alpha in funzione del cl con il procedimento inverso al calcolo del Cl_ALPHA

alphaT=interp1(y_cut,x_cut,Cl1);
plot (alphaT, Cl1,'ob')
hold on

gamma_punto=((T*sin(alphaT))*(cos(phiT))+(L*cos(phiT))-(W*cos(gammaT)))/((W*v)/g);
v_punto=((T*cos(alphaT))-D-(W*sin(gammaT)))/(W/g);

disp([j alphaT T v_punto gamma_punto])
end

%% modello di spinta
Tsl=18.32*(10^3);
nt=1.4236;

deltaT_conv=(T/(n_engine*Tsl) )*(rho0/rhoz)^nt % Manetta di trim 
thetaT=alphaT+gammaT