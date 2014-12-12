#!/usr/bin/perl

# Modules
use strict;
use warnings;
use XML::Simple;
use Data::Dumper;
# UTF8
use open ":encoding(utf8)";
use open IN => ":encoding(utf8)", OUT => ":utf8";

# Array : num => bookname
my %livre = (
	"01" => "Genese",
	"02" => "Exode",
	"03" => "Levitique",
	"04" => "Nombres",
	"05" => "Deuteronome",
	"06" => "Josue",
	"07" => "Juges",
	"08" => "Ruth",
	"09" => "1Samuel",
	"10" => "2Samuel",
	"11" => "1Rois",
	"12" => "2Rois",
	"13" => "1Chroniques",
	"14" => "2Chroniques",
	"15" => "Esdras",
	"16" => "Nehemie",
	"17" => "Esther",
	"18" => "Job",
	"19" => "Psaumes",
	"20" => "Proverbes",
	"21" => "Ecclesiaste",
	"22" => "Cantiques",
	"23" => "Esaie",
	"24" => "Jeremie",
	"25" => "Lamentations",
	"26" => "Ezechiel",
	"27" => "Daniel",
	"28" => "Osee",
	"29" => "Joel",
	"30" => "Amos",
	"31" => "Abdias",
	"32" => "Jonas",
	"33" => "Michee",
	"34" => "Nahum",
	"35" => "Habacuc",
	"36" => "Sophonie",
	"37" => "Aggee",
	"38" => "Zacharie",
	"39" => "Malachie",
	"40" => "Matthieu",
	"41" => "Marc",
	"42" => "Luc",
	"43" => "Jean",
	"44" => "Actes",
	"45" => "Romains",
	"46" => "1Corinthiens",
	"47" => "2Corinthiens",
	"48" => "Galates",
	"49" => "Ephesiens",
	"50" => "Philippiens",
	"51" => "Colossiens",
	"52" => "1Thessaloniciens",
	"53" => "2Thessaloniciens",
	"54" => "1Timothee",
	"55" => "2Timothee",
	"56" => "Tite",
	"57" => "Philemon",
	"58" => "Hebreux",
	"59" => "Jacques",
	"60" => "1Pierre",
	"61" => "2Pierre",
	"62" => "1Jean",
	"63" => "2Jean",
	"64" => "3Jean",
	"65" => "Jude",
	"66" => "Apocalypse"
);

# Variables
my $name = 'bjc_2014';
my $src = '../xml/'.$name.'.xml';
my $dst = '../tex/'.$name;

# Check if destination folder doesn't exists
if (! -d $dst) {
	# Then create it
	`mkdir -p $dst`;
}

# Read XML file
my $bible = XMLin($src, ForceArray => 1);

# Each book
foreach my $book ( @{ $bible->{BIBLEBOOK} } ) {
	# Get book number
	my $bnumber = $book->{bnumber};
	if(length($bnumber) < 2) {
		$bnumber = '0'.$book->{bnumber};
	}
	# Get book name
	my $bname = $book->{bname};

	# Open output file for current book
	open(OUT, "> ".$dst."/".$bnumber."-".$livre{$bnumber}.".tex")
		or die("Impossible d'ouvrir le fichier ".$dst."/".$bnumber."-".$livre{$bnumber}.".tex :\n$!");

	# Write book title
	print(OUT "\\ShortTitle{".$bname."}\\BookTitle{".$bname."}\\BFont\n");
	print(OUT "\\begin{multicols}{2}\n");

	# Each chapter
	foreach my $chapter ( @{ $book->{CHAPTER} } ) {
		# Write chapter
		print (OUT "\\Chap{".$chapter->{cnumber}."}\n");

		# Each verse
		foreach my $verse ( @{ $chapter->{VERS} } ) {
			# Write verse
			if($verse->{vnumber} == 1) {
				print(OUT "\\VerseOne{}".$verse->{content}."\n");
			} else {
				print(OUT "\\VS{".$verse->{vnumber}."}".$verse->{content}."\n");
			}
		}
	}

	# Write 'end of paragraph
	print(OUT "\\PPE{}\n");
	print(OUT "\\end{multicols}");

	# Close current book
	close(OUT);
}
