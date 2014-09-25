#makefile for gaf-geda

# Input DIR using this directory structure cleans things upS
NAME= oohay

SCH=sch
PCB=pcb
SYM=gaf-symbols
FP=gaf_footprints
SS=subcircuits
FORCE=NO
# variables using the Make builtin shell expression/expansion
# not sure if = is a good assignment operator or if =! or =: would be better
DATE = $(shell date +"%b-%d-%Y")
AUTHOR = $(shell git config --global -l | grep user.name | cut -d "=" -f2)
REV = $(shell git describe --tags --long)
STATUS = $(shell git status -z -uno)
CHECKINS = $(shell git status --porcelain *.pcb *.sch)


pcb-files = $(wildcard *.pcb)
schematic-files = $(wildcard *.sch)
.PHONY: test
test:
	@$(foreach asset, $(pcb-files), echo $(asset);)

.PHONY:  clean
clean:
	rm -f *~ *- *.backup *.new.pcb *.png *.bak *.gbr *.cnc *.ps

.PHONY: all
all:
ifneq ($(FORCE),YES)
 ifneq ($(STATUS),)
 $(error error: bad working state -- clean working state and try again or use override)
 endif
 ifneq ($(CHECKINS),)
 $(error error: untracked schematic or pcb content, add content or use override)
 endif
 ifeq ($(REV),)
 $(error error: revision history has no tags to work with, add one and try again)
 endif
endif

%.ps :: %.pcb 
	pcb -x ps --psfile $@ $(REV). $(pcb-assets)

%.ps :: %.sch
# the following sed replacements work on variables found in CVS title blocks for gschem
	sed -i "s/\(date=\).*/\1$\$(DATE)/"  $(schematic-assets)
	sed -i "s/\(auth=\).*/\1$\$(AUTHOR)/" $(schematic-assets)
	sed -i "s/\(fname=\).*/\1$@/" $(schematic-assets)
	sed -i "s/\(rev=\).*/\1$\$(REV) $\$(TAG)/" $(schematic-assets)
#TEMPFILE := ${shell mktemp $(NAME)-sch-XXXX}
	gaf export -o sch-$(REV).$@  -- $(schematic-assets)
# danger, we will discard changes to the schematic file in the working directory now.  This assumes that the working dir was clean before make was called and should be rewritten as an atomic operation
