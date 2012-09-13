use strict;
use warnings;

package Intern::Diary::MoCo::Entry;

use Intern::Diary::MoCo qw(moco);
use base 'Intern::Diary::MoCo';

__PACKAGE__ -> table('entry');
__PACKAGE__->utf8_columns(qw(title));
__PACKAGE__->utf8_columns(qw(body));

sub entries {
    my $self = shift;
    return moco('Entry')->search(
        where => { id => $self->id },
        order => 'createdTime DESC',
    );
}

sub get_entry_info {
    my $self = shift;
    return moco('Entry')->find(
        where =>{id =>$self->id},
    );
}

sub as_string {
    my $self = shift;
    return sprintf '[%d] %s <%s>', (
        $self->id,
        $self->title,
        $self->body,
    );
}

#sub replace_entries_for_json{
#    my $entries = shift;
#    foreach $entry($entries){

#    }
#};

#sub replace_entry_for_json {
#    my $self = shift;
#    my $entry = {
#        id => $self->{id},
#        title => $self->{title},
#        body => $self->{body},
#        author_id => $self->{author_id},
#        createdTime => $self->{createdTime},
#        modifiedTime => $self->{modifiedTime},
#    };
#    return $entry;
#}
1;
