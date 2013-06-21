Stage 1: Recommended Solution
=============================

Download and install jellyfish: http://www.cbcb.umd.edu/software/jellyfish/

Count the kmers in the reads:
```bash
$ jellyfish count -m 7 -s 1000000 motif_finding.fa  
```

Report the counts, and sort them by frequency:
```bash
$ jellyfish dump -c mer_counts_0  | sort -nrk2 | head
TAGCGAC 295
AGCGACT 84
AGCGACG 82
TTAGCGA 80
GTAGCGA 77
CTAGCGA 76
AGCGACC 74
ATAGCGA 72
AGCGACA 70
GGTAGCG 31
```

