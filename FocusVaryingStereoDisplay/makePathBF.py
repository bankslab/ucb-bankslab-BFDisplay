# from __future__ import division
import random
import sys
# import pylab

pathName = sys.argv[1]

# ------------------------
# These are the paramteres
# that specify a path's
# general behaviour
# ------------------------

# Duration of video sequence
duration = 5*60 # seconds
fps      = 45     # frames/sec IS THIS RIGHT?

# Dioptric range
min_d =  0.1 # dioptres
max_d =  1.3

# Rate of dioptric change
min_rate = 0.1 # dioptres per second
max_rate = 1.0

def makePath():
    # ---------------
    # Generate a path
    # ---------------

    timebase = [0,]
    dioptres = [min_d,]

    time = 0
    d    = min_d

    while time < duration:
        # Set a new dioptric value and a rate to go there
        new_d = random.uniform(min_d, max_d)
        rate  = random.uniform(min_rate, max_rate)
        # Time to make the change at that rate
        dt = abs(new_d - d) / rate
        # dt = 1 # second
        # Make the change
        time += dt
        # Clamp at the end
        if time + dt > duration:
            time = duration
        # Make the change
        d    = new_d
        # Record it
        timebase.append(time)
        dioptres.append(d)

    # ------------------------
    # Write it to disk in the
    # format read by siggen.py
    # ------------------------
    fp = open('pathFiles/' + pathName + '.txt', 'w')
    # fp.write( '0  # Diopter bias\n')
    for (t, d) in zip(timebase, dioptres):
        fp.write('%6.2f %5.2f\n' % (t, d))
"""
    # Plot it
    pylab.figure()
    pylab.plot(timebase, dioptres)
    pylab.title('Stimuli path')
    pylab.xlabel('Time (s)')
    pylab.ylabel('Dioptres')
    pylab.ylim(1, -4)
    pylab.show()
"""

if __name__ == '__main__':
    makePath()
