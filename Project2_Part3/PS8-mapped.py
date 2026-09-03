#!/usr/bin/env python
import argparse
def get_args():
    parser = argparse.ArgumentParser(description = 'all of the arguments')
    parser.add_argument('-f','--filename',help='your input file',required=True)
    return parser.parse_args()
args = get_args()
with open(args.filename,'r') as file:
    mapped_reads = 0
    unmapped = 0
    for line in file:
        if line[0] != '@':
            line.strip()
            bitflag = int(line.split('\t')[1])
            if ((bitflag & 256) != 256):
                if((bitflag & 4) != 4):
                    mapped_reads += 1
                else:
                    unmapped += 1
print('mapped reads:',mapped_reads)
print('unmapped reads:', unmapped)

        