#include <iostream>
#include <ostream>
#include <vector>

class Uravnenie  {
public:
	std::vector<double> koeficients;
	double answer;
	Uravnenie(const size_t length_, const double* koeficients_, const double answer_)
	{
		for(int i = 0 ; i < length_ ; i++)
			koeficients.push_back(koeficients_[i]);
		answer = answer_;
	}
	double all_null()
	{
		bool all_null = true;
		for (int i = 0 ; i < koeficients.size() ; i++)
			if (koeficients[i] != 0)
				all_null = false;
		return all_null;
	}
	void print()
	{
		std::cout << koeficients.size() << " | ";
		for (int i = 0 ; i < koeficients.size() ; i++)
			std::cout << koeficients[i] << "\t\t";
		std::cout << "\t| " << answer;
		std::cout << std::endl;
	}
	bool operator<(const Uravnenie& other) const
	{
		if (other.koeficients.size() != koeficients.size())
			throw new std::exception();
		int i = 0;
		while (i < koeficients.size() && koeficients[i] == 0 && other.koeficients[i] == 0)
			i++;
		if (i == koeficients.size())
			return false;
		if (koeficients[i] != 0 && other.koeficients[i] == 0)
			return true;
		if (koeficients[i] == 0 && other.koeficients[i] != 0)
			return false;
		return false;
	}
/*	bool operator==(const Uravnenie& other) const
	{
		if (other.koeficients.size() != koeficients.size())
			throw new std::exception();
		size_t i = 0;
		while ( i < koeficients.size() && koeficients[i] != 0 && other.koeficients[i] != 0)
			i++;
		if (i == koeficients.size())
			return true;
		if (koeficients[i] == 0 && other.koeficients[i] == 0)
			return true;
		return false;
	}
*/
	const double operator[](size_t index) const
	{
		return koeficients[index];
	}
	
};
class Slau{
public:
	std::vector<Uravnenie> uravneniya;
	void sort()
	{
		std::sort(uravneniya.begin(), uravneniya.end());
	}
	Slau(const size_t length_, const double* array, const size_t ur_length)
	{
		for (int i = 0; i < length_ - ur_length ; i++)
			uravneniya.push_back( Uravnenie(ur_length, array+i, (array+i)[ur_length]) );
		sort();
	}
	const Uravnenie& operator[](size_t index) const
	{
		return uravneniya[index];
	}
	Uravnenie& operator[](size_t index)
	{
		return uravneniya[index];
	}
	void print()
	{
		for (int i = 0 ; i < uravneniya.size() ; i++)
			uravneniya[i].print();
	}
	int solve()
	{
		if (uravneniya.size() > 0)
		for (int y = 0 ; y < uravneniya[0].koeficients.size() ; y++)
		{
			for (int i = y+1 ; i < uravneniya.size() ; i++)
			{
				if (uravneniya[i][y] == 0)
					continue;
				double k = uravneniya[y][y]/uravneniya[i][y];
				for (int u = 0 ; u < uravneniya[i].koeficients.size() ; u++)
				{
					uravneniya[i].koeficients[u] = uravneniya[y][u] - uravneniya[i][u]*k;
				}
				uravneniya[i].answer = uravneniya[y].answer - uravneniya[i].answer*k;
			}
			sort();
		}
		
		int max = uravneniya.size() - 1;
		while ( max > -1 && uravneniya[max].all_null())
			max--;
		if ( max == -1)
			return -1;
		std::vector<double> xes(max+1);
		for (int i = max ; i > -1 ; i--)
		{
			xes[i] = uravneniya[i].answer / uravneniya[i][i];
			for (int u = i - 1 ; u > -1 ; u--)
			{
				uravneniya[u].answer -= xes[i] * uravneniya[u][i];
				uravneniya[u].koeficients[i] = 0;
			}
			
		}
		for (int i = 0 ; i <= max ; i++)
		{
			uravneniya[i].answer /= uravneniya[i].koeficients[i];
			uravneniya[i].koeficients[i] = 1;
		}
		std::cout << "Which uravnenie not null first: " << max << std::endl;
		print();
		std::cout << std::endl;
		return max;
	}
};
int main (int argc, char * const argv[]) {
	const size_t length = 16;
//	const double array[ length ] = {1.0, -1.0/2, 1.0/4, 1.0/8, -1.0/16, 1.0/32, 1.0/64, -1.0/128};
	const double array[  ] = {
        0 , 0, 1, 1, 
        4, 0, 9, 1, 
        16, 0, 25, 1, 
        36, 0, 49 ,1};

//	const size_t length = 20;
//	const double array[ length ] = {-3, 0, 2, 1, -1, 0, 1, 1, 0, 0, 1, 1, 1, 0, 2, 1, 3, 0, 5, 1};
	
	Slau slau(length, array, 8);
	int koef_count = slau.solve()+1;
	double next = 0;
	for (int i = 0 ; i < koef_count ; i++)
		next += slau[i].answer*array[length - koef_count + i];
	std::cout << next << std::endl;
    return 0;
}
