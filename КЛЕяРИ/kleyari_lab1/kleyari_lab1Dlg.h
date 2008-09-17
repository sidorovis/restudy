// kleyari_lab1Dlg.h : 標頭檔 
//

#pragma once
#include "afxwin.h"


// Ckleyari_lab1Dlg 對話方塊
class Ckleyari_lab1Dlg : public CDialog
{
// 建構
public:
	Ckleyari_lab1Dlg(CWnd* pParent = NULL);	// 標準建構函式

// 對話方塊資料
	enum { IDD = IDD_KLEYARI_LAB1_DIALOG };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV 支援


// 程式碼實作
protected:
	HICON m_hIcon;

	// 產生的訊息對應函式
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	DECLARE_MESSAGE_MAP()
public:
	afx_msg void OnBnClickedButton1();
	afx_msg void OnBnClickedButton4();
	afx_msg void OnEnChangeEdit1();
	CEdit m_Edit;
	afx_msg void OnBnClickedButton3();
	afx_msg void OnBnClickedButton2();
};
