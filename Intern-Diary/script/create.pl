#!/Users/shoya/perl5/perlbrew/perls/perl-5.14.2/bin/perl
use strict;
use warnings;
use FindBin;
use Path::Class qw/dir/;
use Getopt::Long;
use Pod::Usage;
use Ridge::Helper;

my $help  = 0;
GetOptions('h|help|?' => \$help);

pod2usage(1) if ($help || !$ARGV[0]);

Ridge::Helper->new({
    namespace => 'Intern::Diary',
    root      => dir($FindBin::Bin)->parent,
    argv      => [ @ARGV ],
})->run;

1;

__END__

=head1 NAME

create.pl - Create a new Ridge module.

=head1 SYNOPSIS

create.pl [options] helper [arguments]

 Options:
    -help        display this help and exits

 Examples:
    create.pl engine Hello
    create.pl engine Hello::World
    create.pl test Hello
    create.pl test Hello::World

=head1 DESCRIPTION

Create a new Ridge module / test files.

=head1 AUTHOR

Naoya Ito, C<platform@hatena.ne.jp>

=cut
