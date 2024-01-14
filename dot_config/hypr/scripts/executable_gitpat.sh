source _custom-script-util

if [[ ! -f ~/Stuff/gitpat ]] then
    fatalln "Couldn't find file containing gitpat (~/Stuff/gitpat)"
fi

cat ~/Stuff/gitpat | wl-copy
