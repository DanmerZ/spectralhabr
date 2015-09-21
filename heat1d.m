clear all;

n = 50;             % number of points
dx = 2*pi/n;        % space step
x = 0:dx:2*pi-dx;   % grid

h = 0.1;            % temporal step
times = 10;         % number of iterations in time

k = fftshift(-n/2:1:n/2-1); % wave numbers
k2 = k.*k;             

u0 = 2 + sin(x) + sin(2*x); % initial conditions
u = zeros(times,n);         % stores results
u(1,:) = u0;

uf = fft(u0);               % Fourier coefficients of initial function


for i=2:times
    uf = uf.*(1-h*k2);      % next time step in Fourier space
    u(i,:) = real(ifft(uf));% IFFT to physical space
end

[X,T] = meshgrid(x,0:h:times*h-h);
waterfall(X,T,u), xlabel('x coordinate'), ylabel('time'), zlabel('u temperature')
