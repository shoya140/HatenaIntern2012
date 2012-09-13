use FindBin;
use lib $FindBin::Bin."/lib";

use Bird;
my $b1 = Bird->new( name => 'Mrk1869');
my $b2 = Bird->new( name => 'Rkm8691');
my $b3 = Bird->new( name => 'Kmr6918');

$b1->follow($b2);
$b1->follow($b3);
$b3->follow($b1);
$b2->follow($b1);
$b2->follow($b3);

$b1->tweet('今日は暑いですね！');
$b2->tweet('しなもんのお散歩中です');
$b3->tweet('烏丸御池なう！'); #Fizz
$b2->tweet('結論だけ、書く。');
$b2->tweet('要らないから。'); #Buzz
$b2->tweet('要らないから。'); #Fizz
$b1->tweet('本日は晴天なり。');
$b2->tweet('要らないから。');
$b2->tweet('要らないから。'); #Fizz
$b1->tweet('ゲリラ豪雨。'); #Buzz
$b2->tweet('要らないから。');
$b3->tweet('要らないから。'); #Fizz
$b2->tweet('要らないから。');
$b3->tweet('要らないから。');
$b2->tweet('要らないから。'); #FizzBuzz
$b3->tweet('要らないから。');
$b2->tweet('要らないから。');
$b3->tweet('要らないから。'); #Fizz
$b2->tweet('要らないから。');
$b3->tweet('要らないから。'); #Buzz
$b2->tweet('要らないから。'); #Fizz
$b2->tweet('そして知らないから。');
$b1->tweet('京都は相変わらず暑いな。');
$b2->tweet('さて、まずはこの問題解こうか。制限時間5分。'); #Fizz
$b2->tweet('タイトル: Ants'); #Buzz
$b2->tweet('問題文: 長さL cmの竿の上をn匹のアリが毎秒1cmのスピードで歩いています。');
$b2->tweet('アリが竿の端に到達すると竿の下に落ちていきます。'); #Fizz
$b1->tweet('大雨に注意。');
$b2->tweet('また、竿の上は狭くてすれ違えないので、');
$b3->tweet('二匹のアリが出会うと、それぞれ反対を向いて戻っていきます。'); #FizzBuzz
$b3->tweet('各アリについて、現在の竿の左端からの距離xiはわかりますが、');
$b1->tweet('今夜は月が綺麗だ。');
$b3->tweet('どちらの方向を向いているのかはわかりません。'); #Fizz
$b3->tweet('すべてのアリが竿から落ちるまでにかかる');
$b3->tweet('最小の時間と最大の時間をそれぞれ求めなさい。'); #Buzz
$b3->tweet('出典: プログラミングコンテストチャレンジブック(p.23) '); #Fizz
$b1->tweet('本日は晴天なり。');

$b3->send_DM($b1, 'ダイレクトメッセージも送れるよ！');
$b1->send_DM($b2, 'ダイレクトメッセージは大事な内容だからFizzBussにはならないよ');

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
