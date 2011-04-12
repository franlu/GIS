#!/bin/sh
#Fco Javier Lucena Lucena p4-GIS 2008/09

d.erase
d.mon start=x0

v.in.region output=zona type=area
v.select ainput=curvaNivel@PERMANENT binput=zona output=CurvasNivel

g.region res=100 # Cuarta parte distancia curvas nivel

v.surf.rst input=CurvasNivel zcolumn=COTA elev=elevacionBR 

d.rast map=elevacion15 -o
d.vect map=CurvasNivel

r.resamp.rst elevacionBR ew_res=15 ns_res=15 elev=elevacion15

d.out.file output=elevacionTrevenque1 format=png



#Fin del script
