global a alpha beta J h
a = 1
alpha = 2*pi/3
beta = alpha - pi
J= 6*pi*a/(beta^3 * alpha)
t= [0:0.001:4*pi];
t1 = [-alpha:0.001:alpha];
t2 = [alpha:0.001:pi];
t3 = [pi:.001:2*pi-alpha];
h = 0.3

function retval = f2(t)
  global a alpha beta J;
  retval = J*t.^3/6 - J*beta*t.^2/2 + ((a/alpha) + J*beta^2/2)* t;
endfunction


function retval = f3(t)
  retval = -f2(-t);
endfunction

function retval = f4(t)
  global h alpha beta ;
  retval = 2*h/(beta^3)*t.^3 - 3*h/(beta^2)*t.^2 + h;
endfunction

function retval = f5(t)
  retval = f4(-t);
endfunction


function retval = fs(t)
  global alpha a;
  t = mod(t, 2*pi);
  if (t < alpha)
    retval = a/alpha*t;
    elseif (t >= 2*pi - alpha)
      retval = a/alpha*(t-2*pi);
    elseif (t >= pi)
      retval = f3(t-pi);
    else
      retval = f2(t-pi);
  endif
endfunction

function retval = fh(t)
  global alpha a;
  t = mod(t, 2*pi);
  if (t < alpha || t >= 2*pi - alpha)
    retval = 0;
  elseif (t >= pi)
    retval = f5(t-pi);
  else
    retval = f4(t-pi);
  endif
endfunction


plot(arrayfun(@fs,t), t , t, arrayfun(@fh,t), arrayfun(@fs,t), arrayfun(@fh,t));
