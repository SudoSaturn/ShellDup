.. highlight:: sh
.. code-block:: sh

  kitty [options] [program-to-run ...]

Run the :italic:`kitty` terminal emulator. You can also specify the
:italic:`program` to run inside :italic:`kitty` as normal arguments
following the :italic:`options`.
For example: kitty --hold sh -c "echo hello, world"

For comprehensive documentation for kitty, please see: https://sw.kovidgoyal.net/kitty/

Options
------------------------------
.. option:: --title <TITLE>, -T <TITLE>

    Set the OS window title. This will override any title set by the program running inside kitty, permanently fixing the OS window's title. So only use this if you are running a program that does not set titles.

.. option:: --config <CONFIG>, -c <CONFIG>

    Specify a path to the configuration file(s) to use. All configuration files are merged onto the builtin :file:`kitty.conf`, overriding the builtin values. This option can be specified multiple times to read multiple configuration files in sequence, which are merged. Use the special value :code:`NONE` to not load any config file.

    If this option is not specified, config files are searched for in the order: :file:`$XDG_CONFIG_HOME/kitty/kitty.conf`, :file:`~/.config/kitty/kitty.conf`, :file:`~/Library/Preferences/kitty/kitty.conf`, :file:`$XDG_CONFIG_DIRS/kitty/kitty.conf`. The first one that exists is used as the config file.

    If the environment variable :envvar:`KITTY_CONFIG_DIRECTORY` is specified, that directory is always used and the above searching does not happen.

    If :file:`/etc/xdg/kitty/kitty.conf` exists, it is merged before (i.e. with lower priority) than any user config files. It can be used to specify system-wide defaults for all users. You can use either :code:`-` or :file:`/dev/stdin` to read the config from STDIN.

.. option:: --override <OVERRIDE>, -o <OVERRIDE>

    Override individual configuration options, can be specified multiple times. Syntax: :italic:`name=value`. For example: :option:`kitty -o` font_size=20

.. option:: --directory <DIRECTORY>, --working-directory <DIRECTORY>, -d <DIRECTORY>

    Change to the specified directory when launching.
    Default: :code:`.`

.. option:: --detach [=no]

    Detach from the controlling terminal, if any. On macOS use :code:`open -a kitty.app -n` instead.

.. option:: --detached-log <DETACHED_LOG>

    Path to a log file to store STDOUT/STDERR when using :option:`--detach`

.. option:: --session <SESSION>

    Path to a file containing the startup :italic:`session` (tabs, windows, layout, programs). Use - to read from STDIN. See :ref:`sessions` for details and an example. Environment variables in the file name are expanded, relative paths are resolved relative to the kitty configuration directory. The special value :code:`none` means no session will be used, even if the :opt:`startup_session` option has been specified in kitty.conf. Note that using this option means the command line arguments to kitty specifying a program to run are ignored.

.. option:: --hold [=no]

    Remain open, at a shell prompt, after child process exits. Note that this only affects the first window. You can quit by either using the close window shortcut or running the exit command.

.. option:: --single-instance [=no], -1 [=no]

    If specified only a single instance of :italic:`kitty` will run. New invocations will instead create a new top-level window in the existing :italic:`kitty` instance. This allows :italic:`kitty` to share a single sprite cache on the GPU and also reduces startup time. You can also have separate groups of :italic:`kitty` instances by using the :option:`kitty --instance-group` option.

.. option:: --instance-group <INSTANCE_GROUP>

    Used in combination with the :option:`kitty --single-instance` option. All :italic:`kitty` invocations with the same :option:`kitty --instance-group` will result in new windows being created in the first :italic:`kitty` instance within that group.

.. option:: --wait-for-single-instance-window-close [=no]

    Normally, when using :option:`kitty --single-instance`, :italic:`kitty` will open a new window in an existing instance and quit immediately. With this option, it will not quit till the newly opened window is closed. Note that if no previous instance is found, then :italic:`kitty` will wait anyway, regardless of this option.

.. option:: --listen-on <LISTEN_ON>

    Listen on the specified socket address for control messages. For example, :option:`kitty --listen-on`:code:`=unix:/tmp/mykitty` or :option:`kitty --listen-on`:code:`=tcp:localhost:12345`. On Linux systems, you can also use abstract UNIX sockets, not associated with a file, like this: :option:`kitty --listen-on`:code:`=unix:@mykitty`. Environment variables are expanded and relative paths are resolved with respect to the temporary directory. To control kitty, you can send commands to it with :italic:`kitten @` using the :option:`kitten @ --to` option to specify this address. Note that if you run :italic:`kitten @` within a kitty window, there is no need to specify the :option:`kitten @ --to` option as it will automatically read from the environment. Note that this will be ignored unless :opt:`allow_remote_control` is set to either: :code:`yes`, :code:`socket` or :code:`socket-only`. This can also be specified in :file:`kitty.conf`.  To start in headless mode, without an actual window, use :option:`kitty --start-as`:code:`=hidden`.

.. option:: --start-as <START_AS>

    Control how the initial kitty window is created.
    Default: :code:`normal`
    Choices: :code:`fullscreen`, :code:`hidden`, :code:`maximized`, :code:`minimized`, :code:`normal`

.. option:: --position <POSITION>

    The position, for example 10x20, on screen at which to place the first kitty OS Window. This may or may not work depending on the policies of the desktop environment/window manager. It never works on Wayland. See also :opt:`remember_window_position` to have kitty automatically try to restore the previous window position.

.. option:: --grab-keyboard [=no]

    Grab the keyboard. This means global shortcuts defined in the OS will be passed to kitty instead. Useful if you want to create an OS modal window. How well this works depends on the OS/window manager/desktop environment. On Wayland it works only if the compositor implements the :link:`inhibit-keyboard-shortcuts protocol <https://wayland.app/protocols/keyboard-shortcuts-inhibit-unstable-v1>`. On macOS Apple doesn't allow applications to grab the keyboard without special permissions, so it doesn't work.

Debugging options
~~~~~~~~~~~~~~~~~~~~~~~~~~~
.. option:: --version [=no], -v [=no]

    The current kitty version.

.. option:: --dump-commands [=no]

    Output commands received from child process to STDOUT.

.. option:: --replay-commands <REPLAY_COMMANDS>

    Replay previously dumped commands. Specify the path to a dump file previously created by :option:`kitty --dump-commands`. You can open a new kitty window to replay the commands with::

        kitty sh -c "kitty --replay-commands /path/to/dump/file; read"

.. option:: --dump-bytes <DUMP_BYTES>

    Path to file in which to store the raw bytes received from the child process.

.. option:: --debug-gl [=no], --debug-rendering [=no]

    Debug rendering commands. This will cause all OpenGL calls to check for errors instead of ignoring them. Also prints out miscellaneous debug information. Useful when debugging rendering problems.

.. option:: --debug-input [=no], --debug-keyboard [=no]

    Print out key and mouse events as they are received.

.. option:: --debug-font-fallback [=no]

    Print out information about the selection of fallback fonts for characters not present in the main font.

.. option:: --watcher <WATCHER>

    This option is deprecated in favor of the :opt:`watcher` option in :file:`kitty.conf` and should not be used.
