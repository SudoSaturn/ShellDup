.. program:: kitty +kitten hints

Source code for hints
------------------------------------------------------------------------

The source code for this kitten is `available on GitHub <https://github.com/kovidgoyal/kitty/tree/master/kittens/hints>`_.

Command Line Interface
------------------------------------------------------------------------


.. highlight:: sh
.. code-block:: sh

  kitten hints [options] 

Select text from the screen using the keyboard. Defaults to searching for URLs.

Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. option:: --program <PROGRAM>

    What program to use to open matched text. Defaults to the default open program for the operating system. Various special values are supported:

    :code:`-`
        paste the match into the terminal window.

    :code:`@`
        copy the match to the clipboard

    :code:`*`
        copy the match to the primary selection (on systems that support primary selections)

    :code:`@NAME`
        copy the match to the specified buffer, e.g. :code:`@a`

    :code:`default`
        run the default open program. Note that when using the hyperlink :code:`--type` the default is to use the kitty :doc:`hyperlink handling </open_actions>` facilities.

    :code:`launch`
        run :doc:`/launch` to open the program in a new kitty tab, window, overlay, etc. For example::

            --program "launch --type=tab vim"

    Can be specified multiple times to run multiple programs.

.. option:: --type <TYPE>

    The type of text to search for. A value of :code:`linenum` is special, it looks for error messages using the pattern specified with :option:`--regex`, which must have the named groups: :code:`path` and :code:`line`. If not specified, will look for :code:`path:line`. The :option:`--linenum-action` option controls where to display the selected error message, other options are ignored.
    Default: :code:`url`
    Choices: :code:`hash`, :code:`hyperlink`, :code:`ip`, :code:`line`, :code:`linenum`, :code:`path`, :code:`regex`, :code:`url`, :code:`word`

.. option:: --regex <REGEX>

    The regular expression to use when option :option:`--type` is set to :code:`regex`, in Perl 5 syntax. If you specify a numbered group in the regular expression, only the group will be matched. This allows you to match text ignoring a prefix/suffix, as needed. The default expression matches lines. To match text over multiple lines, things get a little tricky, as line endings are a sequence of zero or more null bytes followed by either a carriage return or a newline character. To have a pattern match over line endings you will need to match the character set ``[\0\r\n]``. The newlines and null bytes are automatically stripped from the returned text. If you specify named groups and a :option:`--program`, then the program will be passed arguments corresponding to each named group of the form :code:`key=value`.
    Default: :code:`(?m)^\\s\*(.+?)\\s\*$`

.. option:: --linenum-action <LINENUM_ACTION>

    Where to perform the action on matched errors. :code:`self` means the current window, :code:`window` a new kitty window, :code:`tab` a new tab, :code:`os_window` a new OS window and :code:`background` run in the background. :code:`remote-control` is like background but the program can use kitty remote control without needing to turn on remote control globally. The actual action is whatever arguments are provided to the kitten, for example: :code:`kitten hints --type=linenum --linenum-action=tab vim +{line} {path}` will open the matched path at the matched line number in vim in a new kitty tab. Note that in order to use :option:`--program` to copy or paste the provided arguments, you need to use the special value :code:`self`.
    Default: :code:`self`
    Choices: :code:`background`, :code:`os\_window`, :code:`remote-control`, :code:`self`, :code:`tab`, :code:`window`

.. option:: --url-prefixes <URL_PREFIXES>

    Comma separated list of recognized URL prefixes. Defaults to the list of prefixes defined by the :opt:`url_prefixes` option in :file:`kitty.conf`.
    Default: :code:`default`

.. option:: --url-excluded-characters <URL_EXCLUDED_CHARACTERS>

    Characters to exclude when matching URLs. Defaults to the list of characters defined by the :opt:`url_excluded_characters` option in :file:`kitty.conf`. The syntax for this option is the same as for :opt:`url_excluded_characters`.
    Default: :code:`default`

.. option:: --word-characters <WORD_CHARACTERS>

    Characters to consider as part of a word. In addition, all characters marked as alphanumeric in the Unicode database will be considered as word characters. Defaults to the :opt:`select_by_word_characters` option from :file:`kitty.conf`.

.. option:: --minimum-match-length <MINIMUM_MATCH_LENGTH>

    The minimum number of characters to consider a match.
    Default: :code:`3`

.. option:: --multiple [=no]

    Select multiple matches and perform the action on all of them together at the end. In this mode, press :kbd:`Esc` to finish selecting.

.. option:: --multiple-joiner <MULTIPLE_JOINER>

    String for joining multiple selections when copying to the clipboard or inserting into the terminal. The special values are: :code:`space` - a space character, :code:`newline` - a newline, :code:`empty` - an empty joiner, :code:`json` - a JSON serialized list, :code:`auto` - an automatic choice, based on the type of text being selected. In addition, integers are interpreted as zero-based indices into the list of selections. You can use :code:`0` for the first selection and :code:`-1` for the last.
    Default: :code:`auto`

.. option:: --add-trailing-space <ADD_TRAILING_SPACE>

    Add trailing space after matched text. Defaults to :code:`auto`, which adds the space when used together with :option:`--multiple`.
    Default: :code:`auto`
    Choices: :code:`always`, :code:`auto`, :code:`never`

.. option:: --hints-offset <HINTS_OFFSET>

    The offset (from zero) at which to start hint numbering. Note that only numbers greater than or equal to zero are respected.
    Default: :code:`1`

.. option:: --alphabet <ALPHABET>

    The list of characters to use for hints. The default is to use numbers and lowercase English alphabets. Specify your preference as a string of characters. Note that you need to specify the :option:`--hints-offset` as zero to use the first character to highlight the first match, otherwise it will start with the second character by default.

.. option:: --ascending [=no]

    Make the hints increase from top to bottom, instead of decreasing from top to bottom.

.. option:: --hints-foreground-color <HINTS_FOREGROUND_COLOR>

    The foreground color for hints. You can use color names or hex values. For the eight basic named terminal colors you can also use the :code:`bright-` prefix to get the bright variant of the color.
    Default: :code:`black`

.. option:: --hints-background-color <HINTS_BACKGROUND_COLOR>

    The background color for hints. You can use color names or hex values. For the eight basic named terminal colors you can also use the :code:`bright-` prefix to get the bright variant of the color.
    Default: :code:`green`

.. option:: --hints-text-color <HINTS_TEXT_COLOR>

    The foreground color for text pointed to by the hints. You can use color names or hex values. For the eight basic named terminal colors you can also use the :code:`bright-` prefix to get the bright variant of the color. The default is to pick a suitable color automatically.
    Default: :code:`auto`

.. option:: --customize-processing <CUSTOMIZE_PROCESSING>

    Name of a python file in the kitty config directory which will be imported to provide custom implementations for pattern finding and performing actions on selected matches. You can also specify absolute paths to load the script from elsewhere. See https://sw.kovidgoyal.net/kitty/kittens/hints/ for details.

.. option:: --window-title <WINDOW_TITLE>

    The title for the hints window, default title is based on the type of text being hinted.

