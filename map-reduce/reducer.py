#!/usr/bin/python

import sys
import re
import os


#def main(argv):
    #(last_word, sum) = (None, 0)
reduce_dict = dict()
#fin = open("output.txt",'r')
#read input comes from STDIN
for line in sys.stdin:
#for line in fin:
    # parse the input we got from mapper.py
    line = line.rstrip("\n").split('\t')

    # compute hour page view in 2D dict: [article, date]
    if(reduce_dict.has_key(line[0])):
        reduce_dict[line[0]][line[2]] = reduce_dict[line[0]].get(line[2],0) + int(line[1])
    else:
        reduce_dict[line[0]] = {line[2]:int(line[1])}
#print reduce_dict

# compute monthly views & daily view 
month_dict = dict()
for key in reduce_dict:
    sum_view = 0
    for key_date in reduce_dict[key]:
        sum_view += reduce_dict[key][key_date]
    month_dict[key] = sum_view

# find article over 1000,000
for key in month_dict:
    if(month_dict[key] > 1000000):
        print  str(month_dict[key])  + "\t" + key,
        for key_date in reduce_dict[key]:
            print "\t" + "<" + key_date + ":" + str(reduce_dict[key][key_date]) + ">",
        


#if __name__ == "__main__":
     #main(sys.argv)
