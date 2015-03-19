#!/usr/bin/perl

# modules
use strict;
use warnings;
use File::Basename;

# variables
my $name = 'dictionnaire';
my $dirname = dirname(__FILE__);
my $src_file = $dirname/.'../tex/bjc/annexes/'.$name.'.tex';
my $dst_file = $dirname/.'../txt/'.$name.'.json';
my ($src_fh, $dst_fh);
my ($line, $word, $etymology, $definition);
my %bjcdbs = ();

%bjcdbs = ( "Ge" => "GN", "Ex" => "EX", "Lé" => "LV", "No" => "NU", "De" => "DT", "Jos" => "JS", "Jg" => "JG", "Ru" => "RT", "1 S" => "S1", "2 S" => "S2", "1 R" => "K1",
"2 R" => "K2", "1 Ch" => "R1", "2 Ch" => "R2", "Esd" => "ER", "Né" => "NH", "Est" => "ET", "Job" => "JB", "Ps" => "PS", "Pr" => "PR", "Ec" => "EC", "Ca" => "SS", "Es" => "IS",
"Jé" => "JR", "La" => "LM", "Ez" => "EK", "Da" => "DN", "Os" => "HS", "Joë" => "JL", "Am" => "AM", "Ab" => "OB", "Jon" => "JH", "Mi" => "MC", "Na" => "NM", "Ha" => "HK",
"So" => "ZP", "Ag" => "HG", "Za" => "ZC", "Mal" => "ML", "Mt" => "MT", "Mc" => "MK", "Lu" => "LK", "Jn" => "JN", "Ac" => "AC", "Ro" => "RM", "1 Co" => "C1", "2 Co" => "C2",
"Ga" => "GL", "Ep" => "EP", "Ph" => "PP", "Col" => "CL", "1 Th" => "H1", "2 Th" => "H2", "1 Ti" => "T1", "2 Ti" => "T2", "Tit" => "TT", "Phm" => "PM", "Hé" => "HB", "Ja" => "JM",
"1 Pi" => "P1", "2 Pi" => "P2" , "1 Jn" => "J1", "2 Jn" => "J2", "3 Jn" => "J3", "Jud" => "JD", "Ap" => "RV");

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
		# $line =~ s/\\vref\{(.*?)\}/$1/g;
		$line =~ s/\\vref\{\b([1|2|3]?\s?[a-zA-Zéë]+)\.(?:\s+(\d+))?(?::(\d+(?:[-–]\d+)?)((?:,\s*\d+(?:[-–]\d+)?)*))?\}/&parseref($1,$2,$3,$4)/eg;
		
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

sub parseref {
	my($bk,$chap,$vs,$multivs) = @_;
	my $ref;
	my $ref2 = "";
	$ref = "<span class=\\\"bibleref\\\" data-id=\\\"" . $bjcdbs{$bk} . "$chap\_$vs\\\">$bk. $chap:$vs</span>";
	
	if ($multivs ne "") {
		my @multivs = split(',',$multivs);
		
		foreach my $val (@multivs) {
			if ($val ne "") {
				$val =~ s/^\s+//;
				if($ref2 ne "") {
					$ref2 .= ",<span class=\\\"bibleref\\\" data-id=\\\"" . $bjcdbs{$bk} . "$chap\_$val\\\">$val</span>";
				} else {
					$ref2 .= "<span class=\\\"bibleref\\\" data-id=\\\"" . $bjcdbs{$bk} . "$chap\_$val\\\">$val</span>";
				}
				# print "<span class=\"bibleref\" data-id=\"" . $bjcdbs{$bk} . "$chap\_$val\">$bk. $chap:$val</span>\n";
			}
		}
	}
	if ($ref2 ne "") {
		return "$ref,$ref2";
	} else {
		return $ref;
	}
}
