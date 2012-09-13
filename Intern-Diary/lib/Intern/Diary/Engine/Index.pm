package Intern::Diary::Engine::Index;
use strict;
use warnings;

use JSON qw/encode_json decode_json/;
use FindBin;
use lib "$FindBin::Bin/../lib", glob "$FindBin::Bin/../modules/*/lib";
use Intern::Diary::Engine -Base;
use Data::Dumper;

use Intern::Diary::MoCo qw(moco);

sub default : Public {
    my ($self, $r) = @_;
    $r->req->session->{hatenaoauth_user_info} = undef;
}
sub logout : Public{
    my ($self, $r) = @_;
    $r->req->session->{hatenaoauth_user_info} = undef;
}

1;
