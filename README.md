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
  
  
  
  
Update Nov 4, 2021

An easier way (see mainB.asm and SNES_13B.sfc)

I made an app that can make a binary file holding all
the Echo Settings. And I added a function to set
all the Echo Settings, called SPC_All_Echo. It also 
sets the Global Volume (Main Volume).

The app is called Echo4GSS.exe and is in the
music folder. It can do other things too
(see that project in my github). Use this app
to "Save Settings", creates a 14 byte bin file.
That file holds all the Echo parameters.

You just need to pass a pointer to that file
to the SPC_All_Echo function to change all
the Echo Settings (and also Main Volume).

Note: it overwrites the first FIR table
Note2: it will take a while. Probably should
       only attempt it between levels.

Adding Echo the "easy" way...
Step by step:
1. Make a song in SNESGSS
2. Save it/ export it, and also (for testing)
   save a song as an SPC
3. Open the SPC in Echo4GSS
4. Change the Echo Settings
(it will tell you if the settings are impossible)
5. Save the SPC, test it in MESEN-S
6. If it sounds bad, goto 4
7. Save the settings as .bin
8. .incbin that settings file to your asm
9. Before you play a new song, first send a
   pointer to the Echo Settings to SPC_All_Echo
10. Now play a song.

You could have a unique Echo Setting for each
song, or you could have 1 or 2 different settings,
or you can always turn off Echo by simply
setting echo volume to zero.

lda #0 ;echo volume 0
tax
jsl Echo_Vol



