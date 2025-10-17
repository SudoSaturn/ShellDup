.. highlight:: conf

.. default-domain:: conf


.. _conf-kitten-quick_access_terminal-qat:

Window appearance
-------------------------------------

.. opt:: kitten-quick_access_terminal.lines
.. code-block:: conf

    lines 25

The number of lines shown in the panel. Ignored for background, centered, and vertical panels. If it has the suffix :code:`px` then it sets the height of the panel in pixels instead of lines.

.. opt:: kitten-quick_access_terminal.columns
.. code-block:: conf

    columns 80

The number of columns shown in the panel. Ignored for background, centered, and horizontal panels. If it has the suffix :code:`px` then it sets the width of the panel in pixels instead of columns.

.. opt:: kitten-quick_access_terminal.edge
.. code-block:: conf

    edge top

Which edge of the screen to place the panel on. Note that some window managers (such as i3) do not support placing docked windows on the left and right edges. The value :code:`background` means make the panel the "desktop wallpaper". Note that when using sway if you set a background in your sway config it will cover the background drawn using this kitten. Additionally, there are three more values: :code:`center`, :code:`center-sized` and :code:`none`. The value :code:`center` anchors the panel to all sides and covers the entire display (on macOS the part of the display not covered by titlebar and dock). The panel can be shrunk and placed using the margin parameters. The value :code:`none` anchors the panel to the top left corner and should be placed using the margin parameters. Its size is set by :opt:`lines <kitten-quick_access_terminal.lines>` and :opt:`columns <kitten-quick_access_terminal.columns>`. The value :code:`center-sized` is just like :code:`none` except that the panel is centered instead of in the top left corner and the margins have no effect.

.. opt:: kitten-quick_access_terminal.background_opacity
.. code-block:: conf

    background_opacity 0.85

The background opacity of the window. This works the same as the kitty
option of the same name, it is present here as it has a different
default value for the quick access terminal.

.. opt:: kitten-quick_access_terminal.hide_on_focus_loss
.. code-block:: conf

    hide_on_focus_loss no

Hide the window when it loses keyboard focus automatically. Using this option
will force :opt:`focus_policy <kitten-quick_access_terminal.focus_policy>` to :code:`on-demand`.

.. opt:: kitten-quick_access_terminal.grab_keyboard
.. code-block:: conf

    grab_keyboard no

Grab the keyboard. This means global shortcuts defined in the OS will be passed to kitty instead. Useful if
you want to create an OS modal window. How well this
works depends on the OS/window manager/desktop environment. On Wayland it works only if the compositor implements
the :link:`inhibit-keyboard-shortcuts protocol <https://wayland.app/protocols/keyboard-shortcuts-inhibit-unstable-v1>`.
On macOS Apple doesn't allow applications to grab the keyboard without special permissions, so it doesn't work.

.. opt:: kitten-quick_access_terminal.margin_left
.. code-block:: conf

    margin_left 0

Set the left margin for the panel, in pixels. Has no effect for right edge panels. Only works on macOS and Wayland compositors that supports the wlr layer shell protocol.

.. opt:: kitten-quick_access_terminal.margin_right
.. code-block:: conf

    margin_right 0

Set the right margin for the panel, in pixels. Has no effect for left edge panels. Only works on macOS and Wayland compositors that supports the wlr layer shell protocol.

.. opt:: kitten-quick_access_terminal.margin_top
.. code-block:: conf

    margin_top 0

Set the top margin for the panel, in pixels. Has no effect for bottom edge panels. Only works on macOS and Wayland compositors that supports the wlr layer shell protocol.

.. opt:: kitten-quick_access_terminal.margin_bottom
.. code-block:: conf

    margin_bottom 0

Set the bottom margin for the panel, in pixels. Has no effect for top edge panels. Only works on macOS and Wayland compositors that supports the wlr layer shell protocol.

.. opt:: kitten-quick_access_terminal.kitty_conf

Path to config file to use for kitty when drawing the window. Can be specified multiple times. By default, the normal kitty.conf is used. Relative paths are resolved with respect to the kitty config directory.

.. opt:: kitten-quick_access_terminal.kitty_override

Override individual kitty configuration options, can be specified multiple times. Syntax: :italic:`kitty_override name=value`. For example: :code:`kitty_override font_size=20`.

.. opt:: kitten-quick_access_terminal.app_id
.. code-block:: conf

    app_id kitty-quick-access

On Wayland set the :italic:`namespace` of the layer shell surface. On X11 set the WM_CLASS assigned to the quick access window. (Linux only)

.. opt:: kitten-quick_access_terminal.output_name

The panel can only be displayed on a single monitor (output) at a time. This allows you to specify which output is used, by name. If not specified the compositor will choose an output automatically, typically the last output the user interacted with or the primary monitor. Run :code:`kitten panel --output-name list` to get a list of available outputs. Use :code:`listjson` for a json encoded output. Note that on Wayland the output can only be set at panel creation time, it cannot be changed after creation, nor is there anyway to display a single panel on all outputs. Please complain to the Wayland developers about this.

.. opt:: kitten-quick_access_terminal.start_as_hidden
.. code-block:: conf

    start_as_hidden no

Whether to start the quick access terminal hidden. Useful if you are starting it as part of system startup.

.. opt:: kitten-quick_access_terminal.focus_policy
.. code-block:: conf

    focus_policy exclusive

On a Wayland compositor that supports the wlr layer shell protocol, specify the focus policy for keyboard interactivity with the panel. Please refer to the wlr layer shell protocol documentation for more details. Note that different Wayland compositors behave very differently with :code:`exclusive`, your mileage may vary. On macOS, :code:`exclusive` and :code:`on-demand` are currently the same.
