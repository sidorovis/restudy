// lab3Dlg.h : header file
//

#pragma once
#include "afxwin.h"
#include "mmsystem.h"


// Clab3Dlg dialog
class Clab3Dlg : public CDialog
{
// Construction
public:
	Clab3Dlg(CWnd* pParent = NULL);	// standard constructor

// Dialog Data
	enum { IDD = IDD_LAB3_DIALOG };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support


// Implementation
protected:
	HICON m_hIcon;

	// Generated message map functions
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	DECLARE_MESSAGE_MAP()
public:
	friend UINT MyThreadProc( LPVOID pParam );
	afx_msg void OnBnClickedButton1();
	afx_msg void OnLbnSelchangeList1();
	void openFile();
	void WavePlay();
	HANDLE WAVEFILE;
	PCMWAVEFORMAT PCMWaveFmtRecord;
	WAVEHDR WaveHeader;
	void log(CString);
//	CEdit text;
	CListBox listBox;
};
