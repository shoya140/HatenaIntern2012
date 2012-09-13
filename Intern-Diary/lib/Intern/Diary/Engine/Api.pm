package Intern::Diary::Engine::Api;
use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/../lib", glob "$FindBin::Bin/../modules/*/lib";
use Intern::Diary::Engine -Base;
use Intern::Diary::MoCo qw(moco);
use Data::Dumper;

sub post_item_to_db : Public {
    my ($self, $r) = @_;
    $r->follow_method;
}

sub _post_item_to_db_get{
}

sub _post_item_to_db_post{
    my ($self, $r) = @_;
    my $logined_user = $r->user;
    my $item = $r->req->param('item');
    $r->user->add_to_board(
        logined_user_name =>$logined_user->{name},
        item_id => $item
    );

$r->res->content("success!");
}

sub delete_item_from_db : Public{
    my ($self, $r) = @_;
    $r->follow_method;
}

sub _delete_item_from_db_get {
}

sub _delete_item_from_db_post {
    my ($self, $r) = @_;
    my $logined_user = $r->user;
    my $item = $r->req->param('item');
    $r->user->delete_from_board(
        logined_user_name => $logined_user->{name},
        item_id => $item,
    );
    $r->res->content("success!");
}
1;
