package Intern::Diary::Engine::User::Entries;
use strict;
use warnings;

use JSON qw/encode_json decode_json/;
use FindBin;
use lib "$FindBin::Bin/../lib", glob "$FindBin::Bin/../modules/*/lib";
use Intern::Diary::Engine -Base;
use Data::Dumper;
use Text::Hatena::Escaped;

use Intern::Diary::MoCo qw(moco);

sub default : Public {
    my ($self, $r) = @_;

    my $logined_user = $r->user;
    my $user = moco('User')->retrieve_by_name($r->req->uri->param('name'));
    if(!$user){
#        $r->res->content("ご指定のユーザは存在しません。");
#        $r->res->status(404);
        $r->res->redirect('/all');
        return;
    }
    my $page = $r->req->param('page') || 1;
    #ページ内エントリ数
    my $limit = 5;

    #エントリ一覧を取得
    my $entries = $user->get_entries($page, $limit);
    
    $entries->each(sub{
        $_->{body} = Text::Hatena::Escaped->parse($_->{body});
        $_->{body} =~ s#</?div.*?>.*?\n##gi;
    });
    
    #エントリ一覧をビューに渡す
    $r->stash->param(
        logined_user => $logined_user,
        user => $user,
        entries => $entries,
        page =>$page,
        before_page =>$page-1,
        next_page =>$page+1,
        limit => $limit,
    );
    warn Dumper $entries;
}

sub get_more_entry : Public {
    my ($self, $r) = @_;
    $r->follow_method;
}

sub _get_more_entry_get {
    my ($self, $r) = @_;
    my $page = $r->req->param('page');
    $r->res->content($page);  
    
    my $user = $r->user;

    #ページ内エントリ数
    my $limit = 5;

    #エントリ一覧を取得
    my $entries = $user->get_entries($page, $limit);

    my $entries_json = [];
    for my $entry (@$entries){
        my $entry_json = {
            id => $entry->id,
            title => $entry->title,
            body => $entry->body,
            author_id => $entry->author_id,
            createdTime => $entry->createdTime->ymd,
        };
        push @$entries_json, $entry_json;
    }

    my $json = {
        entries => $entries_json
    };

    my $json_out = encode_json($json);
    $r->res->content($json_out);
    $r->res->content_type("text/plain");
}

sub logout : Public{
    my $self = shift;
    my $r = shift;
    $r->req->session->{hatenaoauth_user_info} = undef;
}

1;
