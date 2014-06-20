#makefile for gaf-geda
# parts of this makefile are inspired by Nixotic Design's gEDA-tools Makefile

# Q: why use git?
#
# git provides an agnostic and free libre version control
# system for collaborative HW engineering workflows. The end goal is to develop
# a comprehensive FLOSS non-cloud dependent PLM system
#
# Q:why use make?  
#
# make is commonly available as a requirement for any embedded engs to understand 
# with fluency hopefully this functionality doesn't stop with make and the cli
# 
# Q:why not use kicad?
# 
# kicad is great and folks should also describe how to use it with a  
# version control system

# todos
# target for numbering/annotating  the symbols uses refdes_renum
# fix target for pcb layout documentation output:
# gschem and pcb are used to create postscript files  '.ps' 
# target for making oshpark gerbers
# target for making custom gerbers



# assumes a project is version controlled with git and the .sch and .pcb files
# are in the main directory with submodules for gaf-sym and gaf-fp below them.

# /projectname/ 
# /projectname/makefile
# /projectname/*.sch and gafrc
# /projectaname/gaf-symbols/ 
# /projectname/gaf-fooptrints/
# /projectname/*.pcb and gattrib or other pcb specific config



# .PHONY prevents rules from becoming disabled if files exist with the same name 
.PHONY:  clean 
# Input DIR using this directory structure cleans things upS
SCH=sch
PCB=pcb
SYM=gaf-symbols
FP=gaf_footprints
SS=subcircuits

NAME= projectname
DATE = $(shell date +"%b-%d-%Y")
AUTHOR = $(shell git config --global -l | grep user.name | cut -d "=" -f2)
REV = $(shell git log -1 --format=%h)


# target for cleaning up backup files out of project dirs 
#basic format of a 'rule' in Make is target : prerequisite
clean:
	rm -f *~ *- *.backup *.new.pcb *.png *.bak *.gbr *.cnc
# this rule has no prerequisite


#basic format of a 'rule' in Make is target : prerequisite
%.pdf : %.sch
# here the $@ and $< are called  'automatic variables', 
# $@ is the target and $< is the prerequisite
	sed -i "s/\(date=\).*/\1$\$(DATE)/" $<
	sed -i "s/\(auth=\).*/\1$\$(AUTHOR)/" $<
	sed -i "s/\(fname=\).*/\1$@/" $<
	sed -i "s/\(rev=\).*/\1$\$(REV)/" $<
	gaf export -o $@ -- $<

# this following rule conflicts with the rule for schematics.  study make and figure out how to make it work
#%.pdf : %.pcb
#	pcb -x ps --psfile $@ $<
#	ps2pdf $< $@
# perhaps 
#%.pdf : %.sch %.pcb  # rule has prerequisites for any %.sch and %.pcb files... hmm does it need both?

# ps2pdf conversion to pdf
#%.pdf :  %.ps
#	ps2pdf $< $@

renum : $(NAME).sch
	refdes_renum $(NAME).sch

%.bom : %.sch renum
	gnetlist -g partslist3 -o $@ $<


.PHONY gerbers
# rule for making generic gerbers
gerbers :$(NAME).pcb  $(NAME).bom
	rm -rf gerbers
	mkdir gerbers
	pcb -x gerber --gerberfile gerbers/$(NAME) $<

gerbers.zip : gerbers
	rm -f $@
	zip -j $@ gerbers/*

.PHONY : osh-park-gerbers
osh-park-gerbers : gerbers
	mkdir -p $@
	cp gerbers/$(name).top.gbr "$@/Top Layer.ger"
	cp gerbers/$(name).bottom.gbr "$@/Bottom Layer.ger"
	cp gerbers/$(name).topmask.gbr "$@/Top Solder Mask.ger"
	cp gerbers/$(name).bottommask.gbr "$@/Bottom Solder Mask.ger"
	cp gerbers/$(name).topsilk.gbr "$@/Top Silk Screen.ger"
	cp gerbers/$(name).bottomsilk.gbr "$@/Bottom Silk Screen.ger"
	cp gerbers/$(name).outline.gbr "$@/Board Outline.ger"

osh-park-gerbers.zip : osh-park-gerbers
	rm -f $@
	zip -j $@ osh-park-gerbers/*
