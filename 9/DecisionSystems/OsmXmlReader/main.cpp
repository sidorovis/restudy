#include <iostream>
#include <libxml/xmlreader.h>
#include <libxml/tree.h>
#include <libxml/parser.h>

using namespace std;

int main (int argc, char * const argv[]) 
{
	const char* filename = "/Users/rilley_elf/maps/belarus.osm";
	int element_size = 0, allsize = 0, SIGNIFICANT_WHITESPACE_size = 0, size = 0;
	xmlTextReaderPtr xmlReader = xmlReaderForFile(filename, NULL, NULL);
	if (xmlReader) {
		int ret = xmlTextReaderRead(xmlReader);
		while (ret == 1) {
			int type = xmlTextReaderNodeType(xmlReader);
			if (type == XML_READER_TYPE_ELEMENT)
			{
				xmlNodePtr node = xmlTextReaderCurrentNode(xmlReader);
				cout << " * nodename: " <<  node->name << endl;
				for ( xmlNode *cur = node->children; cur; cur = cur->next)
				{
					if (cur->type == XML_ELEMENT_NODE) {
						
//						std::string str = (char*)cur->name;
					}
					else
					if (cur->type == XML_TEXT_NODE)
					{}
					else {
						int debug = 0;
					}

					if (cur->type == XML_ATTRIBUTE_NODE) {
//						std::string str = (char*)cur->name;
						int debug = 0;
					}
				}
				element_size++;
			}
			else
			if (type == XML_READER_TYPE_SIGNIFICANT_WHITESPACE)
				SIGNIFICANT_WHITESPACE_size++;
			else
			if (type == XML_READER_TYPE_END_ELEMENT)
				size++;
				
			ret = xmlTextReaderRead(xmlReader);
			allsize ++;
		}
		if (ret != 0)
		{
			cout << "xml Document error" << endl;
			return 1;
		}
	}
	else {
		cout << "xml Document open error" << endl;
		return 1;
	}
	xmlFreeTextReader(xmlReader);
	cout << allsize << endl << endl;
	cout << element_size << endl;
	cout << SIGNIFICANT_WHITESPACE_size << endl;
	cout << size << endl << endl;
	cout << element_size + SIGNIFICANT_WHITESPACE_size + size << endl;
    return 0;
}
