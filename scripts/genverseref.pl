#!/usr/bin/perl

use strict;
use warnings;
use utf8;

my $verse_filter = "../txt/filtres.txt";
my $sortie = "../txt/verseref.txt";
my $erreur = "../txt/verseerror.txt";
my $terme;
my $verseref = "";
my $inside_word = 0;

# open (INF, $verse_filter);
# @mots = <INF>;
# close (INF);
#ééé

open(READ, "<:utf8", $verse_filter);
open(WRITE, '>:utf8', $sortie);
open(ERROR, '>:utf8', $erreur);

while(my $ligne = <READ>) {
chomp($ligne);
if($ligne =~ /^([^\t][\w\W]+):/) {
	if($inside_word == 1) {
		$inside_word = 0;
		print "$terme\t$verseref\n";
		print (WRITE "$terme\t$verseref\n");
	}
	$terme = $1;
	$verseref = "";
# } elsif($ligne =~ /^\t((?:[1-3]\s)?\w+\s\d+:\d+)\t.*$/) {
} elsif($ligne =~ /^\t((?:Ge|Es[td]|E[cpsxz]|Lé|N[aéo]|D[ae]|Ga|Jo[ësnb]|Jud|J[aégn]|Os|A[bcgmp]|M[cit]|H[éa]|S[o]|Z[a]|Mal|Phm|P[hrs]|Ca|Col|Tit|R[ou]|L[au]|[12]\s[SR]|[12]\s[CT]h|[12]\sCo|[12]\s[TP]i|[1-3]\sJn)\s\d+:\d+)\t.*$/) {
	$inside_word = 1;
	$verseref = ($verseref ne "") ? $verseref.";".$1 : $1;
} else {
	print (ERROR "$terme=>$ligne\n") if(($ligne !~ /^\W+$/) or ($ligne =~ /^$/));
}
}
close(READ);

print "$terme\t$verseref\n";
print (WRITE "$terme\t$verseref\n");
close(WRITE);
close(ERROR);

	
