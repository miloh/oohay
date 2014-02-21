v 20111231 2
C 37900 61800 1 0 0 speaker-1.sym
{
T 39900 64300 5 10 0 0 0 0 1
device=SPEAKER
T 38500 63800 5 10 1 1 0 0 1
refdes=SPK?
}
N 31900 61000 31900 63700 4
N 31900 63700 34900 63700 4
N 35800 63700 37900 63700 4
N 31900 58600 31900 60600 4
N 37900 62500 37400 62500 4
N 37800 58600 37800 61800 4
N 37800 58600 31900 58600 4
C 28800 56300 1 0 0 attiny25-45-85.sym
{
T 35100 60100 5 10 1 1 180 0 1
refdes=U?
T 29200 58700 5 10 0 0 0 0 1
device=tiny85
}
N 31900 61000 33400 61000 4
N 33400 60600 31900 60600 4
N 35900 61800 35900 62500 4
C 36500 62300 1 0 0 capacitor-1.sym
{
T 36700 63000 5 10 0 0 0 0 1
device=CAPACITOR
T 36500 62600 5 10 1 1 0 0 1
refdes=C?
T 36700 63200 5 10 0 0 0 0 1
symversion=0.1
}
C 36500 61600 1 0 0 capacitor-3.sym
{
T 36700 62300 5 10 0 0 0 0 1
device=POLARIZED_CAPACITOR
T 36500 62000 5 10 1 1 0 0 1
refdes=C?
T 36700 62500 5 10 0 0 0 0 1
symversion=0.1
}
N 35400 61800 36500 61800 4
N 37400 61800 37800 61800 4
N 36000 62500 36500 62500 4
C 34900 63600 1 0 0 inductor-1.sym
{
T 35100 64100 5 10 0 0 0 0 1
device=INDUCTOR
T 35100 63900 5 10 1 1 0 0 1
refdes=L?
T 35100 64300 5 10 0 0 0 0 1
symversion=0.1
T 35100 63400 5 10 1 1 0 0 1
value=100uH
}
C 34200 56700 1 0 0 cvstitleblock-1.sym
{
T 34800 57100 5 10 1 1 0 0 1
date=$Date$
T 38700 57100 5 10 1 1 0 0 1
rev=$Revision$
T 40200 56800 5 10 1 1 0 0 1
auth=$Author$
T 35000 57400 5 10 1 1 0 0 1
fname=$Source$
T 38000 57800 5 14 1 1 0 4 1
title=TITLE
}
