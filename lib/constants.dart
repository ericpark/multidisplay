import 'dart:ui';

// ignore_for_file: constant_identifier_names

/*
* TICKER CONSTANTS
*/

//Duration in seconds for one tick of the ticker
const TICKER_DURATION_IN_SECONDS = 30;

// Number of ticks for the timer to tick.
// The goal is to have one cycle complete every 2 hours (7200 seconds)
// 7200 (seconds total) / 30 (seconds per tick) = 240 ticks (duration)
const DEFAULT_TICKER_DURATION = 240;

//Duration in seconds for a tick lasting every 5 minutes
const LONG_TICKER_DURATION_IN_SECONDS = 60 * 5;

// Number of ticks for the timer to tick.
// The goal is to have one cycle complete every 1 hours (3600 seconds)
// 3600 (seconds total) / 300 (seconds per tick) = 12 ticks (duration)
const LONG_TICKER_DURATION = 12;

/*
 * Theme Constants
 */

const PRIMARY_COLOR = Color(0xFFC3EFF2);
const SECONDARY_COLOR = Color(0xFF6AD996);
const ACCENT_COLOR = Color(0xFFD9846A);
const DEEP_PRIMARY_COLOR = Color(0xFF6A8CD9);
const TEAL_GREEN_COLOR = Color(0xFF6AD9BB);
const DARK_GREEN_COLOR = Color(0xFF029100);
const DARKER_BLUE_COLOR = Color(0xFF6C6AD9);
