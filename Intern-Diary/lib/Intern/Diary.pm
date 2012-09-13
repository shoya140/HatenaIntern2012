package Intern::Diary;
use strict;
use warnings;
use base qw/Ridge/;

use Data::Dumper;

use Intern::Diary::MoCo;

__PACKAGE__->configure;

sub user {
    my $self = shift;
#    my $user = moco('User')->retrieve_by_name($self->req->session->{hatenaoauth_user_info}->{url_name});
#    my $user = moco('User')->retrieve_by_name("shoya");
    my $hatena_info = $self->req->session->{hatenaoauth_user_info};
    if(!$hatena_info){
        return undef;
    }
    my $user = moco('User')->retrieve_by_name($hatena_info->{url_name}) || moco('User')->create(name => $hatena_info->{url_name}, image_url => $hatena_info->{profile_image_url});
    return $user;
}

1;
