.. program:: kitty +kitten choose_files

Source code for choose_files
------------------------------------------------------------------------

The source code for this kitten is `available on GitHub <https://github.com/kovidgoyal/kitty/tree/master/kittens/choose_files>`_.

Command Line Interface
------------------------------------------------------------------------


.. highlight:: sh
.. code-block:: sh

  kitten choose_files [options] [directory to start choosing files in]

Select one or more files, quickly, using fuzzy finding, by typing just a few characters from
the file name. Browse matching files, using the arrow keys to navigate matches and press :kbd:`Enter`
to select. The :kbd:`Tab` key can be used to change to a sub-folder. See the :doc:`online docs </kittens/choose-files>`
for full details.


Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. option:: --mode <MODE>

    The type of object(s) to select
    Default: :code:`file`
    Choices: :code:`dir`, :code:`dirs`, :code:`file`, :code:`files`, :code:`save-dir`, :code:`save-file`, :code:`save-files`

.. option:: --file-filter <FILE_FILTER>

    A list of filters to restrict the displayed files. Can be either mimetypes, or glob style patterns. Can be specified multiple times. The syntax is :code:`type:expression:Descriptive Name`. For example: :code:`mime:image/png:Images` and :code:`mime:image/gif:Images` and :code:`glob:*.[tT][xX][Tt]:Text files`. Note that glob patterns are case-sensitive. The mimetype specification is treated as a glob expressions as well, so you can, for example, use :code:`mime:text/*` to match all text files. The first filter in the list will be applied by default. Use a filter such as :code:`glob:*:All` to match all files. Note that filtering only appies to files, not directories.

.. option:: --suggested-save-file-name <SUGGESTED_SAVE_FILE_NAME>

    A suggested name when picking a save file.

.. option:: --suggested-save-file-path <SUGGESTED_SAVE_FILE_PATH>

    Path to an existing file to use as the save file.

.. option:: --title <TITLE>

    Window title to use for this chooser

.. option:: --display-title [=no]

    Show the window title at the top, useful when this kitten is used in an OS window without a title bar.

.. option:: --override <OVERRIDE>, -o <OVERRIDE>

    Override individual configuration options, can be specified multiple times. Syntax: :italic:`name=value`.

.. option:: --config <CONFIG>

    Specify a path to the configuration file(s) to use. All configuration files are merged onto the builtin :file:`choose-files.conf`, overriding the builtin values. This option can be specified multiple times to read multiple configuration files in sequence, which are merged. Use the special value :code:`NONE` to not load any config file.

    If this option is not specified, config files are searched for in the order: :file:`$XDG_CONFIG_HOME/kitty/choose-files.conf`, :file:`~/.config/kitty/choose-files.conf`, :file:`~/Library/Preferences/kitty/choose-files.conf`, :file:`$XDG_CONFIG_DIRS/kitty/choose-files.conf`. The first one that exists is used as the config file.

    If the environment variable :envvar:`KITTY_CONFIG_DIRECTORY` is specified, that directory is always used and the above searching does not happen.

    If :file:`/etc/xdg/kitty/choose-files.conf` exists, it is merged before (i.e. with lower priority) than any user config files. It can be used to specify system-wide defaults for all users. You can use either :code:`-` or :file:`/dev/stdin` to read the config from STDIN.

.. option:: --write-output-to <WRITE_OUTPUT_TO>

    Path to a file to which the output is written in addition to STDOUT.

.. option:: --output-format <OUTPUT_FORMAT>

    The format in which to write the output.
    Default: :code:`text`
    Choices: :code:`json`, :code:`text`

.. option:: --write-pid-to <WRITE_PID_TO>

    Path to a file to which to write the process ID (PID) of this process to.

