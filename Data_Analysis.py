# -*- coding: utf-8 -*-
"""
Script to analyze and plot 1D data for a single result
ES UN SINGLE RESULT!!!! NO SIRVE PARA COMPARAR
"""

import numpy as np
import matplotlib.pyplot as plt

points = 96
freq = 1/200.


rdir = '/media/toni/Toni_LaForge/Results_Burgers1D/nu50/'
rfil = '170622_Results_10037.dat'

# Loading data to script (change rdir and rfil to change data)
data = np.loadtxt(rdir + rfil, comments = '#')

# Number of timesteps
tsteps = len(data[:,1]) / points

# Array with times
time = np.linspace(0, int(tsteps * freq), int(tsteps))

# Extracting coords
coords = np.zeros(points)

for i in range(0,points): 
    coords[i] = data[i,0]    
    
# Creating array to store velocities
data1 = np.reshape(data[:,1], (points, int(tsteps)), order='F')

# Memory clenaup of raw data
del(data)

# Calculating mean values in each point
medios = np.zeros(points)
var = np.zeros(points)
rms = np.zeros(points)
norm = np.zeros(points)

mvel = np.amax(np.abs(data1))

for i in range(0, points): 
    medios[i] = np.average(data1[i,0:10])
    var[i] = np.var(data1[i,:])
    rms[i] = np.sqrt(np.average(data1[i,:] ** 2))
    norm[i] = np.abs(medios[i]) / mvel

# Plotting mean values over height
fig1 = plt.figure()
ax1 = fig1.add_subplot(3, 1, 1)
ax1.plot(time, data1[0,:])
ax2 = fig1.add_subplot(3, 1, 2, sharex=ax1, sharey = ax1)
ax2.plot(time, data1[50,:])
ax3 = fig1.add_subplot(3, 1, 3, sharex = ax1, sharey = ax1)
ax3.plot(time, data1[95,:])
plt.setp(ax1.get_xticklabels(), visible = False)
plt.setp(ax2.get_xticklabels(), visible = False)

# Plotting detail of values over height
fig2 = plt.figure()
ax1 = fig2.add_subplot(3, 1, 1)
ax1.plot(time[0:300], data1[0,0:300])
plt.grid()
ax2 = fig2.add_subplot(3, 1, 2, sharex=ax1, sharey = ax1)
ax2.plot(time[0:300], data1[10,0:300])
plt.grid()
ax3 = fig2.add_subplot(3, 1, 3, sharex = ax1, sharey = ax1)
ax3.plot(time[0:300], data1[60,0:300])
plt.grid()
plt.setp(ax1.get_xticklabels(), visible=False)
plt.setp(ax2.get_xticklabels(), visible=False)

# Plotting mean value of velocity 
fig3 = plt.figure()
ax1 = fig3.add_subplot(1, 1, 1)
ax1.plot(medios, coords)
plt.ylim(1, 0)

# Plotting mean value of velocity normalized
fig4 = plt.figure()
ax1 = fig4.add_subplot(1, 1, 1)
ax1.plot(norm, coords)
plt.ylim(1, 0)

# Plotting mean values over height
fig1 = plt.figure()
ax1 = fig1.add_subplot(3, 1, 1)
ax1.plot(data1[:, 0])
ax2 = fig1.add_subplot(3, 1, 2, sharex=ax1, sharey = ax1)
ax2.plot(data1[:, 20])
ax3 = fig1.add_subplot(3, 1, 3, sharex = ax1, sharey = ax1)
ax3.plot(data1[:, 80])
plt.setp(ax1.get_xticklabels(), visible=False)
plt.setp(ax2.get_xticklabels(), visible=False)

plt.show()