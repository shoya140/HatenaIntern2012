package Bird;

use strict;
use warnings;

my $count = 0;

sub new {
    my($class, $obj, $name) = @_;
    bless{
        name => $name,
        followers => [],
        following => [],
        tweets => [],
        friends_timeline => [],
        directmessage_post => [],
    }, $class;
}

#フォロー意思表示
sub follow {
    my ($self, $bird) = @_;
    $bird -> add_follower($self);
    push @{$self -> {following}}, $bird;
}

#フォロワーに追加
sub add_follower {
    my($self, $bird) = @_;
    push @{$self -> {followers}}, $bird;
    print $bird->{name}." folllowed ".$self->{name}.".\n";
}

#アンフォロー意思表示
sub unfollow {
    my($self, $bird) = @_;
    $bird -> remove_follower($self);
}

#フォロワーから削除
sub remove_follower {
    my($self, $bird) = @_;
    my @followers_new;
    for(@{$self->{followers}}){
        if($_ != $bird){
            push @followers_new, $_;
        }else{
            print $bird->{name}." unfolllowed ".$self->{name}.".\n";
        }
    }
    @{$self->{followers}} = @followers_new;
}

#ツイート送信
sub tweet {
    my ($self, $message) = @_;
    if(length($message) > 0 && length($message) < 141){
        #FizzBuzzアルゴリズム
        $count ++;
        my $message_replaced = "";
        if ($count % 3 == 0) {
            $message_replaced = $message_replaced."Fizz";
        }
        if ($count % 5 == 0) {
            $message_replaced = $message_replaced."Buzz";
        }
        if ($message_replaced eq "") {
            $message_replaced = $message;
        }
        my $tweet = $self->{name}.":".$message_replaced;
        push @{$self -> {tweets}}, $tweet;
        for my $follower (@{$self -> {followers}}){
            $follower -> receive_tweet($tweet);
        }
    }else{
        die("Please input 1~140 characters!!");
    }
}

#ツイート受信
sub receive_tweet {
    my ($self, $tweet) = @_;
    unshift @{$self -> {friends_timeline}}, $tweet;
}

#ダイレクトメッセージ送信
sub send_DM {
    my($self, $bird, $message) = @_;
    if(length($message) > 0 && length($message) < 141){
        my $dm = $self->{name}.":".$message;
        $bird -> get_DM($dm);
    }else{
        die("Please input 1~140 characters!!");
    }
}

#ダイレクトメッセージ受信
sub get_DM {
    my($self, $message) = @_;
    unshift @{$self -> {directmessage_post}}, $message;
}
1;

