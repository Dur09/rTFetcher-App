package RTFetcher::Conf;

use strict;
use warnings;

sub new {
    my $class = shift;
    my $self;

    # Database Settings;
    $self->{database_name} = 'rtdb';
    $self->{database_user} = 'admin';
    $self->{database_pw}   = 'admin';
    $self->{database_host} = 'localhost';
    $self->{database_dsn}  = "dbi:Pg:dbname=$self->{database_name}";

    # DB DSN with HOST
    $self->{database_dsn} .= ";host=$self->{database_host};" if (defined $self->{database_host});

    $self->{rt_host} = 'https://rt.marchex.com';
    $self->{rt_user} = 'dbhole';
    $self->{rt_pass} = 'pidrupHl1haf';

    return bless($self, $class);
}

1;
