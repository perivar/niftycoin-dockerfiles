

class NiftyCoin(Coin):
    NAME = "NiftyCoin"
    SHORTNAME = "NFY"
    NET = "mainnet"
    XPUB_VERBYTES = bytes.fromhex("4e49b21e")
    XPRV_VERBYTES = bytes.fromhex("4e49ade4")
    P2PKH_VERBYTE = bytes.fromhex("30")
    P2SH_VERBYTES = (bytes.fromhex("32"), bytes.fromhex("05"))
    WIF_BYTE = bytes.fromhex("35")
    GENESIS_HASH = ('1bff4bbd83f4cb3fc8341cf2b258da07'
                    '77b38a1f567ca2dd56367e84d2402d9d')
    DESERIALIZER = lib_tx.DeserializerSegWit
    TX_COUNT = 1
    TX_COUNT_HEIGHT = 1
    TX_PER_BLOCK = 1
    RPC_PORT = 3332
    REORG_LIMIT = 800
    PEERS = []


