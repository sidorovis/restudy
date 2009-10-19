#include <iostream>
#include <mitab_capi.h>
using namespace std;

int main (int argc, char * const argv[]) 
{
	const char filename[] = "/Users/rilley_elf/maps/админ_центры_пл.mif";
	mitab_handle map = mitab_c_open( filename );
	if (map == NULL)
	{
		cout << "mitab_c_open failed. " << 
				filename << mitab_c_getlasterrormsg() << endl;
		return 1;
	}
	int fieldsCount = mitab_c_get_field_count( map );
	int feature_id;
	for (	feature_id = mitab_c_next_feature_id(map, -1);
			feature_id != -1;
			feature_id = mitab_c_next_feature_id(map, feature_id))
	{
		mitab_feature feature;
        int feature_type, num_parts, partno, pointno;
		
        feature = mitab_c_read_feature( map, feature_id );
        if( feature == NULL )
        {
            cout << "Failed to read feature. "
				<< feature_id << mitab_c_getlasterrormsg() << endl;
            return 1;
        }
		
        feature_type = mitab_c_get_type(feature);
        num_parts = mitab_c_get_parts(feature);
		
        cout << "Read feature " << feature_id << ": "
				<< feature_id << ". type=" << feature_type
				<< ". num_parts=" << num_parts << endl;
		
		for(int fieldno = 0; fieldno < fieldsCount; fieldno++)
        {
			char* name = (char*)mitab_c_get_field_name(map, fieldno);
			char* str = (char*)mitab_c_get_field_as_string(feature, fieldno);
			wcout << name << endl;
			wcout << str << endl;
        }
        for(partno = 0; partno < num_parts; partno++)
        {
            int num_points = mitab_c_get_vertex_count(feature, partno);
            if (num_parts > 1)
                printf(" Part no %d:\n", partno);
            for(pointno = 0; pointno < num_points; pointno++)
            {
                double dX, dY;
                dX = mitab_c_get_vertex_x(feature, partno, pointno);
                dY = mitab_c_get_vertex_y(feature, partno, pointno);
				
                printf("  %.16g %.16g\n", dX, dY);
            }
		}
        mitab_c_destroy_feature( feature );
    }
    mitab_c_close( map );
    if( mitab_c_getlasterrormsg() != NULL 
	   && strlen(mitab_c_getlasterrormsg()) > 0 )
        fprintf( stderr, "Last Error: %s\n", mitab_c_getlasterrormsg() );
    return 0;
}
