#!/usr/bin/env python3
# -*- coding: utf-8 -*-

class definitions:

    BROADCAST_ID = 0xFE  # 254
    MAX_ID = 0xFC  # 252

    # Instruction for DXL Protocol
    INST_PING = 1
    INST_READ = 2
    INST_WRITE = 3
    INST_REG_WRITE = 4
    INST_ACTION = 5
    INST_FACTORY_RESET = 6
    INST_SYNC_WRITE = 131  # 0x83
    INST_BULK_READ = 146  # 0x92
    # --- Only for 2.0 ---
    INST_REBOOT = 8   
    INST_CLEAR  = 16  #0x10
    INST_STATUS = 85  # 0x55
    INST_SYNC_READ = 130  # 0x82
    INST_BULK_WRITE = 147  # 0x93

    # Communication Result
    COMM_SUCCESS = 0  # tx or rx packet communication success
    COMM_PORT_BUSY = -1000  # Port is busy (in use)
    COMM_TX_FAIL = -1001  # Failed transmit instruction packet
    COMM_RX_FAIL = -1002  # Failed get status packet
    COMM_TX_ERROR = -2000  # Incorrect instruction packet
    COMM_RX_WAITING = -3000  # Now recieving status packet
    COMM_RX_TIMEOUT = -3001  # There is no status packet
    COMM_RX_CORRUPT = -3002  # Incorrect status packet
    COMM_NOT_AVAILABLE = -9000  #