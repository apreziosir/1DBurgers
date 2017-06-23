#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Jun 23 10:34:24 2017

@author: toni
"""

import numpy as np 
import matplotlib.pyplot as plt

time = 20                   # Tiempo total de señal
dt = 1./20000               # Separacion de tiempo en señales
pasos = int(time / dt)      # Pasos de tiempo calculados
periodo = 1                 # Periodo de la onda
vmed = 1                    # Velocidad media de la onda (desp vertical)


# Definiendo vector de velocidades
vel = np.zeros(pasos)

# Llenando vector de velocidades
for i in range(0, pasos):
    
    tac = i * dt    
    if tac <= 1. :        
        vel[i] = vmed + np.sin(2 * np.pi * tac)        
    else:        
        vel[i] = vmed

# Graficando velocidad para prueba
fig1 = plt.figure()
ax1 = plt.plot(vel)
plt.show()

# Escribiendo archivo de texto con input
np.savetxt('/home/toni/Documents/1DBurgers/testsignal.dat', vel)