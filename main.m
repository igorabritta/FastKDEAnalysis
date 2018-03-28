%% Main of the FastKDE Analysis
clear variables;
close all;
clc
%% Parameters
n=10^4;         % Number of events
m=2^9;         % Number of estimation points
div=2^1;          % Number of matrix divisions
d=1;            % Number of dimensions
f=1;            % Smoothness Parameter (Keep it that way)
type='fix';
% Distribuition Parameters
mu=0;
sigma=0.25;
X=[-1:0.01:1];
Y = normpdf(X,mu,sigma);
%% Random Gaussian Distribuition
A = normrnd(mu,sigma,n,d);
% A=randn(n,d);
xgrid=linspace(min(A),max(A),m);

% Not Matricial
tic
[x2v,p2v]=KDE_opt(A,m,f,'variable');                   % Our Implementation
Lvtime=toc;
tic

[x2f,p2f]=KDE_opt(A,m,f,'fix');                   % Our Implementation
Lftime=toc;

tic
[x1f,pdf1f]=fastKDE(A,m,f,div,'fix');      % Our Implementation Fast
Fftime=toc;

tic
[x1v,pdf1v]=fastKDE(A,m,f,div,'variable');      % Our Implementation Fast
Fvtime=toc;

tic
[pdf2,x2] = ksdensity(A,'npoints',m);        % Matlab Implementation
Mtime=toc;

tic
[~,pdf3,x3,~]=kde(A,m,min(A),max(A));
Ktime=toc;

tic
[pdf4,x4]=akde1d(A,m);
aKtime=toc;

display('--------------------------------------');
display('Our Implementation:');
display(['KDE Fix Time: ' num2str(Lftime)]);
display(['KDE Variable Time: ' num2str(Lvtime)]);
display('-------');
display(['FastKDE Fix Time: ' num2str(Fftime)]);
display(['FastKDE Variable Time: ' num2str(Fvtime)]);
display('--------------------------------------');
display('Others Implementations:');
display(['Ksdensity Time: ' num2str(Mtime)]);
display(['KDE Time: ' num2str(Ktime)]);
display(['aKDE Time: ' num2str(aKtime)]);

figure
plot(X,Y,'k','DisplayName','Analytic PDF')
hold on
plot(x2f{1},p2f,'sr','DisplayName','KDEf')
plot(x2v{1},p2v,'sg','DisplayName','KDEv')
plot(x1f,pdf1f,'*r','DisplayName','FastKDEf')
plot(x1v,pdf1v,'*g','DisplayName','FastKDEv')
plot(x2,pdf2,'ob','DisplayName','Ksdensity')
plot(x3,pdf3,'om','DisplayName','KDE')
plot(x4,pdf4,'oc','DisplayName','aKDE')
legend show
axis tight