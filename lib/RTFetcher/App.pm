package RTFetcher::App;

use strict;
use warnings;
use File::FindLib 'lib';

use Dancer2;

use RTFetcher::Utils::Trends;

our $VERSION = '0.1';

get '/' => sub {
    template 'index' => { 'title' => 'RTFetcher::App' };
};

get '/getUserRtCount' => sub {
    header('Content-Type' => 'application/json');
    return to_json ;
};

true;
