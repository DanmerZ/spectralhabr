clear all;

eta = 1;
n = 32;              % number of points
dx = 2*pi/n;         % space step
x = 0:dx:2*pi-dx;    
y = x;
[X, Y] = meshgrid(x,y);

h = 0.01;            % temporal step
times = 30;         % number of iterations in time

k1 = meshgrid(fftshift(-n/2:1:n/2-1),ones(n,1));
k2 = k1';
ks = k1.*k1 + k2.*k2;

mu = (1-(1-eta)*ks^2*h)./(1+eta*ks.^2*h); % stores multipliers 

u0 = 1 + sin(2*X) + sin(2*Y);  % initial temperature
u = zeros(times,n,n);        % stores results
umin=min(min(u0)); 
umax=max(max(u0));

u(1,:,:) = u0;

uf = fft2(u0);

for i=2:times
    uf = mu.*uf;  % time step
    u(i,:,:) = real(ifft2(uf));
end

createGif('diffusion2d.gif',X,Y,u,times,1,[0 2*pi 0 2*pi umin umax]);


