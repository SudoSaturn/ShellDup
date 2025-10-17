.. program:: kitty +kitten ask

Source code for ask
------------------------------------------------------------------------

The source code for this kitten is `available on GitHub <https://github.com/kovidgoyal/kitty/tree/master/kittens/ask>`_.

Command Line Interface
------------------------------------------------------------------------


.. highlight:: sh
.. code-block:: sh

  kitten ask [options] 

Ask the user for input

Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. option:: --type <TYPE>, -t <TYPE>

    Type of input. Defaults to asking for a line of text.
    Default: :code:`line`
    Choices: :code:`choices`, :code:`file`, :code:`line`, :code:`password`, :code:`yesno`

.. option:: --message <MESSAGE>, -m <MESSAGE>

    The message to display to the user. If not specified a default message is shown.

.. option:: --name <NAME>, -n <NAME>

    The name for this question. Used to store history of previous answers which can be used for completions and via the browse history readline bindings.

.. option:: --title <TITLE>, --window-title <TITLE>

    The title for the window in which the question is displayed. Only implemented for yesno and choices types.

.. option:: --choice <CHOICES>, -c <CHOICES>

    A choice for the choices type. Can be specified multiple times. Every choice has the syntax: ``letter[;color]:text``, where :italic:`text` is the choice text and :italic:`letter` is the selection key. :italic:`letter` is a single letter belonging to :italic:`text`. This letter is highlighted within the choice text. There can be an optional color specification after the letter to indicate what color it should be. For example: :code:`y:Yes` and :code:`n;red:No`

.. option:: --default <DEFAULT>, -d <DEFAULT>

    A default choice or text. If unspecified, it is :code:`y` for the type :code:`yesno`, the first choice for :code:`choices` and empty for others types. The default choice is selected when the user presses the :kbd:`Enter` key.

.. option:: --prompt <PROMPT>, -p <PROMPT>

    The prompt to use when inputting a line of text or a password.
    Default: :code:`"> "`

.. option:: --unhide-key <UNHIDE_KEY>

    The key to be pressed to unhide hidden text
    Default: :code:`u`

.. option:: --hidden-text-placeholder <HIDDEN_TEXT_PLACEHOLDER>

    The text in the message to be replaced by hidden text. The hidden text is read via STDIN.

