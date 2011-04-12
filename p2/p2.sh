#!/bin/sh
#       p2.sh
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

# Deletes previously painted maps
# Set monitor output
# Change resolution
d.erase
d.mon start=x0
g.region res=5

g.remove rast=curvas_nivel
r.bilinear input=elevation.dem@PERMANENT output=curvas_nivel

g.remove rast=nivel
cat pendiente.reclass | r.recode curvas_nivel output=nivel
cat colores1 | r.colors nivel color=rules
d.rast map=nivel -o


g.remove rast=pendientes
r.bilinear input=slope output=pendientes

g.remove rast=inundable
cat inundable.reclass | r.recode pendientes output=inundable
cat colores | r.colors inundable color=rules
d.rast map=inundable -o

d.vect roads color=0:0:0
d.vect streams color=blue

echo "Zonas Inundables" | d.text at=60,5 size=4 color=red -b

d.barscale at=5.0,90.0
