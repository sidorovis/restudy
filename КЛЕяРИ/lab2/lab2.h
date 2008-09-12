// lab2.h : main header file for the LAB2 application
//

#if !defined(AFX_LAB2_H__B39A135E_D2B8_4B44_B61E_8A1D1C84CE2B__INCLUDED_)
#define AFX_LAB2_H__B39A135E_D2B8_4B44_B61E_8A1D1C84CE2B__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"		// main symbols

/////////////////////////////////////////////////////////////////////////////
// CLab2App:
// See lab2.cpp for the implementation of this class
//

class CLab2App : public CWinApp
{
public:
	CLab2App();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CLab2App)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation

	//{{AFX_MSG(CLab2App)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_LAB2_H__B39A135E_D2B8_4B44_B61E_8A1D1C84CE2B__INCLUDED_)
