use Text::Iconv;
 
@ARGV || die " Usage:
    scriptname file1 file2 ...
    scriptname \"file name\" ...
    scriptname file\\ name ...
    scriptname \*.mp3
    scriptname \*";
 
sub translit
{
    my $text = shift;
    $text = Text::Iconv->new("","koi-8")->convert($text);
    $text =~ y/ �����ţ�������������������/_abvgdeezijklmnoprstufh'y'e/;
    $text =~ y/�������������������������/ABVGDEEZIJKLMNOPRSTUFH'Y'E/;
    my %mchars = ('�'=>'zh','�'=>'tz','�'=>'ch','�'=>'sh','�'=>'sch','�'=>'ju','�'=>'ja',
                  '�'=>'ZH','�'=>'TZ','�'=>'CH','�'=>'SH','�'=>'SCH','�'=>'JU','�'=>'JA');
 
    map {$text =~ s/$_/$mchars{$_}/g} (keys %mchars);
 
    return $text;
}
 
while (@ARGV)
{
  rename($ARGV[0],translit($ARGV[0])) || die "Can't rename $ARGV[0] to translit($ARGV[0]): $!";
  shift;
}