# SNES_13  
SNES example code - echo tests  
  
2021 Doug Fraker  
  
Learn to program a Super Nintendo game from scratch.  
This program shows music code, using snesgssQ. Patched in echo functions.  
  
Added these functions --  
  
echo_vol	a = vol, 00-$7f, x = which channels (bit field)  
  
echo_addr	a = echo start address (x $100)   
			x = buffer size, 01-$0f, (x $800)  
			(use values 1-5 for buffer size)  
  
echo_fb_fir  a = 0-3 = FIR table set, x = echo feedback 0-$7f  
  
a = 0 = simple echo    7f 00 00 00  00 00 00 00  
a = 1 = multi echo     48 20 12 0c  00 00 00 00  
a = 2 = low pass echo  0c 21 2b 2b  13 fe f3 f9  
a = 3 = high pass echo 01 02 04 08  10 20 40 80  
  
  
  
USE with snesgssQ.exe, the patched version.  
  
follow this procedure in main.asm, lines 227-250  
 1.sound_stop_all  
 2.echo_vol = 0  
 3.echo_addr  
 4.echo_vol, set  
 5.echo_fb_fir, set  
 6.spc_play_song  
   
or, if echo_addr is already where you want it  
 1.sound_stop_all  
 2.echo_vol, set  
 3.echo_fb_fir, set  
 4.spc_play_song  
 (the order of 2-4 is not very important)  
  
  
CAUTIONS:  
-echo vol NEEDS to be zero if you use echo_addr !!!  
 it could have devastating consequences, including crash,  
 if echo vol isn't zero while changing echo_addr  
-changing echo address does a long pause.  
 (ie. freezes the APU from doing anything for that time)  
 Don't change echo address much. Set it once at the start of  
 a new song, or just once at the very beginning of the game.   
-!! SNESGSS has no way to warn you if you are putting the song  
 data, or SPC code, in the same location as the echo buffer.   
 This is something you will have to prevent on your own.   
 spc700.bin + music.bin + $200 needs to less than the start   
 address of the echo buffer.  
-don't make the buffer size larger than the available space  
-also, avoid the SPC boot ROM at $FFC0-FFFF  

*bug fix Qv2 - echo buffer size zero was crashing.
   
NOTES:  
-the echo settings used in the demo are probably much more  
 than you will want. Music will usually sound better with  
 a more subtle echo effect. Vol $20-40, Feedback $30-50.  
   
-oh, and you could put in your own custom FIR filter...  
 spc_load_data the 8 bytes to $3aa, which is the first set  
 on the FIR table, and echo_fb_fir with #0 for the A value  
 ...see the commented out code in main.asm, line 180  
 and the TEST FIR table at line 708  
   
see here for FIR filter examples  
https://sneslab.net/wiki/FIR_Filter   
  
nesdoug.com  
  
