#include <iostream>
#include <fstream>
#include <string>

std::string ReplaceString(const std::string& subject, 
	const std::string& searchString, const std::string& replacementString)
{
	size_t pos = 0;
	std::string  result;
	while (pos < subject.length())
	{
		size_t foundPos = subject.find(searchString, pos);
		result.append(subject, pos, foundPos - pos);
		if (foundPos != std::string::npos)
		{
			result.append(replacementString);
			pos = foundPos + searchString.length();
		}
		else
		{
			break;
		}
		
	}
	return result;
}

void CopyFileWithReplace(std::istream& input, std::ostream& output,
	const std::string& searchString, const std::string& replacementString)
{
	std::string line;

	while (std::getline(input, line))
	{
		output << ReplaceString(line, searchString, replacementString) << "\n";
	}

}


int main(int argc, char *argv[])
{
	if (argc != 5)
	{
		std::cout << "Invalid number of arguments\n"
		<< "Usage: ./replace <inputFile> <outputFile> <searchString> <replacementString>\n";
		return 2;
	}
    	
	std::ifstream inputFile(argv[1]);
	if (!inputFile.is_open())
	{
		std::cout << "Can't open input file\n";
		return 1;
	}
	std::ofstream outputFile(argv[2]);

	std::string search = argv[3];
    	std::string replace = argv[4];
	if (search.empty())
	{
		std::cout << "Search string is empty\n";
		return 1;
	}
	CopyFileWithReplace(inputFile, outputFile, search, replace);
	
	outputFile.flush();

	return 0;
}
