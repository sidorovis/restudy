// lab3Dlg.cpp : implementation file
//

#include "stdafx.h"
#include "lab3.h"
#include "lab3Dlg.h"
#include ".\lab3dlg.h"
#include "mmsystem.h"
#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// CAboutDlg dialog used for App About

class CAboutDlg : public CDialog
{
public:
	CAboutDlg();

// Dialog Data
	enum { IDD = IDD_ABOUTBOX };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support

// Implementation
protected:
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialog(CAboutDlg::IDD)
{
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialog)
END_MESSAGE_MAP()


// Clab3Dlg dialog



Clab3Dlg::Clab3Dlg(CWnd* pParent /*=NULL*/)
	: CDialog(Clab3Dlg::IDD, pParent)
{
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void Clab3Dlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//	DDX_Control(pDX, IDC_LIST1, textb);
//	DDX_Control(pDX, IDC_EDIT2, text);
	DDX_Control(pDX, IDC_LIST3, listBox);
}

BEGIN_MESSAGE_MAP(Clab3Dlg, CDialog)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	//}}AFX_MSG_MAP
	ON_BN_CLICKED(IDC_BUTTON1, OnBnClickedButton1)
//	ON_LBN_SELCHANGE(IDC_LIST1, OnLbnSelchangeList1)
END_MESSAGE_MAP()


// Clab3Dlg message handlers

BOOL Clab3Dlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// Add "About..." menu item to system menu.

	// IDM_ABOUTBOX must be in the system command range.
	ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
	ASSERT(IDM_ABOUTBOX < 0xF000);

	CMenu* pSysMenu = GetSystemMenu(FALSE);
	if (pSysMenu != NULL)
	{
		CString strAboutMenu;
		strAboutMenu.LoadString(IDS_ABOUTBOX);
		if (!strAboutMenu.IsEmpty())
		{
			pSysMenu->AppendMenu(MF_SEPARATOR);
			pSysMenu->AppendMenu(MF_STRING, IDM_ABOUTBOX, strAboutMenu);
		}
	}

	// Set the icon for this dialog.  The framework does this automatically
	//  when the application's main window is not a dialog
	SetIcon(m_hIcon, TRUE);			// Set big icon
	SetIcon(m_hIcon, FALSE);		// Set small icon

	// TODO: Add extra initialization here
	
	return TRUE;  // return TRUE  unless you set the focus to a control
}

void Clab3Dlg::OnSysCommand(UINT nID, LPARAM lParam)
{
	if ((nID & 0xFFF0) == IDM_ABOUTBOX)
	{
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
	}
	else
	{
		CDialog::OnSysCommand(nID, lParam);
	}
}

// If you add a minimize button to your dialog, you will need the code below
//  to draw the icon.  For MFC applications using the document/view model,
//  this is automatically done for you by the framework.

void Clab3Dlg::OnPaint() 
{
	if (IsIconic())
	{
		CPaintDC dc(this); // device context for painting

		SendMessage(WM_ICONERASEBKGND, reinterpret_cast<WPARAM>(dc.GetSafeHdc()), 0);

		// Center icon in client rectangle
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// Draw the icon
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialog::OnPaint();
	}
}

// The system calls this function to obtain the cursor to display while the user drags
//  the minimized window.
HCURSOR Clab3Dlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}

void Clab3Dlg::OnBnClickedButton1()
{
	log(" ");
	log(" --- --- --- --- --- --- ---");
	log(" ");
	openFile();
	WavePlay();
}

void Clab3Dlg::OnLbnSelchangeList1()
{
	
}
void Clab3Dlg::log(CString a)
{
//	CString temp;
	listBox.AddString(a);
//	text.GetWindowText(temp);
//	temp += a + " \n ";
//	text.SetWindowText(temp);
}
void Clab3Dlg::openFile()
{
	CFileDialog fileDialog(1,"","",NULL,"",this,0);
	if ( IDOK == fileDialog.DoModal())
	{
		CString file_path = fileDialog.GetPathName();
		
		char fooBar[1024];
		sprintf(fooBar,"%s",file_path);
		HMMIO hmmio = mmioOpen(fooBar, NULL, MMIO_READ );
		log("Opening file "+file_path);
		if (!hmmio)
		{
			log("error");
			return ;
		}
		MMCKINFO mckinfo;
		MMCKINFO mckinfo_parent;
		mckinfo_parent.fccType = mmioFOURCC('W','A','V','E'); 

		if (mmioDescend(hmmio, &mckinfo_parent, NULL, MMIO_FINDRIFF))
		{
			log(" error while looking RIFF ");
			mmioClose(hmmio, 0);
			return;
		}
		mckinfo.ckid = mmioFOURCC('f','m','t',' ');
		if (mmioDescend(hmmio, &mckinfo, &mckinfo_parent, MMIO_FINDCHUNK))
		{
			log(" error while looking format WAV ");
			mmioClose(hmmio, 0);
			return;
		}
		
		DWORD bytesRead = mmioRead(hmmio,(HPSTR)&PCMWaveFmtRecord,mckinfo.cksize);
		
		if (bytesRead <= 0)
		{
			log("Ошибка чтения данных о формате PCM");
			mmioClose(hmmio, 0);
			return ;
		}

		HWAVEOUT hWaveOut;
		if (waveOutOpen(&hWaveOut, WAVE_MAPPER, 
		(LPWAVEFORMATEX)&PCMWaveFmtRecord, NULL, NULL, WAVE_FORMAT_QUERY))
		{
			log(" this file can't be played ");
			mmioClose(hmmio, 0);
			return ;
		}
		if (mmioAscend(hmmio, &mckinfo, 0))
		{
			log("failed on return to RIFF");
			mmioClose(hmmio, 0);
			return ;
		}
		mckinfo.ckid = mmioFOURCC('d','a','t','a'); 
		if (mmioDescend (hmmio, &mckinfo, &mckinfo_parent, MMIO_FINDCHUNK))
		{
			log("Не могу прочитать блок данных"); 
			mmioClose(hmmio, 0); 
			return; 
		}
		
		long lDataSize = mckinfo.cksize;
		HANDLE waveDataBlock = ::GlobalAlloc(GMEM_MOVEABLE, lDataSize);
		if (waveDataBlock == NULL)
		{
			log("Ошибка выделения памяти");
			mmioClose(hmmio, 0);
			return;
		}

		char* pWave = (char*)::GlobalLock(waveDataBlock); 
		if (mmioRead(hmmio, (LPSTR)pWave, lDataSize) != lDataSize)
		{
			log("Ошибка чтения данных");
			mmioClose(hmmio, 0);
			::GlobalFree(waveDataBlock); 
			return ;
		}

		WaveHeader.lpData = pWave;
		WaveHeader.dwBufferLength = lDataSize;
		WaveHeader.dwFlags = 0L;
		WaveHeader.dwLoops = 0L;

		mmioClose(hmmio, 0);
		log("file successfully readed");
		WAVEFILE = waveDataBlock;
	}
	else
	{
		log("choose file");
	}
}

void Clab3Dlg::WavePlay()
{
	// ссылка на WAVE-устройство
	HWAVEOUT hWaveOut;

	log(_T("Открываем WAVE-устройство"));
	
	// открыть WAVE-устройство
	MMRESULT ReturnCode = waveOutOpen (&hWaveOut, WAVE_MAPPER, (LPWAVEFORMATEX) &PCMWaveFmtRecord, NULL, NULL, CALLBACK_NULL);
	if (ReturnCode)
	{
		log("Ошибка при открытии WAVE-устройства");
		return ;
	}

	log(_T("Подготавливаем заголовок"));
	
	// Подготавливаем заголовок
	ReturnCode = waveOutPrepareHeader(hWaveOut, &WaveHeader, sizeof(WaveHeader));
	if (ReturnCode)
	{
		log("Ошибка при подготовке заголовка");
		waveOutClose(hWaveOut);
		return ;
	}


	log(_T("Выводим данные в WAVE-устройство"));

	// Выводим данные в WAVE-устройство
	ReturnCode = waveOutWrite(hWaveOut, &WaveHeader, sizeof(WaveHeader));
	if (ReturnCode)
	{
		log("Ошибка записи в WAVE-устройство");
		waveOutClose(hWaveOut);
		return ;
	}

	// цикл до окончания воспроизведения
	do {}
	while (!(WaveHeader.dwFlags & WHDR_DONE));

	log(_T("Возвращаем заголовок в исходное состояние"));

	// Вернуть заголовок в исходное состояние
	ReturnCode = waveOutUnprepareHeader(hWaveOut, &WaveHeader, sizeof(WaveHeader));
	if (ReturnCode)
	{
		log("Ошибка при восстановлении заголовка");
		waveOutClose(hWaveOut);
		return ;
	}
	WaveHeader.dwFlags = 0L;

	
	log(_T("Закрываем WAVE-устройство"));
	
	// Закрываем WAVE-устройство
	ReturnCode = waveOutClose(hWaveOut);
	if (ReturnCode)
	{
		log("Ошибка при закрытии WAVE-устройства");
		waveOutClose(hWaveOut);
		return ;
	}
	return ;

}