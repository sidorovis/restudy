// kleyari_lab1Dlg.cpp : 實作檔
//

#include "stdafx.h"
#include "kleyari_lab1.h"
#include "kleyari_lab1Dlg.h"
#include ".\kleyari_lab1dlg.h"
#include "Windows.h"
#include "Mmsystem.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// 對 App About 使用 CAboutDlg 對話方塊

class CAboutDlg : public CDialog
{
public:
	CAboutDlg();

// 對話方塊資料
	enum { IDD = IDD_ABOUTBOX };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV 支援

// 程式碼實作
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


// Ckleyari_lab1Dlg 對話方塊



Ckleyari_lab1Dlg::Ckleyari_lab1Dlg(CWnd* pParent /*=NULL*/)
	: CDialog(Ckleyari_lab1Dlg::IDD, pParent)
{
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void Ckleyari_lab1Dlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	DDX_Control(pDX, IDC_EDIT1, m_Edit);
}

BEGIN_MESSAGE_MAP(Ckleyari_lab1Dlg, CDialog)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	//}}AFX_MSG_MAP
	ON_BN_CLICKED(IDC_BUTTON1, OnBnClickedButton1)
	ON_BN_CLICKED(IDC_BUTTON4, OnBnClickedButton4)
	ON_EN_CHANGE(IDC_EDIT1, OnEnChangeEdit1)
	ON_BN_CLICKED(IDC_BUTTON3, OnBnClickedButton3)
	ON_BN_CLICKED(IDC_BUTTON2, OnBnClickedButton2)
END_MESSAGE_MAP()


// Ckleyari_lab1Dlg 訊息處理常式

BOOL Ckleyari_lab1Dlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// 將 "關於..." 功能表加入系統功能表。

	// IDM_ABOUTBOX 必須在系統命令範圍之中。
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

	// 設定此對話方塊的圖示。當應用程式的主視窗不是對話方塊時，
	// 框架會自動從事此作業
	SetIcon(m_hIcon, TRUE);			// 設定大圖示
	SetIcon(m_hIcon, FALSE);		// 設定小圖示

	// TODO: 在此加入額外的初始設定
	
	return TRUE;  // 傳回 TRUE，除非您對控制項設定焦點
}

void Ckleyari_lab1Dlg::OnSysCommand(UINT nID, LPARAM lParam)
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

// 如果將最小化按鈕加入您的對話方塊，您需要下列的程式碼，以便繪製圖示。
// 對於使用文件/檢視模式的 MFC 應用程式，框架會自動完成此作業。

void Ckleyari_lab1Dlg::OnPaint() 
{
	if (IsIconic())
	{
		CPaintDC dc(this); // 繪製的裝置內容

		SendMessage(WM_ICONERASEBKGND, reinterpret_cast<WPARAM>(dc.GetSafeHdc()), 0);

		// 將圖示置中於用戶端矩形
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// 描繪圖示
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialog::OnPaint();
	}
}

//當使用者拖曳最小化視窗時，系統呼叫這個功能取得游標顯示。
HCURSOR Ckleyari_lab1Dlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}

void Ckleyari_lab1Dlg::OnBnClickedButton1()
{
	CString a;
	m_Edit.GetWindowText(a);
	::MessageBox(NULL,"I will play "+a,"",NULL);

	if ( !sndPlaySound(a,SND_ASYNC))
		::MessageBox(NULL,"Error Playing "+a, "Error", NULL);
	else
		::MessageBox(NULL,"You here it is?", "Question", NULL);
}

void Ckleyari_lab1Dlg::OnBnClickedButton4()
{
	CFileDialog fileDialog(true,"wav","",0,"",this,0);
	if ( IDOK == fileDialog.DoModal())
	{
		CString file_folder = fileDialog.GetPathName();
//		filedialog.Get
		m_Edit.SetWindowText( file_folder );
	}
}

void Ckleyari_lab1Dlg::OnEnChangeEdit1()
{
	// TODO:  If this is a RICHEDIT control, the control will not
	// send this notification unless you override the CDialog::OnInitDialog()
	// function and call CRichEditCtrl().SetEventMask()
	// with the ENM_CHANGE flag ORed into the mask.

	// TODO:  Add your control notification handler code here
}

void Ckleyari_lab1Dlg::OnBnClickedButton3()
{
	if (
		!MessageBeep(MB_ICONASTERISK)
		)
		::MessageBox(NULL,"No Sound !!!","",NULL);

}

void Ckleyari_lab1Dlg::OnBnClickedButton2()
{
	CString a;
	m_Edit.GetWindowText(a);
	::MessageBox(NULL,"I will play "+a,"",NULL);

	if (!PlaySound(a,NULL,SND_FILENAME))
		::MessageBox(NULL,"Not worked", "", NULL );
	else
		::MessageBox(NULL,"You here it is?", "Question", NULL);

}
