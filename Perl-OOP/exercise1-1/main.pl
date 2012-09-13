use FindBin;
use lib $FindBin::Bin."/lib";

use Bird;
my $b1 = Bird->new( name => 'jkondo');
my $b2 = Bird->new( name => 'reikon');
my $b3 = Bird->new( name => 'onishi');

$b1->follow($b2);
$b1->follow($b3);
$b3->follow($b1);
$b2->follow($b1);
$b3->follow($b2);

$b1->unfollow($b2);

$b1->tweet('今日は暑いですね！');
$b2->tweet('しなもんのお散歩中です');
$b3->tweet('烏丸御池なう！');

$b1->send_DM($b2, '私も散歩にご一緒させてください。');

my @birds = ($b1, $b2, $b3);
foreach my $bird (@birds){
    print "----".$bird->{name}."は以下をフォローしています----\n";
    for(@{$bird->{following}}){
        print $_->{name}."\n";
    }
    print "---".$bird->{name}."は以下にフォローされています---\n";
    for(@{$bird->{followers}}){
        print $_->{name}."\n";
    }
    print "----------".$bird->{name}."のタイムライン----------\n";
    for(@{$bird->{friends_timeline}}){
        print $_."\n";
    }
    print "--".$bird->{name}."の受信したダイレクトメッセージ--\n";
    for(@{$bird->{directmessage_post}}){
        print $_."\n";
    }
    print "\n\n";
}
