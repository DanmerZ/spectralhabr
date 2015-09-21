clear all;
a = 1;               % speed of wave propagation
n = 64;              % number of points
dx = 2*pi/n;         % space step
x = 0:dx:2*pi-dx;    
y = x;
[X, Y] = meshgrid(x,y);

h = 0.01;            % temporal step
times = 1000;         % number of iterations in time

% explanation of this part is here www.staff.uni-oldenburg.de/hannes.uecker/pre/030-mcs-hu.pdf
k1 = meshgrid(fftshift(-n/2:1:n/2-1),ones(n,1));
k2 = k1';
ks = k1.*k1 + k2.*k2;

u0 = exp(-100*((X-pi).^2 + (Y-pi).^2));  % profile of initial velocity u 
ut0 = zeros(n,n);                           % profile of initial acceleration ut

u = zeros(times,n,n);  % stores velocity profile for every time steps
u(1,:,:) = u0;

uf = fft2(u0);
uft = fft2(ut0);


for i=2:times
    uft_new = uft - a*h*ks.*uf;
    uf = uf + 0.5*h*(uft+uft_new);
    uft = uft_new;
    
    % == fixed boundary conditions 
%     u0 = real(ifft2(uf));
%     u0(1,:) = 0; u0(end,:) = 0;
%     u0(:,1) = 0; u0(:,end) = 0;
%     uf = fft2(u0);
    % == fixed boundary conditions
    
    u(i,:,:) = real(ifft2(uf));
end

createGif('wave2d_periodic_bc.gif',X,Y,u,times,10,[0 2*pi 0 2*pi -.2 .2]);



