/****************************************************************************************************
*                                                                                                   *
* 	���������� ���������� ����.                                                                     *
* 	�����������:                                                                                    *
* 		: ���������� ���� ������ ��������� ������� �� 54 �������� ������ (������� ����� ���������)  *
* 		: ���������� ���� �������������� ������ � �������� �����                                    *
* 		: ���������� ����������� ����� �������� ��������� ���������� � ������� ���� ���             *
*          ��������� ��������� ������� �������� �����                                               *
* 		: ������������ ������������ �������� �������                                                *
*                                                                                                   * 
****************************************************************************************************/



#include <stdlib.h>
#include "stdafx.h"
using namespace std;

// ������ ��� ������������ �������� ������ ������� wav
	HANDLE WAVEFILE;
	PCMWAVEFORMAT PCMWaveFmtRecord;
	WAVEHDR WaveHeader;
/* 
    ������� change_all_with_brackets
    ��������� �������� ������� ������ ��� �������� �� ����� �������� (�� ��������� ����)
    ������� ���������:
        ������ ���������� ������� �����
        ������ ���������� ������� ���� �������������� �������->����
    �������� ���������:
        ��������� ������������� ���������� ��������� �������� �������   
*/
string change_all_with_brackets(string& a, const string b)
{
	int place = 0;
	place = a.find(b, place);
	while (place > -1)
	{
		if ( place > 0 && a[ place - 1 ]=='|')
			place++;
		else
		{
			a.insert(place,"|");
			a.insert(place+1+b.size(),"|");
			place = 0;
		}
		place = a.find(b, place);
	}
	return a;
}

/* 
    ������� log
    ���������� �������
    ������� ���������:
        ������ ��� ����������� �� ������
*/
void log(string a)
{
//	cout << a << endl;
}
/* 
    ������� openFile, WavePlay
    ������������ ��������� ����� wav
    ������� ���������:
        ������ ���������� ���� � �����
        ������� ����� ��������������� ������� �� ��������� ������� ������� ��������� ��������� 
               (������ �������).
*/

bool openFile(string file_path, double proc);
void WavePlay();

/* 
    ����� MChar
    �������� �������� �������
*/
class MChar
{

public:
	// ������ �������� �������� �������������
	string data;
	// �����, �������� �� ��� ��������� ��������
	bool charli;
/* 
    ����������� ������
*/

	MChar(char a)
	{
		charli = false;
		if (a >= '�' && a <= '�')
			a = a - '�' + '�';
		if (a == ' ' || a == '\n')
			data = string("") + " ";
		else
			data = string("")+ a;
	}
/* 
    ����������� ������
*/
	MChar(bool t,string a)
	{
		charli = true;
		data = a;
	}
/* 
    ������� does_oa
    �������� �� � � � � � � �������
*/
	bool does_oa(int i)
	{
		if (charli)
			return false;
		if ( data[i] == '�' || data[i] == '�' || data[i] == '�' ||
			 data[i] == '�' || data[i] == '�' || data[i] == '�')
			return true;
		return false;
	}
/* 
    ������� does_eya
    �������� �� � � � � �������
*/
	bool does_eya(int i)
	{
		if (charli)
			return false;
		if ( data[i] == '�' || data[i] == '�' || 
			 data[i] == '�' || data[i] == '�' )
			return true;
		return false;
	}
/* 
    ������� does_bv
    �������� �� ���������
*/
	bool does_bv(int i)
	{
		if (charli)
			return false;
		if (!does_oa(i) && !does_eya(i) && data[i] != '�' && data[i] != '�' && data[i] != '�' && data[i] != '_')
			return true;
		return false;
	}
/* 
    ������� run_eya2oa
    �������� ������ ������� �� ��������������� �� ������
*/
	void run_eya2oa()
	{
		if (charli)
			return ;
		if (data[0] == '�')
			data[0] = '�';
		if (data[0] == '�')
			data[0] = '�';
		if (data[0] == '�')
			data[0] = '�';
		if (data[0] == '�')
			data[0] = '�';
	}
/* 
    ������� run_y_gl
    ������� ������ ��������� � ��� ����� � � ������ ��������������� �������
*/
	void run_y_gl()
	{
		if (charli)
			return ;
		if (data[0] == '�')
			data += '�';
		if (data[0] == '�')
			data += '�';
		if (data[0] == '�')
			data += '�';
		if (data[0] == '�')
			data += '�';
		data[0] = '�';
	}
/* 
    ������� make_
    ������� ���� ������ (!��������� ������ ��� ���������)
*/
	void make_()
	{
		if (charli)
			return ;
		if (data[0] == ' ')
			return;
		data += "_";
	}
/* 
    ������� make_
    ���������� �������� ����������������� ����������� �����
*/
	int size()
	{
		if (charli)
			return data.size();
		if (data.size() > 1 && data[1] != '_')
			return 2;
		return 1;
	}
/* 
    ������� make_
    ��������� � ������ ������������ ����
*/
	string make_str_4output()
	{
		if (data[0] == '_')
			return " ";
		if (data == "�")
			return "";
		return data;
	}
/* 
    ������� make_
    ��������� � ������ ������������ �������� ���� (������ �������)
*/
	string make_str()
	{
		if (data == "�" || data == "�")
			return "";
		return data;
	}
};
// 	�������� ����� ��� ����� �������� ������
vector<MChar> text;
	// 	���� ������ ��������� �������� (��������� -> ��������)
map<string,string> sound_base;
map<string,string>::iterator si;
	// 	������ ������������ �������� ������
vector<string> sounds;
int i;

/* 	
    ������� ������ ����� �� �������� ����� � 
        ���������� ��� �������� ��� �� ���� ��� � 
        �� �������� ��������� �����
*/
void read_text()
{
	ifstream inp("input.txt");
	char buffer[1024];
	while ( !inp.eof() )
	{	
		inp.getline(buffer,1024);
		string foobar = buffer;

		for ( si = sound_base.begin(); si != sound_base.end(); si++)
		{
			change_all_with_brackets(foobar,si->first);
		}

		for ( i = 0 ; i < (int)foobar.size(); i++)
		{
			if (foobar[i] == '|')
			{
				int place = i+1;
				int place2 = foobar.find("|",place);
				i = place2+1;

				text.push_back(MChar(true, sound_base[ foobar.substr(place,place2-place) ] ));
			}
			if (foobar[i] == '\n')
				foobar[i] = ' ';
			text.push_back(MChar(foobar[i]));
		}
        text.push_back(MChar('\n'));
	}
	cout << "Text size: "<< text.size() << endl;
	inp.close();
}
/*
    ������ ���� ������������� ������ ������ � 
          ��������������� �� ������ ������
*/
bool read_file_base()
{
	ifstream inp("sound_base.txt");
	char buffer[1024];
	while ( !inp.eof() )
	{	
		inp.getline(buffer,1024);
		string foobar = buffer;
		if (foobar.length() < 2)
			continue;
		int place = foobar.find("|");
		if (place == -1)
			return false;
		string word = foobar.substr(0,place);
		string sound = foobar.substr(place+1,foobar.length() - place-1);
		sound_base[word]=sound;
	}
	cout << "Word->sound base register:" << sound_base.size() << " pairs." << endl;
	return true;
}
/* 	
    ������ ���� ������������ ������
*/
bool read_base()
{
	WIN32_FIND_DATA winFileData;
	HANDLE hFile;
	char szPath[MAX_PATH];
	i = 0;
	if(GetCurrentDirectory(sizeof(szPath),szPath))
	{
		lstrcat(szPath,"\\base\\*.wav");
		hFile = FindFirstFile(szPath,&winFileData);
		if (hFile!=INVALID_HANDLE_VALUE)
		{
			do 
			{
				i++;
				string filename = winFileData.cFileName;
				filename = filename.substr(0,filename.find("."));
				sounds.push_back( filename );
			}
			while
			( FindNextFile( hFile , &winFileData ) != 0 );
			FindClose(hFile);
		}
	}
	for (i = 0 ; i < sounds.size() ; i++)
		for (int u = i; u < sounds.size(); u++)
			if (sounds[i].length() < sounds[u].length() )
			{
				string temp = sounds[i];
				sounds[i] = sounds[u];
				sounds[u] = temp;
			}
	if (i < 54)
		return false;
	cout << "We read " << i << " sound records." << endl;
	return true;
}

void transfer(string& a, string b,int* c,int* c_block,int number);

/*
    ������� ������������ ���� �� ������������ ���� �������� �������� 
        (��������� ����� ��������� �������)
*/
void playSound(int sound_number)
{
	if (sound_number == -1)
		return;
	string file_path;
	file_path = string("base\\")+sounds[ sound_number ]+".wav";
//	MessageBox(NULL,file_path.c_str(),"",NULL);
	double proc = 1;
	if ( sounds[ sound_number ].length() ==1 )
		proc = 1;
	if ( sounds[ sound_number ].length() ==2 )
		proc = 1;
	if ( sounds[ sound_number ] == " " )
		proc = 0.5;
	if ( sounds[ sound_number ] == "," )
		proc = 0.005;
    cout << file_path << endl;
	if (::openFile(file_path,proc))
		::WavePlay();
}
/*
    �������� �������������� ������ � �������� ����������� 
          (������� �� ����� ����������)
	����� ����������� ������������ ������
*/
void do_algo()
{
	// 	���� ������ ���� ������ ������� ������ �� ���� �+������
	if (text.size() > 0)
	if (text[0].does_eya(0))
		text[0].run_y_gl();

	// 	��� ������� �����
	for (i = 0 ; i < (int)text.size() ; i++)
	{
	// 	���� ������ ������� ��� ����� ������ ������� ������ �� �� �+������
//        string temp1 = text[i].data;
//        string temp2;
		if ( i > 0 && text[i].does_eya(0) && (text[i - 1].does_eya(0) || text[i - 1].does_oa(0) || text[i-1].data==" " || text[i-1].data=="�" || text[i-1].data[ text[i-1].data.length()-1 ] == '_'  ) )
			text[i].run_y_gl();

	// 	���� ����� ��������� ��� ���������� ���� �� �������� ����
	// 	���� ��������� �� ������ ������� ��������������� � ������
        if ( i > 0 && (text[i].does_eya(0) || text[i].data[0] == '�'  || text[i].data[0] == '�' ) && text[i-1].does_bv(0))
		{
			text[i - 1].make_();
			if (text[i].does_eya(0))
				text[i].run_eya2oa();
		}
	}
	string output = "";
	// 	������ ���������� ����� ������������� � ������� ������������ ��������������� �������� � ������
	string full_sound = "";
	for (i = 0 ; i < (int)text.size() ; i++)
	{
		output+=text[i].make_str_4output();
		full_sound+=text[i].make_str();
	}
	// 	������� ��������� �� ������� ������������ �����
//	MessageBox(NULL,full_sound.c_str(),"",NULL);
	// 	������ ��� ������������ ������� ������� ����� ����� �������� ������� ��� ������������
	int* c = new int[full_sound.size()+1];
	// 	������ ��� ������������ ������� ������� ����� ����� �������� ������� ��� ������������
	int* c_block = new int[full_sound.size()+1];
	// 	������ ���������� �������� ������� � ��� ������� � ������� ��������� �� ����������� �� ������
	int* sounds_stack = new int[full_sound.size()+1];
	int st_size = 0;
														// 	��������� ������� �������� ������
	for (i = 0; i < full_sound.size(); i++)
		c[i]=-1;

	for (i = 0 ; i < (int)sounds.size(); i++)
	{
		transfer(full_sound,sounds[i],c,c_block,i);
	}

	st_size = 1;
	sounds_stack[0] = c[0];
	for (i = 1 ; i < full_sound.size(); i++)
	{
		if (c[i] != sounds_stack[ st_size - 1] || c_block[i] != c_block[i - 1])
		{
			sounds_stack[st_size]=c[i];
			st_size++;
		}
	}
	full_sound = "";
	// 	������������ �������� ������
	for (i = 0 ; i < st_size ; i ++)
	{
		playSound(sounds_stack[i]);
	}

	// 	������� ������
	delete []c;
	delete []c_block;
	delete []sounds_stack;
}
/* 	
    ������� ������������� �������� ������� �� �����
*/
void transfer(string& a, string b,int* c,int* c_block,int number)
{

	int place = a.find( b );
    int i=0;
	while ( place != -1 )
	{
		if ( c[ place ] == -1 )
        {
			bool label = true;
			for (int u = place ; u < place + b.size() ; u++)
			{
				if (c[u] != -1)
					label = false;
			}
			if (label)
			{
				for (int u = place ; u < place + b.size() ; u++)
				{
					c[ u ] = number;
					c_block[u] = i;
				}
				i++;
			}
        }
		place = a.find(b,place+1);
	}

}
/*
    ���� � ���������
*/
int main()
{
	if (!read_file_base())
	{
		cout << "Database incorrect" << endl;
		return 1;
	}
	read_base();	
	read_text();
	do_algo();
	return 0;
}
/*
    ������� ����������� �������� ����
*/
bool openFile(string file_path, double proc)
{
		char fooBar[1024];
		sprintf(fooBar,"%s",file_path.c_str());
			// �������� ����� ������ ��� ������
		HMMIO hmmio = mmioOpen(fooBar, NULL, MMIO_READ );
		log("Opening file "+file_path);
		if (!hmmio)
		{
			log("error open file");
			return false;
		}
		MMCKINFO mckinfo;
		MMCKINFO mckinfo_parent;
			// ����������� � 4-�� ������� ���
		mckinfo_parent.fccType = mmioFOURCC('W','A','V','E'); 

		if (mmioDescend(hmmio, 
				&mckinfo_parent,	// ������ ��� ��������� ��������� ���������
				NULL, 
				MMIO_FINDRIFF))		// ������ ��������� ���� RIFF 
		{
			log(" error while looking RIFF ");
			mmioClose(hmmio, 0);	// ������� ����
			return false;
		}
			// ����������� � 4-�� ������� ���
		mckinfo.ckid = mmioFOURCC('f','m','t',' ');
		if (mmioDescend(hmmio,				
						&mckinfo,			// ������ ��� ��������� ��������� ���������
						&mckinfo_parent,	// ����� ������ �������� �����
						MMIO_FINDCHUNK))	// ����� ������������� ����� (fmt)
		{
			log(" error while looking format WAV ");
			mmioClose(hmmio, 0);
			return false;
		}
		
		DWORD bytesRead = mmioRead(hmmio,
				(HPSTR)&PCMWaveFmtRecord,	// ������ ��� ������ ������
				mckinfo.cksize				// ���������� ���� ������� ��������� ���������
				);
		
		if (bytesRead <= 0)
		{
			log("������ ������ ������ � ������� PCM");
			mmioClose(hmmio, 0);
			return false;
		}

		HWAVEOUT hWaveOut;
		if (waveOutOpen(&hWaveOut,				// ������ ��� ������ ������
						WAVE_MAPPER,			// �������� WAV ����� ����� ����������
						(LPWAVEFORMATEX)&PCMWaveFmtRecord, 
												// WAV ������
						NULL,					// call back �������
						NULL,					// call back instance
						WAVE_FORMAT_QUERY))		// ������ �������� ����� �� ������ 
														// ������ ��������� ������ ������
		{
			log(" this file can't be played ");
			mmioClose(hmmio, 0);
			return false ;
		}
		if (mmioAscend(hmmio, &mckinfo, 0))
					// �������� ������ � ������ (������ ����� �� �������)
		{
			log("failed on return to RIFF");
			mmioClose(hmmio, 0);
			return  false;
		}
		mckinfo.ckid = mmioFOURCC('d','a','t','a'); 
					// ����� ������ �����
		if (mmioDescend (hmmio, &mckinfo, &mckinfo_parent, MMIO_FINDCHUNK))
					// ��������������� ����� ������� ������
		{
			log("�� ���� ��������� ���� ������"); 
			mmioClose(hmmio, 0); 
			return false; 
		}
		
		long lDataSize = mckinfo.cksize;
					// ���������� ������ ������� ����� ������
		HANDLE waveDataBlock = ::GlobalAlloc(GMEM_MOVEABLE, lDataSize);
					// ��������� ������ ��� ������ ����� �����
		if (waveDataBlock == NULL)
		{
			log("������ ��������� ������");
			mmioClose(hmmio, 0);
			return false;
		}

		char* pWave = (char*)::GlobalLock(waveDataBlock); 
					// ��������� ������ ��� ������ ������������ ����������� �����
		if (mmioRead(hmmio, 
						(LPSTR)pWave,		// ������� ���� ������ ������
						lDataSize			// ����������� ��������� ���������� �������� ������
						) 
						!= lDataSize)		// ���� ��������� ������ ��� ���� �������� � ���������
		{
			log("error on reading datas");
			mmioClose(hmmio, 0);
			::GlobalFree(waveDataBlock);	// ������� (������������) ������
			return  false;
		}

		WaveHeader.lpData = pWave; //(char*)((int)pWave+(int)(lDataSize*proc));
		WaveHeader.dwBufferLength = (int)lDataSize*proc;
		WaveHeader.dwFlags = 0L;
		WaveHeader.dwLoops = 0L;

		mmioClose(hmmio, 0);
		log("file successfully readed");
		WAVEFILE = waveDataBlock;
	return true;
}
/*
    ������� ������������� �������� ����
*/
void WavePlay()
{
	// ������ �� WAVE-����������
	HWAVEOUT hWaveOut;

	log(_T("opening WAVE-device"));
	
	// ������� WAVE-����������
	MMRESULT ReturnCode = waveOutOpen (		&hWaveOut, 	// �������� ���������� ��� ������������
										  WAVE_MAPPER, 	// ������ ������ ���� ��� ������������ WAV
				   (LPWAVEFORMATEX) &PCMWaveFmtRecord, 	// ��� ��������� ������� ����� ������������
												 NULL, 	// callback �������
								   				 NULL, 	// callback instance 
										CALLBACK_NULL);	// �� ��������� �������� callback
	if (ReturnCode)
	{
		log("can't open WAVE-devise");
		return ;
	}

	log(_T("prepait header"));
	
	// �������������� ����� ���������
	ReturnCode = waveOutPrepareHeader(hWaveOut,			// ����������
									&WaveHeader,		// ��������� �� ��������� ������� ��������� ����������� � 
															// ������������
							  sizeof(WaveHeader));		// ������ ���������
	if (ReturnCode)
	{
		log("can't prepare header");
		waveOutClose(hWaveOut);
		return ;
	}


	log(_T("playing by WAVE-device"));

	// ������� ������ � WAVE-����������
	ReturnCode = waveOutWrite(hWaveOut, 	// ������ �� ������� ������
							&WaveHeader, 	// ��������� ����������� �� ������
					sizeof(WaveHeader));	// ������ ���������
	if (ReturnCode)
	{
		log("error on playing WAVE-device");
		waveOutClose(hWaveOut);
		return ;
	}

	// ���� �� ��������� ���������������
	do {}
	while (!(WaveHeader.dwFlags & WHDR_DONE)); // ���� ���� ������ ������ �� (�� ����� �����)

	log(_T("return header"));

	// ������� ��������� � �������� ���������
	ReturnCode = waveOutUnprepareHeader(hWaveOut,	 // ������ �� ������� ������
									&WaveHeader,	 // ��� ���������  
							sizeof(WaveHeader));	 // ������ ���������
	if (ReturnCode)
	{
		log("error on returning header");
		waveOutClose(hWaveOut);
		return ;
	}
	WaveHeader.dwFlags = 0L;

	
	log(_T("close WAVE-device"));
	
	// ��������� WAVE-����������
	ReturnCode = waveOutClose(hWaveOut);
	if (ReturnCode)
	{
		log("can't close WAVE-device");
		waveOutClose(hWaveOut);
		return ;
	}

	::GlobalFree(WAVEFILE);	// ������� (������������) ������

	return ;
}