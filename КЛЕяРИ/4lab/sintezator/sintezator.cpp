// This is the main project file for VC++ application project 
// generated using an Application Wizard.

#include <stdlib.h>
#include "stdafx.h"
//#using <mscorlib.dll>

//using namespace System;
using namespace std;

	HANDLE WAVEFILE;
	PCMWAVEFORMAT PCMWaveFmtRecord;
	WAVEHDR WaveHeader;

void log(string a)
{
//	cout << a << endl;
}
bool openFile(string file_path, double proc);
void WavePlay();

class MChar
{

public:
	string data;
	MChar(char a)
	{
		if (a >= '�' && a <= '�')
			a = a - '�' + '�';
		if (a == ' ' || a == '\n')
			data = string("") + "_";
		else
			data = string("")+ a;
	}
	bool does_oa(int i)
	{
		if ( data[i] == '�' || data[i] == '�' || data[i] == '�' ||
			 data[i] == '�' || data[i] == '�' || data[i] == '�')
			return true;
		return false;
	}

	bool does_eya(int i)
	{
		if ( data[i] == '�' || data[i] == '�' || 
			 data[i] == '�' || data[i] == '�' )
			return true;
		return false;
	}
	bool does_bv(int i)
	{
		if (!does_oa(i) && !does_eya(i) && data[i] != '�' && data[i] != '�' && data[i] != '�' && data[i] != '_')
			return true;
		return false;
	}
	void run_eya2oa()
	{
		if (data[0] == '�')
			data[0] = '�';
		if (data[0] == '�')
			data[0] = '�';
		if (data[0] == '�')
			data[0] = '�';
		if (data[0] == '�')
			data[0] = '�';
	}
	void run_y_gl()
	{
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
	void make_()
	{
		data += "_";
	}
	int size()
	{
		if (data.size() > 1 && data[1] != '_')
			return 2;
		return 1;
	}
	void play()
	{
		for (int i = 0 ; i < size() ; i++)
		{
			playSound(i);
		}
	}
	void playSound(int i)
	{
		string file_path;
		if (i < data.size() - 1 && data[i+1] == '_')
            file_path = string("base\\")+data[i]+"_.wav";
		else
			file_path = string("base\\")+data[i]+".wav";
		cout << file_path << endl;
		double proc = 0.8;
		if ( does_bv(i) )
			proc = 0.8;
		if (::openFile(file_path,proc))
			::WavePlay();
	}
	string make_str()
	{
		return data;
	}
};

vector<MChar> text;
map<string,string> sound_base;
vector<string> sounds;
int i;

void read_text()
{
	ifstream inp("input.txt");
	char buffer[1024];
	while ( !inp.eof() )
	{	
		inp.getline(buffer,1024);
		string foobar = buffer;
		for ( i = 0 ; i < (int)foobar.size(); i ++)
		{
			if (foobar[i] == '\n')
				foobar[i] = ' ';
			text.push_back(MChar(foobar[i]));
		}
	}
	cout << "Text size: "<< text.size() << endl;
	inp.close();
}

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
				sounds.push_back( winFileData.cFileName );
			}
			while
			( FindNextFile( hFile , &winFileData ) != 0 );
			FindClose(hFile);
		}
	}
	if (i < 52)
		return false;
	cout << "We read " << i << " sound records." << endl;
	return true;
}

void do_algo()
{
	if (text.size() > 0)
	if (text[0].does_eya(0))
		text[0].run_y_gl();

	for (i = 0 ; i < (int)text.size() - 1 ; i++)
	{
		if (text[i].does_eya(0) && (text[i + 1].does_eya(0) || text[i + 1].does_oa(0) ))
		{
			text[i+1].run_y_gl();
		}
		if (text[i].does_bv(0) && (text[i + 1].does_eya(0) || text[i+1].data[0] == '�'  || text[i+1].data[0] == '�' ))
		{
			text[i].make_();
			if (text[i + 1].does_eya(0))
				text[i+1].run_eya2oa();
		}
	}
	string full_string = "";
	for (i = 0 ; i < (int)text.size() ; i++)
	{
		full_string+=text[i].make_str();
	}
	MessageBox(NULL,full_string.c_str(),"",NULL);
	cout << (LPCSTR)full_string.c_str() << endl;
//	for (i = 0 ; i < (int)text.size() ; i++)
//	{
//		text[i].play();
//	}

}
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