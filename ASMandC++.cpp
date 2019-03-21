#include <iostream>

using namespace std;

int var2; // letter is in data segment (RAM)

int main()
{
	char letter; // letter is in the stack
	cin >> letter;
	__asm
	{
		push eax;
		mov al, letter;
		xor al, 20h
		mov letter, al
		pop eax
	}

	cout << letter;
	cin.get();
	system("pause");
	return 0;
}