#!/usr/bin/perl

## IMPort format to OSIS (2.1.1) converter (for Bibles only)

## Licensed under the standard (3-clause) BSD license:

# Copyright (c) 2008-2009 CrossWire Bible Society <http://www.crosswire.org/>
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
# 
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
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

$version = "2.0.1";
$osisVersion = "2.1.1";

$date = '$Date$';
$rev = '$Rev$';

$date =~ s/^.+?(\d{4}-\d{2}-\d{2}).+/$1/;
$rev =~ s/^.+?(\d+).+/$1/g;

%OSISbook = (
	"1 BARUCH" => "Bar",
	"1 C" => "1Cor",
	"1 CHRONICLES" => "1Chr",
	"1 CORINTHIANS" => "1Cor",
	"1 E" => "1Esd",
	"1 ENOCH" => "1En",
	"1 ESDRAS" => "1Esd",
	"1 JN" => "1John",
	"1 JOHN" => "1John",
	"1 K" => "1Kgs",
	"1 KGDMS" => "1Sam",
	"1 KGS" => "1Kgs",
	"1 KING" => "1Kgs",
	"1 KINGDOMS" => "1Sam",
	"1 KINGS" => "1Kgs",
	"1 MACCABEES" => "1Macc",
	"1 MAKABIAN" => "1Meq",
	"1 MEQABYAN" => "1Meq",
	"1 P" => "1Pet",
	"1 PARALIPOMENON" => "1Chr",
	"1 PETER" => "1Pet",
	"1 PTR" => "1Pet",
	"1 SAMUEL" => "1Sam",
	"1 THESSALONIANS" => "1Thess",
	"1 TIMOTHY" => "1Tim",
	"1BARUCH" => "Bar",
	"1C" => "1Cor",
	"1CH" => "1Chr",
	"1CHR" => "1Chr",
	"1CHRONICLES" => "1Chr",
	"1CO" => "1Cor",
	"1COR" => "1Cor",
	"1CORINTHIANS" => "1Cor",
	"1E" => "1Esd",
	"1EN" => "1En",
	"1ENOCH" => "1En",
	"1ESD" => "1Esd",
	"1ESDRAS" => "1Esd",
	"1JN" => "1John",
	"1JO" => "1John",
	"1JOHN" => "1John",
	"1K" => "1Kgs",
	"1KGDMS" => "1Sam",
	"1KGS" => "1Kgs",
	"1KI" => "1Kgs",
	"1KING" => "1Kgs",
	"1KINGDOMS" => "1Sam",
	"1KINGS" => "1Kgs",
	"1MA" => "1Macc",
	"1MACC" => "1Macc",
	"1MACCABEES" => "1Macc",
	"1MAKABIAN" => "1Meq",
	"1MEQ" => "1Meq",
	"1MEQABYAN" => "1Meq",
	"1P" => "1Pet",
	"1PARALIPOMENON" => "1Chr",
	"1PE" => "1Pet",
	"1PET" => "1Pet",
	"1PETER" => "1Pet",
	"1PTR" => "1Pet",
	"1SA" => "1Sam",
	"1SAM" => "1Sam",
	"1SAMUEL" => "1Sam",
	"1TH" => "1Thess",
	"1THESS" => "1Thess",
	"1THESSALONIANS" => "1Thess",
	"1TI" => "1Tim",
	"1TIM" => "1Tim",
	"1TIMOTHY" => "1Tim",
	"2 BARUCH" => "2Bar",
	"2 C" => "2Cor",
	"2 CHRONICLES" => "2Chr",
	"2 CORINTHIANS" => "2Cor",
	"2 E" => "2Esd",
	"2 ESDRAS" => "2Esd",
	"2 JN" => "2John",
	"2 JOHN" => "2John",
	"2 K" => "2Kgs",
	"2 KGDMS" => "2Sam",
	"2 KGS" => "2Kgs",
	"2 KING" => "2Kgs",
	"2 KINGDOMS" => "2Sam",
	"2 KINGS" => "2Kgs",
	"2 MACCABEES" => "2Macc",
	"2 MAKABIAN" => "2Meq",
	"2 MEQABYAN" => "2Meq",
	"2 P" => "2Pet",
	"2 PARALIPOMENON" => "2Chr",
	"2 PETER" => "2Pet",
	"2 PTR" => "2Pet",
	"2 SAMUEL" => "2Sam",
	"2 THESSALONIANS" => "2Thess",
	"2 TIMOTHY" => "2Tim",
	"2BAR" => "2Bar",
	"2BARUCH" => "2Bar",
	"2C" => "2Cor",
	"2CH" => "2Chr",
	"2CHR" => "2Chr",
	"2CHRONICLES" => "2Chr",
	"2CO" => "2Cor",
	"2COR" => "2Cor",
	"2CORINTHIANS" => "2Cor",
	"2E" => "2Esd",
	"2ESD" => "2Esd",
	"2ESDRAS" => "2Esd",
	"2JN" => "2John",
	"2JO" => "2John",
	"2JOHN" => "2John",
	"2K" => "2Kgs",
	"2KGDMS" => "2Sam",
	"2KGS" => "2Kgs",
	"2KI" => "2Kgs",
	"2KING" => "2Kgs",
	"2KINGDOMS" => "2Sam",
	"2KINGS" => "2Kgs",
	"2MA" => "2Macc",
	"2MACC" => "2Macc",
	"2MACCABEES" => "2Macc",
	"2MAKABIAN" => "2Meq",
	"2MEQ" => "2Meq",
	"2MEQABYAN" => "2Meq",
	"2P" => "2Pet",
	"2PARALIPOMENON" => "2Chr",
	"2PE" => "2Pet",
	"2PET" => "2Pet",
	"2PETER" => "2Pet",
	"2PTR" => "2Pet",
	"2SA" => "2Sam",
	"2SAM" => "2Sam",
	"2SAMUEL" => "2Sam",
	"2TH" => "2Thess",
	"2THESS" => "2Thess",
	"2THESSALONIANS" => "2Thess",
	"2TI" => "2Tim",
	"2TIM" => "2Tim",
	"2TIMOTHY" => "2Tim",
	"3 EZRA" => "1Esd",
	"3 JN" => "3John",
	"3 JOHN" => "3John",
	"3 KGDMS" => "1Kgs",
	"3 KGS" => "1Kgs",
	"3 KINGDOMS" => "1Kgs",
	"3 KINGS" => "1Kgs",
	"3 MACCABEES" => "3Macc",
	"3 MAKABIAN" => "3Meq",
	"3 MEQABYAN" => "3Meq",
	"3EZRA" => "1Esd",
	"3JN" => "3John",
	"3JO" => "3John",
	"3JOHN" => "3John",
	"3KGDMS" => "1Kgs",
	"3KGS" => "1Kgs",
	"3KINGDOMS" => "1Kgs",
	"3KINGS" => "1Kgs",
	"3MA" => "3Macc",
	"3MACC" => "3Macc",
	"3MACCABEES" => "3Macc",
	"3MAKABIAN" => "3Meq",
	"3MEQ" => "3Meq",
	"3MEQABYAN" => "3Meq",
	"4 BARUCH" => "4Bar",
	"4 EZRA" => "2Esd",
	"4 KGDMS" => "2Kgs",
	"4 KGS" => "2Kgs",
	"4 KINGDOMS" => "2Kgs",
	"4 KINGS" => "2Kgs",
	"4 MACCABEES" => "4Macc",
	"4BAR" => "4Bar",
	"4BARUCH" => "4Bar",
	"4EZRA" => "2Esd",
	"4KGDMS" => "2Kgs",
	"4KGS" => "2Kgs",
	"4KINGDOMS" => "2Kgs",
	"4KINGS" => "2Kgs",
	"4MA" => "4Macc",
	"4MACC" => "4Macc",
	"4MACCABEES" => "4Macc",
	"5APOCSYRPSS" => "AddPs",
	"AC" => "Acts",
	"ACT" => "Acts",
	"ACTS" => "Acts",
	"ADDDAN" => "AddDan",
	"ADDESTH" => "AddEsth",
	"ADDITIONAL PSALM" => "AddPs",
	"ADDITIONS TO DANIEL" => "AddDan",
	"ADDITIONS TO ESTHER" => "AddEsth",
	"ADDPS" => "AddPs",
	"AM" => "Amos",
	"AMO" => "Amos",
	"AMOS" => "Amos",
	"APOCALYPSE OF JOHN" => "Rev",
	"AZA" => "PrAzar",
	"AZAR" => "PrAzar",
	"AZARIAH" => "PrAzar",
	"BAR" => "Bar",
	"BARUCH" => "Bar",
	"BEL" => "Bel",
	"BEL AND THE DRAGON" => "Bel",
	"C" => "Col",
	"CANTICLE OF CANTICLES" => "Song",
	"COL" => "Col",
	"COLOSSIANS" => "Col",
	"D" => "Deut",
	"DA" => "Dan",
	"DAN" => "Dan",
	"DANGR" => "DanGr",
	"DANIEL" => "Dan",
	"DANIEL (ADDITIONS)" => "AddDan",
	"DANIEL (GREEK)" => "DanGr",
	"DE" => "Deut",
	"DEU" => "Deut",
	"DEUT" => "Deut",
	"DEUTERONOMY" => "Deut",
	"DT" => "Deut",
	"E" => "Exod",
	"EC" => "Eccl",
	"ECC" => "Eccl",
	"ECCL" => "Eccl",
	"ECCLESIASTES" => "Eccl",
	"ECCLESIASTICUS" => "Sir",
	"ECCLUS" => "Sir",
	"EK" => "Ezek",
	"ENOCH" => "1En",
	"EPH" => "Eph",
	"EPHESIANS" => "Eph",
	"EPISTLE OF JEREMIAH" => "EpJer",
	"EPJ" => "EpJer",
	"EPJER" => "EpJer",
	"EPLAO" => "EpLao",
	"ES" => "Esth",
	"ESDRAS A" => "1Esd",
	"ESDRAS B" => "2Esd",
	"ESDRASA" => "1Esd",
	"ESDRASB" => "2Esd",
	"ESG" => "EsthGr",
	"EST" => "Esth",
	"ESTER" => "Esth",
	"ESTH" => "Esth",
	"ESTHER" => "Esth",
	"ESTHER (ADDITIONS)" => "AddEsth",
	"ESTHER (GREEK)" => "EsthGr",
	"ESTHGR" => "EsthGr",
	"ETHIOPIC APOCALYPSE OF ENOCH" => "1En",
	"EX" => "Exod",
	"EXO" => "Exod",
	"EXOD" => "Exod",
	"EXODUS" => "Exod",
	"EZE" => "Ezek",
	"EZEK" => "Ezek",
	"EZEKIEL" => "Ezek",
	"EZK" => "Ezek",
	"EZR" => "Ezra",
	"EZRA" => "Ezra",
	"FIVE APOCRYPHAL SYRIAC PSALMS" => "AddPs",
	"G" => "Gen",
	"GA" => "Gal",
	"GAL" => "Gal",
	"GALATIANS" => "Gal",
	"GE" => "Gen",
	"GEN" => "Gen",
	"GENESIS" => "Gen",
	"GN" => "Gen",
	"GRDAN" => "DanGr",
	"GREEK DANIEL" => "DanGr",
	"GREEK ESTHER" => "EsthGr",
	"GRESTH" => "EsthGr",
	"H" => "Heb",
	"HAB" => "Hab",
	"HABAKKUK" => "Hab",
	"HAG" => "Hag",
	"HAGGAI" => "Hag",
	"HEB" => "Heb",
	"HEBREWS" => "Heb",
	"HO" => "Hos",
	"HOS" => "Hos",
	"HOSEA" => "Hos",
	"I" => "Isa",
	"I BARUCH" => "Bar",
	"I C" => "1Cor",
	"I CHRONICLES" => "1Chr",
	"I CORINTHIANS" => "1Cor",
	"I E" => "1Esd",
	"I ENOCH" => "1En",
	"I ESDRAS" => "1Esd",
	"I JN" => "1John",
	"I JOHN" => "1John",
	"I K" => "1Kgs",
	"I KGDMS" => "1Sam",
	"I KGS" => "1Kgs",
	"I KING" => "1Kgs",
	"I KINGDOMS" => "1Sam",
	"I KINGS" => "1Kgs",
	"I MACCABEES" => "1Macc",
	"I MAKABIAN" => "1Meq",
	"I MEQABYAN" => "1Meq",
	"I P" => "1Pet",
	"I PARALIPOMENON" => "1Chr",
	"I PETER" => "1Pet",
	"I PTR" => "1Pet",
	"I SAMUEL" => "1Sam",
	"I THESSALONIANS" => "1Thess",
	"I TIMOTHY" => "1Tim",
	"IBARUCH" => "Bar",
	"IC" => "1Cor",
	"ICHRONICLES" => "1Chr",
	"ICORINTHIANS" => "1Cor",
	"IE" => "1Esd",
	"IENOCH" => "1En",
	"IESDRAS" => "1Esd",
	"II BARUCH" => "2Bar",
	"II C" => "2Cor",
	"II CHRONICLES" => "2Chr",
	"II CORINTHIANS" => "2Cor",
	"II E" => "2Esd",
	"II ESDRAS" => "2Esd",
	"II JN" => "2John",
	"II JOHN" => "2John",
	"II K" => "2Kgs",
	"II KGDMS" => "2Sam",
	"II KGS" => "2Kgs",
	"II KING" => "2Kgs",
	"II KINGDOMS" => "2Sam",
	"II KINGS" => "2Kgs",
	"II MACCABEES" => "2Macc",
	"II MAKABIAN" => "2Meq",
	"II MEQABYAN" => "2Meq",
	"II P" => "2Pet",
	"II PARALIPOMENON" => "2Chr",
	"II PETER" => "2Pet",
	"II PTR" => "2Pet",
	"II SAMUEL" => "2Sam",
	"II THESSALONIANS" => "2Thess",
	"II TIMOTHY" => "2Tim",
	"IIBARUCH" => "2Bar",
	"IIC" => "2Cor",
	"IICHRONICLES" => "2Chr",
	"IICORINTHIANS" => "2Cor",
	"IIE" => "2Esd",
	"IIESDRAS" => "2Esd",
	"III EZRA" => "1Esd",
	"III JN" => "3John",
	"III JOHN" => "3John",
	"III KGDMS" => "1Kgs",
	"III KGS" => "1Kgs",
	"III KINGDOMS" => "1Kgs",
	"III KINGS" => "1Kgs",
	"III MACCABEES" => "3Macc",
	"III MAKABIAN" => "3Meq",
	"III MEQABYAN" => "3Meq",
	"IIIEZRA" => "1Esd",
	"IIIJN" => "3John",
	"IIIJOHN" => "3John",
	"IIIKGDMS" => "1Kgs",
	"IIIKGS" => "1Kgs",
	"IIIKINGDOMS" => "1Kgs",
	"IIIKINGS" => "1Kgs",
	"IIIMACCABEES" => "3Macc",
	"IIIMAKABIAN" => "3Meq",
	"IIIMEQABYAN" => "3Meq",
	"IIJN" => "2John",
	"IIJOHN" => "2John",
	"IIK" => "2Kgs",
	"IIKGDMS" => "2Sam",
	"IIKGS" => "2Kgs",
	"IIKING" => "2Kgs",
	"IIKINGDOMS" => "2Sam",
	"IIKINGS" => "2Kgs",
	"IIMACCABEES" => "2Macc",
	"IIMAKABIAN" => "2Meq",
	"IIMEQABYAN" => "2Meq",
	"IIP" => "2Pet",
	"IIPARALIPOMENON" => "2Chr",
	"IIPETER" => "2Pet",
	"IIPTR" => "2Pet",
	"IISAMUEL" => "2Sam",
	"IITHESSALONIANS" => "2Thess",
	"IITIMOTHY" => "2Tim",
	"IJN" => "1John",
	"IJOHN" => "1John",
	"IK" => "1Kgs",
	"IKGDMS" => "1Sam",
	"IKGS" => "1Kgs",
	"IKING" => "1Kgs",
	"IKINGDOMS" => "1Sam",
	"IKINGS" => "1Kgs",
	"IMACCABEES" => "1Macc",
	"IMAKABIAN" => "1Meq",
	"IMEQABYAN" => "1Meq",
	"IP" => "1Pet",
	"IPARALIPOMENON" => "1Chr",
	"IPETER" => "1Pet",
	"IPTR" => "1Pet",
	"ISA" => "Isa",
	"ISAIAH" => "Isa",
	"ISAMUEL" => "1Sam",
	"ITHESSALONIANS" => "1Thess",
	"ITIMOTHY" => "1Tim",
	"IV BARUCH" => "4Bar",
	"IV EZRA" => "2Esd",
	"IV KGDMS" => "2Kgs",
	"IV KGS" => "2Kgs",
	"IV KINGDOMS" => "2Kgs",
	"IV KINGS" => "2Kgs",
	"IV MACCABEES" => "4Macc",
	"IVBARUCH" => "4Bar",
	"IVEZRA" => "2Esd",
	"IVKGDMS" => "2Kgs",
	"IVKGS" => "2Kgs",
	"IVKINGDOMS" => "2Kgs",
	"IVKINGS" => "2Kgs",
	"IVMACCABEES" => "4Macc",
	"J" => "Josh",
	"JAM" => "Jas",
	"JAMES" => "Jas",
	"JAS" => "Jas",
	"JB" => "Job",
	"JD" => "Judg",
	"JDG" => "Judg",
	"JDGS" => "Judg",
	"JDT" => "Jdt",
	"JER" => "Jer",
	"JEREMIAH" => "Jer",
	"JG" => "Judg",
	"JHN" => "John",
	"JN" => "John",
	"JO" => "John",
	"JOB" => "Job",
	"JOE" => "Joel",
	"JOEL" => "Joel",
	"JOH" => "John",
	"JOHN" => "John",
	"JOL" => "Joel",
	"JON" => "Jonah",
	"JONAH" => "Jonah",
	"JOS" => "Josh",
	"JOSH" => "Josh",
	"JOSHUA" => "Josh",
	"JS" => "Josh",
	"JU" => "Jude",
	"JUB" => "Jub",
	"JUBILEES" => "Jub",
	"JUD" => "Jude",
	"JUDE" => "Jude",
	"JUDG" => "Judg",
	"JUDGES" => "Judg",
	"JUDITH" => "Jdt",
	"L" => "Luke",
	"LA" => "Lam",
	"LAM" => "Lam",
	"LAMENTATIONS" => "Lam",
	"LAO" => "EpLao",
	"LAODICEANS" => "EpLao",
	"LE" => "Lev",
	"LETJER" => "EpJer",
	"LETTER OF JEREMIAH" => "EpJer",
	"LEV" => "Lev",
	"LEVITICUS" => "Lev",
	"LK" => "Luke",
	"LU" => "Luke",
	"LUK" => "Luke",
	"LUKE" => "Luke",
	"LV" => "Lev",
	"MA" => "Matt",
	"MAL" => "Mal",
	"MALACHI" => "Mal",
	"MAN" => "PrMan",
	"MANASSEH" => "PrMan",
	"MANASSES" => "PrMan",
	"MAR" => "Mark",
	"MARK" => "Mark",
	"MAT" => "Matt",
	"MATT" => "Matt",
	"MATTHEW" => "Matt",
	"MIC" => "Mic",
	"MICAH" => "Mic",
	"MK" => "Mark",
	"MR" => "Mark",
	"MRK" => "Mark",
	"MT" => "Matt",
	"N" => "Num",
	"NA" => "Nah",
	"NAH" => "Nah",
	"NAHUM" => "Nah",
	"NAM" => "Nah",
	"NE" => "Neh",
	"NEH" => "Neh",
	"NEHEMIAH" => "Neh",
	"NM" => "Num",
	"NU" => "Num",
	"NUM" => "Num",
	"NUMBERS" => "Num",
	"OB" => "Obad",
	"OBA" => "Obad",
	"OBAD" => "Obad",
	"OBADIAH" => "Obad",
	"ODE" => "Odes",
	"ODES" => "Odes",
	"P" => "Ps",
	"PARALEIPOMENA JEREMIOU" => "4Bar",
	"PARALIPOMENA OF JEREMIAH" => "4Bar",
	"PHI" => "Phil",
	"PHIL" => "Phil",
	"PHILEMON" => "Phlm",
	"PHILIPPIANS" => "Phil",
	"PHLM" => "Phlm",
	"PHM" => "Phlm",
	"PHP" => "Phil",
	"PR" => "Prov",
	"PRA" => "PrAzar",
	"PRAYER OF AZARIAH" => "PrAzar",
	"PRAYER OF MANASSEH" => "PrMan",
	"PRAYER OF MANASSES" => "PrMan",
	"PRAZAR" => "PrAzar",
	"PRM" => "PrMan",
	"PRMAN" => "PrMan",
	"PRO" => "Prov",
	"PROV" => "Prov",
	"PROVERBS" => "Prov",
	"PS" => "Ps",
	"PS 151" => "AddPs",
	"PS151" => "AddPs",
	"PSA" => "Ps",
	"PSALM" => "Ps",
	"PSALM 151" => "AddPs",
	"PSALM151" => "AddPs",
	"PSALMS" => "Ps",
	"PSALMS OF SOLOMON" => "PssSol",
	"PSM" => "Ps",
	"PSS" => "Ps",
	"PSSSOL" => "PssSol",
	"QOHELET" => "Eccl",
	"QOHELETH" => "Eccl",
	"RE" => "Rev",
	"REV" => "Rev",
	"REVELATION" => "Rev",
	"REVELATION OF JOHN" => "Rev",
	"RO" => "Rom",
	"ROM" => "Rom",
	"ROMANS" => "Rom",
	"RU" => "Ruth",
	"RUT" => "Ruth",
	"RUTH" => "Ruth",
	"S" => "Song",
	"S3Y" => "PrAzar",
	"SI" => "Sir",
	"SIP" => "SirP",
	"SIR" => "Sir",
	"SIRACH" => "Sir",
	"SIRACH (PROLOGUE)" => "SirP",
	"SIRP" => "SirP",
	"SNG" => "Song",
	"SOL" => "Song",
	"SOLOMON" => "Song",
	"SONG" => "Song",
	"SONG OF SOLOMON" => "Song",
	"SONG OF SONGS" => "Song",
	"SONG OF THE THREE CHILDREN" => "PrAzar",
	"SUS" => "Sus",
	"SUSANNA" => "Sus",
	"SYRIAC APOCALYPSE OF BARUCH" => "2Bar",
	"T" => "Titus",
	"TB" => "Tob",
	"TBT" => "Tob",
	"TIT" => "Titus",
	"TITUS" => "Titus",
	"TOB" => "Tob",
	"TOBIT" => "Tob",
	"WIS" => "Wis",
	"WISDOM" => "Wis",
	"WISDOM OF BEN SIRA" => "Sir",
	"WISDOM OF JESUS SON OF SIRACH" => "Sir",
	"WISDOM OF SOLOMON" => "Wis",
	"ZEC" => "Zech",
	"ZECH" => "Zech",
	"ZECHARIAH" => "Zech",
	"ZEP" => "Zeph",
	"ZEPH" => "Zeph",
	"ZEPHANIAH" => "Zeph",
    );



if (scalar(@ARGV) < 2) {
    print "imp2osis.pl -- IMP (Sword Import) format to OSIS $osisVersion converter version $version\nRevision $rev ($date)\nSyntax: imp2osis.pl <osisWork> <input filename> [-o OSIS-file] [-m]\n\nThe -m option will produce milestoned <verse\/> elements, which are more likely to produce valid OSIS from Bibles with OSIS markup internally.\n\nNo attempt is made to convert markup present in the verse entries themselves, so this tool is appropriate for converting Bibles that already contain OSIS markup or plaintext markup.\n\nThis tool is ONLY intended for VersKey-type Sword texts, namely Bibles and commentaries.\n";
    exit (-1);
}

$osisWork = $ARGV[0];

$nextarg = 2;

if ($ARGV[$nextarg] eq "-o") {
    $outputFilename = "$ARGV[$nextarg+1]";
    $nextarg += 2;
}
else {
    $outputFilename = "$osisWork.osis.xml";
}

$milestone = 0;
if ($ARGV[$nextarg] eq "-m") {
    $milestone = 1;
}

open (OUTF, ">$outputFilename") or die "Could not open file $ARGV[2] for writing.";

print OUTF "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<osis xmlns=\"http://www.bibletechnologies.net/2003/OSIS/namespace\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"http://www.bibletechnologies.net/2003/OSIS/namespace http://www.bibletechnologies.net/osisCore.$osisVersion.xsd\">\n<osisText osisRefWork=\"Bible\" xml:lang=\"en\" osisIDWork=\"$osisWork\">\n<header>\n<work osisWork=\"$osisWork\"\/>\n<\/header>\n";

open (INF, $ARGV[1]);

$book = "";
$chap = 0;
$vers = 0;

sub closeVers {
    if ($openVers == 1) {
	if ($milestone == 0) {
	    print OUTF "<\/verse>\n";
	}
	else {
	    print OUTF "<verse eID=\"$lastosisID\"\/>\n";
	}
    }
    $openVers = 0;
}

sub closeChap {
    if ($openChap == 1) {
	print OUTF "<\/chapter>\n";
    }
    $openChap = 0;
}
sub closeBook {
    if ($openBook == 1) {
	print OUTF "<\/div>\n";
    }
    $openBook = 0;
}

while (<INF>) {
    $line = $_;
    
    #revert old v11n hack
    while ($line =~ /(.+?)\[ \(([^)]+)\) (.+?) \](.*)/) {
	push @datab, $1;
	push @datab, "\$\$\$$2";
	$line = "$3$4";
    }

    push @datab, $line;
}

foreach $line (@datab) {

    $line =~ s/\s+$//;

    if ($line =~ /^\$\$\$(.+)/) {
	$key = $1;
	$line = "";
	$lastosisID = $osisID;
	$lastBook = $book;
	$lastChap = $chap;
	$lastVers = $vers;
	$osisID = "";

	if ($key =~ /^(.+?) (\d+):(\d+)/) {
	    $book = $OSISbook{uc($1)};
	    $chap = $2;
	    $vers = $3;
	    if ($vers > 0) {
		$osisID = "$book.$chap.$vers";
	    }

	    if ($book ne $lastBook) {
		closeVers();
		closeChap();
		closeBook();
		
		print OUTF "<div type=\"book\" osisID=\"$book\">\n";
		$openBook = 1;

		$lastChap = -1;
		$lastVers = -1;
	    }
	    if ($chap ne $lastChap && $chap > 0) {
		closeVers();
		if ($lastChap > 0) {
		    closeChap();
		}
		print OUTF "<chapter osisID=\"$book.$chap\">\n";
		$openChap = 1;

		$lastVers = -1;
	    }
	    
	    if ($vers ne $lastVers && $vers > 0) {
		if ($lastVers > 0) {
		    closeVers();
		}

		if ($milestone == 0) {
		    print OUTF "<verse osisID=\"$osisID\">\n";
		}
		else {
		    print OUTF "<verse osisID=\"$osisID\" sID=\"$osisID\"\/>\n";
		}
		$openVers = 1;
	    }
	}
	elsif ($key eq "\[ Module Heading \]") {
	    #do nothing
	}
	elsif ($key eq "\[ Testament 1 Heading \]") {
	    print OUTF "<div type=\"bookGroup\">\n";
	    $openTestament = 1;
	}
	elsif ($key eq "\[ Testament 2 Heading \]") {
	    closeVers();
	    closeChap();
	    closeBook();
	    
	    if ($openTestament == 1) {
		print OUTF "<\/div>\n"; # close OT (bookGroup)
	    }
	    print OUTF "<div type=\"bookGroup\">\n";
	    $openTestament = 1;
	}
	
    }
    elsif ($line !~ /^\s*$/) {
	print OUTF "$line\n";
    }
}

closeVers();
closeChap();
closeBook();
if ($openTestament == 1) {
    print OUTF "<\/div>\n"; # close NT (bookGroup)
}
print OUTF "<\/osisText>\n";
print OUTF "<\/osis>\n";

close (OUTF);
close (INF);
