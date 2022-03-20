global a alpha beta J;
a = 1
alpha = 2*pi/3
beta = alpha - pi
J= 6*pi*a/(beta^3 * alpha)
t1 = [-alpha:0.001:alpha];
t2 = [alpha:0.001:pi];
t3 = [pi:.001:2*pi-alpha]

function retval = f2(t)
  global a alpha beta J;
  retval = J*t.^3/6 - J*beta*t.^2/2 + ((a/alpha) + J*beta^2/2)* t;
endfunction

function retval = f3(t)
  retval = -f2(-t);
endfunction

plot(t2, f2(t2-pi),t1, (t1)*a/alpha, t3, f3(t3-pi));
