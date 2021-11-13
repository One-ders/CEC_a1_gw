# CEC_a1_gw

A small application for using the CEC protocol in the HDMI cable from you TV set. it can be configured to run on
the STM32 Discovery boards MB997C or MB1075B

Break out the CEC signal from the HDMI cable, via a junction box, or solder it directly on the graphical board in
the computer that servers as a set top box.

The CEC board will connect to a controlling computer via USB, where it will present a /dev/ttyACM device with the
vendor/product of the Pulse Eight box. It is then possible to use the linux libcec libraries direct since the lib
thinks it is a pulse eight device connect.

Using this with Mythtv f.ex. makes it possible to control all devices from one remote control.

In the application there is also a bit banging driver and application code to provide a SONY A1 2 wire signal
for controlling old Sony 5.1 amplifiers (STRDB 89x something)..., the program will present the amp as a sound system
to the hdmi bus. then convert power on, power off, volume up, volume down to Sony A1 signals thus controlling the amp
from the TV remote.
