use strict;
use warnings;

use Test::More;
use Test::Exception;

use FindBin;
use lib $FindBin::Bin."/../lib";

#Birdの読み込みができるか
use_ok 'Bird';

#Birdから個々のオブジェクトが生成できるか
my $b1 = Bird->new( name => 'jkondo');
isa_ok $b1, 'Bird';

my $b2 = Bird->new( name => 'reikon');
my $b3 = Bird->new( name => 'onishi');

#follow動作確認
lives_ok  { $b1->follow($b2) };

$b1->follow($b2);
$b1->follow($b3);
$b3->follow($b1);
$b2->follow($b3);
$b2->follow($b1);

#unfollow動作確認
lives_ok  { $b2->unfollow($b1) };

#Tweet動作確認・字数チェックテスト
lives_ok  { $b1->tweet('今日はお散歩中です') };
dies_ok  { $b1->tweet('') };

$b3->tweet('Hello, Woeld!');
$b3->tweet('今日はお散歩中です'); #Fizz
$b2->tweet('しなもんなう！');
$b1->tweet('烏丸御池暑いですね！'); #Buzz
$b3->tweet('6つめのツイート'); #Fizz
$b2->tweet('7つめのツイート');
$b1->tweet('8つめのツイート');
$b3->tweet('9つめのツイート'); #Fizz
$b3->tweet('10つめのツイート'); #Buzz
$b2->tweet('11つめのツイート');
$b3->tweet('12つめのツイート'); #Fizz
$b1->tweet('13つめのツイート');
$b1->tweet('14つめのツイート');
$b3->tweet('15つめのツイート'); #FizzBuzz
$b2->tweet('16つめのツイート');

$b1->send_DM($b2, 'これはダイレクトメッセージ');

#期待通りの結果が返ってくるか
my $expected = "jkondo";
cmp_ok $b3->{following}->[0]->{name}, 'eq', $expected;
$expected = "jkondo";
cmp_ok $b2->{followers}->[0]->{name}, 'eq', $expected;
$expected = "jkondo";
cmp_ok $b2->{followers}->[0]->{name}, 'eq', $expected;
my $expected = "reikon:16つめのツイート";
cmp_ok $b1->{friends_timeline}->[0], 'eq', $expected;
$expected = "onishi:FizzBuzz";
cmp_ok $b2->{friends_timeline}->[0], 'eq', $expected;
$expected = "onishi:Fizz";
cmp_ok $b2->{friends_timeline}->[1], 'eq', $expected;
$expected = "onishi:Buzz";
cmp_ok $b2->{friends_timeline}->[2], 'eq', $expected;
$expected = "jkondo:これはダイレクトメッセージ";
cmp_ok $b2->{directmessage_post}->[0], 'eq', $expected;

done_testing();
