// lab2Dlg.cpp : implementation file
//

#include "stdafx.h"
#include "lab2.h"
#include "lab2Dlg.h"
#include "mmsystem.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CLab2Dlg dialog

CLab2Dlg::CLab2Dlg(CWnd* pParent /*=NULL*/)
	: CDialog(CLab2Dlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CLab2Dlg)
	m_file_name = _T("");
	m_result = _T("");
	//}}AFX_DATA_INIT
	// Note that LoadIcon does not require a subsequent DestroyIcon in Win32
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CLab2Dlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CLab2Dlg)
	DDX_Control(pDX, IDC_EDIT2, m_resulttt);
	DDX_Control(pDX, IDC_EDIT1, m_file_con);
	DDX_Text(pDX, IDC_EDIT1, m_file_name);
	DDX_Text(pDX, IDC_EDIT2, m_result);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CLab2Dlg, CDialog)
	//{{AFX_MSG_MAP(CLab2Dlg)
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_BUTTON1, OnButton1)
	ON_BN_CLICKED(IDC_BUTTON2, OnButton2)
	ON_BN_CLICKED(IDC_BUTTON3, OnButton3)
//	ON_BN_CLICKED(IDC_BUTTON4, getDeviceID)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CLab2Dlg message handlers

BOOL CLab2Dlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// Set the icon for this dialog.  The framework does this automatically
	//  when the application's main window is not a dialog
	SetIcon(m_hIcon, TRUE);			// Set big icon
	SetIcon(m_hIcon, FALSE);		// Set small icon
	
	// TODO: Add extra initialization here
	
	return TRUE;  // return TRUE  unless you set the focus to a control
}

// If you add a minimize button to your dialog, you will need the code below
//  to draw the icon.  For MFC applications using the document/view model,
//  this is automatically done for you by the framework.

void CLab2Dlg::OnPaint() 
{
	if (IsIconic())
	{
		CPaintDC dc(this); // device context for painting

		SendMessage(WM_ICONERASEBKGND, (WPARAM) dc.GetSafeHdc(), 0);

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

// The system calls this to obtain the cursor to display while the user drags
//  the minimized window.
HCURSOR CLab2Dlg::OnQueryDragIcon()
{
	return (HCURSOR) m_hIcon;
}

void CLab2Dlg::OnButton1() 
{
	CFileDialog fileDialog(true, NULL , NULL, NULL , "", this);
	if ( IDOK == fileDialog.DoModal())
	{
		m_file_con.SetWindowText(fileDialog.GetPathName());
	}
	
}

void CLab2Dlg::OnButton2() 
{
	CString a;
	m_file_con.GetWindowText(a);
	if (a != "")
	{
		char fooBar[1024];
		strcpy(fooBar,a);
		
		MCI_OPEN_PARMS mciParams;						// подготовка структуры параметров для комманды open mci
		mciParams.lpstrDeviceType = "waveaudio";
		mciParams.lpstrElementName = fooBar;

		if (mciSendCommand(0, MCI_OPEN,						// команда	"открыть"
			MCI_OPEN_TYPE | MCI_OPEN_ELEMENT,				// параметры комманды
			(DWORD)(LPVOID) &mciParams))					// параметры комманды связанные с файлом который требуется проиграть
														// запуск команды опен
		{
			m_resulttt.SetWindowText("Can't open mci");
			return;
		}

		UINT wDeviceID = mciParams.wDeviceID;			// получение девайса которым будем играть
		MCI_PLAY_PARMS	mciPlayParms;
		mciPlayParms.dwCallback = (DWORD) NULL;
		if (mciSendCommand(wDeviceID,						// девайс на котором играть
						MCI_PLAY,							// команда "играть"
						MCI_WAIT,							// параметр ожидания (синхронное проигрывание)
																	// можно задать параметр нотификации и когда звук проиграется вернётся сигнал
						(DWORD)(LPVOID) &mciPlayParms))		// доп параметры можно задать с какой секунды по какую требуется вопроизводить
		{
//				mciSendCommand(wDeviceID, MCI_CLOSE, 0, NULL);
				m_resulttt.SetWindowText("Can't error play");
				return;
		}

		mciSendCommand(wDeviceID, MCI_CLOSE, MCI_WAIT, NULL);	// закрытие уустройства проигрывания
		m_resulttt.SetWindowText("ok");

	}
	else
	{
		m_resulttt.SetWindowText("Bad file");
		return;
	}
//	::MessageBox(NULL,m_file_name,"",NULL);
	//mciSendCommand(
	
}

void CLab2Dlg::OnButton3() 
{
	CString a;
	m_file_con.GetWindowText(a);
	if (a != "")
	{
		char	szCmdLine	[1024];
		CString er;
		char fooBar[1024];

		wsprintf(szCmdLine, "open \"%s\" type waveaudio alias mysound", a); 
							// комманда открытия 
								// задаётся тип waveaudio и именует девайс именем "mysound"
		
	//	UINT device_id = mciGetDeviceID(szCmdLine);
	
		long d;
		if (d = mciSendString(szCmdLine, fooBar, 1024, NULL))	// попытка открытия девайса
		{
			mciGetErrorString(d,fooBar,1024);		// если ошибка то запрашиваем описание ошибки
			AfxMessageBox(fooBar);
			m_resulttt.SetWindowText("can't open mci - "+er);
			return;
		}
		
		wsprintf(szCmdLine, "play mysound wait");		// проигрываем девайс "mysound"
															// c ожидание окончания проигрывания
		if (mciSendString(szCmdLine, NULL, 0, NULL))
		{
			m_resulttt.SetWindowText("error play ");
			return;
		}

		wsprintf(szCmdLine, "close mysound wait");		// закрываем девайс "mysound"
		if (mciSendString(szCmdLine, NULL, 0, NULL))
		{
			m_resulttt.SetWindowText("error close");
			return;
		}

		m_resulttt.SetWindowText("ok");
	}
	else
	{
		m_resulttt.SetWindowText("Bad file");
		return;
	}

	
}

