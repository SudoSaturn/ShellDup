.. highlight:: conf

.. default-domain:: conf


.. _conf-kitten-desktop_ui-Appearance:

Appearance
------------------------------

.. opt:: kitten-desktop_ui.color_scheme
.. code-block:: conf

    color_scheme no-preference

The color scheme for your system. This sets the initial value of the color scheme. It can be changed subsequently
by using :code:`kitten desktop-ui color-scheme`.

.. opt:: kitten-desktop_ui.accent_color
.. code-block:: conf

    accent_color cyan

The RGB accent color for your system, can be specified as a color name or in hex a decimal format.

.. opt:: kitten-desktop_ui.contrast
.. code-block:: conf

    contrast normal

The preferred contrast level.

.. opt:: kitten-desktop_ui.file_chooser_size

The size in lines and columns of the file chooser popup window. By default it is full screen. For example:
:code:`file_chooser_size 25 80` will cause the popup to be of size 25 lines and 80 columns. Note that if you
use this option, depending on the compositor you are running, the popup window may not be properly modal.

.. opt:: kitten-desktop_ui.file_chooser_kitty_conf

Path to config file to use for kitty when drawing the file chooser window. Can be specified multiple times. By default, the normal kitty.conf is used. Relative paths are resolved with respect to the kitty config directory.

.. opt:: kitten-desktop_ui.file_chooser_kitty_override

Override individual kitty configuration options, for the file chooser window. Can be specified multiple times. Syntax: :italic:`name=value`. For example: :code:`font_size=20`.
