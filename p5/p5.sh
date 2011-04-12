#!/bin/sh
#       p5.sh
#       
#       Copyright 2011 Fco Javier Lucena <fran.lucena@gmail.com>
#       
#       GIS is free software; you can redistribute it and/or modify
#       it under the terms of the GNU General Public License as published by
#       the Free Software Foundation; either version 3 of the License, or
#       (at your option) any later version.
#       
#       GIS is distributed in the hope that it will be useful,
#       but WITHOUT ANY WARRANTY; without even the implied warranty of
#       MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#       GNU General Public License for more details.
#       
#       You should have received a copy of the GNU General Public License
#       along with GIS; if not, write to the Free Software
#       Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#       MA 02110-1301, USA.

d.erase
d.mon start=x0

g.remove rast=Rstreams1
v.to.rast input=streams@PERMANENT output=Rstreams1 use=cat
g.remove rast=streamBuffer
r.buffer Rstreams1 output=streamBuffer dist=200

g.remove rast=Rroads1
v.to.rast input=roads@PERMANENT output=Rroads1 use=cat
r.null map=Rroads1 setnull=1
g.remove rast=roadsBuffer
r.buffer Rroads1 output=roadsBuffer dist=200

g.remove rast=rios
g.remove rast=carreteras
cat reclass | r.reclass streamBuffer output=rios
cat reclass | r.reclass roadsBuffer output=carreteras

g.remove rast=celda22min
g.remove rast=celda22max
r.neighbors input=elevation.dem output=celda22max method=maximum size=5
r.neighbors input=elevation.dem output=celda22min method=minimum size=5

g.remove rast=llano
r.mapcalc "llano=celda22max - celda22min < 6"
r.null map=llano setnull=0

g.remove rast=todo
r.mapcalc "todo=if(rios==1 && carreteras==1 && llano==1,1,null())"
cat colores | r.colors todo color=rules

d.frame -e
d.frame -c frame=todo at=10,100,0,100
d.rast map=aspect@PERMANENT -o
d.vect map=streams@PERMANENT color=0:0:255 
d.vect map=roads@PERMANENT color=255:0:0 
d.rast map=todo -o

d.frame -c frame=leyenda at=0,10,0,100
d.legend todo -c at=70,30,10,12
echo "Posibles emplazamientos"| d.text at=20,40 size=40 color=black

