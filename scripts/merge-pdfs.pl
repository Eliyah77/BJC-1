#!/usr/bin/perl -w

use warnings;
use CAM::PDF;

# get last arg as output file
$outfile = pop(@ARGV);

# get main pdf file
@main_pdf = grep(!/^pdf\/annexes/, @ARGV);
$main_pdf = CAM::PDF->new($main_pdf[0]);
foreach(1..20) {
	$nb_pages = $main_pdf->numPages();
	$main_pdf->deletePage($nb_pages);
}

# kickstart
$firstpdf = shift(@ARGV);
$pdf = CAM::PDF->new($firstpdf);

# append the reste of the files
foreach $file (@ARGV) {
	$anotherpdf = CAM::PDF->new($file);
	$pdf->appendPDF($anotherpdf);
}

# generate output pdf
$pdf->cleanoutput($outfile);

__END__
