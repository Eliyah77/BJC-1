#!/usr/bin/perl

use strict;
use warnings;

# lister chaque fichiers tex
my @books = <../tex/bjc/*.tex>;

# parcourir chaque livre listé
foreach my $book (@books) {
    my $chapters = count_chapters($book);
    print($book," : ",$chapters," chapitres\n");
    count_verses($book);
}

# compteur chapitre par livre
sub count_chapters {
    my $book = shift(@_);
    my $chapters = 0;
    
    open(DATA, "< $book") or die("\n/!\\ $book : $! /!\\");
    
    while(my $line = <DATA>) {
        if($line =~ /^\\Chap\{\d{1,3}\}/) {
            $chapters++;
        }
    }
    
    close(DATA);
    
    return($chapters);
}

# compteur versets par chapitre
sub count_verses {
    my $book = shift(@_);
    my $chapter = 0;
    my $verses = 0;
    
    open(DATA, "< $book") or die("\n/!\\ $book : $! /!\\");
    
    while(my $line = <DATA>) {
        if($line =~ /^\\Chap\{\d{1,3}\}/) {
            if($verses != 0) {
                # afficher le compte du chapitre précédent
                print($verses," versets\n");
            }
            $chapter++;
            $verses = 0;
            print("\tChapitre ",$chapter," : ");
        }
        if($line =~ /^\\VerseOne\{\}/) {
            check_verses($verses, 1);
            $verses++;
        } elsif ($line =~ /^\\VS\{(\d{1,3})\}/) {
            check_verses($verses, $1);
            $verses++;
        }
    }
    print($verses," versets\n");
    
    close(DATA);
}

# verifier que les versets se suivent
sub check_verses {
    my $previous_verse = shift(@_);
    my $current_verse = shift(@_);
    
    if($current_verse != $previous_verse+1) {
        print("(verset ",$previous_verse+1," manquant) ");
	# pause
	<STDIN>;
    }
}
