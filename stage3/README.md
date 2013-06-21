Stage 1: Recommended Solution
=============================

+ Download and install bowtie: http://bowtie-bio.sourceforge.net/index.shtml
+ Download and install samtools: http://samtools.sourceforge.net/

Index the ecoli genome:

```
$ bowtie-build ecoli.fa ecoli
```

Align the reads with bowtie:

```
$ bowtie ecoli -1 t1.1.fq -2 t1.2.fq -S > t1.sam
# reads processed: 23902
# reads with at least one reported alignment: 18774 (78.55%)
# reads that failed to align: 5128 (21.45%)
Reported 18774 paired-end alignments to 1 output stream(s)

$ bowtie ecoli -1 t2.1.fq -2 t2.2.fq -S > t2.sam
# reads processed: 72995
# reads with at least one reported alignment: 56572 (77.50%)
# reads that failed to align: 16423 (22.50%)
Reported 56572 paired-end alignments to 1 output stream(s)
```

Convert to BAM and sort the alignments:
```
$ samtools view -Sb t1.sam -o t1.bam
$ samtools sort t1.bam t1.s
$ samtools view -Sb t2.sam -o t2.bam
$ samtools sort t2.bam t2.s
```

The samtools depth command shows the depth at every base
```
$ samtools depth t1.s.bam > t1.depth
$ samtools depth t2.s.bam > t2.depth
```

Use the included analyze_expression script to load the depths, and compute the most
differentially expressed gene

```
$ analyze_expression.pl ecoli.ptt t1.depth t2.depth
Loading t1.depth
Loading t2.depth
carB	|	98.11	|	30817	34038	|	38300	3757800
lspA	|	2.17	|	25207	25701	|	3500	7600
ftsL	|	2.15	|	91032	91397	|	2600	5600
imp	|	2.12	|	54755	57109	|	36000	17000
ftsW	|	2.11	|	98403	99647	|	19600	9300
fixC	|	2.11	|	44180	45466	|	9200	19400
caiF	|	2.11	|	34195	34695	|	7400	3500
talB	|	2.09	|	8238	9191	|	6900	14400
djlA	|	2.07	|	57364	58179	|	5700	11800
kefC	|	2.06	|	47769	49631	|	14700	30300
```

This shows the expression of carB changed by 98-fold in the two experiments, while the next
most differentially expressed gene changed by only 2.1 fold

