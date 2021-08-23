
#KREL=../../krel
KREL=/home/anders/test1/nrepo/RTScheduler-Discovery/boards/MB997C

## application brings own driver, specify the make target in the
## macro below. The make file is expected to create a object file
## with the name of the target+".o" and put it under 'obj/drv_obj'
APPLICATION_DRIVERS=my_drivers

OBJ:=$(KREL)/obj
LOBJ:=obj

include $(KREL)/Makefile

usr.bin.o: $(OBJ)/usr/sys_cmd/sys_cmd.o $(LOBJ)/usr/cec_a1_ctrl.o
	$(LD) -o $(LOBJ)/usr/usr.bin.o $(LDFLAGS_USR) $^
	$(OBJCOPY) --prefix-symbols=__usr_ $(LOBJ)/usr/usr.bin.o

my_drivers: $(LOBJ)/usr $(LOBJ)/usr/cec_a1_drivers.o
	$(LD) -r -o $(LOBJ)/usr/usr.drivers.o $(LOBJ)/usr/cec_a1_drivers.o
	mkdir -p $(LOBJ)/drv_obj
	cp $(LOBJ)/usr/usr.drivers.o  $(LOBJ)/drv_obj/$@.o

$(LOBJ)/usr:
	mkdir -p $(LOBJ)/usr

$(LOBJ)/usr/cec_a1_ctrl.o: $(LOBJ)/usr main.o asynchio.o pulse_eight.o cec.o a1.o
	$(CC) -r -nostdlib -o $@ main.o asynchio.o pulse_eight.o cec.o a1.o

$(LOBJ)/usr/cec_a1_drivers.o: cec_drv.o a1_drv.o
	$(CC) -r -nostdlib -o $@ $^

%_drv.o: %_drv.c
	$(CC) $(CFLAGS) -c -o $@ $<

main.o: main.c
	$(CC) $(CFLAGS_USR) -c -o $@ $<

asynchio.o: asynchio.c asynchio.h
	$(CC) $(CFLAGS_USR) -c -o $@ $<

pulse_eight.o: pulse_eight.c asynchio.h
	$(CC) $(CFLAGS_USR) -c -o $@ $<

cec.o: cec.c cec.h
	$(CC) $(CFLAGS_USR) -c -o $@ $<

a1.o: a1.c a1.h
	$(CC) $(CFLAGS_USR) -c -o $@ $<

clean:
	rm -rf *.o  cec_a1_ctrl myCore obj
