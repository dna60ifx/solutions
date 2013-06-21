Stage 2 Recommended Solution
============================

Download and install the EMBOSS Package: http://emboss.sourceforge.net/index.html

Run the getorf program to identify the open reading frames using the standard genetic code:
```bash
$ EMBOSS-6.5.7/bin/getorf -find 1 genome.fa -outseq genome.orf
```


Reformat the ORFs, extract the first 15 amino acids, and sort in order from longest to shortest:

```bash
$ awk '{if (substr($1,1,1)==">"){print ">"}else{print}}' genome.orf | tr -d '\n' | tr '>' '\n' | awk '{print length($1), substr($1,1,25)}' | sort -nrk1 | head -15
233 MEDNRPLFALRRYWDTTSGSSADDT
210 MVANTFIPLSMGCRYITHSICVSRH
200 MAGVGTTREGLTQGLMLYARPCAVE
186 MRCRHEVSYSLLNKDGFTGITRNLS
175 MALHSPNDASPTTHGLIDGPAEQQE
174 MGRRSDETALTRQASTISQIGDPKC
172 MLLFKSFIPEAKWEPACLYPQQGGR
170 MSVPEAVRFLKILGNICEQRGTVAE
169 MGPADIGHLNPSYICLRMSRSELLT
166 MMLFSRRLLIGLVRRNREVIINTDQ
165 MPPDKQLGAYLSPVRSQIVICECNF
162 MRSQPGFRRFIIDTNSVSPPSEAYL
157 MSICIELRTRFAPRRPGPSAPINSI
156 MSHGWLPILAYRFLPRIAYSMKRVF
154 MGKSLTCQSSHVRGARRRPHGNVLE
```
Notice the last column spells out THESECRETQFLIFE as expected
