#!/usr/bin/python
# coding: utf-8
#
#       p6.sh
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

import os

i=0;
while i<10:
	j=i+1
	print "Iteracion "+ unicode(j)
	os.system("g.remove f"+unicode(j)+">/dev/null 2>/dev/null")
	os.system("./calcula "+unicode(i)+" "+unicode (j))
	i=i+1

