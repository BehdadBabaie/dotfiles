// =========================
//      dwmblocks-async
//        CONFIG FILE
// =========================

#define DELIMITER " • "

#define MAX_BLOCK_OUTPUT_LENGTH 64
#define UTF8_MAX_BYTE_COUNT     4

#define CLICKABLE_BLOCKS        0
#define LEADING_DELIMITER       0
#define TRAILING_DELIMITER      0

// -------------------------
//       BLOCKS
// -------------------------
// NOTE: No trailing commas allowed in this fork.

#define BLOCKS(X) \
    X(" ", "amixer get Master | tail -n1 | awk '{print $5}' | tr -d '[]%'", 0, 10) \
    X(" ", "free -h | awk '/Mem/ {print $3\"/\"$2}'", 10, 0) \
    X("󰍛 ", "nproc", 3600, 0) \
    X("󰖩 ", "curl -fsS --max-time 2 https://ipinfo.io/ip || echo \"???\"", 3600, 0) \
    X("󰃰 ", "date '+%d %b %Y'", 86400, 0) \
    X(" ", "date '+%H:%M'", 5, 0)

