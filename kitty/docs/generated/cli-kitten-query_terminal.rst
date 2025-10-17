.. program:: kitty +kitten query_terminal

Source code for query_terminal
------------------------------------------------------------------------

The source code for this kitten is `available on GitHub <https://github.com/kovidgoyal/kitty/tree/master/kittens/query_terminal>`_.

Command Line Interface
------------------------------------------------------------------------


.. highlight:: sh
.. code-block:: sh

  kitten query_terminal [options] [query1 query2 ...]

Query the terminal this kitten is run in for various capabilities. This sends
escape codes to the terminal and based on its response prints out data about
supported capabilities. Note that this is a blocking operation, since it has to
wait for a response from the terminal. You can control the maximum wait time via
the :code:`--wait-for` option.

The output is lines of the form::

    query: data

If a particular :italic:`query` is unsupported by the running kitty version, the
:italic:`data` will be blank.

Note that when calling this from another program, be very careful not to perform
any I/O on the terminal device until this kitten exits.

Available queries are:

:code:`name`:
  Terminal name (e.g. :code:`xterm-kitty`)

:code:`version`:
  Terminal version (e.g. :code:`0.43.1`)

:code:`allow_hyperlinks`:
  The config option :opt:`allow_hyperlinks` in :file:`kitty.conf` for allowing hyperlinks can be :code:`yes`, :code:`no` or :code:`ask`

:code:`font_family`:
  The current font's PostScript name

:code:`bold_font`:
  The current bold font's PostScript name

:code:`italic_font`:
  The current italic font's PostScript name

:code:`bold_italic_font`:
  The current bold-italic font's PostScript name

:code:`font_size`:
  The current font size in pts

:code:`dpi_x`:
  The current DPI on the x-axis

:code:`dpi_y`:
  The current DPI on the y-axis

:code:`foreground`:
  The current foreground color as a 24-bit # color code

:code:`background`:
  The current background color as a 24-bit # color code

:code:`background_opacity`:
  The current background opacity as a number between 0 and 1

:code:`clipboard_control`:
  The config option :opt:`clipboard_control` in :file:`kitty.conf` for allowing reads/writes to/from the clipboard

:code:`os_name`:
  The name of the OS the terminal is running on. kitty returns values: bsd, linux, macos, unknown




Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. option:: --wait-for <WAIT_FOR>

    The amount of time (in seconds) to wait for a response from the terminal, after querying it.
    Default: :code:`10`

