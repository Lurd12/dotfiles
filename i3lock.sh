#!/usr/bin/env bash
# Author: Dolores Portalatin <hello@doloresportalatin.info>
# Dependencies: imagemagick, i3lock-color-git, scrot, wmctrl (optional)
set -o errexit -o noclobber -o nounset

hue=(-level "0%,100%,0.6")
effect=(-filter Gaussian -resize 20% -define "filter:sigma=1.5" -resize 500.5%)
# default system sans-serif font
font=$(convert -list font | awk "{ a[NR] = \$2 } /family: $(fc-match sans -f "%{family}\n")/ { print a[NR-1]; exit }")
image=$(mktemp --suffix=.png)
shot=(import -silent -window root)
desktop=""
i3lock_cmd=(i3lock -i "$image")
shot_custom=false

options="Options:
    -h, --help       This help menu.

    -d, --desktop    Attempt to minimize all windows before locking.

    -g, --greyscale  Set background to greyscale instead of color.

    -p, --pixelate   Pixelate the background instead of blur, runs faster.

    -f <fontname>, --font <fontname>  Set a custom font.

    -t <text>, --text <text> Set a custom text prompt.

    -l, --listfonts  Display a list of possible fonts for use with -f/--font.
                     Note: this option will not lock the screen, it displays
                     the list and exits immediately.

    -n, --nofork     Do not fork i3lock after starting.

    --               Must be last option. Set command to use for taking a
                     screenshot. Default is 'import -window root'. Using 'scrot'
                     or 'maim' will increase script speed and allow setting
                     custom flags like having a delay."

# move pipefail down as for some reason "convert -list font" returns 1
set -o pipefail
trap 'rm -f "$image"' EXIT
temp="$(getopt -o :hdnpglt:f: -l desktop,help,listfonts,nofork,pixelate,greyscale,text:,font: --name "$0" -- "$@")"
eval set -- "$temp"

# l10n support
case "${LANG:-}" in
    af_* ) text="Tik wagwoord om te ontsluit" ;; # Afrikaans
    cs_* ) text="Pro odemčení zadajte heslo" ;; # Czech
    de_* ) text="Bitte Passwort eingeben" ;; # Deutsch
    da_* ) text="Indtast adgangskode" ;; # Danish
    en_* ) text="Type password to unlock" ;; # English
    es_* ) text="" ;; # Española
    fr_* ) text="Entrez votre mot de passe" ;; # Français
    he_* ) text="הקלד סיסמה לביטול הנעילה" ;; # Hebrew עברית
    hi_* ) text="अनलॉक करने के लिए पासवर्ड टाईप करें" ;; #Hindi
    id_* ) text="Masukkan kata sandi Anda" ;; # Bahasa Indonesia
    it_* ) text="Inserisci la password" ;; # Italian
    ja_* ) text="パスワードを入力してください" ;; # Japanese
    lv_* ) text="Ievadi paroli" ;; # Latvian
    nb_* ) text="Skriv inn passord" ;; # Norwegian
    pl_* ) text="Podaj hasło" ;; # Polish
    pt_* ) text="Digite a senha para desbloquear" ;; # Português
    sk_* ) text="Pre odomknutie zadajte heslo" ;; # Slovak
    tr_* ) text="Giriş yapmak için şifrenizi girin" ;; # Turkish
    ru_* ) text="Введите пароль" ;; # Russian
    zh_* ) text="请输入密码以解锁" ;; # Chinese
    * ) text="Type password to unlock" ;; # Default to English
esac

while true ; do
    case "$1" in
        -h|--help)
            printf "Usage: %s [options]\n\n%s\n\n" "${0##*/}" "$options"; exit 1 ;;
        -d|--desktop) desktop=$(command -V wmctrl) ; shift ;;
        -g|--greyscale) hue=(-level "0%,100%,0.6" -set colorspace Gray -average) ; shift ;;
        -p|--pixelate) effect=(-scale 10% -scale 1000%) ; shift ;;
        -f|--font)
            case "$2" in
                "") shift 2 ;;
                *) font=$2 ; shift 2 ;;
            esac ;;
        -t|--text) text=$2 ; shift 2 ;;
        -l|--listfonts)
	    convert -list font | awk -F: '/Font: / { print $2 }' | sort -du | command -- ${PAGER:-less}
	    exit 0 ;;
	-n|--nofork) i3lock_cmd+=(--nofork) ; shift ;;
        --) shift; shot_custom=true; break ;;
        *) echo "error" ; exit 1 ;;
    esac
done

if "$shot_custom" && [[ $# -gt 0 ]]; then
    shot=("$@");
fi

command -- "${shot[@]}" "$image"

value="60" #brightness value to compare to

color=$(convert "$image" -gravity center -crop 100x100+0+0 +repage -colorspace hsb \
    -resize 1x1 txt:- | awk -F '[%$]' 'NR==2{gsub(",",""); printf "%.0f\n", $(NF-1)}');

if [[ $color -gt $value ]]; then #white background image and black text
    bw="black"
    icon="/home/lur/wallpapers/images-locked/trans.png"
    param=("--inside-color=0000001c" "--ring-color=0000003e" \
        "--line-color=00000000" "--keyhl-color=ffffff80" "--ringver-color=ffffff00" \
        "--separator-color=22222260" "--insidever-color=ffffff1c" \
        "--ringwrong-color=ffffff55" "--insidewrong-color=ffffff1c" \
        "--verif-color=ffffff00" "--wrong-color=ff000000" "--time-color=ffffff00" \
        "--date-color=ffffff00" "--layout-color=ffffff00")
else #black
    bw="white"
    icon="/home/lur/wallpapers/images-locked/trans.png"
    param=("--inside-color=ffffff1c" "--ring-color=ffffff3e" \
        "--line-color=ffffff00" "--keyhl-color=00000080" "--ringver-color=00000000" \
        "--separator-color=22222260" "--insidever-color=0000001c" \
        "--ringwrong-color=00000055" "--insidewrong-color=0000001c" \
        "--verif-color=00000000" "--wrong-color=ff000000" "--time-color=00000000" \
        "--date-color=00000000" "--layout-color=00000000")
fi

convert "$image" "${hue[@]}" "${effect[@]}" -font "$font" -pointsize 26 -fill "$bw" -gravity center \
    -annotate +0+160 "$text" "$icon" -gravity center -composite "$image"

# If invoked with -d/--desktop, we'll attempt to minimize all windows (ie. show
# the desktop) before locking.
${desktop} ${desktop:+-k on}

# try to use i3lock with prepared parameters
if ! "${i3lock_cmd[@]}" "${param[@]}" >/dev/null 2>&1; then
    # We have failed, lets get back to stock one
    "${i3lock_cmd[@]}"
fi

# As above, if we were passed -d/--desktop, we'll attempt to restore all windows
# after unlocking.
${desktop} ${desktop:+-k off}
