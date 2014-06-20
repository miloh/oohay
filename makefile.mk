
name=OLM

backplanebreakout:  backplanebreakout.sch \
            packages/* symbols/*
    refdes_renum $^
    gsch2pcb -v -v $^ -o $@

clean:
    rm -f *~ *- *.backup *.new.pcb *.png *.bak *.gbr *.cnc

#.sym : %.tsym
#tragesym $< $@

SYMS = $(wildcard sym/*.tsym)
SYMBOLS := $(SYMS:.tsym=.sym)

symbols : $(SYMBOLS)

check-symbols : $(SYMBOLS)
gsymcheck $(SYMBOLS)

.PHONY : clean

pcb : symbols
gsch2pcb name | tee pcb.log

%.ps : %.pcb
pcb -x ps --psfile $@ $<

%.pdf : %.ps
ps2pdf $< $@

.PHONY : gerbers
gerbers : $(name).pcb $(name).bom
rm -Rf gerbers
mkdir gerbers
pcb -x gerber --gerberfile gerbers/$(name) $<

gerbers.zip : gerbers
rm -f $@
zip -j $@ gerbers/*
