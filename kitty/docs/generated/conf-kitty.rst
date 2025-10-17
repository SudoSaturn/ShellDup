.. highlight:: conf

.. default-domain:: conf


.. _conf-kitty-fonts:

Fonts
-------------------------

kitty has very powerful font management. You can configure individual font faces
and even specify special fonts for particular characters.

.. opt:: kitty.font_family, kitty.bold_font, kitty.italic_font, kitty.bold_italic_font
.. code-block:: conf

    font_family      monospace
    bold_font        auto
    italic_font      auto
    bold_italic_font auto

You can specify different fonts for the bold/italic/bold-italic variants.
The easiest way to select fonts is to run the ``kitten choose-fonts`` command
which will present a nice UI for you to select the fonts you want with previews
and support for selecting variable fonts and font features. If you want to learn
to select fonts manually, read the :ref:`font specification syntax <font_spec_syntax>`.

.. opt:: kitty.font_size
.. code-block:: conf

    font_size 11.0

Font size (in pts).

.. opt:: kitty.force_ltr
.. code-block:: conf

    force_ltr no

kitty does not support BIDI (bidirectional text), however, for RTL scripts,
words are automatically displayed in RTL. That is to say, in an RTL script, the
words "HELLO WORLD" display in kitty as "WORLD HELLO", and if you try to select
a substring of an RTL-shaped string, you will get the character that would be
there had the string been LTR. For example, assuming the Hebrew word
ירושלים, selecting the character that on the screen appears to be ם actually
writes into the selection buffer the character י. kitty's default behavior is
useful in conjunction with a filter to reverse the word order, however, if you
wish to manipulate RTL glyphs, it can be very challenging to work with, so this
option is provided to turn it off. Furthermore, this option can be used with the
command line program :link:`GNU FriBidi
<https://github.com/fribidi/fribidi#executable>` to get BIDI support, because it
will force kitty to always treat the text as LTR, which FriBidi expects for
terminals.

.. opt:: kitty.symbol_map

Has no default values. Example values are shown below:

.. code-block:: conf

    symbol_map U+E0A0-U+E0A3,U+E0C0-U+E0C7 PowerlineSymbols

Map the specified Unicode codepoints to a particular font. Useful if you need
special rendering for some symbols, such as for Powerline. Avoids the need for
patched fonts. Each Unicode code point is specified in the form ``U+<code
point in hexadecimal>``. You can specify multiple code points, separated by
commas and ranges separated by hyphens. This option can be specified multiple
times. The syntax is::

    symbol_map codepoints Font Family Name

.. opt:: kitty.narrow_symbols

Has no default values. Example values are shown below:

.. code-block:: conf

    narrow_symbols U+E0A0-U+E0A3,U+E0C0-U+E0C7 1

Usually, for Private Use Unicode characters and some symbol/dingbat characters,
if the character is followed by one or more spaces, kitty will use those extra
cells to render the character larger, if the character in the font has a wide
aspect ratio. Using this option you can force kitty to restrict the specified
code points to render in the specified number of cells (defaulting to one cell).
This option can be specified multiple times. The syntax is::

    narrow_symbols codepoints [optionally the number of cells]

.. opt:: kitty.disable_ligatures
.. code-block:: conf

    disable_ligatures never

Choose how you want to handle multi-character ligatures. The default is to
always render them. You can tell kitty to not render them when the cursor is
over them by using :code:`cursor` to make editing easier, or have kitty never
render them at all by using :code:`always`, if you don't like them. The ligature
strategy can be set per-window either using the kitty remote control facility
or by defining shortcuts for it in :file:`kitty.conf`, for example::

    map alt+1 disable_ligatures_in active always
    map alt+2 disable_ligatures_in all never
    map alt+3 disable_ligatures_in tab cursor

Note that this refers to programming ligatures, typically implemented using the
:code:`calt` OpenType feature. For disabling general ligatures, use the
:opt:`font_features <kitty.font_features>` option.

.. opt:: kitty.font_features

Has no default values. Example values are shown below:

.. code-block:: conf

    font_features none

Choose exactly which OpenType features to enable or disable. Note that for the
main fonts, features can be specified when selecting the font using the choose-fonts kitten.
This setting is useful for fallback fonts.

Some fonts might have features worthwhile in a terminal. For example, Fira Code
includes a discretionary feature, :code:`zero`, which in that font changes the
appearance of the zero (0), to make it more easily distinguishable from Ø. Fira
Code also includes other discretionary features known as Stylistic Sets which
have the tags :code:`ss01` through :code:`ss20`.

For the exact syntax to use for individual features, see the
:link:`HarfBuzz documentation
<https://harfbuzz.github.io/harfbuzz-hb-common.html#hb-feature-from-string>`.

Note that this code is indexed by PostScript name, and not the font family. This
allows you to define very precise feature settings; e.g. you can disable a
feature in the italic font but not in the regular font.

On Linux, font features are first read from the FontConfig database and then
this option is applied, so they can be configured in a single, central place.

To get the PostScript name for a font, use the ``fc-scan file.ttf`` command on Linux
or the `Font Book tool on macOS <https://apple.stackexchange.com/questions/79875/how-can-i-get-the-postscript-name-of-a-ttf-font-installed-in-os-x>`__.

Enable alternate zero and oldstyle numerals::

    font_features FiraCode-Retina +zero +onum

Enable only alternate zero in the bold font::

    font_features FiraCode-Bold +zero

Disable the normal ligatures, but keep the :code:`calt` feature which (in this
font) breaks up monotony::

    font_features TT2020StyleB-Regular -liga +calt

In conjunction with :opt:`force_ltr <kitty.force_ltr>`, you may want to disable Arabic shaping
entirely, and only look at their isolated forms if they show up in a document.
You can do this with e.g.::

    font_features UnifontMedium +isol -medi -fina -init

.. opt:: kitty.modify_font

Modify font characteristics such as the position or thickness of the underline
and strikethrough. The modifications can have the suffix :code:`px` for pixels
or :code:`%` for percentage of original value. No suffix means use pts.
For example::

    modify_font underline_position -2
    modify_font underline_thickness 150%
    modify_font strikethrough_position 2px

Additionally, you can modify the size of the cell in which each font glyph is
rendered and the baseline at which the glyph is placed in the cell.
For example::

    modify_font cell_width 80%
    modify_font cell_height -2px
    modify_font baseline 3

Note that modifying the baseline will automatically adjust the underline and
strikethrough positions by the same amount. Increasing the baseline raises
glyphs inside the cell and decreasing it lowers them. Decreasing the cell size
might cause rendering artifacts, so use with care.

.. opt:: kitty.box_drawing_scale
.. code-block:: conf

    box_drawing_scale 0.001, 1, 1.5, 2

The sizes of the lines used for the box drawing Unicode characters. These values
are in pts. They will be scaled by the monitor DPI to arrive at a pixel value.
There must be four values corresponding to thin, normal, thick, and very thick
lines.

.. opt:: kitty.undercurl_style
.. code-block:: conf

    undercurl_style thin-sparse

The style with which undercurls are rendered. This option takes the form
:code:`(thin|thick)-(sparse|dense)`. Thin and thick control the thickness of the
undercurl. Sparse and dense control how often the curl oscillates. With sparse
the curl will peak once per character, with dense twice. Changing this
option dynamically via reloading the config or remote control is undefined.

.. opt:: kitty.underline_exclusion
.. code-block:: conf

    underline_exclusion 1

By default kitty renders gaps in underlines when they overlap with descenders
(the parts of letters below the baseline, such as for y, q, p etc.). This option
controls the thickness of the gaps. It can be either a unitless number in which
case it is a fraction of the underline thickness as specified in the font or
it can have a suffix of :code:`px` for pixels or :code:`pt` for points. Set to zero
to disable the gaps. Changing this option dynamically via reloading the config or remote
control is undefined.

.. opt:: kitty.text_composition_strategy
.. code-block:: conf

    text_composition_strategy platform

Control how kitty composites text glyphs onto the background color. The default
value of :code:`platform` tries for text rendering as close to "native" for
the platform kitty is running on as possible.

A value of :code:`legacy` uses the old (pre kitty 0.28) strategy for how glyphs
are composited. This will make dark text on light backgrounds look thicker and
light text on dark backgrounds thinner. It might also make some text appear like
the strokes are uneven.

You can fine tune the actual contrast curve used for glyph composition by
specifying up to two space-separated numbers for this setting.

The first number is the gamma adjustment, which controls the thickness of dark
text on light backgrounds. Increasing the value will make text appear thicker.
The default value for this is :code:`1.0` on Linux and :code:`1.7` on macOS.
Valid values are :code:`0.01` and above. The result is scaled based on the
luminance difference between the background and the foreground. Dark text on
light backgrounds receives the full impact of the curve while light text on dark
backgrounds is affected very little.

The second number is an additional multiplicative contrast. It is percentage
ranging from :code:`0` to :code:`100`. The default value is :code:`0` on Linux
and :code:`30` on macOS.

If you wish to achieve similar looking thickness in light and dark themes, a good way
to experiment is start by setting the value to :code:`1.0 0` and use a dark theme.
Then adjust the second parameter until it looks good. Then switch to a light theme
and adjust the first parameter until the perceived thickness matches the dark theme.

.. opt:: kitty.text_fg_override_threshold
.. code-block:: conf

    text_fg_override_threshold 0

A setting to prevent low contrast between foreground and background colors.
Useful when working with applications that use colors that do not contrast
well with your preferred color scheme. The default value is :code:`0`, which means no color overriding is performed.
There are two modes of operation:

A value with the suffix :code:`ratio` represents the minimum accepted contrast ratio between the foreground and background color.
Possible values range from :code:`0.0 ratio` to :code:`21.0 ratio`.
For example, to meet :link:`WCAG level AA <https://en.wikipedia.org/wiki/Web_Content_Accessibility_Guidelines>`
a value of :code:`4.5 ratio` can be provided.
The algorithm is implemented using :link:`HSLuv <https://www.hsluv.org/>` which enables it to change
the perceived lightness of a color just as much as needed without really changing its hue and saturation.

A value with the suffix :code:`%` represents the minimum accepted difference in luminance
between the foreground and background color, below which kitty will override the foreground color.
It is percentage ranging from :code:`0 %` to :code:`100 %`. If the difference in luminance of the
foreground and background is below this threshold, the foreground color will be set
to white if the background is dark or black if the background is light.

WARNING: Some programs use characters (such as block characters) for graphics
display and may expect to be able to set the foreground and background to the
same color (or similar colors). If you see unexpected stripes, dots, lines,
incorrect color, no color where you expect color, or any kind of graphic
display problem try setting :opt:`text_fg_override_threshold <kitty.text_fg_override_threshold>` to :code:`0` to
see if this is the cause of the problem or consider using the :code:`ratio` mode of operation
described above instead of the :code:`%` mode of operation.


.. _conf-kitty-cursor:

Text cursor customization
---------------------------------------------

.. opt:: kitty.cursor
.. code-block:: conf

    cursor #cccccc

Default text cursor color. If set to the special value :code:`none` the cursor will
be rendered with a "reverse video" effect. Its color will be the color of the
text in the cell it is over and the text will be rendered with the background
color of the cell. Note that if the program running in the terminal sets a
cursor color, this takes precedence. Also, the cursor colors are modified if
the cell background and foreground colors have very low contrast. Note that some
themes set this value, so if you want to override it, place your value after
the lines where the theme file is included.

.. opt:: kitty.cursor_text_color
.. code-block:: conf

    cursor_text_color #111111

The color of text under the cursor. If you want it rendered with the
background color of the cell underneath instead, use the special keyword:
`background`. Note that if :opt:`cursor <kitty.cursor>` is set to :code:`none` then this option
is ignored. Note that some themes set this value, so if you want to override it,
place your value after the lines where the theme file is included.

.. opt:: kitty.cursor_shape
.. code-block:: conf

    cursor_shape block

The cursor shape can be one of :code:`block`, :code:`beam`, :code:`underline`.
Note that when reloading the config this will be changed only if the cursor
shape has not been set by the program running in the terminal. This sets the
default cursor shape, applications running in the terminal can override it. In
particular, :ref:`shell integration <shell_integration>` in kitty sets the
cursor shape to :code:`beam` at shell prompts. You can avoid this by setting
:opt:`shell_integration <kitty.shell_integration>` to :code:`no-cursor`.

.. opt:: kitty.cursor_shape_unfocused
.. code-block:: conf

    cursor_shape_unfocused hollow

Defines the text cursor shape when the OS window is not focused. The unfocused
cursor shape can be one of :code:`block`, :code:`beam`, :code:`underline`,
:code:`hollow` and :code:`unchanged` (leave the cursor shape as it is).

.. opt:: kitty.cursor_beam_thickness
.. code-block:: conf

    cursor_beam_thickness 1.5

The thickness of the beam cursor (in pts).

.. opt:: kitty.cursor_underline_thickness
.. code-block:: conf

    cursor_underline_thickness 2.0

The thickness of the underline cursor (in pts).

.. opt:: kitty.cursor_blink_interval
.. code-block:: conf

    cursor_blink_interval -1

The interval to blink the cursor (in seconds). Set to zero to disable blinking.
Negative values mean use system default. Note that the minimum interval will be
limited to :opt:`repaint_delay <kitty.repaint_delay>`. You can also animate the cursor blink by specifying
an :term:`easing function`. For example, setting this to option to :code:`0.5 ease-in-out`
will cause the cursor blink to be animated over a second, in the first half of the second
it will go from opaque to transparent and then back again over the next half. You can specify
different easing functions for the two halves, for example: :code:`-1 linear ease-out`. kitty
supports all the :link:`CSS easing functions <https://developer.mozilla.org/en-US/docs/Web/CSS/easing-function>`.
Note that turning on animations uses extra power as it means the screen is redrawn multiple times
per blink interval. See also, :opt:`cursor_stop_blinking_after <kitty.cursor_stop_blinking_after>`. This setting also controls blinking
text, which blinks in exact rhythm with the cursor.

.. opt:: kitty.cursor_stop_blinking_after
.. code-block:: conf

    cursor_stop_blinking_after 15.0

Stop blinking cursor after the specified number of seconds of keyboard
inactivity. Set to zero to never stop blinking. This setting also controls
blinking text, which blinks in exact rhythm with the cursor.

.. opt:: kitty.cursor_trail
.. code-block:: conf

    cursor_trail 0

Set this to a value larger than zero to enable a "cursor trail" animation.
This is an animation that shows a "trail" following the movement of the text cursor.
It makes it easy to follow large cursor jumps and makes for a cool visual effect
of the cursor zooming around the screen. The actual value of this option
controls when the animation is triggered. It is a number of milliseconds. The
trail animation only follows cursors that have stayed in their position for longer
than the specified number of milliseconds. This prevents trails from appearing
for cursors that rapidly change their positions during UI updates in complex applications.
See :opt:`cursor_trail_decay <kitty.cursor_trail_decay>` to control the animation speed and :opt:`cursor_trail_start_threshold <kitty.cursor_trail_start_threshold>`
to control when a cursor trail is started.

.. opt:: kitty.cursor_trail_decay
.. code-block:: conf

    cursor_trail_decay 0.1 0.4

Controls the decay times for the cursor trail effect when the :opt:`cursor_trail <kitty.cursor_trail>`
is enabled. This option accepts two positive float values specifying the
fastest and slowest decay times in seconds. The first value corresponds to the
fastest decay time (minimum), and the second value corresponds to the slowest
decay time (maximum). The second value must be equal to or greater than the
first value. Smaller values result in a faster decay of the cursor trail.
Adjust these values to control how quickly the cursor trail fades away.

.. opt:: kitty.cursor_trail_start_threshold
.. code-block:: conf

    cursor_trail_start_threshold 2

Set the distance threshold for starting the cursor trail. This option accepts a
positive integer value that represents the minimum number of cells the
cursor must move before the trail is started. When the cursor moves less than
this threshold, the trail is skipped, reducing unnecessary cursor trail
animation.

.. opt:: kitty.cursor_trail_color
.. code-block:: conf

    cursor_trail_color none

Set the color of the cursor trail when :opt:`cursor_trail <kitty.cursor_trail>` is enabled.
If set to 'none' (the default), the cursor trail will use the cursor's
background color. Otherwise, specify a color value (e.g., #ff0000 for red,
or a named color like 'red'). This allows you to customize the appearance
of the cursor trail independently of the cursor color.


.. _conf-kitty-scrollback:

Scrollback
------------------------------

.. opt:: kitty.scrollback_lines
.. code-block:: conf

    scrollback_lines 2000

Number of lines of history to keep in memory for scrolling back. Memory is
allocated on demand. Negative numbers are (effectively) infinite scrollback.
Note that using very large scrollback is not recommended as it can slow down
performance of the terminal and also use large amounts of RAM. Instead, consider
using :opt:`scrollback_pager_history_size <kitty.scrollback_pager_history_size>`. Note that on config reload if this
is changed it will only affect newly created windows, not existing ones.

.. opt:: kitty.scrollbar
.. code-block:: conf

    scrollbar scrolled

Control when the scrollbar is displayed.

:code:`scrolled`
    means when the scrolling backwards has started.
:code:`hovered`
    means when the mouse is hovering on the right edge of the window.
:code:`scrolled-and-hovered`
    means when the mouse is over the scrollbar region *and* scrolling backwards has started.
:code:`always`
    means whenever any scrollback is present
:code:`never`
    means disable the scrollbar.

.. opt:: kitty.scrollbar_interactive
.. code-block:: conf

    scrollbar_interactive yes

If disabled, the scrollbar will not be controllable via th emouse and all mouse events
will pass through the scrollbar.

.. opt:: kitty.scrollbar_jump_on_click
.. code-block:: conf

    scrollbar_jump_on_click yes

When enabled clicking in the scrollbar track will cause the scroll position to
jump to the clicked location, otherwise the scroll position will only move
towards the position by a single screenful, which is how traditional scrollbars behave.

.. opt:: kitty.scrollbar_width
.. code-block:: conf

    scrollbar_width 0.5

The width of the scroll bar in units of cell width.

.. opt:: kitty.scrollbar_hover_width
.. code-block:: conf

    scrollbar_hover_width 1

The width of the scroll bar when the mouse is hovering over it, in units of cell width.

.. opt:: kitty.scrollbar_handle_opacity
.. code-block:: conf

    scrollbar_handle_opacity 0.5

The opacity of the scrollbar handle, 0 being fully transparent and 1 being full opaque.

.. opt:: kitty.scrollbar_radius
.. code-block:: conf

    scrollbar_radius 0.3

The radius (curvature) of the scrollbar handle in units of cell width. Should be less than
:opt:`scrollbar_width <kitty.scrollbar_width>`.

.. opt:: kitty.scrollbar_gap
.. code-block:: conf

    scrollbar_gap 0.1

The gap between the scrollbar and the window edge in units of cell width.

.. opt:: kitty.scrollbar_min_handle_height
.. code-block:: conf

    scrollbar_min_handle_height 1

The minimum height of the scrollbar handle in units of cell height. Prevents the handle
from becoming too small when there is a lot of scrollback.

.. opt:: kitty.scrollbar_hitbox_expansion
.. code-block:: conf

    scrollbar_hitbox_expansion 0.25

The extra area around the handle to allow easier grabbing of the scollbar in units of cell width.

.. opt:: kitty.scrollbar_track_opacity
.. code-block:: conf

    scrollbar_track_opacity 0

The opacity of the scrollbar track, 0 being fully transparent and 1 being full opaque.

.. opt:: kitty.scrollbar_track_hover_opacity
.. code-block:: conf

    scrollbar_track_hover_opacity 0.1

The opacity of the scrollbar track when the mouse is over the scrollbar,
0 being fully transparent and 1 being full opaque.

.. opt:: kitty.scrollbar_handle_color
.. code-block:: conf

    scrollbar_handle_color foreground

The color of the scrollbar handle. A value of :code:`foreground` means to use
the current foreground text color, a value of :code:`selection_background` means to
use the current selection background color. Also, you can use an
arbitrary color, such as :code:`#12af59` or :code:`red`.

.. opt:: kitty.scrollbar_track_color
.. code-block:: conf

    scrollbar_track_color foreground

The color of the scrollbar track. A value of :code:`foreground` means to use
the current foreground text color, a value of :code:`selection_background` means to
use the current selection background color. Also, you can use an
arbitrary color, such as :code:`#12af59` or :code:`red`.

.. opt:: kitty.scrollback_pager
.. code-block:: conf

    scrollback_pager less --chop-long-lines --RAW-CONTROL-CHARS +INPUT_LINE_NUMBER

Program with which to view scrollback in a new window. The scrollback buffer is
passed as STDIN to this program. If you change it, make sure the program you use
can handle ANSI escape sequences for colors and text formatting.
INPUT_LINE_NUMBER in the command line above will be replaced by an integer
representing which line should be at the top of the screen. Similarly
CURSOR_LINE and CURSOR_COLUMN will be replaced by the current cursor position or
set to 0 if there is no cursor, for example, when showing the last command
output.

If you would rather use neovim to view the scrollback, use something like this::

    scrollback_pager nvim --cmd 'set eventignore=FileType' +'nnoremap q ZQ' +'call nvim_open_term(0, {})' +'set nomodified nolist' +'$' -

The above works for neovim 0.12 and newer. There is also a dedicated plugin
:link:`kitty-scrollback.nvim <https://github.com/mikesmithgh/kitty-scrollback.nvim>`
you can use with more features that works with older neovim as well.

.. opt:: kitty.scrollback_pager_history_size
.. code-block:: conf

    scrollback_pager_history_size 0

Separate scrollback history size (in MB), used only for browsing the scrollback
buffer with pager. This separate buffer is not available for interactive
scrolling but will be piped to the pager program when viewing scrollback buffer
in a separate window. The current implementation stores the data in UTF-8, so
approximately 10000 lines per megabyte at 100 chars per line, for pure ASCII,
unformatted text. A value of zero or less disables this feature. The maximum
allowed size is 4GB. Note that on config reload if this is changed it will only
affect newly created windows, not existing ones.

.. opt:: kitty.scrollback_fill_enlarged_window
.. code-block:: conf

    scrollback_fill_enlarged_window no

Fill new space with lines from the scrollback buffer after enlarging a window.

.. opt:: kitty.wheel_scroll_multiplier
.. code-block:: conf

    wheel_scroll_multiplier 5.0

Multiplier for the number of lines scrolled by the mouse wheel. Note that this
is only used for low precision scrolling devices, not for high precision
scrolling devices on platforms such as macOS and Wayland. Use negative numbers
to change scroll direction. See also :opt:`wheel_scroll_min_lines <kitty.wheel_scroll_min_lines>`.

.. opt:: kitty.wheel_scroll_min_lines
.. code-block:: conf

    wheel_scroll_min_lines 1

The minimum number of lines scrolled by the mouse wheel. The :opt:`scroll
multiplier <wheel_scroll_multiplier>` only takes effect after it reaches this
number. Note that this is only used for low precision scrolling devices like
wheel mice that scroll by very small amounts when using the wheel. With a
negative number, the minimum number of lines will always be added.

.. opt:: kitty.touch_scroll_multiplier
.. code-block:: conf

    touch_scroll_multiplier 1.0

Multiplier for the number of lines scrolled by a touchpad. Note that this is
only used for high precision scrolling devices on platforms such as macOS and
Wayland. Use negative numbers to change scroll direction.


.. _conf-kitty-mouse:

Mouse
-------------------------

.. opt:: kitty.mouse_hide_wait
.. code-block:: conf

    mouse_hide_wait 3.0

Hide mouse cursor after the specified number of seconds of the mouse not being
used. Set to zero to disable mouse cursor hiding. Set to a negative value to
hide the mouse cursor immediately when typing text. Disabled by default on macOS
as getting it to work robustly with the ever-changing sea of bugs that is Cocoa
is too much effort.

By default, once the cursor is hidden, it is immediately unhidden on any
further mouse events.

Two formats are supported:
 - :code:`<hide-wait>`
 - :code:`<hide-wait> <unhide-wait> <unhide-threshold> <scroll-unhide>`

To change the unhide behavior, the optional parameters :code:`<unhide-wait>`,
:code:`<unhide-threshold>`, and :code:`<scroll-unhide>` may be set.

:code:`<unhide-wait>`
    Waits for the specified number of seconds after mouse events before unhiding the
    mouse cursor. Set to zero to unhide mouse cursor immediately on mouse activity.
    This is useful to prevent the mouse cursor from unhiding on accidental swipes on
    the trackpad.

:code:`<unhide-threshold>`
    Sets the threshold of mouse activity required to unhide the mouse cursor, when
    the <unhide-wait> option is non-zero. When <unhide-wait> is zero, this has no
    effect.

    For example, if :code:`<unhide-threshold>` is 40 and :code:`<unhide-wait>` is 2.5, when kitty
    detects a mouse event, it records the number of mouse events in the next 2.5
    seconds, and checks if that exceeds 40 * 2.5 = 100. If it does, then the mouse
    cursor is unhidden, otherwise nothing happens.

:code:`<scroll-unhide>`
    Controls what mouse events may unhide the mouse cursor. If enabled, both scroll
    and movement events may unhide the cursor. If disabled, only mouse movements can
    unhide the cursor.

Examples of valid values:
 - :code:`0.0`
 - :code:`1.0`
 - :code:`-1.0`
 - :code:`0.1 3.0 40 yes`

.. opt:: kitty.url_color, kitty.url_style
.. code-block:: conf

    url_color #0087bd
    url_style curly

The color and style for highlighting URLs on mouse-over. :opt:`url_style <kitty.url_style>` can
be one of: :code:`none`, :code:`straight`, :code:`double`, :code:`curly`,
:code:`dotted`, :code:`dashed`.

.. opt:: kitty.open_url_with
.. code-block:: conf

    open_url_with default

The program to open clicked URLs. The special value :code:`default` will first
look for any URL handlers defined via the :doc:`open_actions` facility and if
non are found, it will use the Operating System's default URL handler
(:program:`open` on macOS and :program:`xdg-open` on Linux).

.. opt:: kitty.url_prefixes
.. code-block:: conf

    url_prefixes file ftp ftps gemini git gopher http https irc ircs kitty mailto news sftp ssh

The set of URL prefixes to look for when detecting a URL under the mouse cursor.

.. opt:: kitty.detect_urls
.. code-block:: conf

    detect_urls yes

Detect URLs under the mouse. Detected URLs are highlighted with an underline and
the mouse cursor becomes a hand over them. Even if this option is disabled, URLs
are still clickable. See also the :opt:`underline_hyperlinks <kitty.underline_hyperlinks>` option to control
how hyperlinks (as opposed to plain text URLs) are displayed.

.. opt:: kitty.url_excluded_characters

Additional characters to be disallowed from URLs, when detecting URLs under the
mouse cursor. By default, all characters that are legal in URLs are allowed.
Additionally, newlines are allowed (but stripped). This is to accommodate
programs such as mutt that add hard line breaks even for continued lines.
:code:`\\n` can be added to this option to disable this behavior. Special
characters can be specified using backslash escapes, to specify a backslash use
a double backslash.

.. opt:: kitty.show_hyperlink_targets
.. code-block:: conf

    show_hyperlink_targets no

When the mouse hovers over a terminal hyperlink, show the actual URL that will
be activated when the hyperlink is clicked.

.. opt:: kitty.underline_hyperlinks
.. code-block:: conf

    underline_hyperlinks hover

Control how hyperlinks are underlined. They can either be underlined on mouse
:code:`hover`, :code:`always` (i.e. permanently underlined) or :code:`never` which means
that kitty will not apply any underline styling to hyperlinks. Note that the value of :code:`always`
only applies to real (OSC 8) hyperlinks not text that is detected to be a URL on mouse hover.
Uses the :opt:`url_style <kitty.url_style>` and :opt:`url_color <kitty.url_color>` settings for the underline style. Note
that reloading the config and changing this value to/from :code:`always` will only
affect text subsequently received by kitty.

.. opt:: kitty.copy_on_select
.. code-block:: conf

    copy_on_select no

Copy to clipboard or a private buffer on select. With this set to
:code:`clipboard`, selecting text with the mouse will cause the text to be
copied to clipboard. Useful on platforms such as macOS that do not have the
concept of primary selection. You can instead specify a name such as :code:`a1`
to copy to a private kitty buffer. Map a shortcut with the
:code:`paste_from_buffer` action to paste from this private buffer.
For example::

    copy_on_select a1
    map shift+cmd+v paste_from_buffer a1

Note that copying to the clipboard is a security risk, as all programs,
including websites open in your browser can read the contents of the system
clipboard.

.. opt:: kitty.clear_selection_on_clipboard_loss
.. code-block:: conf

    clear_selection_on_clipboard_loss no

When the contents of the clipboard no longer reflect the current selection, clear it.
This is primarily useful on platforms such as Linux where selecting text automatically
copies it to a special "primary selection" clipboard or if you have :opt:`copy_on_select <kitty.copy_on_select>`
set to :code:`clipboard`.

Note that on macOS the system does not provide notifications when the clipboard owner
is changed, so there, copying to clipboard in a non-kitty application will not clear
selections even if :opt:`copy_on_select <kitty.copy_on_select>` is enabled.

.. opt:: kitty.paste_actions
.. code-block:: conf

    paste_actions quote-urls-at-prompt,confirm

A comma separated list of actions to take when pasting text into the terminal.
The supported paste actions are:

:code:`quote-urls-at-prompt`:
    If the text being pasted is a URL and the cursor is at a shell prompt,
    automatically quote the URL (needs :opt:`shell_integration <kitty.shell_integration>`).
:code:`replace-dangerous-control-codes`
    Replace dangerous control codes from pasted text, without confirmation.
:code:`replace-newline`
    Replace the newline character from pasted text, without confirmation.
:code:`confirm`:
    Confirm the paste if the text to be pasted contains any terminal control codes
    as this can be dangerous, leading to code execution if the shell/program running
    in the terminal does not properly handle these.
:code:`confirm-if-large`
    Confirm the paste if it is very large (larger than 16KB) as pasting
    large amounts of text into shells can be very slow.
:code:`filter`:
    Run the filter_paste() function from the file :file:`paste-actions.py` in
    the kitty config directory on the pasted text. The text returned by the
    function will be actually pasted.
:code:`no-op`:
    Has no effect.

.. opt:: kitty.strip_trailing_spaces
.. code-block:: conf

    strip_trailing_spaces never

Remove spaces at the end of lines when copying to clipboard. A value of
:code:`smart` will do it when using normal selections, but not rectangle
selections. A value of :code:`always` will always do it.

.. opt:: kitty.select_by_word_characters
.. code-block:: conf

    select_by_word_characters @-./_~?&=%+#

Characters considered part of a word when double clicking. In addition to these
characters any character that is marked as an alphanumeric character in the
Unicode database will be matched.

.. opt:: kitty.select_by_word_characters_forward

Characters considered part of a word when extending the selection forward on
double clicking. In addition to these characters any character that is marked
as an alphanumeric character in the Unicode database will be matched.

If empty (default) :opt:`select_by_word_characters <kitty.select_by_word_characters>` will be used for both
directions.

.. opt:: kitty.click_interval
.. code-block:: conf

    click_interval -1.0

The interval between successive clicks to detect double/triple clicks (in
seconds). Negative numbers will use the system default instead, if available, or
fallback to 0.5.

.. opt:: kitty.focus_follows_mouse
.. code-block:: conf

    focus_follows_mouse no

Set the active window to the window under the mouse when moving the mouse around.
On macOS, this will also cause the OS Window under the mouse to be focused automatically when the
mouse enters it.

.. opt:: kitty.pointer_shape_when_grabbed
.. code-block:: conf

    pointer_shape_when_grabbed arrow

The shape of the mouse pointer when the program running in the terminal grabs
the mouse.

.. opt:: kitty.default_pointer_shape
.. code-block:: conf

    default_pointer_shape beam

The default shape of the mouse pointer.

.. opt:: kitty.pointer_shape_when_dragging
.. code-block:: conf

    pointer_shape_when_dragging beam crosshair

The default shape of the mouse pointer when dragging across text. The optional second value
sets the shape when dragging in rectangular selection mode.


.. _conf-kitty-mouse.mousemap:

Mouse actions
+++++++++++++++++++++++++++++++++

Mouse buttons can be mapped to perform arbitrary actions. The syntax is:

.. code-block:: none

    mouse_map button-name event-type modes action

Where :code:`button-name` is one of :code:`left`, :code:`middle`, :code:`right`,
:code:`b1` ... :code:`b8` with added keyboard modifiers. For example:
:code:`ctrl+shift+left` refers to holding the :kbd:`Ctrl+Shift` keys while
clicking with the left mouse button. The value :code:`b1` ... :code:`b8` can be
used to refer to up to eight buttons on a mouse.

:code:`event-type` is one of :code:`press`, :code:`release`,
:code:`doublepress`, :code:`triplepress`, :code:`click`, :code:`doubleclick`.
:code:`modes` indicates whether the action is performed when the mouse is
grabbed by the program running in the terminal, or not. The values are
:code:`grabbed` or :code:`ungrabbed` or a comma separated combination of them.
:code:`grabbed` refers to when the program running in the terminal has requested
mouse events. Note that the click and double click events have a delay of
:opt:`click_interval` to disambiguate from double and triple presses.

You can run kitty with the :option:`kitty --debug-input` command line option
to see mouse events. See the builtin actions below to get a sense of what is
possible.

If you want to unmap a button, map it to nothing. For example, to disable
opening of URLs with a plain click::

    mouse_map left click ungrabbed

See all the mappable actions including mouse actions :doc:`here </actions>`.

.. note::
    Once a selection is started, releasing the button that started it will
    automatically end it and no release event will be dispatched.

.. opt:: kitty.clear_all_mouse_actions
.. code-block:: conf

    clear_all_mouse_actions no

Remove all mouse action definitions up to this point. Useful, for instance, to
remove the default mouse actions.

.. shortcut:: kitty.Click the link under the mouse or move the cursor
.. code-block:: conf

    mouse_map left click ungrabbed mouse_handle_click selection link prompt


First check for a selection and if one exists do nothing. Then check for a link
under the mouse cursor and if one exists, click it. Finally check if the click
happened at the current shell prompt and if so, move the cursor to the click
location. Note that this requires :ref:`shell integration <shell_integration>`
to work.

.. shortcut:: kitty.Click the link under the mouse or move the cursor even when grabbed
.. code-block:: conf

    mouse_map shift+left click grabbed,ungrabbed mouse_handle_click selection link prompt


Same as above, except that the action is performed even when the mouse is
grabbed by the program running in the terminal.

.. shortcut:: kitty.Click the link under the mouse cursor
.. code-block:: conf

    mouse_map ctrl+shift+left release grabbed,ungrabbed mouse_handle_click link


Variant with :kbd:`Ctrl+Shift` is present because the simple click based version
has an unavoidable delay of :opt:`click_interval <kitty.click_interval>`, to disambiguate clicks from
double clicks.

.. shortcut:: kitty.Discard press event for link click
.. code-block:: conf

    mouse_map ctrl+shift+left press grabbed discard_event


Prevent this press event from being sent to the program that has grabbed the
mouse, as the corresponding release event is used to open a URL.

.. shortcut:: kitty.Paste from the primary selection
.. code-block:: conf

    mouse_map middle release ungrabbed paste_from_selection

.. shortcut:: kitty.Start selecting text
.. code-block:: conf

    mouse_map left press ungrabbed mouse_selection normal

.. shortcut:: kitty.Start selecting text in a rectangle
.. code-block:: conf

    mouse_map ctrl+alt+left press ungrabbed mouse_selection rectangle

.. shortcut:: kitty.Select a word
.. code-block:: conf

    mouse_map left doublepress ungrabbed mouse_selection word

.. shortcut:: kitty.Select a line
.. code-block:: conf

    mouse_map left triplepress ungrabbed mouse_selection line

.. shortcut:: kitty.Select line from point
.. code-block:: conf

    mouse_map ctrl+alt+left triplepress ungrabbed mouse_selection line_from_point


Select from the clicked point to the end of the line. If you would like to select the word at the point and then extend to the rest of the line, change `line_from_point` to `word_and_line_from_point`.

.. shortcut:: kitty.Extend the current selection
.. code-block:: conf

    mouse_map right press ungrabbed mouse_selection extend


If you want only the end of the selection to be moved instead of the nearest
boundary, use :code:`move-end` instead of :code:`extend`.

.. shortcut:: kitty.Paste from the primary selection even when grabbed
.. code-block:: conf

    mouse_map shift+middle release ungrabbed,grabbed paste_selection
    mouse_map shift+middle press grabbed discard_event

.. shortcut:: kitty.Start selecting text even when grabbed
.. code-block:: conf

    mouse_map shift+left press ungrabbed,grabbed mouse_selection normal

.. shortcut:: kitty.Start selecting text in a rectangle even when grabbed
.. code-block:: conf

    mouse_map ctrl+shift+alt+left press ungrabbed,grabbed mouse_selection rectangle

.. shortcut:: kitty.Select a word even when grabbed
.. code-block:: conf

    mouse_map shift+left doublepress ungrabbed,grabbed mouse_selection word

.. shortcut:: kitty.Select a line even when grabbed
.. code-block:: conf

    mouse_map shift+left triplepress ungrabbed,grabbed mouse_selection line

.. shortcut:: kitty.Select line from point even when grabbed
.. code-block:: conf

    mouse_map ctrl+shift+alt+left triplepress ungrabbed,grabbed mouse_selection line_from_point


Select from the clicked point to the end of the line even when grabbed. If you would like to select the word at the point and then extend to the rest of the line, change `line_from_point` to `word_and_line_from_point`.

.. shortcut:: kitty.Extend the current selection even when grabbed
.. code-block:: conf

    mouse_map shift+right press ungrabbed,grabbed mouse_selection extend

.. shortcut:: kitty.Show clicked command output in pager
.. code-block:: conf

    mouse_map ctrl+shift+right press ungrabbed mouse_show_command_output


Requires :ref:`shell integration <shell_integration>` to work.


.. _conf-kitty-performance:

Performance tuning
--------------------------------------

.. opt:: kitty.repaint_delay
.. code-block:: conf

    repaint_delay 10

Delay between screen updates (in milliseconds). Decreasing it, increases
frames-per-second (FPS) at the cost of more CPU usage. The default value yields
~100 FPS which is more than sufficient for most uses. Note that to actually
achieve 100 FPS, you have to either set :opt:`sync_to_monitor <kitty.sync_to_monitor>` to :code:`no` or
use a monitor with a high refresh rate. Also, to minimize latency when there is
pending input to be processed, this option is ignored.

.. opt:: kitty.input_delay
.. code-block:: conf

    input_delay 3

Delay before input from the program running in the terminal is processed (in
milliseconds). Note that decreasing it will increase responsiveness, but also
increase CPU usage and might cause flicker in full screen programs that redraw
the entire screen on each loop, because kitty is so fast that partial screen
updates will be drawn. This setting is ignored when the input buffer is almost full.

.. opt:: kitty.sync_to_monitor
.. code-block:: conf

    sync_to_monitor yes

Sync screen updates to the refresh rate of the monitor. This prevents
:link:`screen tearing <https://en.wikipedia.org/wiki/Screen_tearing>` when
scrolling. However, it limits the rendering speed to the refresh rate of your
monitor. With a very high speed mouse/high keyboard repeat rate, you may notice
some slight input latency. If so, set this to :code:`no`.


.. _conf-kitty-bell:

Terminal bell
---------------------------------

.. opt:: kitty.enable_audio_bell
.. code-block:: conf

    enable_audio_bell yes

The audio bell. Useful to disable it in environments that require silence.

.. opt:: kitty.visual_bell_duration
.. code-block:: conf

    visual_bell_duration 0.0

The visual bell duration (in seconds). Flash the screen when a bell occurs for
the specified number of seconds. Set to zero to disable. The flash is animated, fading
in and out over the specified duration. The :term:`easing function` used for the fading can be controlled.
For example, :code:`2.0 linear` will casuse the flash to fade in and out linearly. The default
if unspecified is to use :code:`ease-in-out` which fades slowly at the start, middle and end.
You can specify different easing functions for the fade-in and fade-out parts, like this:
:code:`2.0 ease-in linear`. kitty
supports all the :link:`CSS easing functions <https://developer.mozilla.org/en-US/docs/Web/CSS/easing-function>`.

.. opt:: kitty.visual_bell_color
.. code-block:: conf

    visual_bell_color none

The color used by visual bell. Set to :code:`none` will fall back to selection
background color. If you feel that the visual bell is too bright, you can
set it to a darker color.

.. opt:: kitty.window_alert_on_bell
.. code-block:: conf

    window_alert_on_bell yes

Request window attention on bell. Makes the dock icon bounce on macOS or the
taskbar flash on Linux.

.. opt:: kitty.bell_on_tab
.. code-block:: conf

    bell_on_tab "🔔 "

Some text or a Unicode symbol to show on the tab if a window in the tab that
does not have focus has a bell. If you want to use leading or trailing
spaces, surround the text with quotes. See :opt:`tab_title_template <kitty.tab_title_template>` for how
this is rendered.

For backwards compatibility, values of :code:`yes`, :code:`y` and :code:`true`
are converted to the default bell symbol and :code:`no`, :code:`n`,
:code:`false` and :code:`none` are converted to the empty string.

.. opt:: kitty.command_on_bell
.. code-block:: conf

    command_on_bell none

Program to run when a bell occurs. The environment variable
:envvar:`KITTY_CHILD_CMDLINE` can be used to get the program running in the
window in which the bell occurred.

.. opt:: kitty.bell_path
.. code-block:: conf

    bell_path none

Path to a sound file to play as the bell sound. If set to :code:`none`, the
system default bell sound is used. Must be in a format supported by the
operating systems sound API, such as WAV or OGA on Linux (libcanberra) or AIFF,
MP3 or WAV on macOS (NSSound). Relative paths are resolved
with respect to the kitty config directory.

.. opt:: kitty.linux_bell_theme
.. code-block:: conf

    linux_bell_theme __custom

The XDG Sound Theme kitty will use to play the bell sound.
On Wayland, when the compositor supports it, it is asked to play the system default
bell sound, and this setting has no effect. Note that Hyprland claims to support this
protocol, but :link:`does not actually play a sound <https://github.com/hyprwm/Hyprland/issues/10488>`.
This setting defaults to the custom theme name specified in the
:link:`XDG Sound theme specification <https://specifications.freedesktop.org/sound-theme-spec/latest/sound_lookup.html>,
falling back to the default freedesktop theme if it does not exist.
To change your sound theme desktop wide, create :file:`~/.local/share/sounds/__custom/index.theme` with the contents:

    [Sound Theme]

    Inherits=name-of-the-sound-theme-you-want-to-use

Replace :code:`name-of-the-sound-theme-you-want-to-use` with the actual theme name. Now all compliant applications
should use sounds from this theme.


.. _conf-kitty-window:

Window layout
---------------------------------

.. opt:: kitty.remember_window_size, kitty.initial_window_width, kitty.initial_window_height
.. code-block:: conf

    remember_window_size  yes
    initial_window_width  640
    initial_window_height 400

If enabled, the :term:`OS Window <os_window>` size will be remembered so that
new instances of kitty will have the same size as the previous instance.
If disabled, the :term:`OS Window <os_window>` will initially have size
configured by initial_window_width/height, in pixels. You can use a suffix of
"c" on the width/height values to have them interpreted as number of cells
instead of pixels.

.. opt:: kitty.remember_window_position
.. code-block:: conf

    remember_window_position no

If enabled, the :term:`OS Window <os_window>` position will be remembered so that
new instances of kitty will have the same position as the previous instance.
If disabled, the :term:`OS Window <os_window>` will be placed by the window manager.
Note that remembering of position only works if the underlying desktop environment/window
manager supports it. It never works on Wayland. See also :option:`kitty --position` to
specify the position when launching kitty.

.. opt:: kitty.enabled_layouts
.. code-block:: conf

    enabled_layouts *

The enabled window layouts. A comma separated list of layout names. The special
value :code:`all` means all layouts. The first listed layout will be used as the
startup layout. Default configuration is all layouts in alphabetical order. For
a list of available layouts, see the :ref:`layouts`.

.. opt:: kitty.window_resize_step_cells, kitty.window_resize_step_lines
.. code-block:: conf

    window_resize_step_cells 2
    window_resize_step_lines 2

The step size (in units of cell width/cell height) to use when resizing kitty
windows in a layout with the shortcut :sc:`start_resizing_window`. The cells
value is used for horizontal resizing, and the lines value is used for vertical
resizing.

.. opt:: kitty.window_border_width
.. code-block:: conf

    window_border_width 0.5pt

The width of window borders. Can be either in pixels (px) or pts (pt). Values in
pts will be rounded to the nearest number of pixels based on screen resolution.
If not specified, the unit is assumed to be pts. Note that borders are displayed
only when more than one window is visible. They are meant to separate multiple
windows.

.. opt:: kitty.draw_minimal_borders
.. code-block:: conf

    draw_minimal_borders yes

Draw only the minimum borders needed. This means that only the borders that
separate the window from a neighbor are drawn. Note that setting a
non-zero :opt:`window_margin_width <kitty.window_margin_width>` overrides this and causes all borders to be
drawn.

.. opt:: kitty.draw_window_borders_for_single_window
.. code-block:: conf

    draw_window_borders_for_single_window no

Draw borders around a window even when there is only a single window visible. When
enabled and there is only a single window, full borders are drawn around it (as if
:opt:`draw_minimal_borders <kitty.draw_minimal_borders>` is false). The border will show in the active color when
the window is focused and the OS window has focus, and in the inactive color when the
OS window loses focus. This provides a clear visual indicator of whether the kitty
window is focused. When there are multiple windows visible, this option has no effect
and normal border drawing rules apply.

.. opt:: kitty.window_margin_width
.. code-block:: conf

    window_margin_width 0

The window margin (in pts) (blank area outside the border). A single value sets
all four sides. Two values set the vertical and horizontal sides. Three values
set top, horizontal and bottom. Four values set top, right, bottom and left.

.. opt:: kitty.single_window_margin_width
.. code-block:: conf

    single_window_margin_width -1

The window margin to use when only a single window is visible (in pts). Negative
values will cause the value of :opt:`window_margin_width <kitty.window_margin_width>` to be used instead. A
single value sets all four sides. Two values set the vertical and horizontal
sides. Three values set top, horizontal and bottom. Four values set top, right,
bottom and left.

.. opt:: kitty.window_padding_width
.. code-block:: conf

    window_padding_width 0

The window padding (in pts) (blank area between the text and the window border).
A single value sets all four sides. Two values set the vertical and horizontal
sides. Three values set top, horizontal and bottom. Four values set top, right,
bottom and left.

.. opt:: kitty.single_window_padding_width
.. code-block:: conf

    single_window_padding_width -1

The window padding to use when only a single window is visible (in pts). Negative
values will cause the value of :opt:`window_padding_width <kitty.window_padding_width>` to be used instead. A
single value sets all four sides. Two values set the vertical and horizontal
sides. Three values set top, horizontal and bottom. Four values set top, right,
bottom and left.

.. opt:: kitty.placement_strategy
.. code-block:: conf

    placement_strategy center

When the window size is not an exact multiple of the cell size, the cell area of
the terminal window will have some extra padding on the sides. You can control
how that padding is distributed with this option. Using a value of
:code:`center` means the cell area will be placed centrally. A value of
:code:`top-left` means the padding will be only at the bottom and right edges.
The value can be one of: :code:`top-left`, :code:`top`, :code:`top-right`,
:code:`left`, :code:`center`, :code:`right`, :code:`bottom-left`,
:code:`bottom`, :code:`bottom-right`.

.. opt:: kitty.active_border_color
.. code-block:: conf

    active_border_color #00ff00

The color for the border of the active window. Set this to :code:`none` to not
draw borders around the active window.

.. opt:: kitty.inactive_border_color
.. code-block:: conf

    inactive_border_color #cccccc

The color for the border of inactive windows.

.. opt:: kitty.bell_border_color
.. code-block:: conf

    bell_border_color #ff5a00

The color for the border of inactive windows in which a bell has occurred.

.. opt:: kitty.inactive_text_alpha
.. code-block:: conf

    inactive_text_alpha 1.0

Fade the text in inactive windows by the specified amount (a number between zero
and one, with zero being fully faded).

.. opt:: kitty.hide_window_decorations
.. code-block:: conf

    hide_window_decorations no

Hide the window decorations (title-bar and window borders) with :code:`yes`. On
macOS, :code:`titlebar-only` and :code:`titlebar-and-corners` can be used to only hide the titlebar and the rounded corners.
Whether this works and exactly what effect it has depends on the window manager/operating
system. Note that the effects of changing this option when reloading config
are undefined. When using :code:`titlebar-only`, it is useful to also set
:opt:`window_margin_width <kitty.window_margin_width>` and :opt:`placement_strategy <kitty.placement_strategy>` to prevent the rounded
corners from clipping text. Or use :code:`titlebar-and-corners`.

.. opt:: kitty.window_logo_path
.. code-block:: conf

    window_logo_path none

Path to a logo image. Must be in PNG/JPEG/WEBP/GIF/TIFF/BMP format. Relative paths are interpreted
relative to the kitty config directory. The logo is displayed in a corner of
every kitty window. The position is controlled by :opt:`window_logo_position <kitty.window_logo_position>`.
Individual windows can be configured to have different logos either using the
:ac:`launch` action or the :doc:`remote control <remote-control>` facility.

.. opt:: kitty.window_logo_position
.. code-block:: conf

    window_logo_position bottom-right

Where to position the window logo in the window. The value can be one of:
:code:`top-left`, :code:`top`, :code:`top-right`, :code:`left`, :code:`center`,
:code:`right`, :code:`bottom-left`, :code:`bottom`, :code:`bottom-right`.

.. opt:: kitty.window_logo_alpha
.. code-block:: conf

    window_logo_alpha 0.5

The amount the logo should be faded into the background. With zero being fully
faded and one being fully opaque.

.. opt:: kitty.window_logo_scale
.. code-block:: conf

    window_logo_scale 0

The percentage (0-100] of the window size to which the logo should scale. Using a single
number means the logo is scaled to that percentage of the shortest window dimension, while preserving
aspect ratio of the logo image.

Using two numbers means the width and height of the logo are scaled to the respective
percentage of the window's width and height.

Using zero as the percentage disables scaling in that dimension. A single zero (the default)
disables all scaling of the window logo.

.. opt:: kitty.resize_debounce_time
.. code-block:: conf

    resize_debounce_time 0.1 0.5

The time to wait (in seconds) before asking the program running in kitty to resize and
redraw the screen during a live resize of the OS window, when no new resize
events have been received, i.e. when resizing is either paused or finished.
On platforms such as macOS, where the operating system sends events corresponding
to the start and end of a live resize, the second number is used for
redraw-after-pause since kitty can distinguish between a pause and end of
resizing. On such systems the first number is ignored and redraw is immediate
after end of resize. On other systems only the first number is used so that kitty
is "ready" quickly after the end of resizing, while not also continuously
redrawing, to save energy.

.. opt:: kitty.resize_in_steps
.. code-block:: conf

    resize_in_steps no

Resize the OS window in steps as large as the cells, instead of with the usual
pixel accuracy. Combined with :opt:`initial_window_width <kitty.initial_window_width>` and
:opt:`initial_window_height <kitty.initial_window_height>` in number of cells, this option can be used to keep
the margins as small as possible when resizing the OS window. Note that this
does not currently work on Wayland.

.. opt:: kitty.visual_window_select_characters
.. code-block:: conf

    visual_window_select_characters 1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ

The list of characters for visual window selection. For example, for selecting a
window to focus on with :sc:`focus_visible_window`. The value should be a series
of unique numbers or alphabets, case insensitive, from the set :code:`0-9A-Z\`-=[];',./\\`.
Specify your preference as a string of characters.

.. opt:: kitty.confirm_os_window_close
.. code-block:: conf

    confirm_os_window_close -1

Ask for confirmation when closing an OS window or a tab with at least this
number of kitty windows in it by window manager (e.g. clicking the window close
button or pressing the operating system shortcut to close windows) or by the
:ac:`close_tab` action. A value of zero disables confirmation. This confirmation
also applies to requests to quit the entire application (all OS windows, via the
:ac:`quit` action). Negative values are converted to positive ones, however,
with :opt:`shell_integration <kitty.shell_integration>` enabled, using negative values means windows
sitting at a shell prompt are not counted, only windows where some command is
currently running. You can also have backgrounded jobs prevent closing,
by adding :code:`count-background` to the setting, for example: :code:`-1 count-background`.
Note that if you want confirmation when closing individual windows,
you can map the :ac:`close_window_with_confirmation` action.


.. _conf-kitty-tabbar:

Tab bar
---------------------------

.. opt:: kitty.tab_bar_edge
.. code-block:: conf

    tab_bar_edge bottom

The edge to show the tab bar on, :code:`top` or :code:`bottom`.

.. opt:: kitty.tab_bar_margin_width
.. code-block:: conf

    tab_bar_margin_width 0.0

The margin to the left and right of the tab bar (in pts).

.. opt:: kitty.tab_bar_margin_height
.. code-block:: conf

    tab_bar_margin_height 0.0 0.0

The margin above and below the tab bar (in pts). The first number is the margin
between the edge of the OS Window and the tab bar. The second number is the
margin between the tab bar and the contents of the current tab.

.. opt:: kitty.tab_bar_style
.. code-block:: conf

    tab_bar_style fade

The tab bar style, can be one of:

:code:`fade`
    Each tab's edges fade into the background color. (See also :opt:`tab_fade <kitty.tab_fade>`)
:code:`slant`
    Tabs look like the tabs in a physical file.
:code:`separator`
    Tabs are separated by a configurable separator. (See also
    :opt:`tab_separator <kitty.tab_separator>`)
:code:`powerline`
    Tabs are shown as a continuous line with "fancy" separators.
    (See also :opt:`tab_powerline_style <kitty.tab_powerline_style>`)
:code:`custom`
    A user-supplied Python function called draw_tab is loaded from the file
    :file:`tab_bar.py` in the kitty config directory. For examples of how to
    write such a function, see the functions named :code:`draw_tab_with_*` in
    kitty's source code: :file:`kitty/tab_bar.py`. See also
    :disc:`this discussion <4447>`
    for examples from kitty users.
:code:`hidden`
    The tab bar is hidden. If you use this, you might want to create
    a mapping for the :ac:`select_tab` action which presents you with a list of
    tabs and allows for easy switching to a tab.

.. opt:: kitty.tab_bar_filter

A :ref:`search expression <search_syntax>`. Only tabs that match this expression
will be shown in the tab bar. The currently active tab is :italic:`always` shown,
regardless of whether it matches or not. When using this option, the tab bar may
be displayed with less tabs than specified in :opt:`tab_bar_min_tabs <kitty.tab_bar_min_tabs>`, as evaluating
the filter is expensive and is done only at display time. This is most useful when
using :ref:`sessions <sessions>`. An expression of :code:`session:~ or session:^$`
will show only tabs that belong to the current session or no session. The various
tab navigation actions such as :ac:`goto_tab`, :ac:`next_tab`, :ac:`previous_tab`, etc.
are automatically restricted to work only on matching tabs.

.. opt:: kitty.tab_bar_align
.. code-block:: conf

    tab_bar_align left

The horizontal alignment of the tab bar, can be one of: :code:`left`,
:code:`center`, :code:`right`.

.. opt:: kitty.tab_bar_min_tabs
.. code-block:: conf

    tab_bar_min_tabs 2

The minimum number of tabs that must exist before the tab bar is shown.

.. opt:: kitty.tab_switch_strategy
.. code-block:: conf

    tab_switch_strategy previous

The algorithm to use when switching to a tab when the current tab is closed. The
default of :code:`previous` will switch to the last used tab. A value of
:code:`left` will switch to the tab to the left of the closed tab. A value of
:code:`right` will switch to the tab to the right of the closed tab. A value of
:code:`last` will switch to the right-most tab.

.. opt:: kitty.tab_fade
.. code-block:: conf

    tab_fade 0.25 0.5 0.75 1

Control how each tab fades into the background when using :code:`fade` for the
:opt:`tab_bar_style <kitty.tab_bar_style>`. Each number is an alpha (between zero and one) that
controls how much the corresponding cell fades into the background, with zero
being no fade and one being full fade. You can change the number of cells used
by adding/removing entries to this list.

.. opt:: kitty.tab_separator
.. code-block:: conf

    tab_separator " ┇"

The separator between tabs in the tab bar when using :code:`separator` as the
:opt:`tab_bar_style <kitty.tab_bar_style>`.

.. opt:: kitty.tab_powerline_style
.. code-block:: conf

    tab_powerline_style angled

The powerline separator style between tabs in the tab bar when using
:code:`powerline` as the :opt:`tab_bar_style <kitty.tab_bar_style>`, can be one of: :code:`angled`,
:code:`slanted`, :code:`round`.

.. opt:: kitty.tab_activity_symbol
.. code-block:: conf

    tab_activity_symbol none

Some text or a Unicode symbol to show on the tab if a window in the tab that
does not have focus has some activity. If you want to use leading or trailing
spaces, surround the text with quotes. See :opt:`tab_title_template <kitty.tab_title_template>` for how
this is rendered.

.. opt:: kitty.tab_title_max_length
.. code-block:: conf

    tab_title_max_length 0

The maximum number of cells that can be used to render the text in a tab.
A value of zero means that no limit is applied.

.. opt:: kitty.tab_title_template
.. code-block:: conf

    tab_title_template "{fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{tab.last_focused_progress_percent}{title}"

A template to render the tab title. The default just renders the title with
optional symbols for bell and activity. If you wish to include the tab-index as
well, use something like: :code:`{index}:{title}`. Useful if you have shortcuts
mapped for :code:`goto_tab N`. If you prefer to see the index as a superscript,
use :code:`{sup.index}`. All data available is:

:code:`title`
    The current tab title.
:code:`index`
    The tab index usable with :ac:`goto_tab N <goto_tab>` shortcuts.
:code:`layout_name`
    The current layout name.
:code:`session_name`
    The name of the kitty session file from which this tab was created, if any.
:code:`active_session_name`
    The name of the kitty session file from which the active window in this tab was created, if any.
:code:`num_windows`
    The number of windows in the tab.
:code:`num_window_groups`
    The number of window groups (a window group is a window and all of its overlay windows) in the tab.
:code:`tab.active_wd`
    The working directory of the currently active window in the tab
    (expensive, requires syscall). Use :code:`tab.active_oldest_wd` to get
    the directory of the oldest foreground process rather than the newest.
:code:`tab.active_exe`
    The name of the executable running in the foreground of the currently
    active window in the tab (expensive, requires syscall). Use
    :code:`tab.active_oldest_exe` for the oldest foreground process.
:code:`max_title_length`
    The maximum title length available.
:code:`keyboard_mode`
    The name of the current :ref:`keyboard mode <modal_mappings>` or the empty string if no keyboard mode is active.
:code:`tab.last_focused_progress_percent`
    If a command running in a window reports the progress for a task, show this progress as a percentage
    from the most recently focused window in the tab. Empty string if no progress is reported.
:code:`tab.progress_percent`
    If a command running in a window reports the progress for a task, show this progress as a percentage
    from all windows in the tab, averaged. Empty string is no progress is reported.
:code:`custom`
    This will call a function named :code:`draw_title(data)` from the file :file:`tab_bar.py` placed in
    the kitty config directory. The function will be passed a dictionary of data, the same data that
    can be used in this template. It can then perform arbitrarily complex processing and return a string.
    For example: :code:`tab_title_template "{custom}"` will use the output of the function as the tab title.
    Any print statements in the :code:`draw_title()` will print to the STDOUT of the kitty process, useful
    for debugging.


Note that formatting is done by Python's string formatting machinery, so you can
use, for instance, :code:`{layout_name[:2].upper()}` to show only the first two
letters of the layout name, upper-cased. If you want to style the text, you can
use styling directives, for example:
``{fmt.fg.red}red{fmt.fg.tab}normal{fmt.bg._00FF00}greenbg{fmt.bg.tab}``.
Similarly, for bold and italic:
``{fmt.bold}bold{fmt.nobold}normal{fmt.italic}italic{fmt.noitalic}``.
The 256 eight terminal colors can be used as ``fmt.fg.color0`` through ``fmt.fg.color255``.
Note that for backward compatibility, if :code:`{bell_symbol}` or
:code:`{activity_symbol}` are not present in the template, they are prepended to
it.

.. opt:: kitty.active_tab_title_template
.. code-block:: conf

    active_tab_title_template none

Template to use for active tabs. If not specified falls back to
:opt:`tab_title_template <kitty.tab_title_template>`.

.. opt:: kitty.active_tab_foreground, kitty.active_tab_background, kitty.active_tab_font_style, kitty.inactive_tab_foreground, kitty.inactive_tab_background, kitty.inactive_tab_font_style
.. code-block:: conf

    active_tab_foreground   #000
    active_tab_background   #eee
    active_tab_font_style   bold-italic
    inactive_tab_foreground #444
    inactive_tab_background #999
    inactive_tab_font_style normal

Tab bar colors and styles.

.. opt:: kitty.tab_bar_background
.. code-block:: conf

    tab_bar_background none

Background color for the tab bar. Defaults to using the terminal background
color.

.. opt:: kitty.tab_bar_margin_color
.. code-block:: conf

    tab_bar_margin_color none

Color for the tab bar margin area. Defaults to using the terminal background
color for margins above and below the tab bar. For side margins the default
color is chosen to match the background color of the neighboring tab.


.. _conf-kitty-colors:

Color scheme
--------------------------------

.. opt:: kitty.foreground, kitty.background
.. code-block:: conf

    foreground #dddddd
    background #000000

The foreground and background colors.

.. opt:: kitty.background_opacity
.. code-block:: conf

    background_opacity 1.0

The opacity of the background. A number between zero and one, where one is
opaque and zero is fully transparent. This will only work if supported by the
OS (for instance, when using a compositor under X11). Note that it only sets
the background color's opacity in cells that have the same background color as
the default terminal background, so that things like the status bar in vim,
powerline prompts, etc. still look good. But it means that if you use a color
theme with a background color in your editor, it will not be rendered as
transparent. Instead you should change the default background color in your
kitty config and not use a background color in the editor color scheme. Or use
the escape codes to set the terminals default colors in a shell script to
launch your editor. See also :opt:`transparent_background_colors <kitty.transparent_background_colors>`.
Be aware that using a value less than 1.0 is a (possibly
significant) performance hit. When using a low value for this setting, it is
desirable that you set the :opt:`background <kitty.background>` color to a color the matches the
general color of the desktop background, for best text rendering.

If you want to dynamically change transparency of windows, set
:opt:`dynamic_background_opacity <kitty.dynamic_background_opacity>` to :code:`yes` (this is off by default as it
has a performance cost). Changing this option when reloading the config will
only work if :opt:`dynamic_background_opacity <kitty.dynamic_background_opacity>` was enabled in the original
config.

.. opt:: kitty.background_blur
.. code-block:: conf

    background_blur 0

Set to a positive value to enable background blur (blurring of the visuals
behind a transparent window) on platforms that support it. Only takes effect
when :opt:`background_opacity <kitty.background_opacity>` is less than one. On macOS, this will also
control the :italic:`blur radius` (amount of blurring). Setting it to too high
a value will cause severe performance issues and/or rendering artifacts.
Usually, values up to 64 work well. Note that this might cause performance issues,
depending on how the platform implements it, so use with care. Currently supported
on macOS and KDE.

.. opt:: kitty.transparent_background_colors

A space separated list of upto 7 colors, with opacity. When the background color of a cell matches one of these colors,
it is rendered semi-transparent using the specified opacity.

Useful in more complex UIs like editors where you could want more than a single background color
to be rendered as transparent, for instance, for a cursor highlight line background or a highlighted block.
Terminal applications can set this color using :ref:`The kitty color control <color_control>`
escape code.

The syntax for specifying colors is: :code:`color@opacity`, where the :code:`@opacity`
part is optional. When unspecified, the value of :opt:`background_opacity <kitty.background_opacity>` is used. For example::

    transparent_background_colors red@0.5 #00ff00@0.3

Note that you must also set :opt:`background_opacity <kitty.background_opacity>` to something less than 1 for this setting to work properly.

.. opt:: kitty.dynamic_background_opacity
.. code-block:: conf

    dynamic_background_opacity no

Allow changing of the :opt:`background_opacity <kitty.background_opacity>` dynamically, using either
keyboard shortcuts (:sc:`increase_background_opacity` and
:sc:`decrease_background_opacity`) or the remote control facility. Changing
this option by reloading the config is not supported.

.. opt:: kitty.background_image
.. code-block:: conf

    background_image none

Path to a background image. Must be in PNG/JPEG/WEBP/TIFF/GIF/BMP format. Note that when using :ref:`auto_color_scheme` this option is overridden by the color scheme file and must be set inside it to take effect.

.. opt:: kitty.background_image_layout
.. code-block:: conf

    background_image_layout tiled

Whether to tile, scale or clamp the background image. The value can be one of
:code:`tiled`, :code:`mirror-tiled`, :code:`scaled`, :code:`clamped`, :code:`centered`
or :code:`cscaled`. The :code:`scaled` and :code:`cscaled` values scale the image to the
window size, with :code:`cscaled` preserving the image aspect ratio.
Note that when using :ref:`auto_color_scheme` this option is overridden by the color scheme file and must be set inside it to take effect.

.. opt:: kitty.background_image_linear
.. code-block:: conf

    background_image_linear no

When background image is scaled, whether linear interpolation should be used. Note that when using :ref:`auto_color_scheme` this option is overridden by the color scheme file and must be set inside it to take effect.

.. opt:: kitty.background_tint
.. code-block:: conf

    background_tint 0.0

How much to tint the background image by the background color. This option
makes it easier to read the text. Tinting is done using the current background
color for each window. This option applies only if :opt:`background_image <kitty.background_image>` is set.
Note that when using :ref:`auto_color_scheme` this option is overridden by the color scheme file and must be set inside it to take effect.

.. opt:: kitty.background_tint_gaps
.. code-block:: conf

    background_tint_gaps 1.0

How much to tint the background image at the window gaps by the background
color, after applying :opt:`background_tint <kitty.background_tint>`. Since this is multiplicative
with :opt:`background_tint <kitty.background_tint>`, it can be used to lighten the tint over the window
gaps for a *separated* look.
Note that when using :ref:`auto_color_scheme` this option is overridden by the color scheme file and must be set inside it to take effect.

.. opt:: kitty.dim_opacity
.. code-block:: conf

    dim_opacity 0.4

How much to dim text that has the DIM/FAINT attribute set. One means no dimming
and zero means fully dimmed (i.e. invisible).

.. opt:: kitty.selection_foreground, kitty.selection_background
.. code-block:: conf

    selection_foreground #000000
    selection_background #fffacd

The foreground and background colors for text selected with the mouse. Setting
both of these to :code:`none` will cause a "reverse video" effect for
selections, where the selection will be the cell text color and the text will
become the cell background color. Setting only selection_foreground to
:code:`none` will cause the foreground color to be used unchanged. Note that
these colors can be overridden by the program running in the terminal.


.. _conf-kitty-colors.table:

The color table
+++++++++++++++++++++++++++++++++++

The 256 terminal colors. There are 8 basic colors, each color has a dull and
bright version, for the first 16 colors. You can set the remaining 240 colors as
color16 to color255.

.. opt:: kitty.color0, kitty.color8
.. code-block:: conf

    color0 #000000
    color8 #767676

black

.. opt:: kitty.color1, kitty.color9
.. code-block:: conf

    color1 #cc0403
    color9 #f2201f

red

.. opt:: kitty.color2, kitty.color10
.. code-block:: conf

    color2  #19cb00
    color10 #23fd00

green

.. opt:: kitty.color3, kitty.color11
.. code-block:: conf

    color3  #cecb00
    color11 #fffd00

yellow

.. opt:: kitty.color4, kitty.color12
.. code-block:: conf

    color4  #0d73cc
    color12 #1a8fff

blue

.. opt:: kitty.color5, kitty.color13
.. code-block:: conf

    color5  #cb1ed1
    color13 #fd28ff

magenta

.. opt:: kitty.color6, kitty.color14
.. code-block:: conf

    color6  #0dcdcd
    color14 #14ffff

cyan

.. opt:: kitty.color7, kitty.color15
.. code-block:: conf

    color7  #dddddd
    color15 #ffffff

white

.. opt:: kitty.mark1_foreground
.. code-block:: conf

    mark1_foreground black

Color for marks of type 1

.. opt:: kitty.mark1_background
.. code-block:: conf

    mark1_background #98d3cb

Color for marks of type 1 (light steel blue)

.. opt:: kitty.mark2_foreground
.. code-block:: conf

    mark2_foreground black

Color for marks of type 2

.. opt:: kitty.mark2_background
.. code-block:: conf

    mark2_background #f2dcd3

Color for marks of type 1 (beige)

.. opt:: kitty.mark3_foreground
.. code-block:: conf

    mark3_foreground black

Color for marks of type 3

.. opt:: kitty.mark3_background
.. code-block:: conf

    mark3_background #f274bc

Color for marks of type 3 (violet)


.. _conf-kitty-advanced:

Advanced
----------------------------

.. opt:: kitty.shell
.. code-block:: conf

    shell .

The shell program to execute. The default value of :code:`.` means to use
the value of of the :envvar:`SHELL` environment variable or if unset,
whatever shell is set as the default shell for the current user. Note that on
macOS if you change this, you might need to add :code:`--login` and
:code:`--interactive` to ensure that the shell starts in interactive mode and
reads its startup rc files. Environment variables are expanded in this setting.

.. opt:: kitty.editor
.. code-block:: conf

    editor .

The terminal based text editor (such as :program:`vim` or :program:`nano`) to
use when editing the kitty config file or similar tasks.

The default value of :code:`.` means to use the environment variables
:envvar:`VISUAL` and :envvar:`EDITOR` in that order. If these variables aren't
set, kitty will run your :opt:`shell <kitty.shell>` (:code:`$SHELL -l -i -c env`) to see if
your shell startup rc files set :envvar:`VISUAL` or :envvar:`EDITOR`. If that
doesn't work, kitty will cycle through various known editors (:program:`vim`,
:program:`emacs`, etc.) and take the first one that exists on your system.

.. opt:: kitty.close_on_child_death
.. code-block:: conf

    close_on_child_death no

Close the window when the child process (usually the shell) exits. With the default value
:code:`no`, the terminal will remain open when the child exits as long as there
are still other processes outputting to the terminal (for example disowned or
backgrounded processes). When enabled with :code:`yes`, the window will close as
soon as the child process exits. Note that setting it to :code:`yes` means that
any background processes still using the terminal can fail silently because
their stdout/stderr/stdin no longer work.

.. opt:: kitty.remote_control_password

Allow other programs to control kitty using passwords. This option can be
specified multiple times to add multiple passwords. If no passwords are present
kitty will ask the user for permission if a program tries to use remote control
with a password. A password can also *optionally* be associated with a set of
allowed remote control actions. For example::

    remote_control_password "my passphrase" get-colors set-colors focus-window focus-tab

Only the specified actions will be allowed when using this password.
Glob patterns can be used too, for example::

    remote_control_password "my passphrase" set-tab-* resize-*

To get a list of available actions, run::

    kitten @ --help

A set of actions to be allowed when no password is sent can be specified by
using an empty password. For example::

    remote_control_password "" *-colors

Finally, the path to a python module can be specified that provides a function
:code:`is_cmd_allowed` that is used to check every remote control command.
For example::

    remote_control_password "my passphrase" my_rc_command_checker.py

Relative paths are resolved from the kitty configuration directory.
See :ref:`rc_custom_auth` for details.

.. opt:: kitty.allow_remote_control
.. code-block:: conf

    allow_remote_control no

Allow other programs to control kitty. If you turn this on, other programs can
control all aspects of kitty, including sending text to kitty windows, opening
new windows, closing windows, reading the content of windows, etc. Note that
this even works over SSH connections. The default setting of :code:`no`
prevents any form of remote control. The meaning of the various values are:

:code:`password`
    Remote control requests received over both the TTY device and the socket
    are confirmed based on passwords, see :opt:`remote_control_password <kitty.remote_control_password>`.

:code:`socket-only`
    Remote control requests received over a socket are accepted
    unconditionally. Requests received over the TTY are denied.
    See :opt:`listen_on <kitty.listen_on>`.

:code:`socket`
    Remote control requests received over a socket are accepted
    unconditionally. Requests received over the TTY are confirmed based on
    password.

:code:`no`
    Remote control is completely disabled.

:code:`yes`
    Remote control requests are always accepted.

.. opt:: kitty.listen_on
.. code-block:: conf

    listen_on none

Listen to the specified socket for remote control connections. Note that this
will apply to all kitty instances. It can be overridden by the :option:`kitty
--listen-on` command line option. For UNIX sockets, such as
:code:`unix:${TEMP}/mykitty` or :code:`unix:@mykitty` (on Linux). Environment
variables are expanded and relative paths are resolved with respect to the
temporary directory. If :code:`{kitty_pid}` is present, then it is replaced by
the PID of the kitty process, otherwise the PID of the kitty process is
appended to the value, with a hyphen. For TCP sockets such as
:code:`tcp:localhost:0` a random port is always used even if a non-zero port
number is specified.  See the help for :option:`kitty --listen-on` for more
details. Note that this will be ignored unless :opt:`allow_remote_control <kitty.allow_remote_control>` is
set to either: :code:`yes`, :code:`socket` or :code:`socket-only`.
Changing this option by reloading the config is not supported.

.. opt:: kitty.env

Specify the environment variables to be set in all child processes. Using the
name with an equal sign (e.g. :code:`env VAR=`) will set it to the empty string.
Specifying only the name (e.g. :code:`env VAR`) will remove the variable from
the child process' environment. Note that environment variables are expanded
recursively, for example::

    env VAR1=a
    env VAR2=${HOME}/${VAR1}/b

The value of :code:`VAR2` will be :code:`<path to home directory>/a/b`.

Use the special
value :code:`read_from_shell` to have kitty read the specified variables from
your :opt:`login shell <shell>` configuration.
Useful if your shell startup files setup a bunch of environment variables that you want available to kitty and
in kitty session files. Each variable name is treated as a glob pattern to match. For example:
:code:`env read_from_shell=PATH LANG LC_* XDG_* EDITOR VISUAL`. Note that these variables are only
read after the configuration is fully processed, thus they are not available for recursive expansion and
they will override any variables set by other :opt:`env <kitty.env>` directives.

.. opt:: kitty.filter_notification

Specify rules to filter out notifications sent by applications running in kitty.
Can be specified multiple times to create multiple filter rules. A rule specification
is of the form :code:`field:regexp`. A filter rule
can match on any of the fields: :code:`title`, :code:`body`, :code:`app`, :code:`type`.
The special value of :code:`all` filters out all notifications. Rules can be combined
using Boolean operators. Some examples::

    filter_notification title:hello or body:"abc.*def"
    # filter out notification from vim except for ones about updates, (?i)
    # makes matching case insensitive.
    filter_notification app:"[ng]?vim" and not body:"(?i)update"
    # filter out all notifications
    filter_notification all

The field :code:`app` is the name of the application sending the notification and :code:`type`
is the type of the notification. Not all applications will send these fields, so you can also
match on the title and body of the notification text. More sophisticated programmatic filtering
and custom actions on notifications can be done by creating a notifications.py file in the
kitty config directory (:file:`~/.config/kitty`). An annotated sample is
:link:`available <https://github.com/kovidgoyal/kitty/blob/master/docs/notifications.py>`.

.. opt:: kitty.watcher

Path to python file which will be loaded for :ref:`watchers`. Can be specified
more than once to load multiple watchers. The watchers will be added to every
kitty window. Relative paths are resolved relative to the kitty config
directory. Note that reloading the config will only affect windows created after
the reload.

.. opt:: kitty.exe_search_path

Control where kitty finds the programs to run. The default search order is:
First search the system wide :code:`PATH`, then :file:`~/.local/bin` and
:file:`~/bin`. If still not found, the :code:`PATH` defined in the login shell
after sourcing all its startup files is tried. Finally, if present, the
:code:`PATH` specified by the :opt:`env <kitty.env>` option is tried.

This option allows you to prepend, append, or remove paths from this search
order. It can be specified multiple times for multiple paths. A simple path will
be prepended to the search order. A path that starts with the :code:`+` sign
will be append to the search order, after :file:`~/bin` above. A path that
starts with the :code:`-` sign will be removed from the entire search order.
For example::

    exe_search_path /some/prepended/path
    exe_search_path +/some/appended/path
    exe_search_path -/some/excluded/path

.. opt:: kitty.update_check_interval
.. code-block:: conf

    update_check_interval 24

The interval to periodically check if an update to kitty is available (in
hours). If an update is found, a system notification is displayed informing you
of the available update. The default is to check every 24 hours, set to zero to
disable. Update checking is only done by the official binary builds. Distro
packages or source builds do not do update checking. Changing this option by
reloading the config is not supported.

.. opt:: kitty.startup_session
.. code-block:: conf

    startup_session none

Path to a session file to use for all kitty instances. Can be overridden by
using the :option:`kitty --session` :code:`=none` command line option for individual
instances. See :ref:`sessions` in the kitty documentation for details. Note that
relative paths are interpreted with respect to the kitty config directory.
Environment variables in the path are expanded. Changing this option by
reloading the config is not supported. Note that if kitty is invoked with command line
arguments specifying a command to run, this option is ignored.

.. opt:: kitty.clipboard_control
.. code-block:: conf

    clipboard_control write-clipboard write-primary read-clipboard-ask read-primary-ask

Allow programs running in kitty to read and write from the clipboard. You can
control exactly which actions are allowed. The possible actions are:
:code:`write-clipboard`, :code:`read-clipboard`, :code:`write-primary`,
:code:`read-primary`, :code:`read-clipboard-ask`, :code:`read-primary-ask`. The
default is to allow writing to the clipboard and primary selection and to ask
for permission when a program tries to read from the clipboard. Note that
disabling the read confirmation is a security risk as it means that any program,
even the ones running on a remote server via SSH can read your clipboard. See
also :opt:`clipboard_max_size <kitty.clipboard_max_size>`.

.. opt:: kitty.clipboard_max_size
.. code-block:: conf

    clipboard_max_size 512

The maximum size (in MB) of data from programs running in kitty that will be
stored for writing to the system clipboard. A value of zero means no size limit
is applied. See also :opt:`clipboard_control <kitty.clipboard_control>`.

.. opt:: kitty.file_transfer_confirmation_bypass

The password that can be supplied to the :doc:`file transfer kitten
</kittens/transfer>` to skip the transfer confirmation prompt. This should only
be used when initiating transfers from trusted computers, over trusted networks
or encrypted transports, as it allows any programs running on the remote machine
to read/write to the local filesystem, without permission.

.. opt:: kitty.allow_hyperlinks
.. code-block:: conf

    allow_hyperlinks yes

Process :term:`hyperlink <hyperlinks>` escape sequences (OSC 8). If disabled OSC
8 escape sequences are ignored. Otherwise they become clickable links, that you
can click with the mouse or by using the :doc:`hints kitten </kittens/hints>`.
The special value of :code:`ask` means that kitty will ask before opening the
link when clicked.

.. opt:: kitty.shell_integration
.. code-block:: conf

    shell_integration enabled

Enable shell integration on supported shells. This enables features such as
jumping to previous prompts, browsing the output of the previous command in a
pager, etc. on supported shells. Set to :code:`disabled` to turn off shell
integration, completely. It is also possible to disable individual features, set
to a space separated list of these values: :code:`no-rc`, :code:`no-cursor`,
:code:`no-title`, :code:`no-cwd`, :code:`no-prompt-mark`, :code:`no-complete`, :code:`no-sudo`.
See :ref:`Shell integration <shell_integration>` for details.

.. opt:: kitty.allow_cloning
.. code-block:: conf

    allow_cloning ask

Control whether programs running in the terminal can request new windows to be
created. The canonical example is :ref:`clone-in-kitty <clone_shell>`. By
default, kitty will ask for permission for each clone request. Allowing cloning
unconditionally gives programs running in the terminal (including over SSH)
permission to execute arbitrary code, as the user who is running the terminal,
on the computer that the terminal is running on.

.. opt:: kitty.clone_source_strategies
.. code-block:: conf

    clone_source_strategies venv,conda,env_var,path

Control what shell code is sourced when running :command:`clone-in-kitty`
in the newly cloned window. The supported strategies are:

:code:`venv`
    Source the file :file:`$VIRTUAL_ENV/bin/activate`. This is used by the
    Python stdlib venv module and allows cloning venvs automatically.
:code:`conda`
    Run :code:`conda activate $CONDA_DEFAULT_ENV`. This supports the virtual
    environments created by :program:`conda`.
:code:`env_var`
    Execute the contents of the environment variable
    :envvar:`KITTY_CLONE_SOURCE_CODE` with :code:`eval`.
:code:`path`
    Source the file pointed to by the environment variable
    :envvar:`KITTY_CLONE_SOURCE_PATH`.

This option must be a comma separated list of the above values. Only the
first valid match, in the order specified, is sourced.

.. opt:: kitty.notify_on_cmd_finish
.. code-block:: conf

    notify_on_cmd_finish never

Show a desktop notification when a long-running command finishes
(needs :opt:`shell_integration <kitty.shell_integration>`).
The possible values are:

:code:`never`
    Never send a notification.

:code:`unfocused`
    Only send a notification when the window does not have keyboard focus.

:code:`invisible`
    Only send a notification when the window both is unfocused and not visible
    to the user, for example, because it is in an inactive tab or its OS window
    is not currently visible (on platforms that support OS window visibility querying
    this considers an OS Window visible iff it is active).

:code:`always`
    Always send a notification, regardless of window state.

There are two optional arguments:

First, the minimum duration for what is considered a
long running command. The default is 5 seconds. Specify a second argument
to set the duration. For example: :code:`invisible 15`.
Do not set the value too small, otherwise a command that launches a new OS Window
and exits will spam a notification.

Second, the action to perform. The default is :code:`notify`. The possible values are:

:code:`notify`
    Send a desktop notification. The subsequent arguments are optional and specify when
    the notification is automatically cleared. The set of possible events when the notification is
    cleared are: :code:`focus` and :code:`next`. :code:`focus` means that when the notification
    policy is :code:`unfocused` or :code:`invisible` the notification is automatically cleared
    when the window regains focus. The value of :code:`next` means that the previous notification
    is cleared when the next notification is shown. The default when no arguments are specified
    is: :code:`focus next`.

:code:`bell`
    Ring the terminal bell.

:code:`notify-bell`
    Send a desktop notification and ring the terminal bell.
    The arguments are the same as for `notify`.

:code:`command`
    Run a custom command. All subsequent arguments are the cmdline to run.

Some more examples::

    # Send a notification when a command takes more than 5 seconds in an unfocused window
    notify_on_cmd_finish unfocused
    # Send a notification when a command takes more than 10 seconds in a invisible window
    notify_on_cmd_finish invisible 10.0
    # Ring a bell when a command takes more than 10 seconds in a invisible window
    notify_on_cmd_finish invisible 10.0 bell
    # Run 'notify-send' when a command takes more than 10 seconds in a invisible window
    # Here %c is replaced by the current command line and %s by the job exit code
    notify_on_cmd_finish invisible 10.0 command notify-send "job finished with status: %s" %c
    # Do not clear previous notification when next command finishes or window regains focus
    notify_on_cmd_finish invisible 5.0 notify

.. opt:: kitty.term
.. code-block:: conf

    term xterm-kitty

The value of the :envvar:`TERM` environment variable to set. Changing this can
break many terminal programs, only change it if you know what you are doing, not
because you read some advice on "Stack Overflow" to change it. The
:envvar:`TERM` variable is used by various programs to get information about the
capabilities and behavior of the terminal. If you change it, depending on what
programs you run, and how different the terminal you are changing it to is,
various things from key-presses, to colors, to various advanced features may not
work. Changing this option by reloading the config will only affect newly
created windows.

.. opt:: kitty.terminfo_type
.. code-block:: conf

    terminfo_type path

The value of the :envvar:`TERMINFO` environment variable to set. This variable is
used by programs running in the terminal to search for terminfo databases. The default value
of :code:`path` causes kitty to set it to a filesystem location containing the
kitty terminfo database. A value of :code:`direct` means put the entire database into
the env var directly. This can be useful when connecting to containers, for example. But,
note that not all software supports this. A value of :code:`none` means do not touch the variable.

.. opt:: kitty.forward_stdio
.. code-block:: conf

    forward_stdio no

Forward STDOUT and STDERR of the kitty process to child processes.
This is useful for debugging as it
allows child processes to print to kitty's STDOUT directly. For example,
:code:`echo hello world >&$KITTY_STDIO_FORWARDED` in a shell will print
to the parent kitty's STDOUT. Sets the :code:`KITTY_STDIO_FORWARDED=fdnum`
environment variable so child processes know about the forwarding. Note that
on macOS this prevents the shell from being run via the login utility so getlogin()
will not work in programs run in this session.

.. opt:: kitty.menu_map

Specify entries for various menus in kitty. Currently only the global menubar on macOS
is supported. For example::

   menu_map global "Actions::Launch something special" launch --hold --type=os-window sh -c "echo hello world"

This will create a menu entry named "Launch something special" in an "Actions" menu in the macOS global menubar.
Sub-menus can be created by adding more levels separated by the :code:`::` characters.


.. _conf-kitty-os:

OS specific tweaks
--------------------------------------

.. opt:: kitty.wayland_titlebar_color
.. code-block:: conf

    wayland_titlebar_color system

The color of the kitty window's titlebar on Wayland systems with client
side window decorations such as GNOME. A value of :code:`system` means to use
the default system colors, a value of :code:`background` means to use the
background color of the currently active kitty window and finally you can use an
arbitrary color, such as :code:`#12af59` or :code:`red`.

.. opt:: kitty.macos_titlebar_color
.. code-block:: conf

    macos_titlebar_color system

The color of the kitty window's titlebar on macOS. A value of
:code:`system` means to use the default system color, :code:`light` or
:code:`dark` can also be used to set it explicitly. A value of
:code:`background` means to use the background color of the currently active
window and finally you can use an arbitrary color, such as :code:`#12af59` or
:code:`red`.

.. opt:: kitty.macos_option_as_alt
.. code-block:: conf

    macos_option_as_alt no

Use the :kbd:`Option` key as an :kbd:`Alt` key on macOS. With this set to
:code:`no`, kitty will use the macOS native :kbd:`Option+Key` to enter Unicode
character behavior. This will break any :kbd:`Alt+Key` keyboard shortcuts in
your terminal programs, but you can use the macOS Unicode input technique. You
can use the values: :code:`left`, :code:`right` or :code:`both` to use only the
left, right or both :kbd:`Option` keys as :kbd:`Alt`, instead. Note that kitty
itself always treats :kbd:`Option` the same as :kbd:`Alt`. This means you cannot
use this option to configure different kitty shortcuts for :kbd:`Option+Key`
vs. :kbd:`Alt+Key`. Also, any kitty shortcuts using :kbd:`Option/Alt+Key` will
take priority, so that any such key presses will not be passed to terminal
programs running inside kitty. Changing this option by reloading the config is
not supported.

.. opt:: kitty.macos_hide_from_tasks
.. code-block:: conf

    macos_hide_from_tasks no

Hide the kitty window from running tasks on macOS (:kbd:`⌘+Tab` and the Dock).
Changing this option by reloading the config is not supported.

.. opt:: kitty.macos_quit_when_last_window_closed
.. code-block:: conf

    macos_quit_when_last_window_closed no

Have kitty quit when all the top-level windows are closed on macOS. By default,
kitty will stay running, even with no open windows, as is the expected behavior
on macOS.

.. opt:: kitty.macos_window_resizable
.. code-block:: conf

    macos_window_resizable yes

Disable this if you want kitty top-level OS windows to not be resizable on
macOS.

.. opt:: kitty.macos_thicken_font
.. code-block:: conf

    macos_thicken_font 0

Draw an extra border around the font with the given width, to increase
legibility at small font sizes on macOS. For example, a value of :code:`0.75`
will result in rendering that looks similar to sub-pixel antialiasing at common
font sizes. Note that in modern kitty, this option is obsolete (although still
supported). Consider using :opt:`text_composition_strategy <kitty.text_composition_strategy>` instead.

.. opt:: kitty.macos_traditional_fullscreen
.. code-block:: conf

    macos_traditional_fullscreen no

Use the macOS traditional full-screen transition, that is faster, but less
pretty.

.. opt:: kitty.macos_show_window_title_in
.. code-block:: conf

    macos_show_window_title_in all

Control where the window title is displayed on macOS. A value of :code:`window`
will show the title of the currently active window at the top of the macOS
window. A value of :code:`menubar` will show the title of the currently active
window in the macOS global menu bar, making use of otherwise wasted space. A
value of :code:`all` will show the title in both places, and :code:`none` hides
the title. See :opt:`macos_menubar_title_max_length <kitty.macos_menubar_title_max_length>` for how to control the
length of the title in the menu bar.

.. opt:: kitty.macos_menubar_title_max_length
.. code-block:: conf

    macos_menubar_title_max_length 0

The maximum number of characters from the window title to show in the macOS
global menu bar. Values less than one means that there is no maximum limit.

.. opt:: kitty.macos_custom_beam_cursor
.. code-block:: conf

    macos_custom_beam_cursor no

Use a custom mouse cursor for macOS that is easier to see on both light
and dark backgrounds. Nowadays, the default macOS cursor already comes with a
white border. WARNING: this might make your mouse cursor invisible on
dual GPU machines. Changing this option by reloading the config is not supported.

.. opt:: kitty.macos_colorspace
.. code-block:: conf

    macos_colorspace srgb

The colorspace in which to interpret terminal colors. The default of
:code:`srgb` will cause colors to match those seen in web browsers. The value of
:code:`default` will use whatever the native colorspace of the display is.
The value of :code:`displayp3` will use Apple's special snowflake display P3
color space, which will result in over saturated (brighter) colors with some
color shift. Reloading configuration will change this value only for newly
created OS windows.

.. opt:: kitty.linux_display_server
.. code-block:: conf

    linux_display_server auto

Choose between Wayland and X11 backends. By default, an appropriate backend
based on the system state is chosen automatically. Set it to :code:`x11` or
:code:`wayland` to force the choice. Changing this option by reloading the
config is not supported.

.. opt:: kitty.wayland_enable_ime
.. code-block:: conf

    wayland_enable_ime yes

Enable Input Method Extension on Wayland. This is typically used for
inputting text in East Asian languages. However, its implementation in
Wayland is often buggy and introduces latency into the input loop,
so disable this if you know you dont need it. Changing this option
by reloading the config is not supported, it will not have any effect.


.. _conf-kitty-shortcuts:

Keyboard shortcuts
--------------------------------------

Keys are identified simply by their lowercase Unicode characters. For example:
:code:`a` for the :kbd:`A` key, :code:`[` for the left square bracket key, etc.
For functional keys, such as :kbd:`Enter` or :kbd:`Escape`, the names are present
at :ref:`Functional key definitions <functional>`. For modifier keys, the names
are :kbd:`ctrl` (:kbd:`control`, :kbd:`⌃`), :kbd:`shift` (:kbd:`⇧`), :kbd:`alt`
(:kbd:`opt`, :kbd:`option`, :kbd:`⌥`), :kbd:`super` (:kbd:`cmd`, :kbd:`command`,
:kbd:`⌘`).

Simple shortcut mapping is done with the :code:`map` directive. For full details
on advanced mapping including modal and per application maps, see :doc:`mapping`.
Some quick examples to illustrate common tasks::

    # unmap a keyboard shortcut, passing it to the program running in kitty
    map kitty_mod+space
    # completely ignore a keyboard event
    map ctrl+alt+f1 discard_event
    # combine multiple actions
    map kitty_mod+e combine : new_window : next_layout
    # multi-key shortcuts
    map ctrl+x>ctrl+y>z action

The full list of actions that can be mapped to key presses is available
:doc:`here </actions>`.

.. opt:: kitty.kitty_mod
.. code-block:: conf

    kitty_mod ctrl+shift

Special modifier key alias for default shortcuts. You can change the value of
this option to alter all default shortcuts that use :opt:`kitty_mod <kitty.kitty_mod>`.

.. opt:: kitty.clear_all_shortcuts
.. code-block:: conf

    clear_all_shortcuts no

Remove all shortcut definitions up to this point. Useful, for instance, to
remove the default shortcuts.

.. opt:: kitty.action_alias

Has no default values. Example values are shown below:

.. code-block:: conf

    action_alias launch_tab launch --type=tab --cwd=current

Define action aliases to avoid repeating the same options in multiple mappings.
Aliases can be defined for any action and will be expanded recursively. For
example, the above alias allows you to create mappings to launch a new tab in
the current working directory without duplication::

    map f1 launch_tab vim
    map f2 launch_tab emacs

Similarly, to alias kitten invocation::

    action_alias hints kitten hints --hints-offset=0

.. opt:: kitty.kitten_alias

Has no default values. Example values are shown below:

.. code-block:: conf

    kitten_alias hints hints --hints-offset=0

Like :opt:`action_alias <kitty.action_alias>` above, but specifically for kittens. Generally, prefer
to use :opt:`action_alias <kitty.action_alias>`. This option is a legacy version, present for
backwards compatibility. It causes all invocations of the aliased kitten to be
substituted. So the example above will cause all invocations of the hints kitten
to have the :option:`--hints-offset=0 <kitty +kitten hints --hints-offset>`
option applied.


.. _conf-kitty-shortcuts.clipboard:

Clipboard
+++++++++++++++++++++++++++++

.. shortcut:: kitty.Copy to clipboard
.. code-block:: conf

    map ctrl+shift+c copy_to_clipboard


There is also a :ac:`copy_or_interrupt` action that can be optionally mapped
to :kbd:`Ctrl+C`. It will copy only if there is a selection and send an
interrupt otherwise. Similarly, :ac:`copy_and_clear_or_interrupt` will copy
and clear the selection or send an interrupt if there is no selection.
The :ac:`copy_or_noop` action will copy if there is a selection and pass
the key through to the application running in the terminal if there is no selection.

.. shortcut:: kitty.Copy to clipboard or pass through
.. code-block:: conf

    map cmd+c copy_or_noop 🍎

.. shortcut:: kitty.Paste from clipboard
.. code-block:: conf

    map ctrl+shift+v paste_from_clipboard
    map cmd+v paste_from_clipboard 🍎

.. shortcut:: kitty.Paste from selection
.. code-block:: conf

    map ctrl+shift+s paste_from_selection
    map shift+insert paste_from_selection

.. shortcut:: kitty.Pass selection to program
.. code-block:: conf

    map ctrl+shift+o pass_selection_to_program


You can also pass the contents of the current selection to any program with
:ac:`pass_selection_to_program`. By default, the system's open program is used,
but you can specify your own, the selection will be passed as a command line
argument to the program. For example::

    map kitty_mod+o pass_selection_to_program firefox

You can pass the current selection to a terminal program running in a new kitty
window, by using the :code:`@selection` placeholder::

    map kitty_mod+y new_window less @selection


.. _conf-kitty-shortcuts.scrolling:

Scrolling
+++++++++++++++++++++++++++++

.. shortcut:: kitty.Scroll line up
.. code-block:: conf

    map ctrl+shift+up scroll_line_up
    map ctrl+shift+k scroll_line_up
    map opt+cmd+page_up scroll_line_up 🍎
    map cmd+up scroll_line_up 🍎

.. shortcut:: kitty.Scroll line down
.. code-block:: conf

    map ctrl+shift+down scroll_line_down
    map ctrl+shift+j scroll_line_down
    map opt+cmd+page_down scroll_line_down 🍎
    map cmd+down scroll_line_down 🍎

.. shortcut:: kitty.Scroll page up
.. code-block:: conf

    map ctrl+shift+page_up scroll_page_up
    map cmd+page_up scroll_page_up 🍎

.. shortcut:: kitty.Scroll page down
.. code-block:: conf

    map ctrl+shift+page_down scroll_page_down
    map cmd+page_down scroll_page_down 🍎

.. shortcut:: kitty.Scroll to top
.. code-block:: conf

    map ctrl+shift+home scroll_home
    map cmd+home scroll_home 🍎

.. shortcut:: kitty.Scroll to bottom
.. code-block:: conf

    map ctrl+shift+end scroll_end
    map cmd+end scroll_end 🍎

.. shortcut:: kitty.Scroll to previous shell prompt
.. code-block:: conf

    map ctrl+shift+z scroll_to_prompt -1


Use a parameter of :code:`0` for :ac:`scroll_to_prompt` to scroll to the last
jumped to or the last clicked position. Requires :ref:`shell integration
<shell_integration>` to work.

.. shortcut:: kitty.Scroll to next shell prompt
.. code-block:: conf

    map ctrl+shift+x scroll_to_prompt 1

.. shortcut:: kitty.Browse scrollback buffer in pager
.. code-block:: conf

    map ctrl+shift+h show_scrollback


You can pipe the contents of the current screen and history buffer as
:file:`STDIN` to an arbitrary program using :option:`launch --stdin-source`.
For example, the following opens the scrollback buffer in less in an
:term:`overlay` window::

    map f1 launch --stdin-source=@screen_scrollback --stdin-add-formatting --type=overlay less +G -R

For more details on piping screen and buffer contents to external programs,
see :doc:`launch`.

.. shortcut:: kitty.Browse output of the last shell command in pager
.. code-block:: conf

    map ctrl+shift+g show_last_command_output


You can also define additional shortcuts to get the command output.
For example, to get the first command output on screen::

    map f1 show_first_command_output_on_screen

To get the command output that was last accessed by a keyboard action or mouse
action::

    map f1 show_last_visited_command_output

You can pipe the output of the last command run in the shell using the
:ac:`launch` action. For example, the following opens the output in less in an
:term:`overlay` window::

    map f1 launch --stdin-source=@last_cmd_output --stdin-add-formatting --type=overlay less +G -R

To get the output of the first command on the screen, use :code:`@first_cmd_output_on_screen`.
To get the output of the last jumped to command, use :code:`@last_visited_cmd_output`.

Requires :ref:`shell integration <shell_integration>` to work.


.. _conf-kitty-shortcuts.window:

Window management
+++++++++++++++++++++++++++++++++++++

.. shortcut:: kitty.New window
.. code-block:: conf

    map ctrl+shift+enter new_window
    map cmd+enter new_window 🍎


You can open a new :term:`kitty window <window>` running an arbitrary program,
for example::

    map kitty_mod+y launch mutt

You can open a new window with the current working directory set to the working
directory of the current window using::

    map ctrl+alt+enter launch --cwd=current

You can open a new window that is allowed to control kitty via
the kitty remote control facility with :option:`launch --allow-remote-control`.
Any programs running in that window will be allowed to control kitty.
For example::

    map ctrl+enter launch --allow-remote-control some_program

You can open a new window next to the currently active window or as the first
window, with::

    map ctrl+n launch --location=neighbor
    map ctrl+f launch --location=first

For more details, see :doc:`launch`.

.. shortcut:: kitty.New OS window
.. code-block:: conf

    map ctrl+shift+n new_os_window
    map cmd+n new_os_window 🍎


Works like :ac:`new_window` above, except that it opens a top-level :term:`OS
window <os_window>`. In particular you can use :ac:`new_os_window_with_cwd` to
open a window with the current working directory.

.. shortcut:: kitty.Close window
.. code-block:: conf

    map ctrl+shift+w close_window
    map shift+cmd+d close_window 🍎

.. shortcut:: kitty.Next window
.. code-block:: conf

    map ctrl+shift+] next_window

.. shortcut:: kitty.Previous window
.. code-block:: conf

    map ctrl+shift+[ previous_window

.. shortcut:: kitty.Move window forward
.. code-block:: conf

    map ctrl+shift+f move_window_forward

.. shortcut:: kitty.Move window backward
.. code-block:: conf

    map ctrl+shift+b move_window_backward

.. shortcut:: kitty.Move window to top
.. code-block:: conf

    map ctrl+shift+` move_window_to_top

.. shortcut:: kitty.Start resizing window
.. code-block:: conf

    map ctrl+shift+r start_resizing_window
    map cmd+r start_resizing_window 🍎

.. shortcut:: kitty.First window
.. code-block:: conf

    map ctrl+shift+1 first_window
    map cmd+1 first_window 🍎

.. shortcut:: kitty.Second window
.. code-block:: conf

    map ctrl+shift+2 second_window
    map cmd+2 second_window 🍎

.. shortcut:: kitty.Third window
.. code-block:: conf

    map ctrl+shift+3 third_window
    map cmd+3 third_window 🍎

.. shortcut:: kitty.Fourth window
.. code-block:: conf

    map ctrl+shift+4 fourth_window
    map cmd+4 fourth_window 🍎

.. shortcut:: kitty.Fifth window
.. code-block:: conf

    map ctrl+shift+5 fifth_window
    map cmd+5 fifth_window 🍎

.. shortcut:: kitty.Sixth window
.. code-block:: conf

    map ctrl+shift+6 sixth_window
    map cmd+6 sixth_window 🍎

.. shortcut:: kitty.Seventh window
.. code-block:: conf

    map ctrl+shift+7 seventh_window
    map cmd+7 seventh_window 🍎

.. shortcut:: kitty.Eighth window
.. code-block:: conf

    map ctrl+shift+8 eighth_window
    map cmd+8 eighth_window 🍎

.. shortcut:: kitty.Ninth window
.. code-block:: conf

    map ctrl+shift+9 ninth_window
    map cmd+9 ninth_window 🍎

.. shortcut:: kitty.Tenth window
.. code-block:: conf

    map ctrl+shift+0 tenth_window

.. shortcut:: kitty.Visually select and focus window
.. code-block:: conf

    map ctrl+shift+f7 focus_visible_window


Display overlay numbers and alphabets on the window, and switch the focus to the
window when you press the key. When there are only two windows, the focus will
be switched directly without displaying the overlay. You can change the overlay
characters and their order with option :opt:`visual_window_select_characters <kitty.visual_window_select_characters>`.

.. shortcut:: kitty.Visually swap window with another
.. code-block:: conf

    map ctrl+shift+f8 swap_with_window


Works like :ac:`focus_visible_window` above, but swaps the window.


.. _conf-kitty-shortcuts.tab:

Tab management
++++++++++++++++++++++++++++++++++

.. shortcut:: kitty.Next tab
.. code-block:: conf

    map ctrl+shift+right next_tab
    map shift+cmd+] next_tab 🍎
    map ctrl+tab next_tab

.. shortcut:: kitty.Previous tab
.. code-block:: conf

    map ctrl+shift+left previous_tab
    map shift+cmd+[ previous_tab 🍎
    map ctrl+shift+tab previous_tab

.. shortcut:: kitty.New tab
.. code-block:: conf

    map ctrl+shift+t new_tab
    map cmd+t new_tab 🍎

.. shortcut:: kitty.Close tab
.. code-block:: conf

    map ctrl+shift+q close_tab
    map cmd+w close_tab 🍎

.. shortcut:: kitty.Close OS window
.. code-block:: conf

    map shift+cmd+w close_os_window 🍎

.. shortcut:: kitty.Move tab forward
.. code-block:: conf

    map ctrl+shift+. move_tab_forward

.. shortcut:: kitty.Move tab backward
.. code-block:: conf

    map ctrl+shift+, move_tab_backward

.. shortcut:: kitty.Set tab title
.. code-block:: conf

    map ctrl+shift+alt+t set_tab_title
    map shift+cmd+i set_tab_title 🍎


You can also create shortcuts to go to specific :term:`tabs <tab>`, with
:code:`1` being the first tab, :code:`2` the second tab and :code:`-1` being the
previously active tab, :code:`-2` being the tab active before the previously active tab and so on.
Any number larger than the number of tabs goes to the last tab and any number less
than the number of previously used tabs in the history goes to the oldest previously used tab in the history::

    map ctrl+alt+1 goto_tab 1
    map ctrl+alt+2 goto_tab 2

Just as with :ac:`new_window` above, you can also pass the name of arbitrary
commands to run when using :ac:`new_tab` and :ac:`new_tab_with_cwd`. Finally,
if you want the new tab to open next to the current tab rather than at the
end of the tabs list, use::

    map ctrl+t new_tab !neighbor [optional cmd to run]

.. _conf-kitty-shortcuts.layout:

Layout management
+++++++++++++++++++++++++++++++++++++

.. shortcut:: kitty.Next layout
.. code-block:: conf

    map ctrl+shift+l next_layout


You can also create shortcuts to switch to specific :term:`layouts <layout>`::

    map ctrl+alt+t goto_layout tall
    map ctrl+alt+s goto_layout stack

Similarly, to switch back to the previous layout::

    map ctrl+alt+p last_used_layout

There is also a :ac:`toggle_layout` action that switches to the named layout or
back to the previous layout if in the named layout. Useful to temporarily "zoom"
the active window by switching to the stack layout::

    map ctrl+alt+z toggle_layout stack

.. _conf-kitty-shortcuts.fonts:

Font sizes
++++++++++++++++++++++++++++++

You can change the font size for all top-level kitty OS windows at a time or
only the current one.

.. shortcut:: kitty.Increase font size
.. code-block:: conf

    map ctrl+shift+equal change_font_size all +2.0
    map ctrl+shift+plus change_font_size all +2.0
    map ctrl+shift+kp_add change_font_size all +2.0
    map cmd+plus change_font_size all +2.0 🍎
    map cmd+equal change_font_size all +2.0 🍎
    map shift+cmd+equal change_font_size all +2.0 🍎

.. shortcut:: kitty.Decrease font size
.. code-block:: conf

    map ctrl+shift+minus change_font_size all -2.0
    map ctrl+shift+kp_subtract change_font_size all -2.0
    map cmd+minus change_font_size all -2.0 🍎
    map shift+cmd+minus change_font_size all -2.0 🍎

.. shortcut:: kitty.Reset font size
.. code-block:: conf

    map ctrl+shift+backspace change_font_size all 0
    map cmd+0 change_font_size all 0 🍎


To setup shortcuts for specific font sizes::

    map kitty_mod+f6 change_font_size all 10.0

To setup shortcuts to change only the current OS window's font size::

    map kitty_mod+f6 change_font_size current 10.0

To setup shortcuts to multiply/divide the font size::

    map kitty_mod+f6 change_font_size all *2.0
    map kitty_mod+f6 change_font_size all /2.0

.. _conf-kitty-shortcuts.selection:

Select and act on visible text
++++++++++++++++++++++++++++++++++++++++++++++++++

Use the hints kitten to select text and either pass it to an external program or
insert it into the terminal or copy it to the clipboard.

.. shortcut:: kitty.Open URL
.. code-block:: conf

    map ctrl+shift+e open_url_with_hints


Open a currently visible URL using the keyboard. The program used to open the
URL is specified in :opt:`open_url_with <kitty.open_url_with>`.

.. shortcut:: kitty.Insert selected path
.. code-block:: conf

    map ctrl+shift+p>f kitten hints --type path --program -


Select a path/filename and insert it into the terminal. Useful, for instance to
run :program:`git` commands on a filename output from a previous :program:`git`
command.

.. shortcut:: kitty.Open selected path
.. code-block:: conf

    map ctrl+shift+p>shift+f kitten hints --type path


Select a path/filename and open it with the default open program.

.. shortcut:: kitty.Insert selected line
.. code-block:: conf

    map ctrl+shift+p>l kitten hints --type line --program -


Select a line of text and insert it into the terminal. Useful for the output of
things like: ``ls -1``.

.. shortcut:: kitty.Insert selected word
.. code-block:: conf

    map ctrl+shift+p>w kitten hints --type word --program -


Select words and insert into terminal.

.. shortcut:: kitty.Insert selected hash
.. code-block:: conf

    map ctrl+shift+p>h kitten hints --type hash --program -


Select something that looks like a hash and insert it into the terminal. Useful
with :program:`git`, which uses SHA1 hashes to identify commits.

.. shortcut:: kitty.Open the selected file at the selected line
.. code-block:: conf

    map ctrl+shift+p>n kitten hints --type linenum


Select something that looks like :code:`filename:linenum` and open it in
your default editor at the specified line number.

.. shortcut:: kitty.Open the selected hyperlink
.. code-block:: conf

    map ctrl+shift+p>y kitten hints --type hyperlink


Select a :term:`hyperlink <hyperlinks>` (i.e. a URL that has been marked as such
by the terminal program, for example, by ``ls --hyperlink=auto``).


The hints kitten has many more modes of operation that you can map to different
shortcuts. For a full description see :doc:`hints kitten </kittens/hints>`.

.. _conf-kitty-shortcuts.misc:

Miscellaneous
+++++++++++++++++++++++++++++++++

.. shortcut:: kitty.Show documentation
.. code-block:: conf

    map ctrl+shift+f1 show_kitty_doc overview

.. shortcut:: kitty.Toggle fullscreen
.. code-block:: conf

    map ctrl+shift+f11 toggle_fullscreen
    map ctrl+cmd+f toggle_fullscreen 🍎

.. shortcut:: kitty.Toggle maximized
.. code-block:: conf

    map ctrl+shift+f10 toggle_maximized

.. shortcut:: kitty.Toggle macOS secure keyboard entry
.. code-block:: conf

    map opt+cmd+s toggle_macos_secure_keyboard_entry 🍎

.. shortcut:: kitty.Unicode input
.. code-block:: conf

    map ctrl+shift+u kitten unicode_input
    map ctrl+cmd+space kitten unicode_input 🍎

.. shortcut:: kitty.Edit config file
.. code-block:: conf

    map ctrl+shift+f2 edit_config_file
    map cmd+, edit_config_file 🍎

.. shortcut:: kitty.Open the kitty command shell
.. code-block:: conf

    map ctrl+shift+escape kitty_shell window


Open the kitty shell in a new :code:`window` / :code:`tab` / :code:`overlay` /
:code:`os_window` to control kitty using commands.

.. shortcut:: kitty.Increase background opacity
.. code-block:: conf

    map ctrl+shift+a>m set_background_opacity +0.1

.. shortcut:: kitty.Decrease background opacity
.. code-block:: conf

    map ctrl+shift+a>l set_background_opacity -0.1

.. shortcut:: kitty.Make background fully opaque
.. code-block:: conf

    map ctrl+shift+a>1 set_background_opacity 1

.. shortcut:: kitty.Reset background opacity
.. code-block:: conf

    map ctrl+shift+a>d set_background_opacity default

.. shortcut:: kitty.Reset the terminal
.. code-block:: conf

    map ctrl+shift+delete clear_terminal reset active
    map opt+cmd+r clear_terminal reset active 🍎


You can create shortcuts to clear/reset the terminal. For example::

    # Reset the terminal
    map f1 clear_terminal reset active
    # Clear the terminal screen by erasing all contents
    map f1 clear_terminal clear active
    # Clear the terminal scrollback by erasing it
    map f1 clear_terminal scrollback active
    # Scroll the contents of the screen into the scrollback
    map f1 clear_terminal scroll active
    # Clear everything on screen up to the line with the cursor or the start of the current prompt (needs shell integration)
    map f1 clear_terminal to_cursor active
    # Same as above except cleared lines are moved into scrollback
    map f1 clear_terminal to_cursor_scroll active
    # Erase the last command and its output (needs shell integration to work)
    map f1 clear_terminal last_command active

If you want to operate on all kitty windows instead of just the current one, use
:italic:`all` instead of :italic:`active`.

Some useful functions that can be defined in the shell rc files to perform various kinds of
clearing of the current window:

.. code-block:: sh

    clear-only-screen() {
        printf "\e[H\e[2J"
    }

    clear-screen-and-scrollback() {
        printf "\e[H\e[3J"
    }

    clear-screen-saving-contents-in-scrollback() {
        printf "\e[H\e[22J"
    }

For instance, using these escape codes, it is possible to remap :kbd:`Ctrl+L`
to both scroll the current screen contents into the scrollback buffer and clear
the screen, instead of just clearing the screen. For ZSH, in :file:`~/.zshrc`, add:

.. code-block:: zsh

    ctrl_l() {
        builtin print -rn -- $'\r\e[0J\e[H\e[22J' >"$TTY"
        builtin zle .reset-prompt
        builtin zle -R
    }
    zle -N ctrl_l
    bindkey '^l' ctrl_l

Alternatively, you can just add :code:`map ctrl+l clear_terminal to_cursor_scroll active` to :file:`kitty.conf` which
works with no changes to the shell rc files, but only clears up to the prompt, it does not clear any text at the prompt itself.

.. shortcut:: kitty.Clear to start
.. code-block:: conf

    map cmd+k clear_terminal to_cursor active 🍎

.. shortcut:: kitty.Clear scrollback
.. code-block:: conf

    map option+cmd+k clear_terminal scrollback active 🍎

.. shortcut:: kitty.Clear the last command
.. code-block:: conf

    map cmd+l clear_terminal last_command active 🍎

.. shortcut:: kitty.Clear screen
.. code-block:: conf

    map cmd+ctrl+l clear_terminal to_cursor_scroll active 🍎

.. shortcut:: kitty.Reload kitty.conf
.. code-block:: conf

    map ctrl+shift+f5 load_config_file
    map ctrl+cmd+, load_config_file 🍎


Reload :file:`kitty.conf`, applying any changes since the last time it was
loaded. Note that a handful of options cannot be dynamically changed and
require a full restart of kitty. Particularly, when changing shortcuts for
actions located on the macOS global menu bar, a full restart is needed. You can
also map a keybinding to load a different config file, for example::

    map f5 load_config /path/to/alternative/kitty.conf

Note that all options from the original :file:`kitty.conf` are discarded, in
other words the new configuration *replace* the old ones.

.. shortcut:: kitty.Debug kitty configuration
.. code-block:: conf

    map ctrl+shift+f6 debug_config
    map opt+cmd+, debug_config 🍎


Show details about exactly what configuration kitty is running with and its host
environment. Useful for debugging issues.

.. shortcut:: kitty.Send arbitrary text on key presses


You can tell kitty to send arbitrary (UTF-8) encoded text to the client program
when pressing specified shortcut keys. For example::

    map ctrl+alt+a send_text all Special text

This will send "Special text" when you press the :kbd:`Ctrl+Alt+A` key
combination. The text to be sent decodes :link:`ANSI C escapes <https://www.gnu.org/software/bash/manual/html_node/ANSI_002dC-Quoting.html>`
so you can use escapes like :code:`\\e` to send control codes or :code:`\\u21fb` to send
Unicode characters (or you can just input the Unicode characters directly as
UTF-8 text). You can use ``kitten show-key`` to get the key escape
codes you want to emulate.

The first argument to :code:`send_text` is the keyboard modes in which to
activate the shortcut. The possible values are :code:`normal`,
:code:`application`, :code:`kitty` or a comma separated combination of them.
The modes :code:`normal` and :code:`application` refer to the DECCKM
cursor key mode for terminals, and :code:`kitty` refers to the kitty extended
keyboard protocol. The special value :code:`all` means all of them.

Some more examples::

    # Output a word and move the cursor to the start of the line (like typing and pressing Home)
    map ctrl+alt+a send_text normal Word\e[H
    map ctrl+alt+a send_text application Word\eOH
    # Run a command at a shell prompt (like typing the command and pressing Enter)
    map ctrl+alt+a send_text normal,application some command with arguments\r

.. shortcut:: kitty.Open kitty Website
.. code-block:: conf

    map shift+cmd+/ open_url https://sw.kovidgoyal.net/kitty/ 🍎

.. shortcut:: kitty.Hide macOS kitty application
.. code-block:: conf

    map cmd+h hide_macos_app 🍎

.. shortcut:: kitty.Hide macOS other applications
.. code-block:: conf

    map opt+cmd+h hide_macos_other_apps 🍎

.. shortcut:: kitty.Minimize macOS window
.. code-block:: conf

    map cmd+m minimize_macos_window 🍎

.. shortcut:: kitty.Quit kitty
.. code-block:: conf

    map cmd+q quit 🍎
