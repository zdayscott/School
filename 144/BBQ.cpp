// Thread-safe blocking queue.
const int MAX = 10;

class BBQ
{
    // Synchronization variables
    Lock lock;
    CV itemAdded;
    CV itemRemoved;

    // State variables
    int items[MAX];
    int front;
    int nextEmpty;

    public:
        BBQ();
        ~BBQ() {};
        void insert(int item);
        int remove();
};

// Initialize the queue to empty,
// the lock to free, and the
// condition variables to empty
BBQ::BBQ()
{
    front = nextEmpty = 0;
}

// Wait unitil there is room
// then insert an item.
void
BBQ::insert(int item)
{
    lock.aquire();
    while((nextEmpty - front) == MAX)
    {
        itemRemoved.wait(&lock);
    }
    items[nextEmpty % MAX] = item;
    nextEmpty++;
    itemAdded.signal();
    lock.release();
}

// Wait until there is an item and
// then remove an item
int
BBQ::remove()
{
    int item;

    lock.aquire();
    while (front == nextEmpty)
    {
        itemAdded.wait(&lock);
    }
    item = items[front % MAX];
    front++;
    itemRemoved.signal();
    return item;
}

