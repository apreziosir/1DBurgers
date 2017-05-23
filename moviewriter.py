# This example uses a MovieWriter directly to grab individual frames and
# write them to a file. This avoids any event loop integration, but has
# the advantage of working with even the Agg backend. This is not recommended
# for use in an interactive setting.
# -*- noplot -*-

import numpy as np
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import matplotlib.animation as manimation

# Lectura de datos de archivo de resultados
# Verificando directorio de trabajo
p_dom = 96   # Defino puntos en el dominio computacional
archivo = 'Results.dat'  # Poniendo el nombre del archivo en una variable
datos = np.loadtxt(archivo, comments='#', usecols=(0,1))  # Cargo archivo de datos
grupos = int(len(datos) / p_dom)  # Calculo del numero de grupos de resultados presentes

# Rutina orientada a objetos para escribir un GIF con datos resultantes
FFMpegWriter = manimation.writers['imagemagick']
metadata = dict(title='Resultados', artist='APR',
                comment='Velocity damping in Hyporheic Zone')
writer = FFMpegWriter(fps=12, metadata=metadata)

fig = plt.figure()
l, = plt.plot([], [])

# Ejes y etiquetas de ejes graficados
plt.title('RESULTS \n dT = 0.00005, nu = 0.02, filter = 1.57')
plt.xlabel('Depth (m)')
plt.ylabel('Velocity (m/s)')
plt.xlim(0, 0.40)
plt.ylim(-0.25, 0.25)

x0, y0 = 0, 0

with writer.saving(fig, "writer_test.gif", 100):
    for i in range(grupos):
        x0 = datos[i*p_dom: (i+1)*p_dom, 0]
        y0 = datos[i*p_dom: (i+1)*p_dom, 1]
        l.set_data(x0, y0)
        writer.grab_frame()