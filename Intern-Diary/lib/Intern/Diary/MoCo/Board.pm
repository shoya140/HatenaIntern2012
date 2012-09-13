use strict;
use warnings;

package Intern::Diary::MoCo::Board;

use Intern::Diary::MoCo qw(moco);
use base 'Intern::Diary::MoCo';

__PACKAGE__ -> table('board');
__PACKAGE__->utf8_columns(qw(user_name));

1;
