.. highlight:: conf

.. default-domain:: conf


.. _conf-kitten-choose_files-scanning:

Filesystem scanning
---------------------------------------

.. opt:: kitten-choose_files.show_hidden
.. code-block:: conf

    show_hidden last

Whether to show hidden files. The default value of :code:`last` means remember the last
used value. This setting can be toggled withing the program.

.. opt:: kitten-choose_files.sort_by_last_modified
.. code-block:: conf

    sort_by_last_modified last

Whether to sort the list of entries by last modified, instead of name. Note that sorting only applies
before any query is entered. Once a query is entered entries are sorted by their matching score.
The default value of :code:`last` means remember the last
used value. This setting can be toggled withing the program.

.. opt:: kitten-choose_files.respect_ignores
.. code-block:: conf

    respect_ignores last

Whether to respect .gitignore and .ignore files and the :opt:`ignore <kitten-choose_files.ignore>` setting.
The default value of :code:`last` means remember the last used value.
This setting can be toggled withing the program.

.. opt:: kitten-choose_files.ignore

An ignore pattern to ignore matched files. Uses the same sytax as :code:`.gitignore` files (see :code:`man gitignore`).
Anchored patterns match with respect to whatever directory is currently being displayed.
Can be specified multiple times to use multiple patterns. Note that every pattern
has to be checked against every file, so use sparingly.


.. _conf-kitten-choose_files-appearance:

Appearance
------------------------------

.. opt:: kitten-choose_files.show_preview
.. code-block:: conf

    show_preview last

Whether to show a preview of the current file/directory. The default value of :code:`last` means remember the last
used value. This setting can be toggled withing the program.

.. opt:: kitten-choose_files.pygments_style
.. code-block:: conf

    pygments_style default

The pygments color scheme to use for syntax highlighting of file previews. See :link:`pygments
builtin styles <https://pygments.org/styles/>` for a list of schemes.
This sets the colors used for light color schemes, use :opt:`dark_pygments_style <kitten-choose_files.dark_pygments_style>` to change the
colors for dark color schemes.

.. opt:: kitten-choose_files.dark_pygments_style
.. code-block:: conf

    dark_pygments_style github-dark

The pygments color scheme to use for syntax highlighting with dark colors. See :link:`pygments
builtin styles <https://pygments.org/styles/>` for a list of schemes.
This sets the colors used for dark color schemes, use :opt:`pygments_style <kitten-choose_files.pygments_style>` to change the
colors for light color schemes.

.. opt:: kitten-choose_files.cache_size
.. code-block:: conf

    cache_size 0.5

The maximum size of the disk cache, in gigabytes, used for previews. Zero or negative values
mean no limit.

.. opt:: kitten-choose_files.syntax_aliases
.. code-block:: conf

    syntax_aliases pyj:py pyi:py recipe:py

File extension aliases for syntax highlight. For example, to syntax highlight
:file:`file.xyz` as :file:`file.abc` use a setting of :code:`xyz:abc`.
Multiple aliases must be separated by spaces.


.. _conf-kitten-choose_files-shortcuts:

Keyboard shortcuts
--------------------------------------

.. shortcut:: kitten-choose_files.Quit
.. code-block:: conf

    map esc quit
    map ctrl+c quit

.. shortcut:: kitten-choose_files.Accept current result
.. code-block:: conf

    map enter accept

.. shortcut:: kitten-choose_files.Select current result
.. code-block:: conf

    map shift+enter select


When selecting multiple files, this will add the current file to the list of selected files.
You can also toggle the selected status of a file by holding down the :kbd:`Ctrl` key and clicking on
it. Similarly, the :kbd:`Alt` key can be held to click and extend the range of selected files.

.. shortcut:: kitten-choose_files.Type file name
.. code-block:: conf

    map ctrl+enter typename


Type a file name/path rather than filtering the list of existing files.
Useful when specifying a file or directory name for saving that does not yet exist.
When choosing existing directories, will accept the directory whoose
contents are being currently displayed as the choice.
Does not work when selecting files to open rather than to save.

.. shortcut:: kitten-choose_files.Next result
.. code-block:: conf

    map down next 1

.. shortcut:: kitten-choose_files.Previous result
.. code-block:: conf

    map up next -1

.. shortcut:: kitten-choose_files.Left result
.. code-block:: conf

    map left next left

.. shortcut:: kitten-choose_files.Right result
.. code-block:: conf

    map right next right

.. shortcut:: kitten-choose_files.First result on screen
.. code-block:: conf

    map home next first_on_screen
    map ctrl+home next first

.. shortcut:: kitten-choose_files.Last result on screen
.. code-block:: conf

    map end next last_on_screen
    map ctrl+end next last

.. shortcut:: kitten-choose_files.Change to currently selected dir
.. code-block:: conf

    map tab cd .

.. shortcut:: kitten-choose_files.Change to parent directory
.. code-block:: conf

    map shift+tab cd ..

.. shortcut:: kitten-choose_files.Change to root directory
.. code-block:: conf

    map ctrl+/ cd /

.. shortcut:: kitten-choose_files.Change to home directory
.. code-block:: conf

    map ctrl+~ cd ~
    map ctrl+` cd ~
    map ctrl+shift+` cd ~

.. shortcut:: kitten-choose_files.Change to temp directory
.. code-block:: conf

    map ctrl+t cd /tmp

.. shortcut:: kitten-choose_files.Next filter
.. code-block:: conf

    map ctrl+f 1

.. shortcut:: kitten-choose_files.Previous filter
.. code-block:: conf

    map alt+f -1

.. shortcut:: kitten-choose_files.Toggle showing dotfiles
.. code-block:: conf

    map alt+h toggle dotfiles

.. shortcut:: kitten-choose_files.Toggle showing ignored files
.. code-block:: conf

    map alt+i toggle ignorefiles

.. shortcut:: kitten-choose_files.Toggle sorting by dates
.. code-block:: conf

    map alt+d toggle sort_by_dates

.. shortcut:: kitten-choose_files.Toggle showing preview
.. code-block:: conf

    map alt+p toggle preview
