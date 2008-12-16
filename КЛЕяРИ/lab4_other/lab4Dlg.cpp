// lab4Dlg.cpp : implementation file
//

#include "stdafx.h"
#include "lab4.h"
#include "lab4Dlg.h"
#include "fstream"

using namespace std;

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif


/////////////////////////////////////////////////////////////////////////////
// CLab4Dlg dialog

CLab4Dlg::CLab4Dlg(CWnd* pParent /*=NULL*/)
	: CDialog(CLab4Dlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CLab4Dlg)
	m_volume = 0;
	//}}AFX_DATA_INIT
	// Note that LoadIcon does not require a subsequent DestroyIcon in Win32
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
	wDeviceID = 0;
	play_mode = 0;
	pause_mode = 0;
}

void CLab4Dlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CLab4Dlg)
	DDX_Control(pDX, IDC_RANDOM, m_Random);
	DDX_Control(pDX, IDC_REPEATONE, m_RepeateOne);
	DDX_Control(pDX, IDC_LIST, m_list);
	DDX_Control(pDX, IDC_PLAYER, m_set_player);
	DDX_Control(pDX, IDC_VOLUME, m_set_volume);
	DDX_Slider(pDX, IDC_VOLUME, m_volume);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CLab4Dlg, CDialog)
	//{{AFX_MSG_MAP(CLab4Dlg)
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_FILECHOOSER, OnFilechooser)
	ON_BN_CLICKED(IDC_EXIT, OnExit)
	ON_BN_CLICKED(IDC_PLAY, OnPlay)
	ON_BN_CLICKED(IDC_PAUSE, OnPause)
	ON_NOTIFY(NM_RELEASEDCAPTURE, IDC_VOLUME, OnVolume)
	ON_WM_TIMER()
	ON_NOTIFY(NM_RELEASEDCAPTURE, IDC_PLAYER, OnChangePlace)
	ON_BN_CLICKED(IDC_SAVEPLS, OnSavepls)
	ON_BN_CLICKED(IDC_LOAD, OnLoad)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CLab4Dlg message handlers

BOOL CLab4Dlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// Set the icon for this dialog.  The framework does this automatically
	//  when the application's main window is not a dialog
	SetIcon(m_hIcon, TRUE);			// Set big icon
	SetIcon(m_hIcon, FALSE);		// Set small icon
	
	m_set_player.SetRangeMin(0);
	m_set_player.SetRangeMax(100,true);
	m_set_volume.SetRangeMin(0);
	m_set_volume.SetRangeMax(100,true);
	UINT_PTR timer = SetTimer(0, 250, NULL);

	WAVEOUTCAPS waveCaps;
	DWORD volume;

	UINT uRetVal;
	int max = 65535;
	long lLeftVol, lRightVol;

	if (!waveOutGetDevCaps(0,(LPWAVEOUTCAPS)&waveCaps,sizeof(WAVEOUTCAPS)))
	{
		if(waveCaps.dwSupport & WAVECAPS_VOLUME)
		{
			uRetVal = waveOutGetVolume(NULL,(LPDWORD)&volume);
			lLeftVol = (long)LOWORD(volume);
			lRightVol = (long)HIWORD(volume);
			int t = (lLeftVol+lRightVol) / 2;
			double proc = (100 - 100.0*t / max);
			m_set_volume.SetPos( (int)proc );
		}
	}

	current_playing_file = "";

	return TRUE;  // returTRUE  unless you set the focus to a control
}

// If you add a minimize button to your dialog, you will need the code below
//  to draw the icon.  For MFC applications using the document/view model,
//  this is automatically done for you by the framework.

void CLab4Dlg::OnPaint() 
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
HCURSOR CLab4Dlg::OnQueryDragIcon()
{
	return (HCURSOR) m_hIcon;
}

void CLab4Dlg::OnFilechooser() 
{
	char szFilters[] = " Wav Data (*.wav) | *.wav";
	CFileDialog file_dialog(true,NULL,NULL,NULL,szFilters,this);
	if ( file_dialog.DoModal() == IDOK )
	{
		addToList( file_dialog.GetPathName() );
	}
}

void CLab4Dlg::OnExit() 
{
	CDialog::OnOK();	
}

void CLab4Dlg::OnPlay() 
{
	int i = m_list.GetCurSel();
	CString temp;
	if (i == -1)
	{
		wDeviceID = 0;
		return;
	}
	m_list.GetText(i, temp);
	if (wDeviceID != 0)
	{
		if (temp != current_playing_file)
		{
			mciSendCommand(wDeviceID, MCI_CLOSE, MCI_WAIT, NULL);
			wDeviceID = 0;
		}
		else
		{
			if (pause_mode)
			{
				PLAY();
			}
			return;
		}
	}

	OPEN(temp);
	PLAY();
}

void CLab4Dlg::OnPause() 
{
	if (wDeviceID != 0 && pause_mode)
	{
		PLAY();
	}
	if (wDeviceID == 0)
	{
		return;
	}
	MCI_PLAY_PARMS mciPauseParms;
	mciPauseParms.dwCallback = (DWORD) NULL;
	if (mciSendCommand(wDeviceID, MCI_PAUSE, MCI_NOTIFY, (DWORD)(LPVOID) &mciPauseParms))
	{
	}
	else
	{
		pause_mode = 1;
		m_set_player.EnableWindow( true );
	}
}	

long CLab4Dlg::endPlaying()
{
	if (m_RepeateOne.GetCheck() == 1)
	{
		m_set_player.SetPos(0);
		MCI_SEEK_PARMS params;
		params.dwCallback = (DWORD) NULL;
		mciSendCommand(wDeviceID, MCI_SEEK , MCI_SEEK_TO_START | MCI_WAIT, (DWORD)(LPVOID) &params);
		PLAY();
	}
	else
	{
		mciSendCommand(wDeviceID, MCI_CLOSE, MCI_WAIT, NULL);
		current_playing_file = "";
		wDeviceID = 0;
		int track = 0;
		if (m_Random.GetCheck() == 1)
		{
			int max = m_list.GetCount();
			track = rand()%max;
		}
		else
		{
			track = m_list.GetCurSel() + 1;
			int max = m_list.GetCount();
			if (track == max)
				track = 0;
		}
		m_list.SetCurSel(track);
		CString temp;
		m_list.GetText(track, temp);
		OPEN( temp );
		PLAY();

	}
	return 0;
}


void CLab4Dlg::OnVolume(NMHDR* pNMHDR, LRESULT* pResult) 
{
	CString a;
	int temp = m_set_volume.GetPos();

	UINT uRetVal;

	WAVEOUTCAPS waveCaps;
	int max = 65535;
	int curr_proc = 100-temp;

	if (!waveOutGetDevCaps(0,(LPWAVEOUTCAPS)&waveCaps,sizeof(WAVEOUTCAPS)))
	{
		if(waveCaps.dwSupport & WAVECAPS_VOLUME)
		{
			int curr = ((int)(((double)(max*(curr_proc)))/100));
			uRetVal = waveOutSetVolume(NULL, (DWORD)(65536*curr+curr));
		}
	}

	*pResult = 0;
}

void CLab4Dlg::OnTimer(UINT nIDEvent) 
{
	if ( wDeviceID == 0 || pause_mode)
		return;
	
	MCI_STATUS_PARMS params;
	params.dwCallback = (DWORD)NULL;
	params.dwReturn = -1;

	params.dwItem = MCI_STATUS_MODE ;
	mciSendCommand(wDeviceID, MCI_STATUS , MCI_STATUS_ITEM | MCI_WAIT, (DWORD)(LPVOID) &params);
	if (params.dwReturn != MCI_MODE_PLAY && params.dwReturn != MCI_MODE_STOP)
		return;

	params.dwItem = MCI_STATUS_LENGTH ;
	mciSendCommand(wDeviceID, MCI_STATUS , MCI_STATUS_ITEM | MCI_WAIT, (DWORD)(LPVOID) &params);
	double i1 = params.dwReturn;

	params.dwItem = MCI_STATUS_POSITION ;
	mciSendCommand(wDeviceID, MCI_STATUS , MCI_STATUS_ITEM | MCI_WAIT, (DWORD)(LPVOID) &params);
	double i2 = params.dwReturn;

	m_set_player.SetPos((int)(100*(i2/i1)));
	if (i2 == i1)
		endPlaying();

	CDialog::OnTimer(nIDEvent);
}

void CLab4Dlg::OnChangePlace(NMHDR* pNMHDR, LRESULT* pResult) 
{
	int i = m_set_player.GetPos();
	CString a;

	MCI_STATUS_PARMS params;
	params.dwCallback = (DWORD)NULL;
	params.dwReturn = 1;
	params.dwItem = MCI_STATUS_LENGTH ;
	mciSendCommand(wDeviceID, MCI_STATUS , MCI_STATUS_ITEM | MCI_WAIT, (DWORD)(LPVOID) &params);
	int length = params.dwReturn;
	int i1 = params.dwReturn;
	
	MCI_SEEK_PARMS seek_params;
	seek_params.dwCallback = (DWORD) NULL;
	seek_params.dwTo = ((int)(length*(1.0*i/100)));
	mciSendCommand(wDeviceID, MCI_SEEK , MCI_TO | MCI_WAIT, (DWORD)(LPVOID) &seek_params);

	params.dwItem = MCI_STATUS_LENGTH ;
	mciSendCommand(wDeviceID, MCI_STATUS , MCI_STATUS_ITEM | MCI_WAIT, (DWORD)(LPVOID) &params);
	length = params.dwReturn;

	params.dwItem = MCI_STATUS_POSITION ;
	mciSendCommand(wDeviceID, MCI_STATUS , MCI_STATUS_ITEM | MCI_WAIT, (DWORD)(LPVOID) &params);

	*pResult = 0;
}

void CLab4Dlg::addToList(CString a)
{
	m_list.AddString( a );
	m_list.SetCurSel(m_list.GetCount() - 1);
}


void CLab4Dlg::PLAY()
{
	MCI_PLAY_PARMS	mciPlayParms;
	mciPlayParms.dwCallback = (DWORD) NULL;
	if (mciSendCommand(wDeviceID, MCI_PLAY, MCI_NOTIFY, (DWORD)(LPVOID) &mciPlayParms))
	{
		wDeviceID = 0;
	}
	else
	{
		pause_mode = 0;
		m_set_player.EnableWindow( false );
	}
}

void CLab4Dlg::OPEN(CString file_name)
{
	pause_mode = false;
	MCI_OPEN_PARMS	mciOpenParms;
	mciOpenParms.lpstrDeviceType = "waveaudio";
	char file_name_c[1024];
	strcpy(file_name_c, file_name);
	mciOpenParms.lpstrElementName = file_name_c;
	if (mciSendCommand(0, MCI_OPEN, MCI_OPEN_TYPE | MCI_OPEN_ELEMENT, (DWORD)(LPVOID) &mciOpenParms))
	{
		AfxMessageBox("This file type is uncorrect");
	}
	else
	{
		wDeviceID = mciOpenParms.wDeviceID;
		current_playing_file = file_name;
		m_set_player.EnableWindow( true );
	}
}

void CLab4Dlg::OnSavepls() 
{
	char szFilters[] = " Wav Data (*.mpl) | *.mpl";
	CFileDialog file_dialog(false,NULL,NULL,NULL,szFilters,this);
	if (file_dialog.DoModal() == IDOK)
	{
		ofstream file;
		CString ttt = file_dialog.GetPathName();
		if (ttt.Find(".mpl") == -1)
		{
			ttt = ttt+".mpl";
		}
		file.open(ttt,ios::out);
		int max = m_list.GetCount();
		for (int i = 0 ; i < max ; i ++)
		{
			CString f;
			m_list.GetText( i , f );
			char temp[1024];
			strcpy(temp,f);
			file << temp << "\n";
		}
		file.close();
	}
	
}

void CLab4Dlg::OnLoad() 
{
	char szFilters[] = " Wav Data (*.mpl) | *.mpl";
	CFileDialog file_dialog(true,NULL,NULL,NULL,szFilters,this);
	if (file_dialog.DoModal() == IDOK)
	{
		ifstream file;
		CString ttt = file_dialog.GetPathName();
		file.open(ttt);
		char temp[1024];
		while (m_list.GetCount() > 0)
			m_list.DeleteString(0);
		while (!file.eof())
		{
			file.getline(temp,1024);
			if (strlen(temp) > 0)
				addToList( temp );
		}
		file.close();
	}
}
