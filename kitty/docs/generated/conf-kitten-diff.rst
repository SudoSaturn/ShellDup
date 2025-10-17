.. highlight:: conf

.. default-domain:: conf


.. _conf-kitten-diff-diff:

Diffing
---------------------------

.. opt:: kitten-diff.syntax_aliases
.. code-block:: conf

    syntax_aliases pyj:py pyi:py recipe:py

File extension aliases for syntax highlight. For example, to syntax highlight
:file:`file.xyz` as :file:`file.abc` use a setting of :code:`xyz:abc`.
Multiple aliases must be separated by spaces.

.. opt:: kitten-diff.num_context_lines
.. code-block:: conf

    num_context_lines 3

The number of lines of context to show around each change.

.. opt:: kitten-diff.diff_cmd
.. code-block:: conf

    diff_cmd auto

The diff command to use. Must contain the placeholder :code:`_CONTEXT_` which
will be replaced by the number of lines of context. A few special values are allowed:
:code:`auto` will automatically pick an available diff implementation. :code:`builtin`
will use the anchored diff algorithm from the Go standard library. :code:`git` will
use the git command to do the diffing. :code:`diff` will use the diff command to
do the diffing.

.. opt:: kitten-diff.replace_tab_by
.. code-block:: conf

    replace_tab_by \x20\x20\x20\x20

The string to replace tabs with. Default is to use four spaces.

.. opt:: kitten-diff.ignore_name

A glob pattern that is matched against only the filename of files and directories. Matching
files and directories are ignored when scanning the filesystem to look for files to diff.
Can be specified multiple times to use multiple patterns. For example::

    ignore_name .git
    ignore_name *~
    ignore_name *.pyc


.. _conf-kitten-diff-colors:

Colors
--------------------------

.. opt:: kitten-diff.color_scheme
.. code-block:: conf

    color_scheme auto

Whether to use the light or dark colors. The default of :code:`auto` means
to follow the parent terminal color scheme. Note that the actual colors used
for dark schemes are set by the :code:`dark_*` settings below and the non-prefixed
settings are used for light colors.

.. opt:: kitten-diff.pygments_style
.. code-block:: conf

    pygments_style default

The pygments color scheme to use for syntax highlighting. See :link:`pygments
builtin styles <https://pygments.org/styles/>` for a list of schemes. Note that
this **does not** change the colors used for diffing,
only the colors used for syntax highlighting. To change the general colors use the settings below.
This sets the colors used for light color schemes, use :opt:`dark_pygments_style <kitten-diff.dark_pygments_style>` to change the
colors for dark color schemes.

.. opt:: kitten-diff.dark_pygments_style
.. code-block:: conf

    dark_pygments_style github-dark

The pygments color scheme to use for syntax highlighting with dark colors. See :link:`pygments
builtin styles <https://pygments.org/styles/>` for a list of schemes. Note that
this **does not** change the colors used for diffing,
only the colors used for syntax highlighting. To change the general colors use the settings below.
This sets the colors used for dark color schemes, use :opt:`pygments_style <kitten-diff.pygments_style>` to change the
colors for light color schemes.

.. opt:: kitten-diff.foreground, kitten-diff.dark_foreground, kitten-diff.background, kitten-diff.dark_background
.. code-block:: conf

    foreground      black
    dark_foreground #f8f8f2
    background      white
    dark_background #212830

Basic colors

.. opt:: kitten-diff.title_fg, kitten-diff.dark_title_fg, kitten-diff.title_bg, kitten-diff.dark_title_bg
.. code-block:: conf

    title_fg      black
    dark_title_fg white
    title_bg      white
    dark_title_bg #212830

Title colors

.. opt:: kitten-diff.margin_bg, kitten-diff.dark_margin_bg, kitten-diff.margin_fg, kitten-diff.dark_margin_fg
.. code-block:: conf

    margin_bg      #fafbfc
    dark_margin_bg #212830
    margin_fg      #aaaaaa
    dark_margin_fg #aaaaaa

Margin colors

.. opt:: kitten-diff.removed_bg, kitten-diff.dark_removed_bg, kitten-diff.highlight_removed_bg, kitten-diff.dark_highlight_removed_bg, kitten-diff.removed_margin_bg, kitten-diff.dark_removed_margin_bg
.. code-block:: conf

    removed_bg                #ffeef0
    dark_removed_bg           #352c33
    highlight_removed_bg      #fdb8c0
    dark_highlight_removed_bg #5c3539
    removed_margin_bg         #ffdce0
    dark_removed_margin_bg    #5c3539

Removed text backgrounds

.. opt:: kitten-diff.added_bg, kitten-diff.dark_added_bg, kitten-diff.highlight_added_bg, kitten-diff.dark_highlight_added_bg, kitten-diff.added_margin_bg, kitten-diff.dark_added_margin_bg
.. code-block:: conf

    added_bg                #e6ffed
    dark_added_bg           #263834
    highlight_added_bg      #acf2bd
    dark_highlight_added_bg #31503d
    added_margin_bg         #cdffd8
    dark_added_margin_bg    #31503d

Added text backgrounds

.. opt:: kitten-diff.filler_bg, kitten-diff.dark_filler_bg
.. code-block:: conf

    filler_bg      #fafbfc
    dark_filler_bg #262c36

Filler (empty) line background

.. opt:: kitten-diff.margin_filler_bg, kitten-diff.dark_margin_filler_bg
.. code-block:: conf

    margin_filler_bg      none
    dark_margin_filler_bg none

Filler (empty) line background in margins, defaults to the filler background

.. opt:: kitten-diff.hunk_margin_bg, kitten-diff.dark_hunk_margin_bg, kitten-diff.hunk_bg, kitten-diff.dark_hunk_bg
.. code-block:: conf

    hunk_margin_bg      #dbedff
    dark_hunk_margin_bg #0c2d6b
    hunk_bg             #f1f8ff
    dark_hunk_bg        #253142

Hunk header colors

.. opt:: kitten-diff.search_bg, kitten-diff.dark_search_bg, kitten-diff.search_fg, kitten-diff.dark_search_fg, kitten-diff.select_bg, kitten-diff.dark_select_bg, kitten-diff.select_fg, kitten-diff.dark_select_fg
.. code-block:: conf

    search_bg      #444
    dark_search_bg #2c599c
    search_fg      white
    dark_search_fg white
    select_bg      #b4d5fe
    dark_select_bg #2c599c
    select_fg      black
    dark_select_fg white

Highlighting


.. _conf-kitten-diff-shortcuts:

Keyboard shortcuts
--------------------------------------

.. shortcut:: kitten-diff.Quit
.. code-block:: conf

    map q quit
    map esc quit

.. shortcut:: kitten-diff.Scroll down
.. code-block:: conf

    map j scroll_by 1
    map down scroll_by 1

.. shortcut:: kitten-diff.Scroll up
.. code-block:: conf

    map k scroll_by -1
    map up scroll_by -1

.. shortcut:: kitten-diff.Scroll to top
.. code-block:: conf

    map home scroll_to start

.. shortcut:: kitten-diff.Scroll to bottom
.. code-block:: conf

    map end scroll_to end

.. shortcut:: kitten-diff.Scroll to next page
.. code-block:: conf

    map page_down scroll_to next-page
    map space scroll_to next-page
    map ctrl+f scroll_to next-page

.. shortcut:: kitten-diff.Scroll to previous page
.. code-block:: conf

    map page_up scroll_to prev-page
    map ctrl+b scroll_to prev-page

.. shortcut:: kitten-diff.Scroll down half page
.. code-block:: conf

    map ctrl+d scroll_to next-half-page

.. shortcut:: kitten-diff.Scroll up half page
.. code-block:: conf

    map ctrl+u scroll_to prev-half-page

.. shortcut:: kitten-diff.Scroll to next change
.. code-block:: conf

    map n scroll_to next-change

.. shortcut:: kitten-diff.Scroll to previous change
.. code-block:: conf

    map p scroll_to prev-change

.. shortcut:: kitten-diff.Scroll to next file
.. code-block:: conf

    map shift+j scroll_to next-file

.. shortcut:: kitten-diff.Scroll to previous file
.. code-block:: conf

    map shift+k scroll_to prev-file

.. shortcut:: kitten-diff.Show all context
.. code-block:: conf

    map a change_context all

.. shortcut:: kitten-diff.Show default context
.. code-block:: conf

    map = change_context default

.. shortcut:: kitten-diff.Increase context
.. code-block:: conf

    map + change_context 5

.. shortcut:: kitten-diff.Decrease context
.. code-block:: conf

    map - change_context -5

.. shortcut:: kitten-diff.Search forward
.. code-block:: conf

    map / start_search regex forward

.. shortcut:: kitten-diff.Search backward
.. code-block:: conf

    map ? start_search regex backward

.. shortcut:: kitten-diff.Scroll to next search match
.. code-block:: conf

    map . scroll_to next-match
    map > scroll_to next-match

.. shortcut:: kitten-diff.Scroll to previous search match
.. code-block:: conf

    map , scroll_to prev-match
    map < scroll_to prev-match

.. shortcut:: kitten-diff.Search forward (no regex)
.. code-block:: conf

    map f start_search substring forward

.. shortcut:: kitten-diff.Search backward (no regex)
.. code-block:: conf

    map b start_search substring backward

.. shortcut:: kitten-diff.Copy selection to clipboard
.. code-block:: conf

    map y copy_to_clipboard

.. shortcut:: kitten-diff.Copy selection to clipboard or exit if no selection is present
.. code-block:: conf

    map ctrl+c copy_to_clipboard_or_exit
