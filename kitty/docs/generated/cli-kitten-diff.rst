.. program:: kitty +kitten diff

Source code for diff
------------------------------------------------------------------------

The source code for this kitten is `available on GitHub <https://github.com/kovidgoyal/kitty/tree/master/kittens/diff>`_.

Command Line Interface
------------------------------------------------------------------------


.. highlight:: sh
.. code-block:: sh

  kitten diff [options] file_or_directory_left file_or_directory_right

Show a side-by-side diff of the specified files/directories. You can also use :italic:`ssh:hostname:remote-file-path` to diff remote files.

Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. option:: --context <CONTEXT>

    Number of lines of context to show between changes. Negative values use the number set in :file:`diff.conf`.
    Default: :code:`-1`

.. option:: --config <CONFIG>

    Specify a path to the configuration file(s) to use. All configuration files are merged onto the builtin :file:`diff.conf`, overriding the builtin values. This option can be specified multiple times to read multiple configuration files in sequence, which are merged. Use the special value :code:`NONE` to not load any config file.

    If this option is not specified, config files are searched for in the order: :file:`$XDG_CONFIG_HOME/kitty/diff.conf`, :file:`~/.config/kitty/diff.conf`, :file:`~/Library/Preferences/kitty/diff.conf`, :file:`$XDG_CONFIG_DIRS/kitty/diff.conf`. The first one that exists is used as the config file.

    If the environment variable :envvar:`KITTY_CONFIG_DIRECTORY` is specified, that directory is always used and the above searching does not happen.

    If :file:`/etc/xdg/kitty/diff.conf` exists, it is merged before (i.e. with lower priority) than any user config files. It can be used to specify system-wide defaults for all users. You can use either :code:`-` or :file:`/dev/stdin` to read the config from STDIN.

.. option:: --override <OVERRIDE>, -o <OVERRIDE>

    Override individual configuration options, can be specified multiple times. Syntax: :italic:`name=value`. For example: :italic:`-o background=gray`

