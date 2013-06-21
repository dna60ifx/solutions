#!/usr/bin/perl -w
use strict;

my $USAGE="analyze_expression.pl file.ptt depth1 depth2\n";

my $PTTFILE = shift @ARGV or die $USAGE;
my $DEPTH1  = shift @ARGV or die $USAGE;
my $DEPTH2  = shift @ARGV or die $USAGE;


my %genes;

my $INHEADER = 1;

open PTT, "$PTTFILE" or die "Cant open pttfile: $PTTFILE ($!)\n";
while (<PTT>)
{
  if (/^Location/){ $INHEADER = 0; }
  elsif ($INHEADER) { next; }
  else
  {
    my @fields = split /\s+/, $_;
    my ($start, $end) = split /\.\./, $fields[0];
    my $gene = $fields[4];

    # print "$gene\t$start\t$stop\n";

    $genes{$gene}->{start} = $start;
    $genes{$gene}->{end}   = $end;
    $genes{$gene}->{len}   = $end - $start + 1;

    $genes{$gene}->{$DEPTH1} = 0;
    $genes{$gene}->{$DEPTH2} = 0;
  }
}


foreach my $file ($DEPTH1, $DEPTH2)
{
  print STDERR "Loading $file\n";

  open DEPTH, $file or die "Cant open $file ($!)\n";

  while (<DEPTH>)
  {
    chomp;

    my ($genome, $pos, $depth) = split /\s+/, $_;

    foreach my $gene (keys %genes)
    {
      if (($genes{$gene}->{start} <= $pos) &&
          ($pos <= $genes{$gene}->{end}))
      {
        $genes{$gene}->{$file} += $depth;
        last;
      }
    }
  }
}

foreach my $gene (keys %genes)
{
  my $start = $genes{$gene}->{start};
  my $end   = $genes{$gene}->{end};

  my $d1 = $genes{$gene}->{$DEPTH1};
  my $d2 = $genes{$gene}->{$DEPTH2};

  my $max = 0;
  my $min = 0;

  if ($d1 < $d2) { $min = $d1; $max = $d2; }
  else           { $min = $d2; $max = $d1; }

  my $ratio = sprintf("%0.02f", ($min ? $max/$min : 0));
  print "$gene\t|\t$ratio\t|\t$start\t$end\t|\t$d1\t$d2\n";
}

