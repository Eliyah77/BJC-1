#!/usr/bin/perl

## MDB Bible database (Access/Jet/e-Sword < 9) to OSIS (2.1.1) converter

## Licensed under the standard BSD license:

# Copyright (c) 2009 CrossWire Bible Society <http://www.crosswire.org/>
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

$version = "1.0";
$osisVersion = "2.1.1";

$date = '$Date$';
$rev = '$Rev$';

$date =~ s/^.+?(\d{4}-\d{2}-\d{2}).+/$1/;
$rev =~ s/^.+?(\d+).+/$1/g;

use utf8;
use Encoding;

@OSISbook = (
#OT
 "Gen", "Exod", "Lev", "Num", "Deut", "Josh", "Judg", "Ruth", "1Sam", "2Sam", "1Kgs", "2Kgs", "1Chr", "2Chr", "Ezra", "Neh", "Esth", "Job", "Ps", "Prov", "Eccl", "Song", "Isa", "Jer", "Lam", "Ezek", "Dan", "Hos", "Joel", "Amos", "Obad", "Jonah", "Mic", "Nah", "Hab", "Zeph", "Hag", "Zech", "Mal",

#NT
"Matt", "Mark", "Luke", "John", "Acts", "Rom", "1Cor", "2Cor", "Gal", "Eph", "Phil", "Col", "1Thess", "2Thess", "1Tim", "2Tim", "Titus", "Phlm", "Heb", "Jas", "1Pet", "2Pet", "1John", "2John", "3John", "Jude", "Rev",

#Apocrypha
#"Tob", "Jdt", "AddEsth", "Wis", "Sir", "Bar", "EpJer", "PrAzar", "Sus", "Bel", "1Macc", "2Macc", "3Macc", "4Macc", "1Esd", "2Esd", "PrMan", "Ps151", "PssSol", "Odes"
);

if (scalar(@ARGV) < 2) {
    print "mdb2osis.pl -- MDB Bible to OSIS $osisVersion converter version $version\nRevision $rev ($date)\nSyntax: mdb2osis.pl <osisWork> <input filename> [-o OSIS-file]\nThis converter expects MDBs exported as CSVs by mdbview.\n";
    exit (-1);
}

$osisWork = $ARGV[0];

if ($ARGV[2] eq "-o") {
    $outputFilename = "$ARGV[3]";
}
else {
    $outputFilename = "$osisWork.osis.xml";
}
open (OUTF, ">:utf8", "$outputFilename") or die "Could not open file $ARGV[2] for writing.";

print OUTF "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<osis xmlns=\"http://www.bibletechnologies.net/2003/OSIS/namespace\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"http://www.bibletechnologies.net/2003/OSIS/namespace http://www.bibletechnologies.net/osisCore.$osisVersion.xsd\">\n<osisText osisRefWork=\"Bible\" xml:lang=\"en\" osisIDWork=\"$osisWork\">\n<header>\n<work osisWork=\"$osisWork\"\/>\n<\/header>\n";

open (INF, "<:encoding(cp1252)", $ARGV[1]);
@data = <INF>;
close (INF);

$book = "";
$chap = "";
$vers = "";

sub processText {
    my $t = @_[0];

    $t =~ s/\&\#([0-7]+);/chr(oct($1))/eg;

    $t =~ s/\{\\cf6 (.+?)\}/<q who="Jesus">$1<\/q>/g;
    
    return $t;
}

foreach $line (@data) {
    if ($line =~ /(\d+),(\d+),(\d+),(\d+),(.*)/) {

	$ord = $1;

	$nBook = $2;
	$nChap = $3;
	$vers = $4;
	$text = $5;

	$text = processText($text);

	$oBook = @OSISbook[$nBook-1];
	if ($oBook eq "") {
	    print "Error unknown book: $book\n";	    
	}
	
	$text =~ s/\s*$//g;

	if ($book ne $nBook) {
	    if ($book ne "") {
		print OUTF "<\/chapter>\n";
		$chap = "";
		print OUTF "<\/div>\n";
	    }
	    print OUTF "<div type=\"book\" osisID=\"$oBook\">\n";
	}

	if ($chap ne $nChap) {
	    if ($chap ne "") {
		print OUTF "<\/chapter>\n";
	    }
	    print OUTF "<chapter osisID=\"$oBook.$nChap\">\n";
	}
	
	print OUTF "<verse osisID=\"$oBook.$nChap.$vers\">$text<\/verse>\n";
	
	$book = $nBook;
	$chap = $nChap;
    }
}

print OUTF "<\/chapter>\n";
print OUTF "<\/div>\n";
print OUTF "<\/osisText>\n";
print OUTF "<\/osis>\n";

close (OUTF);
