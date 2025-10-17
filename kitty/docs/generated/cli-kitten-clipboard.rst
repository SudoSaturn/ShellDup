.. program:: kitty +kitten clipboard

Source code for clipboard
------------------------------------------------------------------------

The source code for this kitten is `available on GitHub <https://github.com/kovidgoyal/kitty/tree/master/kittens/clipboard>`_.

Command Line Interface
------------------------------------------------------------------------


.. highlight:: sh
.. code-block:: sh

  kitten clipboard [options] [files to copy to/from]

Read or write to the system clipboard.

This kitten operates most simply in :italic:`filter mode`.
To set the clipboard text, pipe in the new text on :file:`STDIN`. Use the
:option:`--get-clipboard` option to instead output the current clipboard text content to
:file:`STDOUT`. Note that copying from the clipboard will cause a permission
popup, see :opt:`clipboard_control` for details.

For more control, specify filename arguments. Then, different MIME types can be copied to/from
the clipboard. Some examples:

.. code:: sh

    # Copy an image to the clipboard:
    kitten clipboard picture.png

    # Copy an image and some text to the clipboard:
    kitten clipboard picture.jpg text.txt

    # Copy text from STDIN and an image to the clipboard:
    echo hello | kitten clipboard picture.png /dev/stdin

    # Copy any raster image available on the clipboard to a PNG file:
    kitten clipboard -g picture.png

    # Copy an image to a file and text to STDOUT:
    kitten clipboard -g picture.png /dev/stdout

    # List the formats available on the system clipboard
    kitten clipboard -g -m . /dev/stdout


Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. option:: --get-clipboard [=no], -g [=no]

    Output the current contents of the clipboard to STDOUT. Note that by default kitty will prompt for permission to access the clipboard. Can be controlled by :opt:`clipboard_control`.

.. option:: --use-primary [=no], -p [=no]

    Use the primary selection rather than the clipboard on systems that support it, such as Linux.

.. option:: --mime <MIME>, -m <MIME>

    The mimetype of the specified file. Useful when the auto-detected mimetype is likely to be incorrect or the filename has no extension and therefore no mimetype can be detected. If more than one file is specified, this option should be specified multiple times, once for each specified file. When copying data from the clipboard, you can use wildcards to match MIME types. For example: :code:`--mime 'text/*'` will match any textual MIME type available on the clipboard, usually the first matching MIME type is copied. The special MIME type :code:`.` will return the list of available MIME types currently on the system clipboard.

.. option:: --alias <ALIAS>, -a <ALIAS>

    Specify aliases for MIME types. Aliased MIME types are considered equivalent. When copying to clipboard both the original and alias are made available on the clipboard. When copying from clipboard if the original is not found, the alias is used, as a fallback. Can be specified multiple times to create multiple aliases. For example: :code:`--alias text/plain=text/x-rst` makes :code:`text/plain` an alias of :code:`text/rst`. Aliases are not used in filter mode. An alias for :code:`text/plain` is automatically created if :code:`text/plain` is not present in the input data, but some other :code:`text/*` MIME is present.

.. option:: --wait-for-completion [=no]

    Wait till the copy to clipboard is complete before exiting. Useful if running the kitten in a dedicated, ephemeral window. Only needed in filter mode.

.. option:: --password <PASSWORD>

    A password to use when accessing the clipboard. If the user chooses to accept the password future invocations of the kitten will not have a permission prompt in this tty session. Does not work in filter mode. Must be of the form: text:actual-password or fd:integer (a file descriptor number to read the password from) or file:path-to-file (a file from which to read the password). Note that you must also specify a human friendly name using the :option:`--human-name` flag.

.. option:: --human-name <HUMAN_NAME>

    A human friendly name to show the user when asking for permission to access the clipboard.

