#!/usr/bin/env python

import argparse
import matplotlib.pyplot as plt
import numpy as np

def get_args():
    parser = argparse.ArgumentParser(description="")
    parser.add_argument('-f','--fwd_read',help='your forward read fq file',required=True)
    parser.add_argument('-r','--rvs_read',help='your reverse read fq file',required=True)

    return parser.parse_args()
args = get_args()


def get_lengths(file):
    '''This function returns a list of the length of each read'''
    line_len = []
    for i,line in enumerate(file):
        if i%4 == 1:
            line=line.strip()
            line_len.append(len(line))
        if i%10000000 == 0:
            print(i)
    return line_len

            

        
with open(args.fwd_read, "r") as fwd:
    fwd_lens=get_lengths(fwd)
with open(args.rvs_read, "r") as rvs:
    rvs_lens=get_lengths(rvs)

fig, ax = plt.subplots()

title = str(args.fwd_read).split("/")[2]
title = title.split("_")[0]
ax.hist([fwd_lens,rvs_lens], bins= 20,density=True,color=["deepskyblue","salmon"], label=["forward reads","reverse reads"])
ax.set_yscale('log')
ax.legend(["forward reads","reverse reads"])
ax.set_xlabel("read length")
ax.set_ylabel("log(count)")
ax.set_title(f"Distribution of read length in trimmed RNAseq data for {title}")
#ax.hist(rvs_lens, bins = 20, alpha = 0.5,label="reverse reads")

plt.savefig(f"Project2_Part2/figures/{title}_distribution.png")

