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

string change_all_with_brackets(string& a, const string b)
{
	int place = 0;
	place = a.find(b, place);
	while (place > -1)
	{
		if ( place > 0 && a[ place - 1 ]=='|')
		{
			place++;
		}
		else
		{
//			char asd[128];
//			sprintf(asd,"%d",place);
//			MessageBox(NULL,(string("'")+a.c_str()+"'").c_str(),asd,NULL);
			a.insert(place,"|");
			a.insert(place+1+b.size(),"|");
			place = 0;
		}
		place = a.find(b, place);
	}
	return a;
}

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
	bool charli;
	MChar(char a)
	{
		charli = false;
		if (a >= 'А' && a <= 'Я')
			a = a - 'А' + 'а';
		if (a == ' ' || a == '\n')
			data = string("") + " ";
		else
			data = string("")+ a;
	}
	MChar(bool t,string a)
	{
		charli = true;
		data = a;
	}
	bool does_oa(int i)
	{
		if (charli)
			return false;
		if ( data[i] == 'а' || data[i] == 'о' || data[i] == 'у' ||
			 data[i] == 'ы' || data[i] == 'и' || data[i] == 'э')
			return true;
		return false;
	}

	bool does_eya(int i)
	{
		if (charli)
			return false;
		if ( data[i] == 'е' || data[i] == 'ё' || 
			 data[i] == 'ю' || data[i] == 'я' )
			return true;
		return false;
	}
	bool does_bv(int i)
	{
		if (charli)
			return false;
		if (!does_oa(i) && !does_eya(i) && data[i] != 'ь' && data[i] != 'ъ' && data[i] != 'й' && data[i] != '_')
			return true;
		return false;
	}
	void run_eya2oa()
	{
		if (charli)
			return ;
		if (data[0] == 'е')
			data[0] = 'э';
		if (data[0] == 'ё')
			data[0] = 'о';
		if (data[0] == 'ю')
			data[0] = 'у';
		if (data[0] == 'я')
			data[0] = 'а';
	}
	void run_y_gl()
	{
		if (charli)
			return ;
		if (data[0] == 'е')
			data += 'э';
		if (data[0] == 'ё')
			data += 'о';
		if (data[0] == 'ю')
			data += 'у';
		if (data[0] == 'я')
			data += 'а';
		data[0] = 'й';
	}
	void make_()
	{
		if (charli)
			return ;
		if (data[0] == ' ')
			return;
		data += "_";
	}
	int size()
	{
		if (charli)
			return data.size();
		if (data.size() > 1 && data[1] != '_')
			return 2;
		return 1;
	}
	string make_str_4output()
	{
		if (data[0] == '_')
			return " ";
		if (data == "ь")
			return "";
		return data;
	}
	string make_str()
	{
		if (data == "ь" || data == "ъ")
			return "";
		return data;
	}
};

vector<MChar> text;
map<string,string> sound_base;
map<string,string>::iterator si;
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
	if (i < 52)
		return false;
	cout << "We read " << i << " sound records." << endl;
	return true;
}

void transfer(string& a, string b,int* c,int number);
void playSound(int sound_number)
{
	string file_path;
	file_path = string("base\\")+sounds[ sound_number ]+".wav";
	double proc = 1;
	if ( sounds[ sound_number ].length() ==1 )
		proc = 0.8;
	if ( sounds[ sound_number ].length() ==2 )
		proc = 0.9;
	if (::openFile(file_path,proc))
		::WavePlay();
}
void do_algo()
{
	if (text.size() > 0)
	if (text[0].does_eya(0))
		text[0].run_y_gl();

	for (i = 0 ; i < (int)text.size() ; i++)
	{
		if ( i > 0 && text[i].does_eya(0) && (text[i - 1].does_eya(0) || text[i - 1].does_oa(0) || text[i-1].data=="_" ) )
			text[i].run_y_gl();

		if ( i > 0 && (text[i].does_eya(0) || text[i].data[0] == 'и'  || text[i].data[0] == 'ь' ) && text[i-1].does_bv(0))
		{
			text[i - 1].make_();
			if (text[i].does_eya(0))
				text[i].run_eya2oa();
		}
	}
	string output = "";
	string full_sound = "";
	for (i = 0 ; i < (int)text.size() ; i++)
	{
		output+=text[i].make_str_4output();
		full_sound+=text[i].make_str();
	}
MessageBox(NULL,full_sound.c_str(),"",NULL);
	int* c = new int[full_sound.size()+1];
	int* sounds_stack = new int[full_sound.size()+1];
	int st_size = 0;
	for (i = 0; i < full_sound.size(); i++)
		c[i]=-1;

	for (i = 0 ; i < (int)sounds.size(); i++)
	{
		transfer(full_sound,sounds[i],c,i);
	}

	st_size = 1;
	sounds_stack[0] = c[0];
	for (i = 1 ; i < full_sound.size(); i++)
	{
		if (c[i] != sounds_stack[ st_size - 1])
		{
			sounds_stack[st_size]=c[i];
			st_size++;
		}
	}
	full_sound = "";
	for (i = 0 ; i < st_size ; i ++)
	{
		playSound(sounds_stack[i]);
	}

	delete []c;
	delete []sounds_stack;
}

void transfer(string& a, string b,int* c,int number)
{

	int place = a.find( b );
	while ( place != -1 )
	{
		if ( c[ place ] == -1 )
		{
			for (int u = place ; u < place + b.size() ; u++)
			{
				c[ u ] = number;
			}
		}
		place = a.find(b,place+1);
	}

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
			// открытие файла только для чтения
		HMMIO hmmio = mmioOpen(fooBar, NULL, MMIO_READ );
		log("Opening file "+file_path);
		if (!hmmio)
		{
			log("error open file");
			return false;
		}
		MMCKINFO mckinfo;
		MMCKINFO mckinfo_parent;
			// конвертация в 4-ёх байтный код
		mckinfo_parent.fccType = mmioFOURCC('W','A','V','E'); 

		if (mmioDescend(hmmio, 
				&mckinfo_parent,	// буффер для получения структуры заголовка
				NULL, 
				MMIO_FINDRIFF))		// искать заголовок типа RIFF 
		{
			log(" error while looking RIFF ");
			mmioClose(hmmio, 0);	// закрыть файл
			return false;
		}
			// конвертация в 4-ёх байтный код
		mckinfo.ckid = mmioFOURCC('f','m','t',' ');
		if (mmioDescend(hmmio,				
						&mckinfo,			// буффер для получения структуры заголовка
						&mckinfo_parent,	// место откуда начинать поиск
						MMIO_FINDCHUNK))	// поиск идентификации блока (fmt)
		{
			log(" error while looking format WAV ");
			mmioClose(hmmio, 0);
			return false;
		}
		
		DWORD bytesRead = mmioRead(hmmio,
				(HPSTR)&PCMWaveFmtRecord,	// буффер для чтения данных
				mckinfo.cksize				// количество байт которые требуется прочитать
				);
		
		if (bytesRead <= 0)
		{
			log("Ошибка чтения данных о формате PCM");
			mmioClose(hmmio, 0);
			return false;
		}

		HWAVEOUT hWaveOut;
		if (waveOutOpen(&hWaveOut,				// буффер для чтения данных
						WAVE_MAPPER,			// открытие WAV формы аудио устройства
						(LPWAVEFORMATEX)&PCMWaveFmtRecord, 
												// WAV данные
						NULL,					// call back функция
						NULL,					// call back instance
						WAVE_FORMAT_QUERY))		// запрос проверки может ли данный 
														// девайс проиграть данный формат
		{
			log(" this file can't be played ");
			mmioClose(hmmio, 0);
			return false ;
		}
		if (mmioAscend(hmmio, &mckinfo, 0))
					// проблема работы с файлом (формат файла не соблюдён)
		{
			log("failed on return to RIFF");
			mmioClose(hmmio, 0);
			return  false;
		}
		mckinfo.ckid = mmioFOURCC('d','a','t','a'); 
					// поиск данных файла
		if (mmioDescend (hmmio, &mckinfo, &mckinfo_parent, MMIO_FINDCHUNK))
					// непосредственно вызов функции поиска
		{
			log("Не могу прочитать блок данных"); 
			mmioClose(hmmio, 0); 
			return false; 
		}
		
		long lDataSize = mckinfo.cksize;
					// поличество данных которые будем читать
		HANDLE waveDataBlock = ::GlobalAlloc(GMEM_MOVEABLE, lDataSize);
					// выделение памяти для данных медиа файла
		if (waveDataBlock == NULL)
		{
			log("Ошибка выделения памяти");
			mmioClose(hmmio, 0);
			return false;
		}

		char* pWave = (char*)::GlobalLock(waveDataBlock); 
					// занимание памяти для чтения музыкального содержимого файла
		if (mmioRead(hmmio, 
						(LPSTR)pWave,		// область куда читать данные
						lDataSize			// максимально возможное количество читаемых данных
						) 
						!= lDataSize)		// если прочитали меньше чем было заявлено в заголовке
		{
			log("error on reading datas");
			mmioClose(hmmio, 0);
			::GlobalFree(waveDataBlock);	// очистка (освобождение) памяти
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
	// ссылка на WAVE-устройство
	HWAVEOUT hWaveOut;

	log(_T("opening WAVE-device"));
	
	// открыть WAVE-устройство
	MMRESULT ReturnCode = waveOutOpen (		&hWaveOut, 	// открытие устройства для проигрывания
										  WAVE_MAPPER, 	// девайс должен быть для проигрывания WAV
				   (LPWAVEFORMATEX) &PCMWaveFmtRecord, 	// тип структуры который будет передаваться
												 NULL, 	// callback функция
								   				 NULL, 	// callback instance 
										CALLBACK_NULL);	// не требуется механизм callback
	if (ReturnCode)
	{
		log("can't open WAVE-devise");
		return ;
	}

	log(_T("prepait header"));
	
	// Подготавливаем аудио заголовок
	ReturnCode = waveOutPrepareHeader(hWaveOut,			// устройство
									&WaveHeader,		// указатель на структуру которую требуется подготовить к 
															// проигрыванию
							  sizeof(WaveHeader));		// размер структуры
	if (ReturnCode)
	{
		log("can't prepare header");
		waveOutClose(hWaveOut);
		return ;
	}


	log(_T("playing by WAVE-device"));

	// Выводим данные в WAVE-устройство
	ReturnCode = waveOutWrite(hWaveOut, 	// девайс на котором играть
							&WaveHeader, 	// заголовок указывающий на занные
					sizeof(WaveHeader));	// размер заголовка
	if (ReturnCode)
	{
		log("error on playing WAVE-device");
		waveOutClose(hWaveOut);
		return ;
	}

	// цикл до окончания воспроизведения
	do {}
	while (!(WaveHeader.dwFlags & WHDR_DONE)); // пока есть данные читаем их (до конца файла)

	log(_T("return header"));

	// Вернуть заголовок в исходное состояние
	ReturnCode = waveOutUnprepareHeader(hWaveOut,	 // девайс на котором играть
									&WaveHeader,	 // тип структуры  
							sizeof(WaveHeader));	 // размер структуры
	if (ReturnCode)
	{
		log("error on returning header");
		waveOutClose(hWaveOut);
		return ;
	}
	WaveHeader.dwFlags = 0L;

	
	log(_T("close WAVE-device"));
	
	// Закрываем WAVE-устройство
	ReturnCode = waveOutClose(hWaveOut);
	if (ReturnCode)
	{
		log("can't close WAVE-device");
		waveOutClose(hWaveOut);
		return ;
	}

	::GlobalFree(WAVEFILE);	// очистка (освобождение) памяти

	return ;
}