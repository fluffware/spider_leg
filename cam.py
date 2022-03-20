import numpy as np;
from stl import mesh
from math import sin,cos,pi
import sys

stride = 7
half_contact_angle = 2*pi/3

def walk_forward(a):
    if a < half_contact_angle:
        return a*stride/half_contact_angle
    elif a >= 2*pi - half_contact_angle:
        return (a-2*pi)*stride/half_contact_angle
    elif a < pi:
        beta = half_contact_angle - pi;
        a0 = a - pi;
        return stride / half_contact_angle *(6*pi/(beta*beta*beta)*(a0*a0*a0/6 - beta*a0*a0/2 + beta*beta*a0/2) + a0);
    else:
        beta = half_contact_angle - pi;
        a0 = pi - a
        return -stride / half_contact_angle *(6*pi/(beta*beta*beta)*(a0*a0*a0/6 - beta*a0*a0/2 + beta*beta*a0/2) + a0);
    

def rotate_z(v,a):
    c = cos(a)
    s = sin(a)
    return np.array([v[0]*c + v[1]*-s, v[0]*s + v[1]*c, v[2]])

def draw_cam(v0, v1):
    N= len(v0)
    faces = [];
    for i in range(0,N):
        #vertices.extend([v0[i][0], v0[i][1], v1[i][0], v1[i][1]])
        i1 = (i+1) % N
        faces.extend([
            [v0[i][0], v0[i1][1], v0[i][1]], [v0[i][0], v0[i1][0], v0[i1][1]],
            #[i0,i0 + 1, i1+1],[i0,i1+1,i1], # bottom
            [v0[i][0], v1[i][0], v0[i1][0]], [v0[i1][0], v1[i][0], v1[i1][0]],
            #[i0,i1,i0+2], [i1,i1+2, i0+2],
             [v0[i][1], v0[i1][1], v1[i][1]], [v0[i1][1], v1[i1][1], v1[i][1]],
            #[i0+1,i1+1,i0+3], [i1+1,i1+3, i0+3],
            [v1[i][0], v1[i][1], v1[i1][1]], [v1[i][0], v1[i1][1], v1[i1][0]]
            #[i0+3,i1+3,i0+2], [i1+3,i1+2, i0+2] # top
            ])
    
    data = np.zeros(len(faces), dtype=mesh.Mesh.dtype)
    for i in range(len(faces)):
        data['vectors'][i] = faces[i];
        data['normals'][i] = np.cross(np.array(faces[i][0]),np.array(faces[i][1]))
    v = mesh.Mesh(data, calculate_normals=False)
    return v;

#axial_offset = list(map(lambda i: 0.3*sin(i*pi*2/100), range(100)))
axial_offset = list(map(lambda i: walk_forward(i*pi*2/200), range(200)))

#axial_offset = list(map(lambda i: 0, range(10)))
N = len(axial_offset)
vc = []
for i in range(N):
    a0 = i * pi*2 / N;
    z0 = axial_offset[i]
    inner = rotate_z(np.array([13, 0,z0]), a0)
    outer = rotate_z(np.array([30,0,z0]), a0)
    vc.append([inner,outer])

v0 = []
v1 = []
for i in range(N):
    inner0 = vc[i][0]
    inner1 = vc[(i+1) % N][0]
    outer0 = vc[i][1]
    outer1 = vc[(i+1) % N][1]
    offset = np.cross((inner1-inner0),outer0 - inner0)
    offset /= np.linalg.norm(offset)
    offset *= 5
    v0.append([inner0+offset,outer0+offset])
    v1.append([inner0-offset,outer0-offset])
    




m = draw_cam(v0,v1)
if not m.check():
    print("Mesh is invalid");
#    sys.exit(1)
        
if not m.is_closed():
    print("Mesh is not closed");
#    sys.exit(1)
else:
    print("Mesh is closed");
    
print(m.normals)
m.save("/tmp/foo.stl")
