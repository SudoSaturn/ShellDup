.. program:: kitty +kitten transfer

Source code for transfer
------------------------------------------------------------------------

The source code for this kitten is `available on GitHub <https://github.com/kovidgoyal/kitty/tree/master/kittens/transfer>`_.

Command Line Interface
------------------------------------------------------------------------


.. highlight:: sh
.. code-block:: sh

  kitten transfer [options] source_files_or_directories destination_path

Transfer files over the TTY device. Can be used to send files between any two
computers provided there is a TTY connection between them, such as over SSH.
Supports copying files, directories (recursively), symlinks and hardlinks.  Can
even use an rsync like protocol to copy only changes between files.  When
copying multiple files, use the --confirm-paths option to see what exactly will
be copied. The easiest way to use this kitten is to first ssh into the remote
computer with the ssh kitten:

.. code::

    $ kitten ssh my-remote-computer

Then, on the remote computer run the transfer kitten to do your copying.
To copy a file from the remote computer to the local computer, run:

.. code::

    $ kitten transfer remote-file /path/to/local-file

This will copy :file:`remote-file` from the remote computer to :file:`/path/to/local-file`
on the local computer.

Similarly, to copy a file from the local computer to the remote one, run:

.. code::

    $ kitten transfer --direction=upload /path/to/local-file remote-file

This will copy :file:`/path/to/local-file` from the local computer
to :file:`remote-file` on the remote computer.

Multiple files can be copied:

.. code::

    $ kitten transfer file1 file2 /path/to/dir/

This will put :code:`file1` and :code:`file2` into the directory
:file:`/path/to/dir/` on the local computer.

Directories can also be copied, recursively:

.. code::

    $ kitten transfer dir1 /path/to/dir/

This will put :file:`dir1` and all its contents into
:file:`/path/to/dir/` on the local computer.

Note that when copying multiple files or directories, the destination
must be an existing directory on the receiving computer. Relative file
paths are resolved with respect to the current directory on the computer
running the kitten and the home directory on the other computer. It is
a good idea to use the :option:`--confirm-paths` command line flag to verify
the kitten will copy the files you expect it to.


Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. option:: --direction <DIRECTION>, -d <DIRECTION>

    Whether to send or receive files. :code:`send` or :code:`download` copy files from the computer on which the kitten is running (usually the remote computer) to the local computer. :code:`receive` or :code:`upload` copy files from the local computer to the remote computer.
    Default: :code:`download`
    Choices: :code:`download`, :code:`receive`, :code:`send`, :code:`upload`

.. option:: --mode <MODE>, -m <MODE>

    How to interpret command line arguments. In :code:`mirror` mode all arguments are assumed to be files/dirs on the sending computer and they are mirrored onto the receiving computer. Files under the HOME directory are copied to the HOME directory on the receiving computer even if the HOME directory is different. In :code:`normal` mode the last argument is assumed to be a destination path on the receiving computer. The last argument must be an existing directory unless copying a single file. When it is a directory it should end with a trailing slash.
    Default: :code:`normal`
    Choices: :code:`mirror`, :code:`normal`

.. option:: --compress <COMPRESS>

    Whether to compress data being sent. By default compression is enabled based on the type of file being sent. For files recognized as being already compressed, compression is turned off as it just wastes CPU cycles.
    Default: :code:`auto`
    Choices: :code:`always`, :code:`auto`, :code:`never`

.. option:: --permissions-bypass <PERMISSIONS_BYPASS>, -p <PERMISSIONS_BYPASS>

    The password to use to skip the transfer confirmation popup in kitty. Must match the password set for the :opt:`file_transfer_confirmation_bypass` option in :file:`kitty.conf`. Note that leading and trailing whitespace is removed from the password. A password starting with :code:`.`, :code:`/` or :code:`~` characters is assumed to be a file name to read the password from. A value of :code:`-` means read the password from STDIN. A password that is purely a number less than 256 is assumed to be the number of a file descriptor from which to read the actual password.

.. option:: --confirm-paths [=no], -c [=no]

    Before actually transferring files, show a mapping of local file names to remote file names and ask for confirmation.

.. option:: --transmit-deltas [=no], -x [=no]

    If a file on the receiving side already exists, use the rsync algorithm to update it to match the file on the sending side, potentially saving lots of bandwidth and also automatically resuming partial transfers. Note that this will actually degrade performance on fast links or with small files, so use with care.

