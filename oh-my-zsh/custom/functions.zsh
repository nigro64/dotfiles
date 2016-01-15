function phptags () {
  exec ctags -f tags -h ".php" -R \
    --exclude=".git"  \
    --totals=yes \
    --languages=php \
    #--tag-relative=yes \
    --PHP-kinds=+cf \
    --regex-PHP='/abstract class ([^ ]*)/\1/c/' \
    --regex-PHP='/interface ([^ ]*)/\1/c/' \
    --regex-PHP='/(public |static |abstract |protected |private )+function ([^ (]*)/\2/f/'
}

