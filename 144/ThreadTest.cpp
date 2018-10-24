#include <iostream>
#include <thread>

using namespace std;

void threadFn()
{
    cout << "Im inside a threaed function" << endl;
}

int main()
{

    thread t1(threadFn);

    t1.join();

    return 0;
}