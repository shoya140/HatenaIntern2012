#!/usr/bin/perl

use strict;
use warnings;

    package Text::Hatena::Escaped;
    use base qw(Text::Hatena);

    sub text_line {
        my $class = shift;
        my $text  = shift->{items}->[2];
        return $class->escape("$text\n");
    }

    sub cdata {
        my $class = shift;
        my $items = shift->{items};
        my $data  = $items->[1];
        $data = $class->escape($data);
        return "<$data>\n";
    }

    sub pre_line {
        my $class   = shift;
        my $items   = shift->{items};
        my $inlines = $class->expand($items->[2]);
        return $class->escape("$inlines\n");
    }

    sub inline {
        my $class = shift;
        my $items = shift->{items};
        my $item  = $items->[0] or return;
        $item = $class->escape($item);
        $item = Text::Hatena::AutoLink->parse($item);
        return $item;
    }

    sub escape {
        my ($self, $text) = @_;
        return $text unless $text;
        for ($text) {
            s/&/&amp;/g;
            s/</&lt;/g;
            s/>/&gt;/g;
            s/"/&quot;/g;
        }
        $text;
    }

    1;
