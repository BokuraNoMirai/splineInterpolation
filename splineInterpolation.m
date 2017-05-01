clear;

x = [0 2 5 8 10 16 20 30 35];
y = [0 4 -25 3 18 -30 24 16 -1];
%x = [1 2 4 5 8 10];
%y = [2 1.5 1.25 1.2 1.125 1.1];
n = 9;
scale = 100;

for i=1:n-1
  u(i) = x(i+1)-x(i);
endfor

for i=2:n-1
  d(i) = 2*(x(i+1)-x(i-1));
  w(i) = 6*((y(i+1)-y(i))/u(i) - (y(i)-y(i-1))/u(i-1));
endfor

p(1) = 0;
p(n) = 0;

for i=2:n-2
  w(i+1) = w(i+1)-w(i)*u(i)/d(i);
  d(i+1) = d(i+1)-u(i)*u(i)/d(i);
endfor

i = n-1;
while(i>1)
  p(i) = (w(i)-u(i)*p(i+1))/d(i);
  i--;
endwhile

k = 1;
for i=1:n-1
  xStep = x(i);
  stepCount = abs(x(i+1)*scale-x(i)*scale);
  step = u(i)/stepCount;
  for j=1:stepCount
    t = (xStep-x(i))/u(i);
    xPlot(k) = xStep;
    yPlot(k) = t*y(i+1) + (1-t)*y(i) + u(i)*u(i) * ((t*t*t-t)*p(i+1) + ((1-t)*(1-t)*(1-t)-(1-t))*p(i)) / 6;
    k++;
    xStep += step;
  endfor
endfor

plot(xPlot, yPlot, "-b");
hold;
plot(x, y, "xr");