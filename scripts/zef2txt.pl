#!/usr/bin/perl

# Modules
use strict;
use warnings;
use XML::Simple;
use Data::Dumper;
# UTF8
use open ":encoding(utf8)";
use open IN => ":encoding(utf8)", OUT => ":utf8";

# Variables
my $name = 'martin_1744';
my $src = '../XML/'.$name.'.xml';
my $out = '../TXT/'.$name.'.txt';

# Read XML file
my $bible = XMLin($src, ForceArray => 1);

open(OUT, '>', $out)
	or die("Impossible d'ouvrir le fichier $out :\n$!");

foreach my $book ( @{ $bible->{BIBLEBOOK} } ) {
	my $bnumber = $book->{bnumber};
	if(length($bnumber) < 2) {
		$bnumber = '0'.$book->{bnumber};
	}
	foreach my $chapter ( @{ $book->{CHAPTER} } ) {
		foreach my $verse ( @{ $chapter->{VERS} } ) {
			print(OUT $bnumber."\t".$chapter->{cnumber}."\t".$verse->{vnumber}."\t".$verse->{content}."\n");
		}
	}
}

close(OUT);
