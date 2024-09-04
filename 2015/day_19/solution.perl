#! /usr/bin/env perl
my %rule = map { reverse =~ m/(\w*).*\b(\w+)/ } <>;
my $string = delete $rule{""};
my $count = 0; $count++ while ($string =~ s/(@{[ join "|", keys %rule ]})/$rule{$1}/);
print "$count @{[scalar reverse $string]}\n"
