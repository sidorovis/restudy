// kleyari_lab1.h : PROJECT_NAME ���ε{�����D�n���Y��
//

#pragma once

#ifndef __AFXWIN_H__
	#error �b�� PCH �]�t���ɮ׫e���]�t 'stdafx.h'
#endif

#include "resource.h"		// �D�n�Ÿ�


// Ckleyari_lab1App:
// �аѾ\��@�����O�� kleyari_lab1.cpp
//

class Ckleyari_lab1App : public CWinApp
{
public:
	Ckleyari_lab1App();

// �мg
	public:
	virtual BOOL InitInstance();

// �{���X��@

	DECLARE_MESSAGE_MAP()
};

extern Ckleyari_lab1App theApp;
