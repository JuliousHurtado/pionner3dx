import os
import yaml

L = [line for line in open('output-XYT_SimuMIT_REALMAP.txt')]
Y = yaml.load(open('../maps/reducedDCCMap.yaml'))

origin = Y['origin']
resolution = Y['resolution']

scale = 0.82162
pxorigin = (int(-origin[0]/resolution))
pyorigin = (int(-origin[1]/resolution))

fod = open('output-XYT_SimuMIT_REALMAP_scaled.txt','w')

for line in L:
    fline = [float(i) for i in line.split()]
    fline[3] = fline[3]*scale
    fline[4] = (410 - fline[4])*scale
    fod.write('%d %d %d %lf %lf\n'%(int(fline[0]),int(fline[1]), int(fline[2]), fline[3], fline[4],))

fod.close();
    
