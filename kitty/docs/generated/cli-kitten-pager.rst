.. program:: kitty +kitten pager

Source code for pager
------------------------------------------------------------------------

The source code for this kitten is `available on GitHub <https://github.com/kovidgoyal/kitty/tree/master/kittens/pager>`_.

Command Line Interface
------------------------------------------------------------------------


.. highlight:: sh
.. code-block:: sh

  kitten pager [options] [filename]

Display text in a pager with various features such as searching, copy/paste, etc.
Text can some from the specified file or from STDIN. If no filename is specified
and STDIN is not a TTY, it is used.


Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. option:: --role <ROLE>

    The role the pager is used for. The default is a standard less like pager.
    Default: :code:`pager`
    Choices: :code:`pager`, :code:`scrollback`

.. option:: --follow [=no]

    Follow changes in the specified file, automatically scrolling if currently on the last line.

