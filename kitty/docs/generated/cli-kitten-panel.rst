.. program:: kitty +kitten panel

Source code for panel
------------------------------------------------------------------------

The source code for this kitten is `available on GitHub <https://github.com/kovidgoyal/kitty/tree/master/kittens/panel>`_.

Command Line Interface
------------------------------------------------------------------------


.. highlight:: sh
.. code-block:: sh

  kitty +kitten panel [options] [cmdline-to-run ...]

Use a command line program to draw a GPU accelerated panel on your desktop

Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. option:: --lines <LINES>

    The number of lines shown in the panel. Ignored for background, centered, and vertical panels. If it has the suffix :code:`px` then it sets the height of the panel in pixels instead of lines.
    Default: :code:`1`

.. option:: --columns <COLUMNS>

    The number of columns shown in the panel. Ignored for background, centered, and horizontal panels. If it has the suffix :code:`px` then it sets the width of the panel in pixels instead of columns.
    Default: :code:`1`

.. option:: --margin-top <MARGIN_TOP>

    Set the top margin for the panel, in pixels. Has no effect for bottom edge panels. Only works on macOS and Wayland compositors that supports the wlr layer shell protocol.
    Default: :code:`0`

.. option:: --margin-left <MARGIN_LEFT>

    Set the left margin for the panel, in pixels. Has no effect for right edge panels. Only works on macOS and Wayland compositors that supports the wlr layer shell protocol.
    Default: :code:`0`

.. option:: --margin-bottom <MARGIN_BOTTOM>

    Set the bottom margin for the panel, in pixels. Has no effect for top edge panels. Only works on macOS and Wayland compositors that supports the wlr layer shell protocol.
    Default: :code:`0`

.. option:: --margin-right <MARGIN_RIGHT>

    Set the right margin for the panel, in pixels. Has no effect for left edge panels. Only works on macOS and Wayland compositors that supports the wlr layer shell protocol.
    Default: :code:`0`

.. option:: --edge <EDGE>

    Which edge of the screen to place the panel on. Note that some window managers (such as i3) do not support placing docked windows on the left and right edges. The value :code:`background` means make the panel the "desktop wallpaper". Note that when using sway if you set a background in your sway config it will cover the background drawn using this kitten. Additionally, there are three more values: :code:`center`, :code:`center-sized` and :code:`none`. The value :code:`center` anchors the panel to all sides and covers the entire display (on macOS the part of the display not covered by titlebar and dock). The panel can be shrunk and placed using the margin parameters. The value :code:`none` anchors the panel to the top left corner and should be placed using the margin parameters. Its size is set by :option:`--lines` and :option:`--columns`. The value :code:`center-sized` is just like :code:`none` except that the panel is centered instead of in the top left corner and the margins have no effect.
    Default: :code:`top`
    Choices: :code:`background`, :code:`bottom`, :code:`center`, :code:`center-sized`, :code:`left`, :code:`none`, :code:`right`, :code:`top`

.. option:: --layer <LAYER>

    On a Wayland compositor that supports the wlr layer shell protocol, specifies the layer on which the panel should be drawn. This parameter is ignored and set to :code:`background` if :option:`--edge` is set to :code:`background`. On macOS, maps these to appropriate NSWindow *levels*.
    Default: :code:`bottom`
    Choices: :code:`background`, :code:`bottom`, :code:`overlay`, :code:`top`

.. option:: --config <CONFIG>, -c <CONFIG>

    Path to config file to use for kitty when drawing the panel.

.. option:: --override <OVERRIDE>, -o <OVERRIDE>

    default= Override individual kitty configuration options, can be specified multiple times. Syntax: :italic:`name=value`. For example: :option:`kitty +kitten panel -o` font_size=20

.. option:: --output-name <OUTPUT_NAME>

    The panel can only be displayed on a single monitor (output) at a time. This allows you to specify which output is used, by name. If not specified the compositor will choose an output automatically, typically the last output the user interacted with or the primary monitor. Use the special value :code:`list` to get a list of available outputs. Use :code:`listjson` for a json encoded output. Note that on Wayland the output can only be set at panel creation time, it cannot be changed after creation, nor is there anyway to display a single panel on all outputs. Please complain to the Wayland developers about this.

.. option:: --focus-policy <FOCUS_POLICY>

    On a Wayland compositor that supports the wlr layer shell protocol, specify the focus policy for keyboard interactivity with the panel. Please refer to the wlr layer shell protocol documentation for more details. Note that different Wayland compositors behave very differently with :code:`exclusive`, your mileage may vary. On macOS, :code:`exclusive` and :code:`on-demand` are currently the same.
    Default: :code:`not-allowed`
    Choices: :code:`exclusive`, :code:`not-allowed`, :code:`on-demand`

.. option:: --hide-on-focus-loss [=no]

    Automatically hide the panel window when it loses focus. Using this option will force :option:`--focus-policy` to :code:`on-demand`. Note that on Wayland, depending on the compositor, this can result in the window never becoming visible.

.. option:: --grab-keyboard [=no]

    Grab the keyboard. This means global shortcuts defined in the OS will be passed to kitty instead. Useful if you want to create an OS modal window. How well this works depends on the OS/window manager/desktop environment. On Wayland it works only if the compositor implements the :link:`inhibit-keyboard-shortcuts protocol <https://wayland.app/protocols/keyboard-shortcuts-inhibit-unstable-v1>`. On macOS Apple doesn't allow applications to grab the keyboard without special permissions, so it doesn't work.

.. option:: --exclusive-zone <EXCLUSIVE_ZONE>

    On a Wayland compositor that supports the wlr layer shell protocol, request a given exclusive zone for the panel. Please refer to the wlr layer shell documentation for more details on the meaning of exclusive and its value. If :option:`--edge` is set to anything other than :code:`center` or :code:`none`, this flag will not have any effect unless the flag :option:`--override-exclusive-zone` is also set. If :option:`--edge` is set to :code:`background`, this option has no effect. Ignored on X11 and macOS.
    Default: :code:`-1`

.. option:: --override-exclusive-zone [=no]

    On a Wayland compositor that supports the wlr layer shell protocol, override the default exclusive zone. This has effect only if :option:`--edge` is set to :code:`top`, :code:`left`, :code:`bottom` or :code:`right`. Ignored on X11 and macOS.
    Default: :code:`no`

.. option:: --single-instance [=no], -1 [=no]

    If specified only a single instance of the panel will run. New invocations will instead create a new top-level window in the existing panel instance.
    Default: :code:`no`

.. option:: --instance-group <INSTANCE_GROUP>

    default= Used in combination with the :option:`--single-instance` option. All panel invocations with the same :option:`--instance-group` will result in new panels being created in the first panel instance within that group.

.. option:: --wait-for-single-instance-window-close [=no]

    Normally, when using :option:`kitty --single-instance`, :italic:`kitty` will open a new window in an existing instance and quit immediately. With this option, it will not quit till the newly opened window is closed. Note that if no previous instance is found, then :italic:`kitty` will wait anyway, regardless of this option.

.. option:: --listen-on <LISTEN_ON>

    Listen on the specified socket address for control messages. For example, :option:`kitty --listen-on`:code:`=unix:/tmp/mykitty` or :option:`kitty --listen-on`:code:`=tcp:localhost:12345`. On Linux systems, you can also use abstract UNIX sockets, not associated with a file, like this: :option:`kitty --listen-on`:code:`=unix:@mykitty`. Environment variables are expanded and relative paths are resolved with respect to the temporary directory. To control kitty, you can send commands to it with :italic:`kitten @` using the :option:`kitten @ --to` option to specify this address. Note that if you run :italic:`kitten @` within a kitty window, there is no need to specify the :option:`kitten @ --to` option as it will automatically read from the environment. Note that this will be ignored unless :opt:`allow_remote_control` is set to either: :code:`yes`, :code:`socket` or :code:`socket-only`. This can also be specified in :file:`kitty.conf`.

.. option:: --toggle-visibility [=no]

    When set and using :option:`--single-instance` will toggle the visibility of the existing panel rather than creating a new one.
    Default: :code:`no`

.. option:: --move-to-active-monitor [=no]

    When set and using :option:`--toggle-visibility` to show an existing panel, the panel is moved to the active monitor (typically the monitor with the mouse on it). This works only if the underlying OS supports it. It is currently supported on macOS only.
    Default: :code:`false`

.. option:: --start-as-hidden [=no]

    Start in hidden mode, useful with :option:`--toggle-visibility`.
    Default: :code:`no`

.. option:: --detach [=no]

    Detach from the controlling terminal, if any, running in an independent child process, the parent process exits immediately.
    Default: :code:`no`

.. option:: --detached-log <DETACHED_LOG>

    default= Path to a log file to store STDOUT/STDERR when using :option:`--detach`

.. option:: --debug-rendering [=no]

    For internal debugging use.

.. option:: --debug-input [=no]

    For internal debugging use.

