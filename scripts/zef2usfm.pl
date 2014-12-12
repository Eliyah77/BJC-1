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
my $out = '../USFM/'.$name.'.usfm';

# Read XML file
my $bible = XMLin($src, ForceArray => 1);

open(OUT, '>', $out)
	or die("Impossible d'ouvrir le fichier ".$out." :\n".$!);

print(OUT "\\id ".$name.".usfm\n");
print(OUT "\\ide UTF-8\n");

foreach my $book ( @{ $bible->{BIBLEBOOK} } ) {
	print(OUT "\\h ".$book->{bname}."\n");
	print(OUT "\\toc1 ".$book->{bname}."\n");
	print(OUT "\\toc2 ".$book->{bname}."\n");
	print(OUT "\\toc3 ".$book->{bname}."\n");
	foreach my $chapter ( @{ $book->{CHAPTER} } ) {
		print(OUT "\\c ".$chapter->{cnumber}."\n");
		foreach my $verse ( @{ $chapter->{VERS} } ) {
			print(OUT "\\v ".$verse->{vnumber}." ".$verse->{content}."\n");
		}
	}
}

close(OUT);
