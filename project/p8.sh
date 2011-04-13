#!/bin/sh
#       p8.sh
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


#Generacion de Mapas
#g.remove rast=Paisaje_uf_2005

#El mapa vectorial Paisajes_uf_2005 ocupa 250 MG

#v.in.ogr dns=../Shapes/ufpaisaje.shp output=Paisaje_uf_2005


#g.remove rast=parcela_vegetacion
#v.to.rast input=Paisaje_uf_2005 output=RPaisaje_uf_2005 use=cat
#cat reclass | r.reclass RPaisaje_uf_2005 output=parcela_vegetacion1


#
# Funcion para cargar las coordenas en variables
#
getCoord( ) {
X=$1;
Y=$2;	
	}


# ======  E N T R A D A    D E    D A T O S  ======

#
# Leemos el punto inicial del cortafuegos
#
d.mon start=x0
d.rast map=parcela_vegetacion1


echo Indica el punto de inicio del cortafuegos


getCoord $(d.where -1)
XT=$X; # Punto de inicio
YT=$Y;

echo "Punto donde empieza el cortafuegos: $XT,$YT a altura: $HT"
#
# Leemos el punto final del cortafuegos
#
echo Indica el punto donde acaba el cortafuegos

getCoord $(d.where -1)
XD=$X;	# Punto de fin
YD=$Y;
echo "Punto donde acaba el cortafuegos: $XD,$YD a altura: $HD"


# ======  SUPERFICIE DE COSTE  ======



# El cortafuego se marca en linea recta, no tiene sentido calcular el coste minimo.
g.remove=cuTerreno
r.mapcalc "cuTerreno=1"

# Calculo de la superficie de coste
#
g.remove rast=coste
r.cost -k input=cuTerreno output=coste coordinate=$XT,$YT

g.remove rast=cortafuegos
r.drain coste output=cortafuegos coordinate=$XD,$YD


# ==== DIBUJANDO ====


g.remove vect=cortafuegos
r.to.vect cortafuegos output=cortafuegos feature=line


echo Dibujando mapa de situacion

d.frame -e
d.frame -c frame=mapa at=20,100,0,80 
d.rast map=parcela_vegetacion1
d.barscale  at=60.0,85.0 


#Sustituimos r.buffer por una linea mas ancha en el mapa vectorial
d.vect cortafuegos color=black width=6s

d.frame -c frame=titulo at=0,20,0,80
echo "Traza del cortafuegos"|d.text at=2,40 size=40 color=black -b

d.frame -c frame=leyenda at=0,100,80,100
d.legend map=parcela_vegetacion1 at=0,95,5,95 

d.out.file output=cortafuegos  res=1 format=png compression=0 quality=75


# ==== N V I Z =====

echo Dibujando mapa con nviz

nviz elevation=elevacion vector=cortafuegos 









