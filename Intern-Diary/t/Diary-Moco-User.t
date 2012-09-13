package t::Diary::MoCo::User;
use strict;
use warnings;
use utf8;

use FindBin;
use lib $FindBin::Bin."/../lib";

use base 'Test::Class';
use Test::More;
use Test::Exception;


use t::Diary;

use Data::Dumper;

sub startup : Test(startup => 3) {
    my $self = shift;
    use_ok 'Intern::Diary::MoCo::User';
    t::Diary->truncate_db;
    ok my $user = Intern::Diary::MoCo::User->create(name => 'test_user_1'), 'create user';
    is_deeply $user->get_entries->to_a, [];
    $self -> {user} = $user;;
}

sub add_entry : Test(2) {

    my $self = shift;
    my $user = $self->{user};

    my $title = "My title";
    my $body = "My body";
    my $non_title = "";

    my $entry = $user->add_entry(title => $title, body => $body);
    isa_ok $entry, 'Intern::Diary::MoCo::Entry';
    is_deeply $user->get_entries->map(sub {$_->title}) ->to_a, [${title}];
}

sub edit_entry : Test(3) {
    my $self = shift;
    my $user = $self->{user};

    my $entry = $user->add_entry(title => "hoge", body => "hogehige");
    my $edited_entry = $user->edit_entry(
        entry_id => $entry->id,
        title => "Edited title",
        body => "Edited body"
    );
    isa_ok $entry, 'Intern::Diary::MoCo::Entry';
    #DBの中身が書き換わっていれば成功
    is $edited_entry->title, "Edited title", 'edited title of a entry';
    is $edited_entry->body, "Edited body", 'edited body of a entry';
}

sub delete_entry : Test(2) {
    my $self = shift;
    my $user = $self->{user};

    my $entry = $user->add_entry(title => "hoge", body => "hogehige");
    isa_ok $entry, 'Intern::Diary::MoCo::Entry';
    my $deleted_entry = $user->delete_entry($entry);
    #値が帰ってこなければ成功
    ok not $user->find(id => $entry->id);   
}



__PACKAGE__->runtests;
