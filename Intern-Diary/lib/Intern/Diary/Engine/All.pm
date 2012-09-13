package Intern::Diary::Engine::All;
use strict;
use warnings;

use Text::Hatena::Escaped;

use JSON qw/encode_json decode_json/;
use FindBin;
use lib "$FindBin::Bin/../lib", glob "$FindBin::Bin/../modules/*/lib";
use Intern::Diary::Engine -Base;
use Data::Dumper;

use Intern::Diary::MoCo qw(moco);

sub default : Public {
    my ($self, $r) = @_;
    
    my $logined_user = $r->user;
    my $page = $r->req->param('page') || 1;
    #ページ内エントリ数
    my $limit = 5;

    #エントリ一覧を取得
    my $entries = $logined_user->get_all_entries($page, $limit);

    $entries->each(sub{
        $_->{body} = Text::Hatena::Escaped->parse($_->{body});
        $_->{body} =~ s#</?div.*?>.*?\n##gi;
    });

    #エントリ一覧をビューに渡す
    $r->stash->param(
        logined_user => $logined_user,
        entries => $entries,
        page =>$page,
        before_page =>$page-1,
        next_page =>$page+1,
        limit => $limit,
    );
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
    my $entries = $user->get_all_entries($page, $limit);

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


1;
