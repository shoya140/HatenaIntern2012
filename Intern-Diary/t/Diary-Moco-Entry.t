package t::Diary::MoCo::Entry;
use strict;
use warnings;
use utf8;

use FindBin;
use lib $FindBin::Bin."/../lib";

use base 'Test::Class';

use Test::More;
use t::Diary;

sub startup : Test(startup => 1) {
    use_ok 'Intern::Diary::MoCo::Entry';
    t::Diary->truncate_db;
}

sub modifiedTime : Test(1) {
    my $e = Intern::Diary::MoCo::Entry->create;
    no warnings 'once';
    local *DateTime::now = sub {
        my $class = shift;
        return DateTime->new(year => 1970, month => 1, day => 1, @_);
    };
    $e->title('hoge');
    is $e->modifiedTime . '', '1970-01-01T00:00:00', 'modifiedTime 更新された';
}

__PACKAGE__->runtests;
