#!/usr/bin/perl

## Licensed under the standard BSD license:

# Copyright (c) 2005-2007 CrossWire Bible Society <http://www.crosswire.org/>
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
# 
#     * Redistributions of source code must retain the above copyright
#        notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in
#       the documentation and/or other materials provided with the
#       distribution.
#     * Neither the name of the CrossWire Bible Society nor the names of
#       its contributors may be used to endorse or promote products
#       derived from this software without specific prior written
#       permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
# IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
# TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
# PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

## For general inquiries, comments, suggestions, bug reports, etc. email:
## sword-support@crosswire.org

#########################################################################

$version = "1.5.1";
$osisVersion = "2.1.1";

$date = '$Date$';
$rev = '$Rev$';

$date =~ s/^.+?(\d{4}-\d{2}-\d{2}).+/$1/;
$rev =~ s/^.+?(\d+).+/$1/g;

%OSISbook = ("Genesis" => "Gen", "Ge" => "Gen", "Gn" => "Gen", "Exodus" => "Exod", "Ex" => "Exod", "Leviticus" => "Lev", "Lev" => "Lev", "Lv" => "Lev", "Numbers" => "Num", "Nu" => "Num", "Deuteronomy" => "Deut", "De" => "Deut", "Dt" => "Deut", "Joshua" => "Josh", "Jos" => "Josh", "Judges" => "Judg", "Judg" => "Judg", "Jdg" => "Judg", "Ruth" => "Ruth", "Ru" => "Ruth", "1 Samuel" => "1Sam", "1 Sa" => "1Sam", "1Sa" => "1Sam", "2 Samuel" => "2Sam", "2 Sa" => "2Sam", "2Sa" => "2Sam", "1 Kings" => "1Kgs", "1 Ki" => "1Kgs", "1Ki" => "1Kgs", "2 Kings" => "2Kgs", "2 Ki" => "2Kgs", "2Ki" => "2Kgs", "1 Chronicles" => "1Chr", "1 Ch" => "1Chr", "1Ch" => "1Chr", "2 Chronicles" => "2Chr", "2 Ch" => "2Chr", "2Ch" => "2Chr", "Ezra" => "Ezra", "Ezr" => "Ezra", "Nehemiah" => "Neh", "Ne" => "Neh", "Esther" => "Esth", "Es" => "Esth", "Job" => "Job", "Psalms" => "Ps", "Psalm" => "Ps", "Ps" => "Ps", "Proverbs" => "Prov", "Pr" => "Prov", "Ecclesiastes" => "Eccl", "Ec" => "Eccl", "Song" => "Song", "SS" => "Song", "Isaiah" => "Isa", "Isa" => "Isa", "Jeremiah" => "Jer", "Je" => "Jer", "Lamentations" => "Lam", "La" => "Lam", "Ezekiel" => "Ezek", "Eze" => "Ezek", "Daniel" => "Dan", "Da" => "Dan", "Hosea" => "Hos", "Ho" => "Hos", "Joel" => "Joel", "Joe" => "Joel", "Amos" => "Amos", "Am" => "Amos", "Obadiah" => "Obad", "Ob" => "Obad", "Jonah" => "Jonah", "Jon" => "Jonah", "Micah" => "Mic", "Mi" => "Mic", "Nahum" => "Nah", "Na" => "Nah", "Habakkuk" => "Hab", "Hab" => "Hab", "Zephaniah" => "Zeph", "Zep" => "Zeph", "Haggai" => "Hag", "Hag" => "Hag", "Zechariah" => "Zech", "Zec" => "Zech", "Malachi" => "Mal", "Mal" => "Mal", "Tobit" => "Tob", "Tob" => "Tob", "Judith" => "Jdt", "Judi" => "Jdt", "Jdt" => "Jdt", "GrkEs" => "AddEsth", "GR" => "AddEsth", "Baruch" => "Bar", "Bar" => "Bar", "Letter" => "EpJer", "Let" => "EpJer", "DNT" => "AddDan", "AddDan" => "AddDan", "Matthew" => "Matt", "Mat" => "Matt", "Mt" => "Matt", "Mark" => "Mark", "Mar" => "Mark", "Mk" => "Mark", "Luke" => "Luke", "Lu" => "Luke", "Lk" => "Luke", "John" => "John", "Joh" => "John", "Acts" => "Acts", "Ac" => "Acts", "Romans" => "Rom", "Ro" => "Rom", "Rm" => "Rom", "1 Corinthians" => "1Cor", "1 Co" => "1Cor", "1Co" => "1Cor", "2 Corinthians" => "2Cor", "2 Co" => "2Cor", "2Co" => "2Cor", "Galatians" => "Gal", "Ga" => "Gal", "Ephesians" => "Eph", "Ep" => "Eph", "Philippians" => "Phil", "Phili" => "Phil", "Php" => "Phil", "Colossians" => "Col", "Col" => "Col", "1 Thessalonians" => "1Thess", "1 Th" => "1Thess", "1Th" => "1Thess", "2 Thessalonians" => "2Thess", "2 Th" => "2Thess", "2Th" => "2Thess", "1 Timothy" => "1Tim", "1 Ti" => "1Tim", "1Ti" => "1Tim", "2 Timothy" => "2Tim", "2 Ti" => "2Tim", "2Ti" => "2Tim", "Titus" => "Tit", "Tit" => "Tit", "Philemon" => "Phlm", "Phile" => "Phlm", "Phm" => "Phlm", "Hebrews" => "Heb", "Heb" => "Heb", "He" => "Heb", "James" => "Jas", "Ja" => "Jas", "1 Peter" => "1Pet", "1 Pe" => "1Pet", "1Pe" => "1Pet", "2 Peter" => "2Pet", "2 Pe" => "2Pet", "2Pe" => "2Pet", "1 John" => "1John", "1 Jo" => "1John", "1Jo" => "1John", "2 John" => "2John", "2 Jo" => "2John", "2Jo" => "2John", "3 John" => "3John", "3 Jo" => "3John", "3Jo" => "3John", "Jude" => "Jude", "Revelation" => "Rev", "Re" => "Rev");

if (scalar(@ARGV) < 1) {
    print "gbf2osis.pl -- GBF to OSIS $osisVersion converter version $version\nRevision $rev ($date)\nSyntax: gbf2osis.pl [web|hnv]\n";
    exit (-1);
}

$work = @ARGV[0];

($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)=localtime(time);
$year += 1900;
$date = sprintf("%04d\-%02d\-%02d", $year, $mon, $mday);

open (INF, "$work.gbf");
$work = uc($work);
$osisWork = "Bible.en.$work.$year";
open (OUTF, ">$osisWork.osis.xml");

while (<INF>) {
    $line = $_;
    
    $line =~ s/[\r\n]+//g;
    if ($line =~ /^</) {
	$bible .= "$line";
    }
    else {
	$bible .= " $line";
    }
    $bible .= "@";
}

sub chapterdivs {
    $chcontents = @_[0];
    $vs = 0;
    
    $chcontents =~ s/(<CM>|[\#\@])*$//;
    $chcontents = "<chapter osisID=\"" . $bk . "." . ++$ch . "\">\#<p>$chcontents<\/p><\/chapter>\#";
    $chcontents =~ s/<SV[^>]+>(.+?)(?=<SV|<\/chapter)/"<verse sID=\"" . $bk . "." . $ch . "." . ++$vs . "\" osisID=\"" . $bk . "." . $ch . "." . $vs . "\"\/>$1<verse eID=\"" . $bk . "." . $ch . "." . $vs . "\"\/>\#"/eg;
    
    return $chcontents;
}

sub bookdivs {
    $bk = @_[0];
    $bkcontents = @_[1];
    $ch = 0;
    
    $bk = $OSISbook{$bk};
    
    $bkcontents =~ s/(<CM>|[\#\@])*$//;
    $bkcontents = "<div type=\"book\" osisID=\"" . $bk . "\">\#$bkcontents<\/div>\#";
    $bkcontents =~ s/<SC[^>]+>(.+?)(?=<SC|<\/div)/chapterdivs($1)/eg;
				    
    return $bkcontents;
}


sub poetrychunk {
    $poetrycontents = @_[0];

    $poetrycontents =~ s/((<CM>\@?)?<SC[^>]+?>)/<Pp>$1<PP>/g;
    $poetrycontents = "<PP>$poetrycontents<Pp>";

    return $poetrycontents;
}

sub poetry {
    $poetrycontents = @_[0];

    $poetrycontents =~ s/^(<CM>)+//;
    $poetrycontents =~ s/(<CM>)+$//;

    $poetrycontents = "<lg><l>" . $poetrycontents . "<\/l><\/lg>\#";
    $poetrycontents =~ s/<CL>/<\/l>\#<l>/g;

    if ($poetrycontents =~ /<CM>/) {
#	$poetrycontents =~ s/<lg>/<lg><lg>/;
#	$poetrycontents =~ s/<\/lg>/<\/lg><\/lg>/;
	$poetrycontents = "<lg>$poetrycontents<\/lg>";
	$poetrycontents =~ s/<CM>/<\/l><\/lg>\#<lg><l>/g;
    }

    return $poetrycontents;
}

sub buildheader {
    $type = @_[0];
    $contents = @_[1];
    
    if ($type eq "1") {
	$Htitle = $contents;
    }
    elsif ($type eq "4") {
	$Hcopyright = $contents;
    }
    elsif ($type eq "C") {
	$Hcreator = $contents;
    }

    return "";
}



#construct header
$bible =~ s/<H(1|2|3|4|T|E|S|U|V|C|A|L|P)>(.+?)(?=<)/buildheader($1,$2)/eg;
$header = "<header>\#<revisionDesc><date>$date<\/date><p>Initial conversion from GBF using gbf2osis.pl.<\/p><\/revisionDesc>\#<work osisWork=\"$osisWork\">\#<\/work>\#<\/header>\#";
if ($Htitle ne "") {$header =~ s/<\/work>/<title>$Htitle<\/title>\#<\/work>/g;}
if ($Hcreator ne "") {$header =~ s/<\/work>/<creator>$Hcreator<\/creator>\#<\/work>/g;}
if ($Hcopyright ne "") {$header =~ s/<\/work>/<rights>$Hcopyright<\/rights>\#<\/work>/g;}
$header = "<\?xml version=\"1.0\" encoding=\"UTF-8\"?>\#<osis xmlns=\"http:\/\/www.bibletechnologies.net\/2003\/OSIS\/namespace\" xmlns:xsi=\"http:\/\/www.w3.org\/2001\/XMLSchema-instance\" xsi:schemaLocation=\"http:\/\/www.bibletechnologies.net\/2003\/OSIS\/namespace http:\/\/www.bibletechnologies.net\/osisCore.$osisVersion.xsd\">\#<osisText osisRefWork=\"Bible\" xml:lang=\"en\" osisIDWork=\"$osisWork\">\#$header";


$bible =~ s/<H0[\d][\d]>.+<BO>/<BO>/;

#early reformatting
$bible =~ s/<PP><CM>\@<SC60><SV1>/<CM>\@<SC60><PP><SV1>/;
$bible =~ s/<PP>(.+?)<Pp>/poetrychunk($1)/eg;


#deal with body
$bible =~ s/<B[OAN]>(.+?)(?=<B|<ZZ)/<div type="bookGroup" canonical="true">\#$1<\/div>\#/g;

$bk = 0;
$bible =~ s/(<CM>[\@\#]*)+<SB/\#<SB/g;
$bible =~ s/<SB([^>]+)>(.+?)(?=<SB|<\/div)/bookdivs($1,$2)/eg;
$bible =~ s/<RB>(.+?)<RF>(.+?)<Rf>/$1<note><catchWord>$1<\/catchWord> $2<\/note>/g;
$bible =~ s/<RF>(.+?)<Rf>/<note>$1<\/note>/g;


$bible =~ s/<TC>(.+?)<Tc>//g;
$bible =~ s/<TN>(.+?)<Tn>//g;
$bible =~ s/<TT>(.+?)(<CM>[\#\@]*)<Tt>/<title>$1<\/title>\#/g;
$bible =~ s/<TB>(.+?)(<CM>[\#\@]*)<Tb>/<title>$1<\/title>\#/g;
$bible =~ s/<TH>(.+?)(<CM>[\#\@]*)<Th>/<title type="psalm">$1<\/title>\#/g;
$bible =~ s/<TS>(.+?)(<CM>|[\#\@])*<Ts>/<speaker>$1<\/speaker>\#/g;

$bible =~ s/<PP>(.+?)<Pp>/poetry($1)/eg;
$bible =~ s/<CL>/<lb\/>/g;

$bible =~ s/<FI>(.+?)<Fi>/<hi type=\"italic\">$1<\/hi>/g;

$bible =~ s/<CM>/<\/p>\#<p>/g;

$bible =~ s/<JR>([^<]+?)<\/lg>/<l type=\"selah\">$1<\/l><\/lg>/g;
$bible =~ s/<JL>//g;

$qn = 0;

$bible =~ s/<FR>ì(.+?)î?<Fr>/"<q marker=\"&ldquo;\" level=\"1\" sID=\"q." . ++$qn . "\" who=\"Jesus\"\/>$1<q marker=\"&rdquo;\" eID=\"q." . $qn . "\"\/>"/eg;
$bible =~ s/<FR>ë(.+?)í?<Fr>/"<q marker=\"&lsquo;\" level=\"2\" sID=\"q2." . ++$qn . "\" who=\"Jesus\"\/>$1<q marker=\"&rsquo;\" eID=\"q2." . $qn . "\"\/>"/eg;

$bible =~ s/ì(.+?)î/"<q marker=\"&ldquo;\" level=\"1\" sID=\"q." . ++$qn . "\"\/>$1<q marker=\"&rdquo;\" eID=\"q." . $qn . "\"\/>"/eg;
$bible =~ s/ë(.+?)í/"<q marker=\"&ldquo;\" level=\"2\" sID=\"q2." . ++$qn . "\"\/>$1<q marker=\"&rsquo;\" eID=\"q2." . $qn . "\"\/>"/eg;

$bible =~ s/(\w+)<WTP>/<w morph="pl">$1<\/w>/g;
$bible =~ s/(\w+)<WTf>/<w morph="2">$1<\/w>/g;

$bible =~ s/(<\/p>\#<p>)\@?(<verse eID[^>]+>)\#?/$2$1/g;
$bible =~ s/(<\/p>)(<verse eID[^>]+>)/$2$1/g;
$bible =~ s/<l> +/<l>/g;
$bible =~ s/<p> +/<p>/g;
$bible =~ s/<l>\@?<JR>/<l type=\"selah\">/g;

$bible =~ s/<ZZ>/<\/osisText>\#<\/osis>\#/g;
$bible = $header . $bible;

$bible =~ s/\@//g;
$bible =~ s/\s*\#+\s*/\#/g;

# cleanups

sub nukelongcw {
    $cw = @_[0];
    if ($cw =~ /<verse /) {return "";}
    else {return $cw};
}

$bible =~ s/<lg><l><\/l><\/lg>\#//g;
$bible =~ s/<p><\/p>\#//g;

$bible =~ s/<lg><lg><l>(<title type=\"psalm\">[^<]+<\/title>)\#<\/l><\/lg>/$1<lg>\#/g;
$bible =~ s/<lg><l>(<title type=\"psalm\">[^<]+<\/title>)\#<\/l><\/lg>/<\/lg>\#$1<lg>\#/g;
$bible =~ s/(<catchWord>[^<]+)<\/l>\#<l>([^<]+<\/catchWord>)/$1<lb\/>$2/g;
$bible =~ s/(<catchWord>.+?<\/catchWord> *)/nukelongcw($1)/eg; # nuke overly long (multi-verse) catchWords
#$bible =~ s/(<\/p>\#<\/chapter>\#<chapter osisID=\"[^\"]+\">\#<p>)(<\/l><\/lg>)\#(<lg><l>)/$2<\/lg>$1<lg>$3/g;





$bible =~ s/\#/\n/g;


# encoding stuff
use encoding 'latin1';
 utf8::encode($bible);

$bible =~ s/&ldquo;/‚Äú/g;
$bible =~ s/&rdquo;/‚Äù/g;
$bible =~ s/&lsquo;/‚Äò/g;
$bible =~ s/&rsquo;/‚Äô/g;
$bible =~ s/\&/\&amp;/g;


print OUTF "$bible";

close (INF);
