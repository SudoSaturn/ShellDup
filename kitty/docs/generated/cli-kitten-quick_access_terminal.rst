.. program:: kitty +kitten quick_access_terminal

Source code for quick_access_terminal
------------------------------------------------------------------------

The source code for this kitten is `available on GitHub <https://github.com/kovidgoyal/kitty/tree/master/kittens/quick_access_terminal>`_.

Command Line Interface
------------------------------------------------------------------------


.. highlight:: sh
.. code-block:: sh

  kitten quick_access_terminal [options] [cmdline-to-run ...]

A quick access terminal window that you can bring up instantly with a keypress or a command.

Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. option:: --config <CONFIG>, -c <CONFIG>

    Specify a path to the configuration file(s) to use. All configuration files are merged onto the builtin :file:`quick-access-terminal.conf`, overriding the builtin values. This option can be specified multiple times to read multiple configuration files in sequence, which are merged. Use the special value :code:`NONE` to not load any config file.

    If this option is not specified, config files are searched for in the order: :file:`$XDG_CONFIG_HOME/kitty/quick-access-terminal.conf`, :file:`~/.config/kitty/quick-access-terminal.conf`, :file:`~/Library/Preferences/kitty/quick-access-terminal.conf`, :file:`$XDG_CONFIG_DIRS/kitty/quick-access-terminal.conf`. The first one that exists is used as the config file.

    If the environment variable :envvar:`KITTY_CONFIG_DIRECTORY` is specified, that directory is always used and the above searching does not happen.

    If :file:`/etc/xdg/kitty/quick-access-terminal.conf` exists, it is merged before (i.e. with lower priority) than any user config files. It can be used to specify system-wide defaults for all users. You can use either :code:`-` or :file:`/dev/stdin` to read the config from STDIN.

.. option:: --override <OVERRIDE>, -o <OVERRIDE>

    Override individual configuration options, can be specified multiple times. Syntax: :italic:`name=value`. For example: :italic:`-o lines=12`

.. option:: --detach [=no]

    Detach from the controlling terminal, if any, running in an independent child process, the parent process exits immediately.

.. option:: --detached-log <DETACHED_LOG>

    Path to a log file to store STDOUT/STDERR when using :option:`--detach`

.. option:: --instance-group <INSTANCE_GROUP>

    The unique name of this quick access terminal Use a different name if you want multiple such terminals.
    Default: :code:`quick-access`

.. option:: --debug-rendering [=no]

    For debugging interactions with the compositor/window manager.

.. option:: --debug-input [=no]

    For debugging interactions with the compositor/window manager.

