package Intern::Diary::Engine::User::Entry;
use strict;
use warnings;

use Text::Hatena::Escaped;

use FindBin;
use lib "$FindBin::Bin/../lib", glob "$FindBin::Bin/../modules/*/lib";
use Intern::Diary::Engine -Base;

use Intern::Diary::MoCo qw(moco);

use Data::Dumper;

sub default : Public{
    my ($self, $r) = @_;
    my $logined_user = $r->user;
    my $id = $r->req->param('id');
    my $entry = $id ? moco("Entry")->find(id => $id) : undef;
    $entry->{body} = Text::Hatena::Escaped->parse($entry->{body});
    $entry->{body} =~ s#</?div.*?>.*?\n##gi;
    $r->stash->param(
        logined_user => $logined_user,
        entry => $entry
    );
}


sub add : Public {
    my ($self, $r) = @_;
    my $logined_user = $r->user;
    my $id = $r->req->param('id');
    my $entry = $id ? moco("Entry")->find(id => $id) : undef;
    $r->stash->param(
        logined_user => $logined_user,
        entry => $entry
    );
    $r->follow_method;
}

sub _add_get {
}

sub _add_post {
    my ($self, $r) = @_;
    my $logined_user = $r->user;
    my $title = $r->req->param('title');
    my $body = $r->req->param('body');

    my $entry = $r->user->add_entry(
        title => $title,
        body => $body,
    );
    warn Dumper $logined_user;
    $r->res->redirect("/".$logined_user->{name}."/entries");
}

sub delete : Public{
    my ($self, $r) = @_;
    $r->follow_method;
}

sub _delete_get{
    my ($self, $r) = @_;
    my $logined_user = $r->user;
    my $id = $r->req->param('id');
    my $entry = $id ? moco('Entry')->find(id => $id) : undef;
    $entry->{body} = Text::Hatena::Escaped->parse($entry->{body});
    $entry->{body} =~ s#</?div.*?>.*?\n##gi;
    $r->stash->param(
        logined_user => $logined_user,
        entry => $entry
    );
}

sub _delete_post{
    my ($self, $r) = @_;
    my $logined_user = $r->user;
    my $entry_id = $r->req->param('id');
    my $user = $r->user;
    my $entry = moco('Entry')->find(id => $entry_id) or die "id=".$entry_id."に該当するエントリはありません。";
    my $delete = $r->user->delete_entry($entry);
    $r->res->redirect("/".$logined_user->{name}."/entries");
}

1;
