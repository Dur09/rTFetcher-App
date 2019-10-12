package RTFetcher::DB;

use strict;
use warnings;
use File::FindLib 'lib';

use JSON;
use DBI;
use RTFetcher::Conf;

sub new {
    my $class = shift;
    return bless({}, $class);
}

sub connect_db {
    my $self = shift;

    my $conf = RTFetcher::Conf->new();
    my $dsn = $conf->{database_dsn};
    my $user = $conf->{database_user};
    my $pass = $conf->{database_pw};
    my %attr = (
        PrintError => 0,
        RaiseError => 1,
        AutoCommit => 0,
    );

    return DBI->connect($dsn, $user, $pass, \%attr) || die "Unable to connect to DB $@";
}

1;
