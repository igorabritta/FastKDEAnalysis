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
% Distribuition Parameters
mu=0;
sigma=0.25;
% X=[-1:0.01:1];
% Y = normpdf(X,mu,sigma);
% A=randn(n,d);
% xgrid=linspace(min(A),max(A),m);

%% FLAGS PLOTS
plot.hist=0;

%-------------------------------------------------------------------------%
%% PreAllocation
kk=10;
Fvtime=zeros(1,kk);

matrix=zeros(6,6);
matrixe=zeros(6,6);
%-------------------------------------------------------------------------%

for j=1:5
    n=10^j;
    %% Random Gaussian Distribuition
    A = normrnd(mu,sigma,n,d);
    
    for div=0:7
        for i=1:kk
            tic
            [~,~]=fastKDE(A,m,f,(2^div),'variable');      % Our Implementation Fast
            Fvtime(i)=toc;
        end
        matrix(j,div+1)=mean(Fvtime);
        matrixe(j,div+1)=std(Fvtime)/kk;
    end
end

vector_div=[2^0 2^1 2^2 2^3 2^4 2^5 2^6];
vector_n=[10^1 10^2 10^3 10^4 10^5];
figure
surf(vector_n,vector_div,matrix')
xlabel('Attempts')
ylabel('Time(seconds)')
legend show
axis tight
grid on

