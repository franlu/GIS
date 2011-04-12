#!/usr/bin/python
# coding: utf-8
import os
import sys
import re
# Grass script
#
# Return the cat value from the r.what string 
# passed as argument 
#
# Usage:
#
# 	Z=$(u.getZ $(r.what MAPA ));
#
# Author:
# J.C. Torres 				May 2006
#
# 
# Copyright (c) J.C. Torres (Univ. de Granada, SPAIN)
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details 
# http://www.gnu.org/copyleft/gpl.html
#

argumentos=sys.argv
# print argumentos[1]
result = re.split(r'\|\|(.+)',argumentos[1])
print result[1]

# $s=$ARGV[0];

# ($Z)  = ($s =~ /\|\|(.*)/);

# print "$Z \n";

