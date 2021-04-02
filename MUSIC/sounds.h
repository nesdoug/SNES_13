//this file generated with SNES GSS tool

#define SOUND_EFFECTS_ALL	1

#define MUSIC_ALL	2

//sound effect aliases

enum {
	SFX_DING=0
};

//sound effect names

const char* const soundEffectsNames[SOUND_EFFECTS_ALL]={
	"DING"	//0
};

//music effect aliases

enum {
	MUS_BLOCKPARTY=0,
	MUS_UNTITLED=1
};

//music names

const char* const musicNames[MUSIC_ALL]={
	"BLOCKPARTY",	//0
	"UNTITLED"	//1
};

extern const unsigned char spc700_code_1[];
extern const unsigned char spc700_code_2[];
extern const unsigned char music_1_data[];
extern const unsigned char music_2_data[];

const unsigned char* const musicData[MUSIC_ALL]={
	music_1_data,
	music_2_data
};
