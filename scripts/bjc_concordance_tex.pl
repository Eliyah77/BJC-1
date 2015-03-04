#!/usr/bin/perl


use strict;
use warnings;
use utf8;
# use 5.016;

# Fichiers
my $name = 'bjc_2014';
my $entree = "../unb/".$name.".txt";
my $sortie = "../tex/concordance/".$name."_concordance.tex";
my $liste_mots = "../txt/mots.txt";
my $notmatched = "../txt/wordsnotmatched.txt";
my (%concordance, @BJCbooks, @mots, @verserefs);
my $int_after;
my $int_before;
my $versecount;
my $found;
my $matcherror;
my ($classe_mot,$conjug,$context);
my $conjug_er = "(?:";
	$conjug_er = $conjug_er."[est]|es|ai[est]?|[i]?ons|[i]?ez|(?:ai)?ent";
	$conjug_er = $conjug_er."|é[e]?[s]?|ant[s]?|er(?:a(?:i|s)?[st]?|[i]?on[st]|[i]?ez|aient)?";
	$conjug_er = $conjug_er."|(?:a(?:i|s)?|â(m|t)es|èrent)";
	$conjug_er = $conjug_er.")";
	
my $conjug_ir = "(?:";
	$conjug_ir = $conjug_ir."i[st]|isse[s]?|issai[est]?|iss[i]?ons|iss[i]?ez|iss(?:ai)?ent";
	$conjug_ir = $conjug_ir."|i[e]?[s]?|(?:iss)?ant[s]?|ir(?:a(?:i|s)?[st]?|[i]?on[st]|[i]?ez|aient)?";
	$conjug_ir = $conjug_ir."|î(m|t)es|irent";
	$conjug_ir = $conjug_ir.")";

my $conjug_re = "(?:";
	$conjug_re = $conjug_re."[st]?|ai[est]?|[i]?ons|[i]?ez|(?:ai)?ent|e[s]?";
	$conjug_re = $conjug_re."|u[e]?[s]?|i[et]?[s]?|ant[s]?|r[e]?(?:a(?:i|s)?[st]?|[i]?on[st]|[i]?ez|aient)?";
	$conjug_re = $conjug_re."|î(m|t)es|irent";
	$conjug_re = $conjug_re.")";	

@BJCbooks = (
#OT
 "Ge", "Ex", "Lé", "No", "De", "Jos", "Jg", "Ru", "1 S", "2 S", "1 R", "2 R", "1 Ch", "2 Ch", "Esd", "Né", "Est", "Job", "Ps", "Pr", "Ec", "Ca", "Es", "Jé", "La", "Ez", "Da", "Os", "Joë", "Am", "Ab", "Jon", "Mi", "Na", "Ha", "So", "Ag", "Za", "Mal",

#NT
"Mt", "Mc", "Lu", "Jn", "Ac", "Ro", "1 Co", "2 Co", "Ga", "Ep", "Ph", "Col", "1 Th", "2 Th", "1 Ti", "2 Ti", "Tit", "Phm", "Hé", "Ja", "1 Pi", "2 Pi", "1 Jn", "2 Jn", "3 Jn", "Jud", "Ap"
);

open (INF, '<:utf8', $liste_mots);
@mots = <INF>;
close (INF);

open(WRITE, '>:utf8', $sortie);
open(NOTFOUND, '>:utf8', $notmatched);

print (WRITE "\\begin{multicols}{3}\n");
print (WRITE "{\\fontsize{6pt}{0.7em}\\selectfont\n");
# print (WRITE "\\renewcommand{\\descriptionlabel}[1]%\n");
# print (WRITE "{\\hspace{\\labelsep}\\textsf{#1}}");

foreach(@mots) {
	# my $mot = lc($_);
	chomp($_);
	@verserefs = ();
	$versecount = 0;
	$matcherror = "";
	my @ligne_mot = split(/\t/, $_);
	my $terme = $ligne_mot[0];
	$terme =~ s/^\s+|\s+$//g;
	my $mot = $ligne_mot[1];
	chomp($mot);
	$mot =~ s/^\s+|\s+$//g;
	if (defined($ligne_mot[2])){
		$classe_mot =  $ligne_mot[2];
		if($classe_mot eq "v"){
			my ($racine,$suffixe) = split(/(er|ir|re)$/,$mot);
			if($suffixe eq "er") {
				$conjug = $conjug_er;
			} elsif ($suffixe eq "ir") {
				$conjug = $conjug_ir;
			} else {
				$conjug = $conjug_re;
			}
			$mot = $racine.$conjug;
		} elsif(($classe_mot eq "n") or ($classe_mot eq "adj")) {
			if($mot !~ /\]\?$/) {
				if($mot =~ /eux$/) {
					$mot = substr($mot,0,-1)."(?:x|se[s]?)";
				}else{
					$mot = $mot."[e]?[sx]?";
				}
			}
		}
	}
	if (defined($ligne_mot[3])){
		@verserefs =  split(/;/,$ligne_mot[3]);
		$versecount = scalar @verserefs;
	}
	print "$terme\n";
	# print $ligne_mot[3]."\n" if(defined($ligne_mot[3]));
	print (WRITE "\n\\ConcordanceEntry{".$terme."}\n");
	# print (WRITE "\\begin{tabular}{\@{}ll\@{}}\n");
	print (WRITE "\\vspace{-2mm}\n");
	# print(WRITE "\\begin{description}[leftmargin=!,labelwidth=\\widthof{1 Ch 33:10},font=\\normalfont]\n");
	print(WRITE "\\begin{listverse}\n");
	my $occurrences = 0;

	# Ouverture du fichier de la Bible
	open(READ, "<:utf8", $entree);

	# Parcours du fichier de la Bible
	while(my $ligne = <READ>) {
		$found = 0;
	# Découpaqe de chaque ligne du fichier
		my @div = split(/[:\.,;\-'!\?"\[\]\(\)\s\t]+/, $ligne);

		# Récupération de la référence du verset en cours (livre:chapitre:verset)
		$div[0] =~ s/(\d+)[ONAona]/$1/;
		my $book = $BJCbooks[$div[0]-1];
		# print "$book\n";
		my $ref = $book." ".$div[1].":".$div[2];

		if(@verserefs){
			next if(!grep(/^$ref$/, @verserefs));
		}
		my $verset = $ligne;
		chomp($verset);
		$verset =~ s/\d+[ONAona]\t\d+\t\d+\t(.*)/$1/;
			# if($ligne =~ /(?:(?<=\p{L})(?!\p{L})|(?<!\p{L})(?=\p{L}))$mot(?:(?<=\p{L})(?!\p{L})|(?<!\p{L})(?=\p{L}))/iu) {
		if($verset =~ /\b$mot\b/gi) {
			$occurrences ++;
			$found = 1;
			# my $match = $1;
			my $match = substr($verset, $-[0], $+[0] - $-[0]);
			
			# On récupère la position du mot recherché puis les 3 mots le précédant et le suivant
			# http://stackoverflow.com/questions/616041/using-perl-how-do-i-show-the-context-around-a-search-term-in-the-search-results
			my $before = substr($verset, 0, $-[0]);
			my $after =  substr($verset, $+[0]);

			$after = replace_hyphen_quote($after);
			$before = replace_hyphen_quote($before);
			if($-[0]<10) {
				$int_after = 6;
				$int_before = 3;
			} elsif ($+[0]>length($verset)-10){
				$int_after = 3;
			    $int_before = 6;
			} else {
				$int_after = 3;
				$int_before = 3;
			}
				
			$after =~ s/((?:(?:\w+)(?:\W+)){$int_after}).*/$1/;
			$before = reverse $before;                   # reverse the string to limit backtracking.
			$before =~ s/((?:(?:\W+)(?:\w+)){$int_before}).*/$1/;
			$before = reverse $before;
			my $num; 
			$num++ while $match =~ /(\S+)/g; 
			if($num == 1) {
				$match = substr($match,0,1).".";
			}
			
			$after = restore_hyphen_quote($after);
			$before = restore_hyphen_quote($before);
			
			$context = $before.$match.$after;
			$context = shorten($context);
			# $context =~ s/^\s+//;
			# $context =~ s/\s+$//;
			# $context =~ s/\.\.$/./;
			
			# print(WRITE "\\vref{".$ref."}\t".$before.$match.$after."\\newline\n");
			print(WRITE "\\item[\\vref{".$ref."}] ".$context."\n");

		}
		# Si le mot n'a pas été trouvé alors qu'une référence a été donnée, on note la référence pour la loguer et pour vérification
		if (@verserefs and !$found) {
			$matcherror = ($matcherror) ? $matcherror.";".$ref : $ref;
		}
	}
	# print(WRITE "\\end{tabular}\n");
	print(WRITE "\\end{listverse}\n");
	if (defined($ligne_mot[4])){
		my $legend = $ligne_mot[4];
		$legend =~ s/\\\\/\n\\item /g;
		print(WRITE "\\begin{legend}\n");
		print(WRITE "\\NoAutoSpaceBeforeFDP{\n");
		print(WRITE "\\item ");
		print(WRITE $legend."\n");
		print(WRITE "}\n\\end{legend}\n");
	}
	close(READ);
	#Si un mot n'a pas été trouvé, on logue pour analyse
	if ($occurrences == 0 ) {
		print "$terme non trouvé\n";
		print(NOTFOUND "$terme non trouvé\n");
	}
	# Si des références ont été données et que le nombre d'occurrences trouvées est différent du nombre de références données => on logue les erreurs pour analyse
	if ((@verserefs) and ($occurrences != $versecount)) {
		my $errors = $versecount - $occurrences;
		print "$terme => nb ref=$versecount, nb occurrences trouvées=$occurrences, $errors erreurs, refs=$matcherror\n";
		print(NOTFOUND "$terme => nb ref=$versecount, nb occurrences trouvées=$occurrences, $errors erreurs, refs=$matcherror\n");
	}
}

print(WRITE "\n}\n");
print(WRITE "\n\\end{multicols}\n");

close(NOTFOUND);
close(WRITE);

sub replace_hyphen_quote {
	my ($text) = @_;
	$text =~ s/-/999/g;
	$text =~ s/'/888/g;
	return $text;
}

sub restore_hyphen_quote {
	my ($text) = @_;
	$text =~ s/999/-/g;
	$text =~ s/888/'/g;
	return $text;
}

sub shorten {
	my ($text) = @_;
	$text =~ s/\bcomme\b/com./g;
	$text =~ s/\bdonc\b/dc/g;
	$text =~ s/\bdans\b/ds/g;
	$text =~ s/\bdevant\b/dvt/g;
	$text =~ s/\bfemme\b/fem./g;
	$text =~ s/\bholocauste\b/holoc./g;
	$text =~ s/\bhomme\b/hom./g;
	$text =~ s/\bJérusalem\b/Jérus./g;
	$text =~ s/\bleur\b/lr./g;
	$text =~ s/\bjusque\b/jsq./g;
	$text =~ s/\bmême\b/mm/g;
	$text =~ s/\bmaintenant\b/mntnt/g;
	$text =~ s/\bordonnance\b/ordon./g;
	$text =~ s/\bquand\b/qnd/g;
	$text =~ s/\bquelque\b/qq/g;
	$text =~ s/\bSeigneur\b/Seign./g;
	$text =~ s/\bsouverain\b/souv./g;
	$text =~ s/\btous\b/ts/g;
	$text =~ s/\btout\b/tt/g;
	$text =~ s/\btoute\b/tte/g;
	$text =~ s/\btoutes\b/ttes/g;
	$text =~ s/\bvêtement\b/vêt./g;
	$text =~ s/\bnous\b/ns./g;
	$text =~ s/\bvous\b/vs./g;
	$text =~ s/^\s+//;
	$text =~ s/\s+$//;
	$text =~ s/\.\.$/./;
	return $text;
}	
