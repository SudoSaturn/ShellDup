.. program:: kitty +kitten unicode_input

Source code for unicode_input
------------------------------------------------------------------------

The source code for this kitten is `available on GitHub <https://github.com/kovidgoyal/kitty/tree/master/kittens/unicode_input>`_.

Command Line Interface
------------------------------------------------------------------------


.. highlight:: sh
.. code-block:: sh

  kitten unicode_input [options] 

Input a Unicode character

Options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. option:: --emoji-variation <EMOJI_VARIATION>

    Whether to use the textual or the graphical form for emoji. By default the default form specified in the Unicode standard for the symbol is used.
    Default: :code:`none`
    Choices: :code:`graphic`, :code:`none`, :code:`text`

.. option:: --tab <TAB>

    The initial tab to display. Defaults to using the tab from the previous kitten invocation.
    Default: :code:`previous`
    Choices: :code:`code`, :code:`emoticons`, :code:`favorites`, :code:`name`, :code:`previous`

