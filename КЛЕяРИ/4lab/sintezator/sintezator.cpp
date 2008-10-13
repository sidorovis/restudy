// This is the main project file for VC++ application project 
// generated using an Application Wizard.

#include <stdlib.h>
#include "stdafx.h"
#using <mscorlib.dll>

using namespace System;
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
		if (a >= 'А' && a <= 'Я')
			a = a - 'А' + 'а';
		if (a == ' ')
			data = string("") + "_";
		else
			data = string("")+ a;
	}
	bool does_oa(int i)
	{
		if ( data[i] == 'а' || data[i] == 'о' || data[i] == 'у' ||
			 data[i] == 'ы' || data[i] == 'и' || data[i] == 'э')
			return true;
		return false;
	}

	bool does_eya(int i)
	{
		if ( data[i] == 'е' || data[i] == 'ё' || 
			 data[i] == 'ю' || data[i] == 'я' )
			return true;
		return false;
	}
	bool does_bv(int i)
	{
		if (!does_oa(i) && !does_eya(i) && data[i] != 'ь' && data[i] != 'ъ' && data[i] != 'й')
			return true;
		return false;
	}
	void run_eya2oa()
	{
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
		if (i < size() - 1 && data[i+1] == '_')
            file_path = string("base\\")+data[i]+"_.wav";
		else
			file_path = string("base\\")+data[i]+".wav";
		cout << file_path << endl;
		double proc = 0.8;
		if ( does_bv(i) )
			proc = 0.7;
		if (::openFile(file_path,proc))
			::WavePlay();
	}
};


int _tmain()
{
	int i;
    ifstream inp("input.txt");
	char buffer[1024];
	vector<MChar> text;
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
	if (text.size() > 0)
		if (text[0].does_eya(0))
			text[0].run_y_gl();


	for (int i = 0 ; i < (int)text.size() - 1 ; i++)
	{
		if (text[i].does_oa(0) && text[i + 1].does_eya(0))
		{
			text[i+1].run_y_gl();
		}
		if (text[i].does_bv(0) && text[i + 1].does_eya(0))
		{
			text[i].make_();
			text[i+1].run_eya2oa();
		}
	}
	for (int i = 0 ; i < (int)text.size() ; i++)
	{
		text[i].play();
	}
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