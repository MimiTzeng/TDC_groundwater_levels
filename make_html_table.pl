#!/usr/bin/perl
use strict;
use warnings;
use List::Util qw(min max sum);
use Time::Piece;

my $filename = "groundwater-level_website-all_hydro-dump.txt";
my $today = localtime -> Time::Piece -> strftime('%Y%m%d');
my $hydrotel_update = "Site Name,Minimum,Maximum,Average\n";

open my $file, '<', "$filename" or die ("cant open file: $!");
my $text;
while(defined(my $line = <$file>)) {
      chomp($line);  #cleans off any whitespaces and newlines
      $text .= "$line\n";
}
close $file;

my @site_split = split /Source is /, $text;
shift @site_split; #gets rid of the top header info about Hilltop Hydro

foreach my $site (@site_split) {
      my @header_split = split /Year  Month    Minimum         Mean      Maximum\n/, $site; #split header and data

      #get sitename from header
      my $namestart = index $header_split[0], "(mm) at";
      my $sitename = substr $header_split[0], $namestart + 9;

      #splits each data line
      my @dataline_split = split /\n/, $header_split[1];
      #invoke all the min/max/mean arrays
      my (@JanMin, @JanMax, @JanMean, @FebMin, @FebMax, @FebMean, @MarMin, @MarMax, @MarMean, @AprMin, @AprMax, @AprMean,
          @MayMin, @MayMax, @MayMean, @JunMin, @JunMax, @JunMean, @JulMin, @JulMax, @JulMean, @AugMin, @AugMax, @AugMean,
          @SepMin, @SepMax, @SepMean, @OctMin, @OctMax, @OctMean, @NovMin, @NovMax, @NovMean, @DecMin, @DecMax, @DecMean,
          @AllMin, @AllMax, @AllMean);
      #populate the min/max/mean arrays
      foreach my $dataline (@dataline_split) {
            my @data_split = split / +/, $dataline;
            my $year = $data_split[0]; my $month = $data_split[1]; 
            my $min = $data_split[2]; my $mean = $data_split[3]; my $max = $data_split[4];
            if ($min*1 eq $min && $max*1 eq $max && $mean*1 eq $mean) { #check that they're numbers and not errors
                  if ($month == 1) {push @JanMin, $min; push @JanMax, $max; push @JanMean, $mean;}
                  if ($month == 2) {push @FebMin, $min; push @FebMax, $max; push @FebMean, $mean;}
                  if ($month == 3) {push @MarMin, $min; push @MarMax, $max; push @MarMean, $mean;}
                  if ($month == 4) {push @AprMin, $min; push @AprMax, $max; push @AprMean, $mean;}
                  if ($month == 5) {push @MayMin, $min; push @MayMax, $max; push @MayMean, $mean;}
                  if ($month == 6) {push @JunMin, $min; push @JunMax, $max; push @JunMean, $mean;}
                  if ($month == 7) {push @JulMin, $min; push @JulMax, $max; push @JulMean, $mean;}
                  if ($month == 8) {push @AugMin, $min; push @AugMax, $max; push @AugMean, $mean;}
                  if ($month == 9) {push @SepMin, $min; push @SepMax, $max; push @SepMean, $mean;}
                  if ($month == 10) {push @OctMin, $min; push @OctMax, $max; push @OctMean, $mean;}
                  if ($month == 11) {push @NovMin, $min; push @NovMax, $max; push @NovMean, $mean;}
                  if ($month == 12) {push @DecMin, $min; push @DecMax, $max; push @DecMean, $mean;}
                  push @AllMin, $min; push @AllMax, $max; push @AllMean, $mean;
            }
      }
      #get monthly and total min/max/means
      if (scalar @JanMean > 0) { my $JanMinMin = min @JanMin; my $JanMaxMax = max @JanMax; my $JanMeanMean = (sum @JanMean)/(scalar @JanMean); }
      if (scalar @FebMean > 0) { my $FebMinMin = min @FebMin; my $FebMaxMax = max @FebMax; my $FebMeanMean = (sum @FebMean)/(scalar @FebMean); }
      if (scalar @MarMean > 0) { my $MarMinMin = min @MarMin; my $MarMaxMax = max @MarMax; my $MarMeanMean = (sum @MarMean)/(scalar @MarMean); }
      if (scalar @AprMean > 0) { my $AprMinMin = min @AprMin; my $AprMaxMax = max @AprMax; my $AprMeanMean = (sum @AprMean)/(scalar @AprMean); }
      if (scalar @MayMean > 0) { my $MayMinMin = min @MayMin; my $MayMaxMax = max @MayMax; my $MayMeanMean = (sum @MayMean)/(scalar @MayMean); }
      if (scalar @JunMean > 0) { my $JunMinMin = min @JunMin; my $JunMaxMax = max @JunMax; my $JunMeanMean = (sum @JunMean)/(scalar @JunMean); }
      if (scalar @JulMean > 0) { my $JulMinMin = min @JulMin; my $JulMaxMax = max @JulMax; my $JulMeanMean = (sum @JulMean)/(scalar @JulMean); }
      if (scalar @AugMean > 0) { my $AugMinMin = min @AugMin; my $AugMaxMax = max @AugMax; my $AugMeanMean = (sum @AugMean)/(scalar @AugMean); }
      if (scalar @SepMean > 0) { my $SepMinMin = min @SepMin; my $SepMaxMax = max @SepMax; my $SepMeanMean = (sum @SepMean)/(scalar @SepMean); }
      if (scalar @OctMean > 0) { my $OctMinMin = min @OctMin; my $OctMaxMax = max @OctMax; my $OctMeanMean = (sum @OctMean)/(scalar @OctMean); }
      if (scalar @NovMean > 0) { my $NovMinMin = min @NovMin; my $NovMaxMax = max @NovMax; my $NovMeanMean = (sum @NovMean)/(scalar @NovMean); }
      if (scalar @DecMean > 0) { my $DecMinMin = min @DecMin; my $DecMaxMax = max @DecMax; my $DecMeanMean = (sum @DecMean)/(scalar @DecMean); }
      my $AllMinMin = min @AllMin; my $AllMaxMax = max @AllMax; my $AllMeanMean = (sum @AllMean)/(scalar @AllMean);

      #get years of each monthly min/max
      foreach my $dataline (@dataline_split) {
            my @data_split = split / +/, $dataline;
            my $year = $data_split[0]; my $month = $data_split[1]; 
            my $min = $data_split[2]; my $mean = $data_split[3]; my $max = $data_split[4];
            if ($month == 1 && $min == $JanMinMin) { my $YearMinJan == $year; last; }
            if ($month == 1 && $max == $JanMaxMax) { my $YearMaxJan == $year; last; }
            if ($month == 2 && $min == $FebMinMin) { my $YearMinFeb == $year; last; }
            if ($month == 2 && $max == $FebMaxMax) { my $YearMaxFeb == $year; last; }
            if ($month == 3 && $min == $MarMinMin) { my $YearMinMar == $year; last; }
            if ($month == 3 && $max == $MarMaxMax) { my $YearMaxMar == $year; last; }
            if ($month == 4 && $min == $AprMinMin) { my $YearMinApr == $year; last; }
            if ($month == 4 && $max == $AprMaxMax) { my $YearMaxApr == $year; last; }
            if ($month == 5 && $min == $MayMinMin) { my $YearMinMay == $year; last; }
            if ($month == 5 && $max == $MayMaxMax) { my $YearMaxMay == $year; last; }
            if ($month == 6 && $min == $JunMinMin) { my $YearMinJun == $year; last; }
            if ($month == 6 && $max == $JunMaxMax) { my $YearMaxJun == $year; last; }
            if ($month == 7 && $min == $JulMinMin) { my $YearMinJul == $year; last; }
            if ($month == 7 && $max == $JulMaxMax) { my $YearMaxJul == $year; last; }
            if ($month == 8 && $min == $AugMinMin) { my $YearMinAug == $year; last; }
            if ($month == 8 && $max == $AugMaxMax) { my $YearMaxAug == $year; last; }
            if ($month == 9 && $min == $SepMinMin) { my $YearMinSep == $year; last; }
            if ($month == 9 && $max == $SepMaxMax) { my $YearMaxSep == $year; last; }
            if ($month == 10 && $min == $OctMinMin) { my $YearMinOct == $year; last; }
            if ($month == 10 && $max == $OctMaxMax) { my $YearMaxOct == $year; last; }
            if ($month == 11 && $min == $NovMinMin) { my $YearMinNov == $year; last; }
            if ($month == 11 && $max == $NovMaxMax) { my $YearMaxNov == $year; last; }
            if ($month == 12 && $min == $DecMinMin) { my $YearMinDec == $year; last; }
            if ($month == 12 && $max == $DecMaxMax) { my $YearMaxDec == $year; last; }
      }

      my $startyear = substr $dataline_split[0], 0, 4;
      my $startmonth = substr $dataline_split[0], 6, 2;
      my $lastline = scalar @dataline_split;
      my $endyear = substr $dataline_split[$lastline-1], 0, 4;
      my $endmonth =  substr $dataline_split[$lastline-1], 6, 2;

      # make html table
      my $table = "<P><strong>Period of analysis:</strong> $startmonth $startyear to $endmonth $endyear</P>\n
<table width=\"831\"><tbody>\n
<tr><td width=\"63\">&nbsp;</td>\n
<td style=\"text-align: center;\" colspan=\"12\" width=\"768\"><strong>Month</strong></td></tr>\n
<tr><td width=\"63\">&nbsp;</td>\n
<td width=\"64\"><strong>Jan</strong></td>\n
<td width=\"64\"><strong>Feb</strong></td>\n
<td width=\"64\"><strong>Mar</strong></td>\n
<td width=\"64\"><strong>Apr</strong></td>\n
<td width=\"64\"><strong>May</strong></td>\n
<td width=\"64\"><strong>Jun</strong></td>\n
<td width=\"64\"><strong>Jul</strong></td>\n
<td width=\"64\"><strong>Aug</strong></td>\n
<td width=\"64\"><strong>Sep</strong></td>\n
<td width=\"64\"><strong>Oct</strong></td>\n
<td width=\"64\"><strong>Nov</strong></td>\n
<td width=\"64\"><strong>Dec</strong></td></tr>\n
<tr><td width=\"63\">Min level (m)</td>\n
<td width=\"64\">$JanMinMin</td>\n
<td width=\"64\">$FebMinMin</td>\n
<td width=\"64\">$MarMinMin</td>\n
<td width=\"64\">$AprMinMin</td>\n
<td width=\"64\">$MayMinMin</td>\n
<td width=\"64\">$JunMinMin</td>\n
<td width=\"64\">$JulMinMin</td>\n
<td width=\"64\">$AugMinMin</td>\n
<td width=\"64\">$SepMinMin</td>\n
<td width=\"64\">$OctMinMin</td>\n
<td width=\"64\">$NovMinMin</td>\n
<td width=\"64\">$DecMinMin</td></tr>\n
<tr><td width=\"63\">Year it occurred</td>\n
<td width=\"64\">$YearMinJan</td>\n
<td width=\"64\">$YearMinFeb</td>\n
<td width=\"64\">$YearMinMar</td>\n
<td width=\"64\">$YearMinApr</td>\n
<td width=\"64\">$YearMinMay</td>\n
<td width=\"64\">$YearMinJun</td>\n
<td width=\"64\">$YearMinJul</td>\n
<td width=\"64\">$YearMinAug</td>\n
<td width=\"64\">$YearMinSep</td>\n
<td width=\"64\">$YearMinOct</td>\n
<td width=\"64\">$YearMinNov</td>\n
<td width=\"64\">$YearMinDec</td></tr>\n
<tr><td width=\"63\">Max level (m)</td>\n
<td width=\"64\">$JanMaxMax</td>\n
<td width=\"64\">$FebMaxMax</td>\n
<td width=\"64\">$MarMaxMax</td>\n
<td width=\"64\">$AprMaxMax</td>\n
<td width=\"64\">$MayMaxMax</td>\n
<td width=\"64\">$JunMaxMax</td>\n
<td width=\"64\">$JulMaxMax</td>\n
<td width=\"64\">$AugMaxMax</td>\n
<td width=\"64\">$SepMaxMax</td>\n
<td width=\"64\">$OctMaxMax</td>\n
<td width=\"64\">$NovMaxMax</td>\n
<td width=\"64\">$DecMaxMax</td></tr>\n
<tr><td width=\"63\">Year it occurred</td>\n
<td width=\"64\">$YearMaxJan</td>\n
<td width=\"64\">$YearMaxFeb</td>\n
<td width=\"64\">$YearMaxMar</td>\n
<td width=\"64\">$YearMaxApr</td>\n
<td width=\"64\">$YearMaxMay</td>\n
<td width=\"64\">$YearMaxJun</td>\n
<td width=\"64\">$YearMaxJul</td>\n
<td width=\"64\">$YearMaxAug</td>\n
<td width=\"64\">$YearMaxSep</td>\n
<td width=\"64\">$YearMaxOct</td>\n
<td width=\"64\">$YearMaxNov</td>\n
<td width=\"64\">$YearMaxDec</td></tr>\n
<tr><td width=\"63\">Average</td>\n
<td width=\"64\">$JanMeanMean</td>\n
<td width=\"64\">$FebMeanMean</td>\n
<td width=\"64\">$MarMeanMean</td>\n
<td width=\"64\">$AprMeanMean</td>\n
<td width=\"64\">$MayMeanMean</td>\n
<td width=\"64\">$JunMeanMean</td>\n
<td width=\"64\">$JulMeanMean</td>\n
<td width=\"64\">$AugMeanMean</td>\n
<td width=\"64\">$SepMeanMean</td>\n
<td width=\"64\">$OctMeanMean</td>\n
<td width=\"64\">$NovMeanMean</td>\n
<td width=\"64\">$DecMeanMean</td></tr>\n
</tbody></table>\n";

# output table to html file
open my $sitedata, '>', "$today\_GroundwaterLevel\_$sitename.html" or die ("cant open data file: $!");
print $sitedata "$table";
close $sitedata;

# hydrotel output
$hydrotel_update .= "$sitename,$AllMinMin,$AllMaxMax,$AllMeanMean\n";

} #closes site loop

# output hydrotel to file
open my $hydrotel_file, '>', "$today\_GroundwaterLevel\_Hydrotel.csv" or die ("cant open data file: $!");
print $hydrotel_file "$hydrotel_update";
close $hydrotel_file;
