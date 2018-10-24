import datetime
import hashlib

class Block:
    blockNo = 0
    data = None
    next = None
    hash = None
    nonce = 0
    previousHash = 0x0
    timestamp = datetime.datetime.now()

    def __init__(self,data):
        self.data = data

    def hash(self):
        h = hashlib.sha256()
        h.update(
            str(self.nonce).encode('utf-8') +
            str(self.data).encode('utf-8') +
            str(self.previousHash).encode('utf-8') +
            str(self.timestamp).encode('utf-8') +
            str(self.blockNo).encode('utf-8') 
        )
        return h.hexdigest()

    def __str__(self):
        # Print out the value of a block 
        return "Block Hash: " + str(self.hash()) + "\nBlockNo: " + str(self.blockNo) + "\nBlock Data: " + str(self.data) + "\nHashes: " + str(self.nonce) + "\nTImestamp: " + str(self.timestamp) + "\n--------------"

class Blockchain:

    # Mining difficulty
    diff = 20
    maxNonce = 2**32
    target = 2 ** (256-diff)

    # Generates the Genesis block in the blockchain
    block = Block("Genesis")
    # Sets it as the head of our blockchain
    head = block

    # Adds a given block to the chain of blocks
    # the block to be added is the only parameter
    def add(self, block):

        # Set the hash of a given block
        # as our new block's previous hash
        block.previousHash = self.block.hash()

        # Set the block # of our new block
        # as the given block's # + 1, since
        # its next in the chain
        block.blockNo = self.block.blockNo + 1

        # Sets the next block equal to
        # itself. This is the new head
        # of the blockchain
        self.block.next = block
        self.block = self.block.next

    # Determines whether or not we can add a given block to
    # the blockchain
    def mine(self, block):
        # From 0 to 2^32
        for n in range(self.maxNonce):
            # Is the value of the given block's hash less than our target value?
            if int(block.hash(), 16) <= self.target:
                # If it is,
                # add the block to the chain
                self.add(block)
                print(block)
                break
            else:
                block.nonce += 1

#_______________________MAIN____________________________

#initialize blockchain
blockchain = Blockchain()

# Mine 10 blocks
for n in range(10):
    blockchain.mine(Block("Block " + str(n + 1)))

# Print out each block in the blockchain
while blockchain.head != None:
    print(blockchain.head)
    blockchain.head = blockchain.head.next
