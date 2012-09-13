use strict;
use warnings;

package Intern::Diary::DataBase;

use parent 'DBIx::MoCo::DataBase';

__PACKAGE__ -> dsn('dbi:mysql:dbname=intern_diary_mrk1869');
__PACKAGE__ -> username('root');
__PACKAGE__ -> password('');

1;

