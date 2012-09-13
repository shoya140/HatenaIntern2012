package Intern::Diary::Engine::User::Index;
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

    my $logined_user = $r->user;
    my $user = moco('User')->retrieve_by_name($r->req->uri->param('name'));
    if(!$user){
#        $r->res->content("ご指定のユーザは存在しません。");
#        $r->res->status(404);
        $r->res->redirect('/all');
        return;
    }

    my $edit_flag = "false";
    if($logined_user->{name} eq $user->name){
        $edit_flag = "true";
    }

    #エントリ一覧を取得
    my $entries = $user->get_board($user->name);
    #エントリ一覧をビューに渡す
    $r->stash->param(
        logined_user => $logined_user,
        user => $user,
        entries => $entries,
        edit_flag => $edit_flag,
    );
}

1;
