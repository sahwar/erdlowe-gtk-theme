#!/bin/bash
# Erdlöwe theme by DarthWound
# Use this script to get Materia and build the changes
# Works with materia-master 2018/01/31 - caution if used with more recent files

# START

printf "[0/11] Preparing build directory...\n"

rm -rf ~/.erdlowe-buildir
mkdir ~/.erdlowe-buildir
cd ~/.erdlowe-buildir
wget -O - https://github.com/nana-4/materia-theme/archive/master.tar.gz | tar xz
cd materia-theme-master

# STEP1

printf "[1/11] Changing name...\n"sleep 2s


sed -i '/Comment/!s/Materia/Erdlowe/g' src/*.theme

# STEP2

printf "[2/11] Editing assets...\n"
sleep 2s

sed -i 's/#FF4081/#35B9AB/g' src/gtk/assets.svg
sed -i 's/#FF4081/#35B9AB/g' src/gtk-2.0/assets{,-dark}.svg
sed -i 's/#42A5F5/#73BA25/g' src/gtk-2.0/assets{,-dark}.svg
sed -i 's/#000000/#173F4F/g' src/gtk-2.0/assets{,-dark}.svg
sed -i 's/#F5F5F5/#EEEEEE/g' src/gtk-2.0/assets.svg
sed -i 's/#FAFAFA/#FFFFFF/g' src/gtk-2.0/assets.svg
sed -i 's/#333e43/#12313D/g' src/gtk-2.0/assets-dark.svg
sed -i 's/#414f56/#173F4F/g' src/gtk-2.0/assets-dark.svg
sed -i 's/#3b484e/#173F4F/g' src/gtk-2.0/assets-dark.svg
sed -i 's/#374349/#12313D/g' src/gtk-2.0/assets-dark.svg
sed -i 's/#FF4081/#35B9AB/g' src/gnome-shell/assets{,-dark}/*.svg
sed -i 's/#FF5252/#BB2525/g' src/gnome-shell/assets{,-dark}/*.svg

# STEP3

printf "[3/11] Changing shell fonts and icons...\n"
sleep 2s

sed -i 's/Roboto, "M+ 1c"/Source Sans Pro/g' src/_sass/gnome-shell/_variables.scss
sed -i 's/"M+ 1c", Roboto/Source Sans Pro/g' src/_sass/gnome-shell/_variables.scss
sed -i 's/symbolic/regular/g' src/_sass/gnome-shell/_common{-3.18,-3.24,-3.26}.scss

# STEP4

printf "[4/11] Creating new color palette...\n"
sleep 2s

cat > src/_sass/_color-palette.scss << "EOF"
// based color palette:
// https://opensuse.github.io/branding-guidelines/

// Basics
$white: #FFFFFF;
$black: #000000;

// Material
$grey_50: #FAFAFA;
$grey_100: #F5F5F5;
$grey_200: #EEEEEE;
$grey_300: #E0E0E0;
$grey_400: #BDBDBD;
$grey_500: #9E9E9E;
$grey_600: #757575;
$grey_700: #616161;
$grey_800: #424242;
$grey_900: #212121;

// openSUSE® primary colors
$lightgreen: #73BA25;
$lightcyan: #35B9AB;
$darkblue: #173F4F;

// openSUSE® primary tints
$lightgreen90: #81C13B;
$lightgreen75: #96CB5C;
$lightgreen50: #B9DC92;
$lightgreen25: #DCEEC8;
$lightcyan90: #4AC0B4;
$lightcyan75: #68CBC0;
$lightcyan50: #9ADCD5;
$lightcyan25: #CCEDEA;
$darkblue90: #2F5361;
$darkblue75: #516F7B;
$darkblue50: #8B9FA7;
$darkblue25: #C5CFD3;

// openSUSE® additional colors
$darkgreen: #6DA741;
$darkcyan: #00A489;
$lightblue: #21A4DF;

// openSUSE® additional tints
$darkgreen90: #7CB054;
$darkgreen75: #92BD71;
$darkgreen50: #B6D3A0;
$darkgreen25: #DAE9CF;
$darkcyan90: #1AAD95;
$darkcyan75: #40BBA7;
$darkcyan50: #7FD1C4;
$darkcyan25: #BFE8E1;
$lightblue90: #38ADE2;
$lightblue75: #59BBE7;
$lightblue50: #90D1EF;
$lightblue25: #C7E8F7;

// Derivatives
$red: #BB2525;
$orange: #BB7025;
$yellow: #BBBB25;
$purple: #9625BB;
$darkerwhite: #EEEEEE;
$darkerblue: #12313D;
$realgrey: #878787;
EOF

# STEP5

printf "[5/11] Using new color palette in GTK3 and GS...\n"
sleep 2s

cat > src/_sass/_colors.scss << "EOF"
// When color definition differs for dark and light variant,
// it gets @if ed depending on $variant

@import 'color-palette';

@function gtkalpha($c, $a) {
  @return unquote("alpha(#{$c}, #{$a})");
}

@function fade($c) {
  @return mix($c, $grey_900, 50%);
}

// Foreground colors
$dark_fg_color:   $darkblue;
$light_fg_color:  $white;

$button_fg_color:             $lightcyan; // extra fg color for raised buttons

$fg_color:                    if($variant == 'light', $darkblue, $white);
$secondary_fg_color:          if($variant == 'light', rgba($darkblue, 0.77), rgba($white, 0.77));
$hint_fg_color:               if($variant == 'light', rgba($darkblue, 0.55), rgba($white, 0.55));
$disabled_fg_color:           if($variant == 'light', rgba($darkblue, 0.55), rgba($white, 0.55));
$disabled_secondary_fg_color: if($variant == 'light', rgba($darkblue, 0.33), rgba($white, 0.33));
$track_color:                 if($variant == 'light', rgba($darkblue, 0.33), rgba($white, 0.33));
$divider_color:               if($variant == 'light', rgba($darkblue, 0.11), rgba($white, 0.11));

$titlebar_fg_color:                    $darkgreen;
$titlebar_secondary_fg_color:          rgba($darkgreen, 0.77);
$titlebar_hint_fg_color:               rgba($darkgreen, 0.55);
$titlebar_disabled_fg_color:           rgba($darkgreen, 0.55);
$titlebar_disabled_secondary_fg_color: rgba($darkgreen, 0.33);
$titlebar_track_color:                 rgba($darkgreen, 0.33);
$titlebar_divider_color:               rgba($darkgreen, 0.11);

$inverse_fg_color:                    $white;
$inverse_secondary_fg_color:          rgba($white, 0.77);
$inverse_hint_fg_color:               rgba($white, 0.55);
$inverse_disabled_fg_color:           rgba($white, 0.55);
$inverse_disabled_secondary_fg_color: rgba($white, 0.33);
$inverse_track_color:                 rgba($white, 0.33);
$inverse_divider_color:               rgba($white, 0.11);

// Background colors
$bg_color:         if($variant == 'light', $darkerwhite, $darkerblue);
$base_color:       if($variant == 'light', $white, $darkblue);
$alt_base_color:   if($variant == 'light', $darkerwhite, $darkerblue);
$lighter_bg_color: if($variant == 'light', $white, $darkblue);
$alt_lighter_bg_color: if($variant == 'light', $darkerwhite, $darkerblue); // for gnome-shell sub menu
$darker_bg_color:  if($variant == 'light', $darkerwhite, $darkerblue);

$titlebar_bg_color:     if($titlebar == 'dark', if($variant == 'light', $darkblue, $darkblue), $darkerwhite);
$alt_titlebar_bg_color: if($titlebar == 'dark', rgba($darkblue, 0.55), rgba($darkerwhite, 0.55));

$panel_bg_color:        rgba($black, $middle_opacity);
$alt_panel_bg_color:    rgba($black, $lower_opacity);
$inverse_panel_bg_color: rgba($inverse_fg_color, 0.1);
$solid_panel_bg_color:  $black;
$opaque_panel_bg_color: $black; // for Unity panel which cannot use translucent colors

$gdm_bg_color: if($variant == 'light', $grey_700, $grey_800);

$fill_color:      gtkalpha(currentColor, $lower_opacity);
$semi_fill_color: gtkalpha(currentColor, $lower_opacity / 2);
$row_fill_color:  gtkalpha(currentColor, 0.05);

// Misc colors
$primary_color:         $lightgreen;
$alt_primary_color:     $darkgreen;
$accent_color:          $lightcyan;
$disabled_accent_color: rgba($lightcyan, 0.33);

$link_color:         $lightblue;
$visited_link_color: $purple;

$warning_color: $yellow;
$error_color:   $orange;
$success_color: $lightgreen;

$suggested_color:   $accent_color;
$destructive_color: $red;

$info_bg_color:     $realgrey;
$question_bg_color: $realgrey;
$warning_bg_color:  $realgrey;
$error_bg_color:    $realgrey;

$border_color:             if($variant == 'light', rgba($black, 0.12), rgba($black, 0.26));
$alt_border_color:         rgba($black, 0.26); // for non-native GTK+ apps (e.g. Firefox and Chrome)
$highlight_color:          if($variant == 'light', rgba($white, 0.4),  rgba($white, 0.1));
$titlebar_highlight_color: if($titlebar == 'dark', rgba($white, 0.1),  rgba($white, 0.4));
$alt_highlight_color:      rgba($white, 0.2); // for selection-mode headerbar which colored with $primary_color
$titlebar_indicator_color: if($titlebar == 'dark', currentColor, $primary_color);

// for Electron/Atom menu which cannot use translucent colors
$opaque_fg_color:           if($variant == 'light', $grey_900, $white);
$opaque_secondary_fg_color: if($variant == 'light', $grey_600, mix($white, $base_color, percentage(0.7)));
$opaque_disabled_fg_color:  if($variant == 'light', $grey_500, mix($white, $base_color, percentage(0.5)));
$opaque_divider_color:      if($variant == 'light', $grey_300, mix($white, $base_color, percentage(0.12)));

// FIXME: gtk's @placeholder_text_color API really should use $secondary_fg_color,
// but it doesn't work with translucent colors. So we use opaque colors instead.
$placeholder_text_color: if($variant == 'light',
                            mix($black, $base_color, percentage(0.5)),
                            mix($white, $base_color, percentage(0.7)));
EOF

# STEP6

printf "[6/11] Using new color palette in GTK2...\n"
sleep 2s

cat > src/gtk-2.0/gtkrc << "EOF"
# Based on Bridge by ScionicSpectre and Adwaita by GNOME
# vim:set ts=2 sw=2 sts=2 ai et:
#
# This is the GTK+ 2 version of Materia. It's whole purpose is to look as the
# GTK+ 3 version as much as possible until GTK+ 2 dies completely.
#
# Note: comments for explaining styles are on the bottom of each file beside the
# widget matches.

# Declare the colours used throughout the theme.
# There shouldn't be any fiddling with them in the theme files themselves in
# order to not mess up the dark theme.

# Text/base
gtk-color-scheme = "text_color:#173F4F\nbase_color:#FFFFFF"
# Foreground/background
gtk-color-scheme = "fg_color:#173F4F\nbg_color:#EEEEEE"
# Selected foreground/background
gtk-color-scheme = "selected_fg_color:#FFFFFF\nselected_bg_color:#73BA25"
# Titlebar foreground/background
gtk-color-scheme = "titlebar_fg_color:#6DA741\ntitlebar_bg_color:#173F4F"
# Links
gtk-color-scheme = "link_color:#21A4DF\nvisited_link_color:#9625BB"

# Set GTK settings
gtk-auto-mnemonics              = 1
gtk-primary-button-warps-slider = 1

# And hand over the control to the theme files
include "main.rc"
include "apps.rc"
include "hacks.rc"
EOF

cat > src/gtk-2.0/gtkrc-dark << "EOF"
# Based on Bridge by ScionicSpectre and Adwaita by GNOME
# vim:set ts=2 sw=2 sts=2 ai et:
#
# This is the GTK+ 2 version of Materia. It's whole purpose is to look as the
# GTK+ 3 version as much as possible until GTK+ 2 dies completely.
#
# Note: comments for explaining styles are on the bottom of each file beside the
# widget matches.

# Declare the colours used throughout the theme.
# There shouldn't be any fiddling with them in the theme files themselves in
# order to not mess up the dark theme.

# Text/base
gtk-color-scheme = "text_color:#FFFFFF\nbase_color:#173F4F"
# Foreground/background
gtk-color-scheme = "fg_color:#FFFFFF\nbg_color:#12313D"
# Selected foreground/background
gtk-color-scheme = "selected_fg_color:#FFFFFF\nselected_bg_color:#73BA25"
# Titlebar foreground/background
gtk-color-scheme = "titlebar_fg_color:#FFFFFF\ntitlebar_bg_color:#173F4F"
# Links
gtk-color-scheme = "link_color:#21A4DF\nvisited_link_color:#9625BB"

# Set GTK settings
gtk-auto-mnemonics              = 1
gtk-primary-button-warps-slider = 1

# And hand over the control to the theme files
include "main.rc"
include "apps.rc"
include "hacks.rc"
EOF

cat > src/gtk-2.0/gtkrc-light << "EOF"
# Based on Bridge by ScionicSpectre and Adwaita by GNOME
# vim:set ts=2 sw=2 sts=2 ai et:
#
# This is the GTK+ 2 version of Materia. It's whole purpose is to look as the
# GTK+ 3 version as much as possible until GTK+ 2 dies completely.
#
# Note: comments for explaining styles are on the bottom of each file beside the
# widget matches.

# Declare the colours used throughout the theme.
# There shouldn't be any fiddling with them in the theme files themselves in
# order to not mess up the dark theme.

# Text/base
gtk-color-scheme = "text_color:#173F4F\nbase_color:#FFFFFF"
# Foreground/background
gtk-color-scheme = "fg_color:#173F4F\nbg_color:#EEEEEE"
# Selected foreground/background
gtk-color-scheme = "selected_fg_color:#FFFFFF\nselected_bg_color:#73BA25"
# Titlebar foreground/background
gtk-color-scheme = "titlebar_fg_color:#6DA741\ntitlebar_bg_color:#EEEEEE"
# Links
gtk-color-scheme = "link_color:#21A4DF\nvisited_link_color:#9625BB"

# Set GTK settings
gtk-auto-mnemonics              = 1
gtk-primary-button-warps-slider = 1

# And hand over the control to the theme files
include "main.rc"
include "apps.rc"
include "hacks.rc"
EOF

# STEP7

printf "[7/11] Rendering new assets...\n"
sleep 2s

./render-assets.sh

# STEP8

printf "[8/11] Rendering new styles...\n"
sleep 2s

./parse-sass.sh

# STEP9

printf "[9/11] Removing old version...\n"
sleep 2s

rm -rf ~/.themes/Erdlowe*

# STEP10

printf "[10/11] Installing new version...\n"
sleep 2s

# change theme name from materia to erdlowe
# remove blocks about chrome, metacity, unity, xfw4, and glib-compile-resource
cat > install.sh << "EOF"
#!/bin/bash
#set -ueo pipefail
#set -x

DEST_DIR=/usr/share/themes
THEME_NAME=Erdlowe
COLOR_VARIANTS=('' '-dark' '-light')
SIZE_VARIANTS=('' '-compact')

GTK_VERSIONS=('3.18' '3.20' '3.22')
GS_VERSIONS=('3.18' '3.24' '3.26')
LATEST_GS_VERSION=${GS_VERSIONS[@]: -1}

# Set a proper gnome-shell theme version
if [[ $(which gnome-shell 2> /dev/null) ]]; then
  CURRENT_GS_VERSION=$(gnome-shell --version | cut -d ' ' -f 3 | cut -d . -f -2)
  for version in "${GS_VERSIONS[@]}"; do
    if (( $(echo "$CURRENT_GS_VERSION <= $version" | bc) )); then
      GS_VERSION=${version}
      break
    elif (( $(echo "$CURRENT_GS_VERSION > $LATEST_GS_VERSION" | bc) )); then
      GS_VERSION=${LATEST_GS_VERSION}
      break
    fi
  done
else
  GS_VERSION=${LATEST_GS_VERSION}
fi

usage() {
  printf "%s\n" "Usage: $0 [OPTIONS...]"
  printf "\n%s\n" "OPTIONS:"
  printf "  %-25s%s\n" "-d, --dest DIR" "Specify theme destination directory (Default: ${DEST_DIR})"
  printf "  %-25s%s\n" "-n, --name NAME" "Specify theme name (Default: ${THEME_NAME})"
  printf "  %-25s%s\n" "-c, --color VARIANTS..." "Specify theme color variant(s) [standard|dark|light] (Default: All variants)"
  printf "  %-25s%s\n" "-s, --size VARIANT" "Specify theme size variant [standard|compact] (Default: All variants)"
  printf "  %-25s%s\n" "-h, --help" "Show this help"
  printf "\n%s\n" "INSTALLATION EXAMPLES:"
  printf "%s\n" "Install all theme variants into ~/.themes"
  printf "  %s\n" "$0 --dest ~/.themes"
  printf "%s\n" "Install standard theme variant only"
  printf "  %s\n" "$0 --color standard --size standard"
  printf "%s\n" "Install specific theme variants with different name into ~/.themes"
  printf "  %s\n" "$0 --dest ~/.themes --name MyTheme --color light dark --size compact"
}

install() {
  local dest=${1}
  local name=${2}
  local color=${3}
  local size=${4}

  [[ ${color} == '-dark' ]] && local ELSE_DARK=${color}
  [[ ${color} == '-light' ]] && local ELSE_LIGHT=${color}

  local THEME_DIR=${dest}/${name}${color}${size}

  [[ -d ${THEME_DIR} ]] && rm -rf ${THEME_DIR}

  echo "Installing '${THEME_DIR}'..."

  mkdir -p                                                                      ${THEME_DIR}
  cp -ur COPYING                                                                ${THEME_DIR}
  cp -ur src/index${color}${size}.theme                                         ${THEME_DIR}/index.theme

  mkdir -p                                                                      ${THEME_DIR}/gnome-shell
  cp -ur src/gnome-shell/{*.svg,extensions,noise-texture.png,pad-osd.css}       ${THEME_DIR}/gnome-shell
  cp -ur src/gnome-shell/assets${ELSE_DARK}                                     ${THEME_DIR}/gnome-shell/assets
  cp -ur src/gnome-shell/${GS_VERSION}/gnome-shell${color}${size}.css           ${THEME_DIR}/gnome-shell/gnome-shell.css

  mkdir -p                                                                      ${THEME_DIR}/gtk-2.0
  cp -ur src/gtk-2.0/{apps.rc,hacks.rc,main.rc}                                 ${THEME_DIR}/gtk-2.0
  cp -ur src/gtk-2.0/assets${ELSE_DARK}                                         ${THEME_DIR}/gtk-2.0/assets
  cp -ur src/gtk-2.0/gtkrc${color}                                              ${THEME_DIR}/gtk-2.0/gtkrc

  cp -ur src/gtk/assets                                                         ${THEME_DIR}/gtk-assets

  for version in "${GTK_VERSIONS[@]}"; do
    if [[ ${version} == '3.18' ]]; then
      mkdir -p                                                                  ${THEME_DIR}/gtk-3.0
      ln -sf ../gtk-assets                                                      ${THEME_DIR}/gtk-3.0/assets
      cp -ur src/gtk/${version}/gtk${color}.css                                 ${THEME_DIR}/gtk-3.0/gtk.css
      [[ ${color} != '-dark' ]] && \
      cp -ur src/gtk/${version}/gtk-dark.css                                    ${THEME_DIR}/gtk-3.0/gtk-dark.css
    else
      mkdir -p                                                                  ${THEME_DIR}/gtk-${version}
      ln -sf ../gtk-assets                                                      ${THEME_DIR}/gtk-${version}/assets
      cp -ur src/gtk/${version}/gtk${color}${size}.css                          ${THEME_DIR}/gtk-${version}/gtk.css
      [[ ${color} != '-dark' ]] && \
      cp -ur src/gtk/${version}/gtk-dark${size}.css                             ${THEME_DIR}/gtk-${version}/gtk-dark.css
    fi
  done
}

while [[ $# -gt 0 ]]; do
  case "${1}" in
    -d|--dest)
      dest="${2}"
      if [[ ! -d "${dest}" ]]; then
        echo "ERROR: Destination directory does not exist."
        exit 1
      fi
      shift 2
      ;;
    -n|--name)
      name="${2}"
      shift 2
      ;;
    -c|--color)
      shift
      for variant in "${@}"; do
        case "${variant}" in
          standard)
            colors+=("${COLOR_VARIANTS[0]}")
            shift
            ;;
          dark)
            colors+=("${COLOR_VARIANTS[1]}")
            shift
            ;;
          light)
            colors+=("${COLOR_VARIANTS[2]}")
            shift
            ;;
          -*|--*)
            break
            ;;
          *)
            echo "ERROR: Unrecognized color variant '$1'."
            echo "Try '$0 --help' for more information."
            exit 1
            ;;
        esac
      done
      ;;
    -s|--size)
      shift
      for variant in "${@}"; do
        case "${variant}" in
          standard)
            sizes+=("${SIZE_VARIANTS[0]}")
            shift
            ;;
          compact)
            sizes+=("${SIZE_VARIANTS[1]}")
            shift
            ;;
          -*|--*)
            break
            ;;
          *)
            echo "ERROR: Unrecognized size variant '$1'."
            echo "Try '$0 --help' for more information."
            exit 1
            ;;
        esac
      done
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "ERROR: Unrecognized installation option '$1'."
      echo "Try '$0 --help' for more information."
      exit 1
      ;;
  esac
done

if [[ ! -w "${dest:-${DEST_DIR}}" ]]; then
  echo "Please run as root."
  exit 1
fi

for color in "${colors[@]:-${COLOR_VARIANTS[@]}}"; do
  for size in "${sizes[@]:-${SIZE_VARIANTS[@]}}"; do
    install "${dest:-${DEST_DIR}}" "${name:-${THEME_NAME}}" "${color}" "${size}"
  done
done

echo
echo Done.
EOF

mkdir ~/.themes
./install.sh --dest ~/.themes

# STEP11

printf "[11/11] Creating release archive...\n"
sleep 2s

cd ..
rm -rf release
mkdir release
cd release
cp -r ~/.themes/Erdlowe{,-compact,-light,-light-compact,-dark,-dark-compact} $PWD
read -p "Release version (X.X-YYYYMMDD): "
echo "v$REPLY" > $PWD/Erdlowe/version.txt
tar -czf erdlowe.tar.gz Erdlowe{,-compact,-light,-light-compact,-dark,-dark-compact}
rm -rf ~/.themes/Erdlowe{,-compact,-light,-light-compact,-dark,-dark-compact}

# END

sleep 2s
printf "SUCCESS - archive is in $PWD\n"
