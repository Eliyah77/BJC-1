#!/usr/bin/perl

# modules
use strict;
use warnings;

# variables
my $name = 'bjc_2014';
my $src_dir = '../tex/'.$name;
my $dst_file = '../txt/'.$name.'.txt';
my ($src_dh, $src_fh, $dst_fh);
my (@file_list, $src_file, $line, $book, $chapter, $verse, $text);

# liste des fichiers latex source
opendir($src_dh, $src_dir) or die("Impossible d'ouvrir le dossier $src_dir : $!");
while($src_file = readdir($src_dh)) {
	if((-T "$src_dir/$src_file") and ($src_file =~ /\.tex$/)) {
		push(@file_list, $src_file);
	}
}
closedir($src_dh);
# tri de la liste
@file_list = sort({$a cmp $b} @file_list);

# fichier de sortie
open($dst_fh, ">", $dst_file);

# parcours des fichiers
foreach $src_file (@file_list) {
	# ouverture du fichier (un livre)
	open($src_fh, "<", $src_dir."/".$src_file);
	
	# recup numéro de livre
	$book = $src_file;
	$book =~ s/^(\d{2}).*/$1/;
	
	# parcours du livre
	while($line = <$src_fh>) {
		# pre-formatage ligne
		chomp($line);
		$line =~ s/\\FTNT\{.[^\}]*\}//g;
		$line =~ s/~/ /g;
		
		# recup numéro de chaptire
		if($line =~ /^\\Chap/) {
			$chapter = $line;
			$chapter =~ s/^\\Chap\{(\d{1,3})\}/$1/;
		}
		
		# recup numéro de verset et texte du verset
		if(($line =~ /^\\VerseOne/) or ($line =~ /^\\VS/)) {
			$text = $verse = $line;
			if($line =~ /^\\VerseOne/) {
				$verse = "1";
				$text =~ s/^\\VerseOne\{\}(.*)/$1/;
			}
			elsif($line =~ /^\\VS/) {
				$verse =~ s/^\\VS\{(\d{1,3})\}.*/$1/;
				$text =~ s/^\\VS\{\d{1,3}\}(.*)/$1/;
			}
			
			# écrire ligne formatée
			print($dst_fh $book,"\t",$chapter,"\t",$verse,"\t",$text,"\n");
		}
	}
	
	close($src_fh);
}

close($dst_fh);

