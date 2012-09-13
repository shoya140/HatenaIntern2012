package Intern::Diary::Config;
use strict;
use warnings;
use base qw/Ridge::Config/;
use Path::Class qw/file/;

use Data::Dumper;

my $root = file(__FILE__)->dir->parent->parent->parent;

__PACKAGE__->setup({
    root          => __PACKAGE__->find_root,
    namespace     => 'Intern::Diary',
    charset       => 'utf-8',
    ignore_config => 1,
    static_path   => [
        '^/images\/',
        '^/img\/',
        '^/js\/',
        '^/css\/',
        '^/favicon\.ico',
    ],
    URI => {
        use_lite => 1,
        filter   => \&uri_filter,
    },

    ## Application specific configuration
    app_config => {
        default => {
            uri => URI->new('http://local.hatena.ne.jp:3000/'),
        },
    }
});

sub uri_filter {
    my $uri = shift;
    my $path = $uri->path;

    if($path =~ m{^(?:/login|/logout|/css/|/js/|/images|/img/|/favicon\.ico)}){
        $uri;
        return;
    }

    if ($path =~ m{^/(\w+)/}) {
        $uri->param(name => $1);
    }

    if ($path =~ m{^/(?:\w+)/$}) {
        $uri->path('/user/');
    }

#    if ($path =~ m{^/(?:\w+)/(?:page/(\d+))?$}) {
#        $uri->path('/user');
#        $uri->param(page => $1) if $1;
#    }

#    if ($path =~ m{^/(?:\w+)/entry/(\d+)}) {
#        $uri->path('/entry');
#        $uri->param(id => $1);
#    } elsif ($path =~ m{^/(?:\w+)/entry/add/(?:/(\d+))?$}) {
#        $uri->path('/entry.add');
#        $uri->param(id => $1);
#    } elsif ($path =~ m{^/(?:\w+)/entry/delete/(\d+)$}) {
#        $uri->path('/entry.delete');
#        $uri->param(id => $1);
#    }
#
    if ($path =~ m{^/(?:\w+)/entries}){
        $uri->path('/user/entries');
    } elsif($path =~ m{^/(?:\w+)/entry}){
        $uri->path('/user/entry');
    }
    if ($path =~ m{^/(?:\w+)/entry.add}){
        $uri->path('/user/entry.add');
    } elsif ($path =~ m{^/(?:\w+)/entry.delete}){
        $uri->path('/user/entry.delete');
    }

#    } elsif ($path =~ m{^/(?:\w+)/entry.add/(?:/(\d+))?$}) {
#        $uri->path('/entry.add');
#        $uri->param(id => $1);
#    } elsif ($path =~ m{^/(?:\w+)/entry.delete/(\d+)$}) {
#        $uri->path('/entry.delete');
#        $uri->param(id => $1);
#    }



#    if ($path =~ m{^/api/(\w+)/entries/(?:page/(\d+))?$}) {
#        $uri->path('/api.entries');
#        $uri->param(username => $1);
#        $uri->param(page => $2) if $2;
#    } elsif ($path =~ m{^/api/(\w+)/entry/(?:add|edit)(?:/(\d+))?$}) {
#        $uri->path('/api.newentry');
#        $uri->param(username => $1);
#        $uri->param(id => $2) if $2;
#    } elsif ($path =~ m{^/api/(\w+)/entry/(\d+)}) {
#        $uri->path('/api.entry');
#        $uri->param(username => $1);
#        $uri->param(id => $2) if $2;
#    }


#    if($path =~ m{^(?:/login|/logout|/css/|/js/|/images|/img|/favicon\.ico)}){
#        $uri;
#    }elsif($path =~ m{^/([^/]+)/}){
#        $uri -> path('/user/');
#        $uri -> param(name => $1);
#    }
}

1;
