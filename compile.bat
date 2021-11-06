@echo off

set name="SNES_13"
set name2="SNES_13B"

set path=%path%;..\bin\

set CC65_HOME=..\

ca65 main.asm -g
ca65 mainB.asm -g

ld65 -C lorom256k.cfg -o %name%.sfc main.o -Ln labels.txt
ld65 -C lorom256k.cfg -o %name2%.sfc mainB.o -Ln labelsB.txt

pause

del *.o

