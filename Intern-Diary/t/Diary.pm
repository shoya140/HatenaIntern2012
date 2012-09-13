package t::Diary;
use strict;
use warnings;
use lib 'lib', glob 'modules/*/lib';
use Intern::Diary::DataBase;

Intern::Diary::DataBase->dsn('dbi:mysql:dbname=intern_diary_mrk1869_test');

sub truncate_db {

    Intern::Diary::DataBase->execute("TRUNCATE TABLE $_") for qw(user entry);
}

1;
