#!/usr/bin/perl

# modules
use strict;
use warnings;
use File::Basename;

# variables
my $name = 'bjc';
my $dirname = dirname(__FILE__);
my $src_dir = $dirname.'/../tex/'.$name;
my $dst_file = $dirname.'/../osis/'.$name.'_full.xml';
my ($src_dh, $src_fh, $dst_fh);
my (@file_list, @OSISbook, $src_file, $line, $book, $booktitle, $isintro, $chapter, $title, $verse, $text);
my $osisVersion = "2.1.1";
my $osisWork = "BJC";

@OSISbook = (
#OT
 "Gen", "Exod", "Lev", "Num", "Deut", "Josh", "Judg", "Ruth", "1Sam", "2Sam", "1Kgs", "2Kgs", "1Chr", "2Chr", "Ezra", "Neh", "Esth", "Job", "Ps", "Prov", "Eccl", "Song", "Isa", "Jer", "Lam", "Ezek", "Dan", "Hos", "Joel", "Amos", "Obad", "Jonah", "Mic", "Nah", "Hab", "Zeph", "Hag", "Zech", "Mal",

#NT
"Matt", "Mark", "Luke", "John", "Acts", "Rom", "1Cor", "2Cor", "Gal", "Eph", "Phil", "Col", "1Thess", "2Thess", "1Tim", "2Tim", "Titus", "Phlm", "Heb", "Jas", "1Pet", "2Pet", "1John", "2John", "3John", "Jude", "Rev",

#Apocrypha
"Tob", "Jdt", "AddEsth", "Wis", "Sir", "Bar", "EpJer", "PrAzar", "Sus", "Bel", "1Macc", "2Macc", "3Macc", "4Macc", "1Esd", "2Esd", "PrMan", "Ps151", "PssSol", "Odes"
);

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

print($dst_fh "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<osis xmlns=\"http://www.bibletechnologies.net/2003/OSIS/namespace\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"http://www.bibletechnologies.net/2003/OSIS/namespace http://www.bibletechnologies.net/osisCore.$osisVersion.xsd\">\n");
# print($dst_fh "<osisText osisRefWork=\"Bible\" xml:lang=\"en\" osisIDWork=\"$osisWork\">\n<header>\n<work osisWork=\"$osisWork\"\/>\n");
# <\/header>\n");
print($dst_fh "<osisText osisIDWork=\"$osisWork\" osisRefWork=\"Bible\" xml:lang=\"fr\">\n");
print($dst_fh "<header>\n");
print($dst_fh "\t<work osisWork=\"$osisWork\">\n");
print($dst_fh "\t\t<title>Bible de Jésus-Christ</title>\n");
print($dst_fh "\t\t<date>2014-08-24</date>\n");
print($dst_fh "\t\t<description>Révision de la Bible à partir du texte de la Bible Martin 1744.</description>\n");
print($dst_fh "\t\t<type type=\"OSIS\">Bible</type>\n");
print($dst_fh "\t\t<identifier type=\"OSIS\">Bible.$osisWork</identifier>\n");
# print($dst_fh "\t\t<refSystem>Bible</refSystem>\n");
print($dst_fh "\t\t<source>http://www.bibledejesuschrist.org</source>\n");
# print($dst_fh "\t\t<publisher>ANJC Productions</publisher>\n");
print($dst_fh "\t\t<rights>CC-BY-SA 4.0</rights>\n");
# print($dst_fh "\t\t<language type=\"IETF\">fr</language>\n");
print($dst_fh "\t</work>\n");
print($dst_fh "</header>\n");

# parcours des fichiers
foreach $src_file (@file_list) {
	$chapter = "";
	$isintro = 0;
	
	# ouverture du fichier (un livre)
	open($src_fh, "<", $src_dir."/".$src_file);
	
	# recup numéro de livre
	$book = $src_file;
	$book =~ s/^(\d{2}).*/$1/;
	
	print($dst_fh "<div type=\"book\" osisID=\"",$OSISbook[$book-1],"\">\n");
	
	
	# parcours du livre
	while($line = <$src_fh>) {
		# pre-formatage ligne
		chomp($line);
		# $line =~ s/\\FTNT\{.[^\}]*\}//g;
		$line =~ s/\\TextDial\{(.[^\}]*)\}/\[$1\]/g;
		$line =~ s/~/ /g;
		$line =~ s/\\%/%/g;
				
		if ($line =~ /^\\ShortTitle\{.*?\}\\BookTitle\{(.[^\}]*)\}/) {
			$booktitle = $line;
			$booktitle =~ s/\\ShortTitle\{.*?\}\\BookTitle\{(.[^\}]*)\}\\.*$/$1/g;
			print($dst_fh "<title type=\"main\">",$booktitle,"<\/title>\n");
		}
	
		if ($line =~ /^\\textit\{$/) {
			$isintro = 1;
			print($dst_fh "<div type=\"introduction\">\n");
		}
		
		if (($isintro == 1) and ($line =~ /^\\\\/)) {
			$line =~ s/^\\\\//g;
			$line =~s/\\up\{(ème)\}/<hi type="super">$1<\/hi>/g;
			if ($line =~ /(\\\\\}|\\bigskip)$/) {
				$line =~ s/(\\\\\}|\\bigskip)$/<\/div>/g;
				$isintro = 0;
			}
			print($dst_fh $line,"\n");
		}
		# recup numéro de chaptire
		if($line =~ /^\\Chap/) {
			if ($chapter ne "") {
				print($dst_fh  "\t<\/chapter>\n");
			}
			$chapter = $line;
			$chapter =~ s/^\\Chap\{(\d{1,3})\}/$1/;
			print($dst_fh "\t<chapter osisID=\"",$OSISbook[$book-1],".",$chapter,"\">\n");
		}
		
		if ($line =~ /^\\TextTitle/) {
			# if ($inverse == 1) {
				# $inverse = 0;
				# print($dst_fh "<verse eID=\"",@OSISbook[$book-1],".",$chapter,'.',$verse,"\"/>\n");
			# }
			$title = $line;
			$title =~ s/\\TextTitle\{(.[^\}]*)\}/$1/g;
			$title =~ s/\\FTNT[T]?\{(.*)?\}//g;
			print($dst_fh "\t<title>",$title,"<\/title>\n");
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
			if($text =~ /\\FTNT\{.[^\}]*\\\\[\-1-9]/) {
				# $text =~ s/\\FTNT\{(.[^\}]*)\}/<note type="study">$1<\/note>/g;
				$text =~ s/\\\\/\n/g;
				$text =~ s/^([\-1-9])(\s?.*)$/<item><label>$1<\/label>$2<\/item>/mg;
				$text =~ s/\\FTNT\{(.[^\}]*)\}/<note type="study">$1<\/note>/g;
				$text =~ s/(<\/note>)(.*)(<\/item>)/$3$1$2/;
				$text =~ s/<item>/<list>\n<item>/;
				$text =~ s/(.*)<\/item>/$1<\/item>\n<\/list>/s;
				# print $book," ",$chapter,":",$verse,"\t",$text,"\n";
			}
			$text =~ s/\\FTNT\{(.[^\}]*)\}/<note type="study">$1<\/note>/g;
			
			# écrire ligne formatée
			print($dst_fh "\t\t<verse osisID=\"",$OSISbook[$book-1],".",$chapter,'.',$verse,"\" sID=\"",$OSISbook[$book-1],".",$chapter,'.',$verse,"\"/>",$text,"<verse eID=\"",$OSISbook[$book-1],".",$chapter,'.',$verse,"\"/>\n");
		}
	}
	
	print($dst_fh "\t</chapter>\n");
    print($dst_fh "</div>\n");
	
	close($src_fh);
}

print($dst_fh "</osisText>\n");
print($dst_fh "</osis>\n");

close($dst_fh);

