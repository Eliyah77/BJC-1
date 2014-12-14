#!/usr/bin/perl

# modules
use strict;
use warnings;

# variables
my $name = 'dictionnaire';
my $src_file = '../tex/bjc_2014/annexes/'.$name.'.tex';
my $dst_file = '../txt/'.$name.'.json';
my ($src_fh, $dst_fh);
my ($line, $word, $etymology, $definition);

# fichier de sortie
open($dst_fh, ">", $dst_file);

# ouverture du dictionnaire
open($src_fh, "<", $src_file) or die("Impossible d'ouvrir le fichier $src_file : $!");;

print($dst_fh "{\n");
print($dst_fh "\t\"data\": [\n");
	
	# parcours du livre
	while($line = <$src_fh>) {
		# pre-formatage ligne
		chomp($line);
		# $line =~ s/\\FTNT\{.[^\}]*\}//g;
		# $line =~ s/\\TextDial\{(.[^\}]*)\}/\[$1\]/g;
		$line =~ s/~/ /g;
		$line =~ s/\\vref\{(.*?)\}/$1/g;
		
		if($line =~ m/^\\DicoEntry\{(.*?)\}\\textit\{(.*?)\}/) {
			$word = $1;
			$etymology = $2;
			$etymology =~ s/^,\s+//;
			# $word =~ s/^\\DicoEntry\{(.*?)\}/$1/;
			# $etymology =~ s/\\textit\{[,\}]\s?(.*?)\}/$1/;
			print($dst_fh "\t{\n");
			print($dst_fh "\t\t\"word\": \"$word\",\n");
			print($dst_fh "\t\t\"etymology\": \"$etymology\",\n");
		}
		# or ($line !~ /^\s+$/)
		if(($line =~ /^(?!(\\DicoEntry|\\begin|\\end))/) and ($line !~ /^\s*$/)) {
			$definition = $line;
			if(($definition =~ /^\\\\/) or ($definition =~ /\\newline$/)) {
				$definition =~ s/^\\\\/<br\/>/g;
				$definition =~ s/\\newline/<br\/>/g;
				print($dst_fh $definition);
			} else {
				print($dst_fh "\t\t\"definition\": \"$definition");
			}
		}
		
		if($line =~ /^$/) {
			print($dst_fh "\"\n\t},\n");
		}
	}

print($dst_fh "\"\n\t}\n");
print($dst_fh "\t]\n");
print($dst_fh "}\n");
close($src_fh);

close($dst_fh);

