#include <iostream>
#include <mitab.h>
#include <mitab_capi.h>

int main (int argc, char * const argv[]) 
{
	
	MITABLoadCoordSysTable("~/maps/Admin_Units.txt");
	IMapInfoFile* feature;
	if ( (feature = IMapInfoFile::SmartOpen("~/maps/Admin_Units.TAB")) == NULL)
	{
		std::cout << "ololol" << std::endl;
	}
//	mitab_handle handle = mitab_c_open("~/maps/Admin_Units.MIF");
//	std::cout << handle << std::endl;
//	std::cout << MITAB_VERSION << std::endl;
    return 0;
}
