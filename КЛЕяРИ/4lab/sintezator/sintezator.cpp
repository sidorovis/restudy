// This is the main project file for VC++ application project 
// generated using an Application Wizard.


#include "stdafx.h"
#using <mscorlib.dll>

using namespace System;
using namespace std;

bool oa_glasnaya(char symb)
{
	if ( symb == 'à' || symb == 'î' || symb == 'ó' ||
		 symb == 'û' || symb == 'è' || symb == 'ý')
		 return true;
	return false;
}
bool eya_glasnaya(char symb)
{
	if (symb == 'å' || symb == '¸' || symb == 'þ' || symb == 'ÿ')
		return true;
	return false;
}
char eya2oa(char symb)
{
	if (symb == 'å')
		return 'ý';
	if (symb == '¸')
		return  'î';
	if (symb == 'þ')
		return  'ó';
	if (symb == 'ÿ')
		return  'à';
}

int _tmain()
{
    ifstream inp("input.txt");
	char buffer[1024];
	string text = "";
	while ( !inp.eof() )
	{	
		inp.getline(buffer,1024);
		text=text+buffer+" ";
	}
	for (int i = 0 ; i < (int)text.length() ; i++)
	{
		if (text[i] >= 'À' && text[i] <= 'ß')
			text[i] = text[i] - 'À' + 'à';

		if (text[i] == ' ')	text[i] = '_';
		if (text[i] == '\n') continue;

		string current = string("") + text[i];
		if ( i + 1 < (int)text.length())
		{
			if (text[i+1] == 'ü')
			{
				current += "_";
				text.erase(i+1,1);
			}
			if (!oa_glasnaya(text[i]) && eya_glasnaya(text[i+1]) || text[i+1] == 'è' )
				current += "_";
			if (eya_glasnaya(text[i+1]))
				text[i+1] = eya2oa(text[i+1]);
		}
		string file_name = string("") + "base\\"+current+".wav";
		cout << file_name << endl;
		sndPlaySound(file_name.c_str(),SND_SYNC);
	}

	return 0;
}