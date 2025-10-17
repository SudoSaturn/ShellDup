.. program:: kitty +kitten icat

Source code for icat
------------------------------------------------------------------------

The source code for this kitten is `available on GitHub <https://github.com/kovidgoyal/kitty/tree/master/kittens/icat>`_.

Command Line Interface
------------------------------------------------------------------------


.. highlight:: sh
.. code-block:: sh

  kitten icat [options] image-file-or-url-or-directory ...

A cat like utility to display images in the terminal. You can specify multiple image files and/or directories. Directories are scanned recursively for image files. If STDIN is not a terminal, image data will be read from it as well. You can also specify HTTP(S) or FTP URLs which will be automatically downloaded and displayed.

Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. option:: --align <ALIGN>

    Horizontal alignment for the displayed image.
    Default: :code:`center`
    Choices: :code:`center`, :code:`left`, :code:`right`

.. option:: --place <PLACE>

    Choose where on the screen to display the image. The image will be scaled to fit into the specified rectangle. The syntax for specifying rectangles is <:italic:`width`>x<:italic:`height`>@<:italic:`left`>x<:italic:`top`>. All measurements are in cells (i.e. cursor positions) with the origin :italic:`(0, 0)` at the top-left corner of the screen. Note that the :option:`--align` option will horizontally align the image within this rectangle. By default, the image is horizontally centered within the rectangle. Using place will cause the cursor to be positioned at the top left corner of the image, instead of on the line after the image.

.. option:: --scale-up [=no]

    When used in combination with :option:`--place` it will cause images that are smaller than the specified area to be scaled up to use as much of the specified area as possible.

.. option:: --background <BACKGROUND>

    Specify a background color, this will cause transparent images to be composited on top of the specified color.
    Default: :code:`none`

.. option:: --mirror <MIRROR>

    Mirror the image about a horizontal or vertical axis or both.
    Default: :code:`none`
    Choices: :code:`both`, :code:`horizontal`, :code:`none`, :code:`vertical`

.. option:: --clear [=no]

    Remove all images currently displayed on the screen. Note that this cannot work with terminal multiplexers such as tmux since only the multiplexer can know the position of the screen.

.. option:: --transfer-mode <TRANSFER_MODE>

    Which mechanism to use to transfer images to the terminal. The default is to auto-detect. :italic:`file` means to use a temporary file, :italic:`memory` means to use shared memory, :italic:`stream` means to send the data via terminal escape codes. Note that if you use the :italic:`file` or :italic:`memory` transfer modes and you are connecting over a remote session then image display will not work.
    Default: :code:`detect`
    Choices: :code:`detect`, :code:`file`, :code:`memory`, :code:`stream`

.. option:: --detect-support [=no]

    Detect support for image display in the terminal. If not supported, will exit with exit code 1, otherwise will exit with code 0 and print the supported transfer mode to stderr, which can be used with the :option:`--transfer-mode` option.

.. option:: --detection-timeout <DETECTION_TIMEOUT>

    The amount of time (in seconds) to wait for a response from the terminal, when detecting image display support.
    Default: :code:`10`

.. option:: --use-window-size <USE_WINDOW_SIZE>

    Instead of querying the terminal for the window size, use the specified size, which must be of the format: width_in_cells,height_in_cells,width_in_pixels,height_in_pixels

.. option:: --print-window-size [=no]

    Print out the window size as <:italic:`width`>x<:italic:`height`> (in pixels) and quit. This is a convenience method to query the window size if using :code:`kitten icat` from a scripting language that cannot make termios calls.

.. option:: --stdin <STDIN>

    Read image data from STDIN. The default is to do it automatically, when STDIN is not a terminal, but you can turn it off or on explicitly, if needed.
    Default: :code:`detect`
    Choices: :code:`detect`, :code:`no`, :code:`yes`

.. option:: --silent [=no]

    Not used, present for legacy compatibility.

.. option:: --engine <ENGINE>

    The engine used for decoding and processing of images. The default is to use the most appropriate engine.  The :code:`builtin` engine uses Go's native imaging libraries. The :code:`magick` engine uses ImageMagick which requires it to be installed on the system.
    Default: :code:`auto`
    Choices: :code:`auto`, :code:`builtin`, :code:`magick`

.. option:: --z-index <Z_INDEX>, -z <Z_INDEX>

    Z-index of the image. When negative, text will be displayed on top of the image. Use a double minus for values under the threshold for drawing images under cell background colors. For example, :code:`--1` evaluates as -1,073,741,825.
    Default: :code:`0`

.. option:: --loop <LOOP>, -l <LOOP>

    Number of times to loop animations. Negative values loop forever. Zero means only the first frame of the animation is displayed. Otherwise, the animation is looped the specified number of times.
    Default: :code:`-1`

.. option:: --hold [=no]

    Wait for a key press before exiting after displaying the images.

.. option:: --unicode-placeholder [=no]

    Use the Unicode placeholder method to display the images. Useful to display images from within full screen terminal programs that do not understand the kitty graphics protocol such as multiplexers or editors. See :ref:`graphics_unicode_placeholders` for details. Note that when using this method, images placed (with :option:`--place`) that do not fit on the screen, will get wrapped at the screen edge instead of getting truncated. This wrapping is per line and therefore the image will look like it is interleaved with blank lines.

.. option:: --passthrough <PASSTHROUGH>

    Whether to surround graphics commands with escape sequences that allow them to passthrough programs like tmux. The default is to detect when running inside tmux and automatically use the tmux passthrough escape codes. Note that when this option is enabled it implies :option:`--unicode-placeholder` as well.
    Default: :code:`detect`
    Choices: :code:`detect`, :code:`none`, :code:`tmux`

.. option:: --image-id <IMAGE_ID>

    The graphics protocol id to use for the created image. Normally, a random id is created if needed. This option allows control of the id. When multiple images are sent, sequential ids starting from the specified id are used. Valid ids are from 1 to 4294967295. Numbers outside this range are automatically wrapped.
    Default: :code:`0`

.. option:: --no-trailing-newline [=no], -n [=no]

    By default, the cursor is moved to the next line after displaying an image. This option, prevents that. Should not be used when catting multiple images. Also has no effect when the :option:`--place` option is used.

