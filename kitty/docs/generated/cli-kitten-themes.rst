.. program:: kitty +kitten themes

Source code for themes
------------------------------------------------------------------------

The source code for this kitten is `available on GitHub <https://github.com/kovidgoyal/kitty/tree/master/kittens/themes>`_.

Command Line Interface
------------------------------------------------------------------------


.. highlight:: sh
.. code-block:: sh

  kitten themes [options] [theme name to switch to]

Change the kitty theme. If no theme name is supplied, run interactively, otherwise change the current theme to the specified theme name.

Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. option:: --cache-age <CACHE_AGE>

    Check for new themes only after the specified number of days. A value of zero will always check for new themes. A negative value will never check for new themes, instead raising an error if a local copy of the themes is not available.
    Default: :code:`1`

.. option:: --reload-in <RELOAD_IN>

    By default, this kitten will signal only the parent kitty instance it is running in to reload its config, after making changes. Use this option to instead either not reload the config at all or in all running kitty instances.
    Default: :code:`parent`
    Choices: :code:`all`, :code:`none`, :code:`parent`

.. option:: --dump-theme [=no]

    When running non-interactively, dump the specified theme to STDOUT instead of changing kitty.conf.
    Default: :code:`false`

.. option:: --config-file-name <CONFIG_FILE_NAME>

    The name or path to the config file to edit. Relative paths are interpreted with respect to the kitty config directory. By default the kitty config file, kitty.conf is edited. This is most useful if you add :code:`include themes.conf` to your kitty.conf and then have the kitten operate only on :file:`themes.conf`, allowing :code:`kitty.conf` to remain unchanged.
    Default: :code:`kitty.conf`

