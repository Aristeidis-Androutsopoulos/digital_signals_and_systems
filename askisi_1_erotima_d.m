Ts = 0.005;
f0 = 40;
% initial_phase =  pi/4;
initial_phase =  0;

n=0:1/Ts;
x = sin(2*pi*f0*n*Ts);
x2 = sin(2*pi*240*n*Ts);
x3 = sin(2*pi*4040*n*Ts);
% x1 = sin(2*pi*f0*n*Ts+pi/4);
figure;
plot(n, x, '-x')
figure;
plot(n, x2, '-x')
figure;
plot(n, x3, '-x')

