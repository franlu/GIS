#!/bin/sh
#       p3.sh
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

g.remove rast=Rfields1
v.to.rast input=fields@PERMANENT output=Rfields1 use=cat

g.remove rast=parcela_parque

r.null map=Rfields1 null=1
r.null map=Rfields1 setnull=63

cat parcela.reclass | r.reclass Rfields1 output=parcela_parque
cat colores_ | r.colors parcela_parque color=rules

d.rast map=elevation.dem@PERMANENT -o

g.remove vect=curvasnivel
r.contour input=elevation.dem@PERMANENT output=curvasnivel minlevel=1066 maxlevel=1840 step=50 cut=0 
d.vect map=curvasnivel

d.rast map=parcela_parque -o

d.vect roads color=255:0:0
d.vect streams color=blue

echo "Parque Natural" | d.text at=76,5 size=4 color=black -b
d.barscale at=5.0,90.0


