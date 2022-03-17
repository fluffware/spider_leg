import numpy
from stl import mesh
from math import sin,cos,pi

v = []
axial_offset = list(map(lambda i: 0.3*sin(i*pi*2/100), range(100)))
N = len(axial_offset)
vs = []
for i in range(N):
    a0 = i * pi*2 / N;
    z0 = axial_offset[i]
    inner = [0.5*cos(a0),0.5*sin(a0),z0]
    outer = [cos(a0),sin(a0),z0]
    vs.append([inner,outer])
    
for i in range(0,N):
    a0 = i * pi / N
    a1 = (i+1) * pi / N
    outer0 = vs[i][1];
    inner0 = vs[i][0];
    outer1 = vs[(i+1) % N][1];
    inner1 = vs[(i+1) % N][0];
    #print(axial_offset[i])
    v.append(numpy.array([inner0, outer0, outer1]))
    v.append(numpy.array([inner0, inner1, outer1]))

    
data = numpy.zeros(len(v), dtype=mesh.Mesh.dtype)
for i in range(len(v)):
    data['vectors'][i] = v[i]

m = mesh.Mesh(data)

m.save("/tmp/foo.stl")
