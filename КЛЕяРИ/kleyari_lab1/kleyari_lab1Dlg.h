// kleyari_lab1Dlg.h : ���Y�� 
//

#pragma once
#include "afxwin.h"


// Ckleyari_lab1Dlg ��ܤ��
class Ckleyari_lab1Dlg : public CDialog
{
// �غc
public:
	Ckleyari_lab1Dlg(CWnd* pParent = NULL);	// �зǫغc�禡

// ��ܤ�����
	enum { IDD = IDD_KLEYARI_LAB1_DIALOG };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV �䴩


// �{���X��@
protected:
	HICON m_hIcon;

	// ���ͪ��T�������禡
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
