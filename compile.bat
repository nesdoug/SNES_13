@echo off

set name="SNES_13"

set path=%path%;..\bin\

set CC65_HOME=..\

ca65 main.asm -g

ld65 -C lorom256k.cfg -o %name%.sfc main.o -Ln labels.txt

pause

del *.o

