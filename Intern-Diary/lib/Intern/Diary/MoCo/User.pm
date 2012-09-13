package Intern::Diary::MoCo::User;
use strict;
use warnings;

use Intern::Diary::MoCo qw(moco);
use base 'Intern::Diary::MoCo';
use Data::Dumper;
use Carp qw(croak);

__PACKAGE__ -> table('user');

sub get_entries {
    my $self = shift;
    my $page = shift;
    my $limit = shift;
    my $offset = ($page - 1) * $limit;

    return moco('Entry')->search(
        where => {author_name => $self->{name}},
        offset => $offset,
        limit    => $limit,
        order => 'createdTime DESC',
    );
}

sub get_all_entries {
    my $self = shift;
    my $page = shift;
    my $limit = shift;
    my $offset = ($page - 1) * $limit;

    return moco('Entry')->search(
        offset => $offset,
        limit    => $limit,
        order => 'createdTime DESC',
    );
}

#エントリ追加
sub add_entry {
    my($self, %args) = @_; 
    my $title = $args{title};
    my $body = $args{body};
    if($title ne "" && $body ne ""){
        my $entry = moco('Entry')->find(title=>$title);
        if(not $entry){
            $entry = moco('Entry')->create(title=>$title);
        }
        $entry->body($args{body});
        $entry->author_name($self->{name});
        return $entry;
    }else{
#        die("0Character message is refused.");
    }
}

#エントリ削除
sub delete_entry {
    my($self, $entry) = @_;
    my $entry_id = $entry->{id};
    $entry = moco('Entry')->find(id=>$entry_id);
    my $items = moco('Board')->search(where =>{entry_id=>$entry_id});
    warn Dumper $items;
    if($self->{name} == $entry->author_name){
        $entry->delete;
        $items->delete;
    }else{
#        die("権限がありません。");
    }
}

#エントリ編集
sub edit_entry {
    my($self, %args) = @_;
    my $entry_id = $args{entry_id};
    my $title = $args{title};
    my $body = $args{body};
    my $entry = moco('Entry')->find(id=>$entry_id);
    if($self->{name} == $entry->author_name){

        if($title ne ""){
            $entry->title($title);
        }
        if($body ne ""){
            $entry->body($body);
        }
    }else{
#        die("権限がありません。");
    }
    return $entry;
}

#ボードに追加
sub add_to_board {
    my($self, %args) = @_;
    my $logined_user_name = $args{logined_user_name};
    my $entry_id = $args{item_id};
    my $entry = moco('Board')->find(user_name=>$logined_user_name, entry_id => $entry_id);
    if(not $entry){
        $entry = moco('Board')->create(user_name=>$logined_user_name, entry_id=>$entry_id);
    }
    return $entry;
}

#ボードの情報を取得
sub get_board {
    my($self, $user_name) = @_;
    my $items = moco('Board')->search(where=>{user_name => $user_name});
    my $entries = [];
    for(my $i = 0; $i < $items->size; $i++){
        my $entry = moco('Entry')->find(id => $items->[$i]->entry_id);
        push (@$entries, $entry);
    }
    return $entries;
}

#ボードから削除
sub delete_from_board {
    my($self, %args) = @_;
    my $logined_user_name = $args{logined_user_name};
    my $entry_id = $args{item_id};
    warn Dumper $entry_id;
    my $entry = moco('Board')->find(user_name=>$logined_user_name, entry_id => $entry_id);
    if($entry){
        $entry->delete;
    }
}
1;
