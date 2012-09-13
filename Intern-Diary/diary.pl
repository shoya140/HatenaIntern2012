use strict;
use warnings;

use utf8;

use FindBin;
use lib "$FindBin::Bin/lib", glob "$FindBin::Bin/modules/*/lib";
use Intern::Diary::MoCo "moco";
use Pod::Usage; #for pod2usage()
use Encode::Locale;

binmode STDOUT, ':encoding(console_out)';

my %HANDLERS = (
    add => \&add_entry,
    list => \&list_entries,
    edit => \&edit_entry,
    delete => \&delete_entry,
);

my $command = shift @ARGV || 'list';

my $user = moco('User')->find(name => $ENV{USER}) || moco('User')->create(name => $ENV{USER});
my $handler = $HANDLERS{$command} or pod2usage;

$handler -> ($user, @ARGV);

exit 0;

#エントリ追加
sub add_entry{
    my ($self) = @_;
    print "タイトルを入力:";
    chomp(my $title = <STDIN>);
    print "本文を入力:";
    chomp(my $body = <STDIN>);
    my $entry = $user->add_entry(
        title => $title,
        body => $body,
    );
    print "投稿完了！".$entry->as_string."\n";
}

#エントリ一覧取得
sub list_entries {
    my ($user) = @_;
    print "---".$user->name."の日記---\n";
    my $entries = $user->get_entries;
    foreach my $entry(@$entries){
        print $entry->as_string."\n";
    }
}

#エントリ削除
sub delete_entry{
    my ($user, $entry_id) = @_;
    my $entry = moco('Entry')->find(id => $entry_id) or die "id=".$entry_id."に該当するエントリはありません。";
    my $delete= $user->delete_entry($entry);
    if ($delete) {
        print "削除完了！\n";
    }
}

#エントリ編集
sub edit_entry {
    my($user, $entry_id) = @_;
    my $entry = moco('Entry')->find(id => $entry_id) or die "id=".$entry_id."に該当するエントリはありません。";
    print "タイトルを入力:";
    chomp(my $title = <STDIN>);
    print "本文を入力:";
    chomp(my $body = <STDIN>);
    my $edit = $user->edit_entry(
        entry_id => $entry_id,
        title => $title,
        body => $body,
    );
    if($edit){
        print "編集完了！".$edit->as_string."\n";
    }
}
