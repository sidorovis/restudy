// lab4Dlg.h : header file
//

#if !defined(AFX_LAB4DLG_H__1A91F5B2_D218_4A29_BDD3_BD6E80BE0C10__INCLUDED_)
#define AFX_LAB4DLG_H__1A91F5B2_D218_4A29_BDD3_BD6E80BE0C10__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

/////////////////////////////////////////////////////////////////////////////
// CLab4Dlg dialog

class CLab4Dlg : public CDialog
{
// Construction
public:
	void OPEN(CString file_name);
	void PLAY();
	void addToList(CString a);
	long endPlaying();
	CLab4Dlg(CWnd* pParent = NULL);	// standard constructor
	bool play_mode;
	bool pause_mode;
	CString current_playing_file;

	MCIDEVICEID wDeviceID;

// Dialog Data
	//{{AFX_DATA(CLab4Dlg)
	enum { IDD = IDD_LAB4_DIALOG };
	CButton	m_Random;
	CButton	m_RepeateOne;
	CListBox	m_list;
	CSliderCtrl	m_set_player;
	CSliderCtrl	m_set_volume;
	int		m_volume;
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CLab4Dlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	HICON m_hIcon;

	// Generated message map functions
	//{{AFX_MSG(CLab4Dlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	afx_msg void OnFilechooser();
	afx_msg void OnExit();
	afx_msg void OnPlay();
	afx_msg void OnPause();
	afx_msg void OnVolume(NMHDR* pNMHDR, LRESULT* pResult);
	afx_msg void OnTimer(UINT nIDEvent);
	afx_msg void OnChangePlace(NMHDR* pNMHDR, LRESULT* pResult);
	afx_msg void OnSavepls();
	afx_msg void OnLoad();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_LAB4DLG_H__1A91F5B2_D218_4A29_BDD3_BD6E80BE0C10__INCLUDED_)
