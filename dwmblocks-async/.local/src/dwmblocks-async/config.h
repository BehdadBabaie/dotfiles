// =========================
//   dwmblocks-async CONFIG
//   Catppuccin Mocha theme + Nerd Font + Colored Blocks
//   FIXED for compilation: escaped %, /, and trigraphs
// =========================

#define DELIMITER " ^c#5E5E5E^•^d^ "

#define MAX_BLOCK_OUTPUT_LENGTH 128
#define UTF8_MAX_BYTE_COUNT     4

#define CLICKABLE_BLOCKS        0
#define LEADING_DELIMITER       0
#define TRAILING_DELIMITER      0

// -------------------------
// COLOR PALETTE: Catppuccin Mocha
// -------------------------
#define COL_BG "#1E1E2E"
#define COL_FOREGROUND "#D9E0EE"
#define COL_BLUE "#89B4FA"
#define COL_GREEN "#A6E3A1"
#define COL_YELLOW "#F9E2AF"
#define COL_ORANGE "#F5C2E7"
#define COL_RED "#F38BA8"
#define COL_PURPLE "#CBA6F7"
#define COL_TEAL "#94E2D5"

// Wrap text in color
#define C(color, text) "^c" color "^" text "^d^"

// -------------------------
// BLOCKS
// -------------------------
// NO TRAILING COMMAS ALLOWED
#define BLOCKS(X) \
    /* Volume (PipeWire via pamixer) */ \
    X(C(COL_BLUE, " "), "pamixer --get-volume | awk '{print $1\"%%\"}'", 5, 10) \
    \
    /* RAM Usage */ \
    X(C(COL_GREEN, " "), "free -h | awk '/Mem/ {print $3\"/\"$2}'", 10, 0) \
    \
    /* CPU Temperature */ \
    X(C(COL_RED, "󰔏 "), "sensors | awk '/Package/ {print $4}' | tr -d '+'", 5, 0) \
    \
    /* CPU Load */ \
    X(C(COL_ORANGE, " "), "awk '{u=$2+$4; t=$2+$4+$5+$6+$7} END {printf \"%d%%\", (u/t*100)}' /proc/stat", 5, 0) \
    \
    /* WiFi SSID + Signal */ \
    X(C(COL_TEAL, "󰖩 "), "iw dev wlan0 link | awk '/SSID/ {ssid=$2}; /signal/ {print ssid\" \"int(($2+90)/2)}'", 10, 0) \
    \
    /* Battery */ \
    X(C(COL_PURPLE, " "), "acpi -b | awk -F ', ' '{print $2}'", 30, 0) \
    \
    /* Brightness */ \
    X(C(COL_YELLOW, "󰃞 "), "brightnessctl g | awk '{print $1\"%%\"}'", 10, 0) \
    \
    /* VPN Status */ \
    X(C(COL_ORANGE, "󰯄 "), "(pgrep openvpn >/dev/null || pgrep nordvpnd >/dev/null || pgrep windscribe >/dev/null) && echo ON || echo OFF", 15, 0) \
    \
    /* Disk Usage */ \
    X(C(COL_BLUE, " "), "df -h / | awk 'NR==2{print $3\"/\"$2}'", 60, 0) \
    \
    /* Public IP */ \
    X(C(COL_GREEN, " "), "curl -fsS --max-time 2 https://ipinfo.io/ip || echo \"???\"", 3600, 0) \
    \
    /* Local IP */ \
    X(C(COL_TEAL, "󰅘 "), "hostname -I | awk '{print $1}'", 60, 0) \
    \
    /* Date */ \
    X(C(COL_YELLOW, "󰃰 "), "date '+%d %b %Y'", 3600, 0) \
    \
    /* Time */ \
    X(C(COL_ORANGE, " "), "date '+%H:%M'", 5, 0)
