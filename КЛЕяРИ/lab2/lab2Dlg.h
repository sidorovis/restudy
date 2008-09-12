// lab2Dlg.h : header file
//

#if !defined(AFX_LAB2DLG_H__C26AA2A3_FC84_48BA_BA77_C01BCB921034__INCLUDED_)
#define AFX_LAB2DLG_H__C26AA2A3_FC84_48BA_BA77_C01BCB921034__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

/////////////////////////////////////////////////////////////////////////////
// CLab2Dlg dialog

class CLab2Dlg : public CDialog
{
// Construction
public:
	CLab2Dlg(CWnd* pParent = NULL);	// standard constructor

// Dialog Data
	//{{AFX_DATA(CLab2Dlg)
	enum { IDD = IDD_LAB2_DIALOG };
	CEdit	m_resulttt;
	CEdit	m_file_con;
	CString	m_file_name;
	CString	m_result;
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CLab2Dlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	HICON m_hIcon;

	// Generated message map functions
	//{{AFX_MSG(CLab2Dlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	afx_msg void OnButton1();
	afx_msg void OnButton2();
	afx_msg void OnButton3();
	afx_msg void getDeviceID();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_LAB2DLG_H__C26AA2A3_FC84_48BA_BA77_C01BCB921034__INCLUDED_)
