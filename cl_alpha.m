load 'Principi di simulazione del volo SIMULATORE'\ext_nl_CLalfa_XLS.dat
alpha=ext_nl_CLalfa_XLS(:,1)';
Cl=ext_nl_CLalfa_XLS(:,2)';
alpharad=(alpha*pi)/180;
plot(alpharad,Cl)
