package RTFetcher::App;

use strict;
use warnings;
use File::FindLib 'lib';

use Dancer2;

use JSON;
use RTFetcher::RTClient::Client;
use Data::Dumper;

my $rt = RTFetcher::RTClient::Client->new();

our $VERSION = '0.1';

get '/' => sub {
    template 'index' => { 'title' => 'RTFetcher::App' };
};

post '/api/v1/getUserRtCount' => sub {
    header('Content-Type' => 'application/json');
    my $data = from_json(request->body);
    return to_json { count => $rt->search_ticket_count_per_user( $data ) };
};

true;
