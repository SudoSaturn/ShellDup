.. program:: kitty +kitten notify

Source code for notify
------------------------------------------------------------------------

The source code for this kitten is `available on GitHub <https://github.com/kovidgoyal/kitty/tree/master/kittens/notify>`_.

Command Line Interface
------------------------------------------------------------------------


.. highlight:: sh
.. code-block:: sh

  kitten notify [options] TITLE [BODY ...]

Send notifications to the user that are displayed to them via the
desktop environment's notifications service. Works over SSH as well.

To update an existing notification, specify the identifier of the notification
with the --identifier option. The value should be the same as the identifier specified for
the notification you wish to update.

If no title is specified and an identifier is specified using the --identifier
option, then instead of creating a new notification, an existing notification
with the specified identifier is closed.


Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. option:: --icon <ICON>, -n <ICON>

    The name of the icon to use for the notification. An icon with this name will be searched for on the computer running the terminal emulator. Can be specified multiple times, the first name that is found will be used. Standard names: error, file-manager, help, info, question, system-monitor, text-editor, warn, warning

.. option:: --icon-path <ICON_PATH>, -p <ICON_PATH>

    Path to an image file in PNG/JPEG/GIF formats to use as the icon. If both name and path are specified then first the name will be looked for and if not found then the path will be used.

.. option:: --app-name <APP_NAME>, -a <APP_NAME>

    The application name for the notification.
    Default: :code:`kitten-notify`

.. option:: --button <BUTTON>, -b <BUTTON>

    Add a button with the specified text to the notification. Can be specified multiple times for multiple buttons. If --wait-till-closed is used then the kitten will print the button number to STDOUT if the user clicks a button. 1 for the first button, 2 for the second button and so on.

.. option:: --urgency <URGENCY>, -u <URGENCY>

    The urgency of the notification.
    Default: :code:`normal`
    Choices: :code:`critical`, :code:`low`, :code:`normal`

.. option:: --expire-after <EXPIRE_AFTER>, -e <EXPIRE_AFTER>

    The duration, for the notification to appear on screen. The default is to use the policy of the OS notification service. A value of :code:`never` means the notification should never expire, however, this may or may not work depending on the policies of the OS notification service. Time is specified in the form NUMBER[SUFFIX] where SUFFIX can be :code:`s` for seconds, :code:`m` for minutes, :code:`h` for hours or :code:`d` for days. Non-integer numbers are allowed. If not specified, seconds is assumed. The notification is guaranteed to be closed automatically after the specified time has elapsed. The notification could be closed before by user action or OS policy.

.. option:: --sound-name <SOUND_NAME>, -s <SOUND_NAME>

    The name of the sound to play with the notification. :code:`system` means let the notification system use whatever sound it wants. :code:`silent` means prevent any sound from being played. Any other value is passed to the desktop's notification system which may or may not honor it.
    Default: :code:`system`

.. option:: --type <TYPE>, -t <TYPE>

    The notification type. Can be any string, it is used by users to create filter rules for notifications, so choose something descriptive of the notification's purpose.

.. option:: --identifier <IDENTIFIER>, -i <IDENTIFIER>

    The identifier of this notification. If a notification with the same identifier is already displayed, it is replaced/updated.

.. option:: --print-identifier [=no], -P [=no]

    Print the identifier for the notification to STDOUT. Useful when not specifying your own identifier via the --identifier option.

.. option:: --wait-for-completion [=no], --wait-till-closed [=no], -w [=no]

    Wait until the notification is closed. If the user activates the notification, "0" is printed to STDOUT before quitting. If a button on the notification is pressed the number corresponding to the button is printed to STDOUT. Press the Esc or Ctrl+C keys to close the notification manually.

.. option:: --only-print-escape-code [=no]

    Only print the escape code to STDOUT. Useful if using this kitten as part of a larger application. If this is specified, the --wait-till-closed option will be used for escape code generation, but no actual waiting will be done.

.. option:: --icon-cache-id <ICON_CACHE_ID>, -g <ICON_CACHE_ID>

    Identifier to use when caching icons in the terminal emulator. Using an identifier means that icon data needs to be transmitted only once using --icon-path. Subsequent invocations will use the cached icon data, at least until the terminal instance is restarted. This is useful if this kitten is being used inside a larger application, with --only-print-escape-code.

