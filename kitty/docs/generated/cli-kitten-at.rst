kitten @
--------------------------------------------------------------------------------
.. program:: kitten @


.. highlight:: sh
.. code-block:: sh

  kitten @ [options] command ...

Control kitty by sending it commands. Set the :opt:`allow_remote_control` option in :file:`kitty.conf` or use a password, for this to work.

Options
______________________________
.. option:: --to <TO>

    An address for the kitty instance to control. Corresponds to the address given to the kitty instance via the :option:`kitty --listen-on` option or the :opt:`listen_on` setting in :file:`kitty.conf`. If not specified, the environment variable :envvar:`KITTY_LISTEN_ON` is checked. If that is also not found, messages are sent to the controlling terminal for this process, i.e. they will only work if this process is run within a kitty window.

.. option:: --password <PASSWORD>

    A password to use when contacting kitty. This will cause kitty to ask the user for permission to perform the specified action, unless the password has been accepted before or is pre-configured in :file:`kitty.conf`. To use a blank password specify :option:`kitten @ --use-password` as :code:`always`.

.. option:: --password-file <PASSWORD_FILE>

    A file from which to read the password. Trailing whitespace is ignored. Relative paths are resolved from the kitty configuration directory. Use - to read from STDIN. Use :code:`fd:num` to read from the file descriptor :code:`num`. Used if no :option:`kitten @ --password` is supplied. Defaults to checking for the :file:`rc-pass` file in the kitty configuration directory.
    Default: :code:`rc-pass`

.. option:: --password-env <PASSWORD_ENV>

    The name of an environment variable to read the password from. Used if no :option:`kitten @ --password-file` is supplied. Defaults to checking the environment variable :envvar:`KITTY_RC_PASSWORD`.
    Default: :code:`KITTY\_RC\_PASSWORD`

.. option:: --use-password <USE_PASSWORD>

    If no password is available, kitty will usually just send the remote control command without a password. This option can be used to force it to :code:`always` or :code:`never` use the supplied password. If set to always and no password is provided, the blank password is used.
    Default: :code:`if-available`
    Choices: :code:`always`, :code:`if-available`, :code:`never`

.. _at-action:

kitten @ action
------------------------------------------------------------------------------------------------------------------------
.. program:: kitten @ action


.. highlight:: sh
.. code-block:: sh

  kitten @ action [options] ACTION [ARGS FOR ACTION...]

Run the specified mappable action. For a list of all available mappable actions, see :doc:`actions`. Any arguments for ACTION should follow the action. Note that parsing of arguments is action dependent so for best results specify all arguments as single string on the command line in the same format as you would use for that action in kitty.conf.

Options
______________________________
.. option:: --self [=no]

    Run the action on the window this command is run in instead of the active window.

.. option:: --no-response [=no]

    Don't wait for a response indicating the success of the action. Note that using this option means that you will not be notified of failures.
    Default: :code:`false`

.. option:: --match <MATCH>, -m <MATCH>

    The window to match. Match specifications are of the form: :italic:`field:query`. Where :italic:`field` can be one of: :code:`id`, :code:`title`, :code:`pid`, :code:`cwd`, :code:`cmdline`, :code:`num`, :code:`env`, :code:`var`, :code:`state`, :code:`neighbor`, :code:`session` and :code:`recent`. :italic:`query` is the expression to match. Expressions can be either a number or a regular expression, and can be :ref:`combined using Boolean operators <search_syntax>`.

    The special value :code:`all` matches all windows.

    For numeric fields: :code:`id`, :code:`pid`, :code:`num` and :code:`recent`, the expression is interpreted as a number, not a regular expression. Negative values for :code:`id` match from the highest id number down, in particular, -1 is the most recently created window.

    The field :code:`num` refers to the window position in the current tab, starting from zero and counting clockwise (this is the same as the order in which the windows are reported by the :ref:`kitten @ ls <at-ls>` command).

    The window id of the current window is available as the :envvar:`KITTY_WINDOW_ID` environment variable.

    The field :code:`recent` refers to recently active windows in the currently active tab, with zero being the currently active window, one being the previously active window and so on.

    The field :code:`neighbor` refers to a neighbor of the active window in the specified direction, which can be: :code:`left`, :code:`right`, :code:`top` or :code:`bottom`.

    The field :code:`session` matches windows that were created in the specified session. Use the expression :code:`^$` to match windows that were not created in a session and :code:`.` to match the currently active session and :code:`~` to match either the currently active sesison or the last active session when no session is active.

    When using the :code:`env` field to match on environment variables, you can specify only the environment variable name or a name and value, for example, :code:`env:MY_ENV_VAR=2`.

    Similarly, the :code:`var` field matches on user variables set on the window. You can specify name or name and value as with the :code:`env` field.

    The field :code:`state` matches on the state of the window. Supported states are: :code:`active`, :code:`focused`, :code:`needs_attention`, :code:`parent_active`, :code:`parent_focused`, :code:`self`, :code:`overlay_parent`.  Active windows are the windows that are active in their parent tab. There is only one focused window and it is the window to which keyboard events are delivered. If no window is focused, the last focused window is matched. The value :code:`self` matches the window in which the remote control command is run. The value :code:`overlay_parent` matches the window that is under the :code:`self` window, when the self window is an overlay.

    Note that you can use the :ref:`kitten @ ls <at-ls>` command to get a list of windows.

.. _at-close-tab:

kitten @ close-tab
------------------------------------------------------------------------------------------------------------------------
.. program:: kitten @ close-tab


.. highlight:: sh
.. code-block:: sh

  kitten @ close-tab [options] 

Close an arbitrary set of tabs. The :code:`--match` option can be used to
specify complex sets of tabs to close. For example, to close all non-focused
tabs in the currently focused OS window, use::

    kitten @ close-tab --match "not state:focused and state:parent_focused"


Options
______________________________
.. option:: --match <MATCH>, -m <MATCH>

    The tab to match. Match specifications are of the form: :italic:`field:query`. Where :italic:`field` can be one of: :code:`id`, :code:`index`, :code:`title`, :code:`window_id`, :code:`window_title`, :code:`pid`, :code:`cwd`, :code:`cmdline` :code:`env`, :code:`var`, :code:`state`, :code:`session` and :code:`recent`. :italic:`query` is the expression to match. Expressions can be either a number or a regular expression, and can be :ref:`combined using Boolean operators <search_syntax>`.

    The special value :code:`all` matches all tabs.

    For numeric fields: :code:`id`, :code:`index`, :code:`window_id`, :code:`pid` and :code:`recent`, the expression is interpreted as a number, not a regular expression. Negative values for :code:`id`/:code:`window_id` match from the highest id number down, in particular, -1 is the most recently created tab/window.

    When using :code:`title` or :code:`id`, first a matching tab is looked for, and if not found a matching window is looked for, and the tab for that window is used.

    You can also use :code:`window_id` and :code:`window_title` to match the tab that contains the window with the specified id or title.

    The :code:`index` number is used to match the nth tab in the currently active OS window. The :code:`recent` number matches recently active tabs in the currently active OS window, with zero being the currently active tab, one the previously active tab and so on.

    The field :code:`session` matches tabs that were created in the specified session. Use the expression :code:`^$` to match windows that were not created in a session and :code:`.` to match the currently active session and :code:`~` to match either the currently active sesison or the last active session when no session is active.

    When using the :code:`env` field to match on environment variables, you can specify only the environment variable name or a name and value, for example, :code:`env:MY_ENV_VAR=2`. Tabs containing any window with the specified environment variables are matched. Similarly, :code:`var` matches tabs containing any window with the specified user variable.

    The field :code:`state` matches on the state of the tab. Supported states are: :code:`active`, :code:`focused`, :code:`needs_attention`, :code:`parent_active` and :code:`parent_focused`. Active tabs are the tabs that are active in their parent OS window. There is only one focused tab and it is the tab to which keyboard events are delivered. If no tab is focused, the last focused tab is matched.

    Note that you can use the :ref:`kitten @ ls <at-ls>` command to get a list of tabs.

.. option:: --no-response [=no]

    Don't wait for a response indicating the success of the action. Note that using this option means that you will not be notified of failures.
    Default: :code:`false`

.. option:: --self [=no]

    Close the tab of the window this command is run in, rather than the active tab.

.. option:: --ignore-no-match [=no]

    Do not return an error if no tabs are matched to be closed.

.. _at-close-window:

kitten @ close-window
------------------------------------------------------------------------------------------------------------------------
.. program:: kitten @ close-window


.. highlight:: sh
.. code-block:: sh

  kitten @ close-window [options] 

Close the specified windows

Options
______________________________
.. option:: --match <MATCH>, -m <MATCH>

    The window to match. Match specifications are of the form: :italic:`field:query`. Where :italic:`field` can be one of: :code:`id`, :code:`title`, :code:`pid`, :code:`cwd`, :code:`cmdline`, :code:`num`, :code:`env`, :code:`var`, :code:`state`, :code:`neighbor`, :code:`session` and :code:`recent`. :italic:`query` is the expression to match. Expressions can be either a number or a regular expression, and can be :ref:`combined using Boolean operators <search_syntax>`.

    The special value :code:`all` matches all windows.

    For numeric fields: :code:`id`, :code:`pid`, :code:`num` and :code:`recent`, the expression is interpreted as a number, not a regular expression. Negative values for :code:`id` match from the highest id number down, in particular, -1 is the most recently created window.

    The field :code:`num` refers to the window position in the current tab, starting from zero and counting clockwise (this is the same as the order in which the windows are reported by the :ref:`kitten @ ls <at-ls>` command).

    The window id of the current window is available as the :envvar:`KITTY_WINDOW_ID` environment variable.

    The field :code:`recent` refers to recently active windows in the currently active tab, with zero being the currently active window, one being the previously active window and so on.

    The field :code:`neighbor` refers to a neighbor of the active window in the specified direction, which can be: :code:`left`, :code:`right`, :code:`top` or :code:`bottom`.

    The field :code:`session` matches windows that were created in the specified session. Use the expression :code:`^$` to match windows that were not created in a session and :code:`.` to match the currently active session and :code:`~` to match either the currently active sesison or the last active session when no session is active.

    When using the :code:`env` field to match on environment variables, you can specify only the environment variable name or a name and value, for example, :code:`env:MY_ENV_VAR=2`.

    Similarly, the :code:`var` field matches on user variables set on the window. You can specify name or name and value as with the :code:`env` field.

    The field :code:`state` matches on the state of the window. Supported states are: :code:`active`, :code:`focused`, :code:`needs_attention`, :code:`parent_active`, :code:`parent_focused`, :code:`self`, :code:`overlay_parent`.  Active windows are the windows that are active in their parent tab. There is only one focused window and it is the window to which keyboard events are delivered. If no window is focused, the last focused window is matched. The value :code:`self` matches the window in which the remote control command is run. The value :code:`overlay_parent` matches the window that is under the :code:`self` window, when the self window is an overlay.

    Note that you can use the :ref:`kitten @ ls <at-ls>` command to get a list of windows.

.. option:: --no-response [=no]

    Don't wait for a response indicating the success of the action. Note that using this option means that you will not be notified of failures.
    Default: :code:`false`

.. option:: --self [=no]

    Close the window this command is run in, rather than the active window.

.. option:: --ignore-no-match [=no]

    Do not return an error if no windows are matched to be closed.

.. _at-create-marker:

kitten @ create-marker
------------------------------------------------------------------------------------------------------------------------
.. program:: kitten @ create-marker


.. highlight:: sh
.. code-block:: sh

  kitten @ create-marker [options] MARKER SPECIFICATION

Create a marker which can highlight text in the specified window. For example: :code:`create_marker text 1 ERROR`. For full details see: :doc:`marks`

Options
______________________________
.. option:: --match <MATCH>, -m <MATCH>

    The window to match. Match specifications are of the form: :italic:`field:query`. Where :italic:`field` can be one of: :code:`id`, :code:`title`, :code:`pid`, :code:`cwd`, :code:`cmdline`, :code:`num`, :code:`env`, :code:`var`, :code:`state`, :code:`neighbor`, :code:`session` and :code:`recent`. :italic:`query` is the expression to match. Expressions can be either a number or a regular expression, and can be :ref:`combined using Boolean operators <search_syntax>`.

    The special value :code:`all` matches all windows.

    For numeric fields: :code:`id`, :code:`pid`, :code:`num` and :code:`recent`, the expression is interpreted as a number, not a regular expression. Negative values for :code:`id` match from the highest id number down, in particular, -1 is the most recently created window.

    The field :code:`num` refers to the window position in the current tab, starting from zero and counting clockwise (this is the same as the order in which the windows are reported by the :ref:`kitten @ ls <at-ls>` command).

    The window id of the current window is available as the :envvar:`KITTY_WINDOW_ID` environment variable.

    The field :code:`recent` refers to recently active windows in the currently active tab, with zero being the currently active window, one being the previously active window and so on.

    The field :code:`neighbor` refers to a neighbor of the active window in the specified direction, which can be: :code:`left`, :code:`right`, :code:`top` or :code:`bottom`.

    The field :code:`session` matches windows that were created in the specified session. Use the expression :code:`^$` to match windows that were not created in a session and :code:`.` to match the currently active session and :code:`~` to match either the currently active sesison or the last active session when no session is active.

    When using the :code:`env` field to match on environment variables, you can specify only the environment variable name or a name and value, for example, :code:`env:MY_ENV_VAR=2`.

    Similarly, the :code:`var` field matches on user variables set on the window. You can specify name or name and value as with the :code:`env` field.

    The field :code:`state` matches on the state of the window. Supported states are: :code:`active`, :code:`focused`, :code:`needs_attention`, :code:`parent_active`, :code:`parent_focused`, :code:`self`, :code:`overlay_parent`.  Active windows are the windows that are active in their parent tab. There is only one focused window and it is the window to which keyboard events are delivered. If no window is focused, the last focused window is matched. The value :code:`self` matches the window in which the remote control command is run. The value :code:`overlay_parent` matches the window that is under the :code:`self` window, when the self window is an overlay.

    Note that you can use the :ref:`kitten @ ls <at-ls>` command to get a list of windows.

.. option:: --self [=no]

    Apply marker to the window this command is run in, rather than the active window.

.. _at-detach-tab:

kitten @ detach-tab
------------------------------------------------------------------------------------------------------------------------
.. program:: kitten @ detach-tab


.. highlight:: sh
.. code-block:: sh

  kitten @ detach-tab [options] 

Detach the specified tabs and either move them into a new OS window or add them to the OS window containing the tab specified by :option:`kitten @ detach-tab --target-tab`

Options
______________________________
.. option:: --match <MATCH>, -m <MATCH>

    The tab to match. Match specifications are of the form: :italic:`field:query`. Where :italic:`field` can be one of: :code:`id`, :code:`index`, :code:`title`, :code:`window_id`, :code:`window_title`, :code:`pid`, :code:`cwd`, :code:`cmdline` :code:`env`, :code:`var`, :code:`state`, :code:`session` and :code:`recent`. :italic:`query` is the expression to match. Expressions can be either a number or a regular expression, and can be :ref:`combined using Boolean operators <search_syntax>`.

    The special value :code:`all` matches all tabs.

    For numeric fields: :code:`id`, :code:`index`, :code:`window_id`, :code:`pid` and :code:`recent`, the expression is interpreted as a number, not a regular expression. Negative values for :code:`id`/:code:`window_id` match from the highest id number down, in particular, -1 is the most recently created tab/window.

    When using :code:`title` or :code:`id`, first a matching tab is looked for, and if not found a matching window is looked for, and the tab for that window is used.

    You can also use :code:`window_id` and :code:`window_title` to match the tab that contains the window with the specified id or title.

    The :code:`index` number is used to match the nth tab in the currently active OS window. The :code:`recent` number matches recently active tabs in the currently active OS window, with zero being the currently active tab, one the previously active tab and so on.

    The field :code:`session` matches tabs that were created in the specified session. Use the expression :code:`^$` to match windows that were not created in a session and :code:`.` to match the currently active session and :code:`~` to match either the currently active sesison or the last active session when no session is active.

    When using the :code:`env` field to match on environment variables, you can specify only the environment variable name or a name and value, for example, :code:`env:MY_ENV_VAR=2`. Tabs containing any window with the specified environment variables are matched. Similarly, :code:`var` matches tabs containing any window with the specified user variable.

    The field :code:`state` matches on the state of the tab. Supported states are: :code:`active`, :code:`focused`, :code:`needs_attention`, :code:`parent_active` and :code:`parent_focused`. Active tabs are the tabs that are active in their parent OS window. There is only one focused tab and it is the tab to which keyboard events are delivered. If no tab is focused, the last focused tab is matched.

    Note that you can use the :ref:`kitten @ ls <at-ls>` command to get a list of tabs.

.. option:: --target-tab <TARGET_TAB>, -t <TARGET_TAB>

    The tab to match. Match specifications are of the form: :italic:`field:query`. Where :italic:`field` can be one of: :code:`id`, :code:`index`, :code:`title`, :code:`window_id`, :code:`window_title`, :code:`pid`, :code:`cwd`, :code:`cmdline` :code:`env`, :code:`var`, :code:`state`, :code:`session` and :code:`recent`. :italic:`query` is the expression to match. Expressions can be either a number or a regular expression, and can be :ref:`combined using Boolean operators <search_syntax>`.

    The special value :code:`all` matches all tabs.

    For numeric fields: :code:`id`, :code:`index`, :code:`window_id`, :code:`pid` and :code:`recent`, the expression is interpreted as a number, not a regular expression. Negative values for :code:`id`/:code:`window_id` match from the highest id number down, in particular, -1 is the most recently created tab/window.

    When using :code:`title` or :code:`id`, first a matching tab is looked for, and if not found a matching window is looked for, and the tab for that window is used.

    You can also use :code:`window_id` and :code:`window_title` to match the tab that contains the window with the specified id or title.

    The :code:`index` number is used to match the nth tab in the currently active OS window. The :code:`recent` number matches recently active tabs in the currently active OS window, with zero being the currently active tab, one the previously active tab and so on.

    The field :code:`session` matches tabs that were created in the specified session. Use the expression :code:`^$` to match windows that were not created in a session and :code:`.` to match the currently active session and :code:`~` to match either the currently active sesison or the last active session when no session is active.

    When using the :code:`env` field to match on environment variables, you can specify only the environment variable name or a name and value, for example, :code:`env:MY_ENV_VAR=2`. Tabs containing any window with the specified environment variables are matched. Similarly, :code:`var` matches tabs containing any window with the specified user variable.

    The field :code:`state` matches on the state of the tab. Supported states are: :code:`active`, :code:`focused`, :code:`needs_attention`, :code:`parent_active` and :code:`parent_focused`. Active tabs are the tabs that are active in their parent OS window. There is only one focused tab and it is the tab to which keyboard events are delivered. If no tab is focused, the last focused tab is matched.

    Note that you can use the :ref:`kitten @ ls <at-ls>` command to get a list of tabs.

.. option:: --self [=no]

    Detach the tab this command is run in, rather than the active tab.

.. _at-detach-window:

kitten @ detach-window
------------------------------------------------------------------------------------------------------------------------
.. program:: kitten @ detach-window


.. highlight:: sh
.. code-block:: sh

  kitten @ detach-window [options] 

Detach the specified windows and either move them into a new tab, a new OS window or add them to the specified tab. Use the special value :code:`new` for :option:`kitten @ detach-window --target-tab` to move to a new tab. If no target tab is specified the windows are moved to a new OS window.

Options
______________________________
.. option:: --match <MATCH>, -m <MATCH>

    The window to match. Match specifications are of the form: :italic:`field:query`. Where :italic:`field` can be one of: :code:`id`, :code:`title`, :code:`pid`, :code:`cwd`, :code:`cmdline`, :code:`num`, :code:`env`, :code:`var`, :code:`state`, :code:`neighbor`, :code:`session` and :code:`recent`. :italic:`query` is the expression to match. Expressions can be either a number or a regular expression, and can be :ref:`combined using Boolean operators <search_syntax>`.

    The special value :code:`all` matches all windows.

    For numeric fields: :code:`id`, :code:`pid`, :code:`num` and :code:`recent`, the expression is interpreted as a number, not a regular expression. Negative values for :code:`id` match from the highest id number down, in particular, -1 is the most recently created window.

    The field :code:`num` refers to the window position in the current tab, starting from zero and counting clockwise (this is the same as the order in which the windows are reported by the :ref:`kitten @ ls <at-ls>` command).

    The window id of the current window is available as the :envvar:`KITTY_WINDOW_ID` environment variable.

    The field :code:`recent` refers to recently active windows in the currently active tab, with zero being the currently active window, one being the previously active window and so on.

    The field :code:`neighbor` refers to a neighbor of the active window in the specified direction, which can be: :code:`left`, :code:`right`, :code:`top` or :code:`bottom`.

    The field :code:`session` matches windows that were created in the specified session. Use the expression :code:`^$` to match windows that were not created in a session and :code:`.` to match the currently active session and :code:`~` to match either the currently active sesison or the last active session when no session is active.

    When using the :code:`env` field to match on environment variables, you can specify only the environment variable name or a name and value, for example, :code:`env:MY_ENV_VAR=2`.

    Similarly, the :code:`var` field matches on user variables set on the window. You can specify name or name and value as with the :code:`env` field.

    The field :code:`state` matches on the state of the window. Supported states are: :code:`active`, :code:`focused`, :code:`needs_attention`, :code:`parent_active`, :code:`parent_focused`, :code:`self`, :code:`overlay_parent`.  Active windows are the windows that are active in their parent tab. There is only one focused window and it is the window to which keyboard events are delivered. If no window is focused, the last focused window is matched. The value :code:`self` matches the window in which the remote control command is run. The value :code:`overlay_parent` matches the window that is under the :code:`self` window, when the self window is an overlay.

    Note that you can use the :ref:`kitten @ ls <at-ls>` command to get a list of windows.

.. option:: --target-tab <TARGET_TAB>, -t <TARGET_TAB>

    The tab to match. Match specifications are of the form: :italic:`field:query`. Where :italic:`field` can be one of: :code:`id`, :code:`index`, :code:`title`, :code:`window_id`, :code:`window_title`, :code:`pid`, :code:`cwd`, :code:`cmdline` :code:`env`, :code:`var`, :code:`state`, :code:`session` and :code:`recent`. :italic:`query` is the expression to match. Expressions can be either a number or a regular expression, and can be :ref:`combined using Boolean operators <search_syntax>`.

    The special value :code:`all` matches all tabs.

    For numeric fields: :code:`id`, :code:`index`, :code:`window_id`, :code:`pid` and :code:`recent`, the expression is interpreted as a number, not a regular expression. Negative values for :code:`id`/:code:`window_id` match from the highest id number down, in particular, -1 is the most recently created tab/window.

    When using :code:`title` or :code:`id`, first a matching tab is looked for, and if not found a matching window is looked for, and the tab for that window is used.

    You can also use :code:`window_id` and :code:`window_title` to match the tab that contains the window with the specified id or title.

    The :code:`index` number is used to match the nth tab in the currently active OS window. The :code:`recent` number matches recently active tabs in the currently active OS window, with zero being the currently active tab, one the previously active tab and so on.

    The field :code:`session` matches tabs that were created in the specified session. Use the expression :code:`^$` to match windows that were not created in a session and :code:`.` to match the currently active session and :code:`~` to match either the currently active sesison or the last active session when no session is active.

    When using the :code:`env` field to match on environment variables, you can specify only the environment variable name or a name and value, for example, :code:`env:MY_ENV_VAR=2`. Tabs containing any window with the specified environment variables are matched. Similarly, :code:`var` matches tabs containing any window with the specified user variable.

    The field :code:`state` matches on the state of the tab. Supported states are: :code:`active`, :code:`focused`, :code:`needs_attention`, :code:`parent_active` and :code:`parent_focused`. Active tabs are the tabs that are active in their parent OS window. There is only one focused tab and it is the tab to which keyboard events are delivered. If no tab is focused, the last focused tab is matched.

    Note that you can use the :ref:`kitten @ ls <at-ls>` command to get a list of tabs. Use the special value :code:`new` to move to a new tab.

.. option:: --self [=no]

    Detach the window this command is run in, rather than the active window.

.. option:: --stay-in-tab [=no]

    Keep the focus on a window in the currently focused tab after moving the specified windows.

.. _at-disable-ligatures:

kitten @ disable-ligatures
------------------------------------------------------------------------------------------------------------------------
.. program:: kitten @ disable-ligatures


.. highlight:: sh
.. code-block:: sh

  kitten @ disable-ligatures [options] STRATEGY

Control ligature rendering for the specified windows/tabs (defaults to active window). The :italic:`STRATEGY` can be one of: :code:`never`, :code:`always`, :code:`cursor`.

Options
______________________________
.. option:: --all [=no], -a [=no]

    By default, ligatures are only affected in the active window. This option will cause ligatures to be changed in all windows.

.. option:: --match <MATCH>, -m <MATCH>

    The window to match. Match specifications are of the form: :italic:`field:query`. Where :italic:`field` can be one of: :code:`id`, :code:`title`, :code:`pid`, :code:`cwd`, :code:`cmdline`, :code:`num`, :code:`env`, :code:`var`, :code:`state`, :code:`neighbor`, :code:`session` and :code:`recent`. :italic:`query` is the expression to match. Expressions can be either a number or a regular expression, and can be :ref:`combined using Boolean operators <search_syntax>`.

    The special value :code:`all` matches all windows.

    For numeric fields: :code:`id`, :code:`pid`, :code:`num` and :code:`recent`, the expression is interpreted as a number, not a regular expression. Negative values for :code:`id` match from the highest id number down, in particular, -1 is the most recently created window.

    The field :code:`num` refers to the window position in the current tab, starting from zero and counting clockwise (this is the same as the order in which the windows are reported by the :ref:`kitten @ ls <at-ls>` command).

    The window id of the current window is available as the :envvar:`KITTY_WINDOW_ID` environment variable.

    The field :code:`recent` refers to recently active windows in the currently active tab, with zero being the currently active window, one being the previously active window and so on.

    The field :code:`neighbor` refers to a neighbor of the active window in the specified direction, which can be: :code:`left`, :code:`right`, :code:`top` or :code:`bottom`.

    The field :code:`session` matches windows that were created in the specified session. Use the expression :code:`^$` to match windows that were not created in a session and :code:`.` to match the currently active session and :code:`~` to match either the currently active sesison or the last active session when no session is active.

    When using the :code:`env` field to match on environment variables, you can specify only the environment variable name or a name and value, for example, :code:`env:MY_ENV_VAR=2`.

    Similarly, the :code:`var` field matches on user variables set on the window. You can specify name or name and value as with the :code:`env` field.

    The field :code:`state` matches on the state of the window. Supported states are: :code:`active`, :code:`focused`, :code:`needs_attention`, :code:`parent_active`, :code:`parent_focused`, :code:`self`, :code:`overlay_parent`.  Active windows are the windows that are active in their parent tab. There is only one focused window and it is the window to which keyboard events are delivered. If no window is focused, the last focused window is matched. The value :code:`self` matches the window in which the remote control command is run. The value :code:`overlay_parent` matches the window that is under the :code:`self` window, when the self window is an overlay.

    Note that you can use the :ref:`kitten @ ls <at-ls>` command to get a list of windows.

.. option:: --match-tab <MATCH_TAB>, -t <MATCH_TAB>

    The tab to match. Match specifications are of the form: :italic:`field:query`. Where :italic:`field` can be one of: :code:`id`, :code:`index`, :code:`title`, :code:`window_id`, :code:`window_title`, :code:`pid`, :code:`cwd`, :code:`cmdline` :code:`env`, :code:`var`, :code:`state`, :code:`session` and :code:`recent`. :italic:`query` is the expression to match. Expressions can be either a number or a regular expression, and can be :ref:`combined using Boolean operators <search_syntax>`.

    The special value :code:`all` matches all tabs.

    For numeric fields: :code:`id`, :code:`index`, :code:`window_id`, :code:`pid` and :code:`recent`, the expression is interpreted as a number, not a regular expression. Negative values for :code:`id`/:code:`window_id` match from the highest id number down, in particular, -1 is the most recently created tab/window.

    When using :code:`title` or :code:`id`, first a matching tab is looked for, and if not found a matching window is looked for, and the tab for that window is used.

    You can also use :code:`window_id` and :code:`window_title` to match the tab that contains the window with the specified id or title.

    The :code:`index` number is used to match the nth tab in the currently active OS window. The :code:`recent` number matches recently active tabs in the currently active OS window, with zero being the currently active tab, one the previously active tab and so on.

    The field :code:`session` matches tabs that were created in the specified session. Use the expression :code:`^$` to match windows that were not created in a session and :code:`.` to match the currently active session and :code:`~` to match either the currently active sesison or the last active session when no session is active.

    When using the :code:`env` field to match on environment variables, you can specify only the environment variable name or a name and value, for example, :code:`env:MY_ENV_VAR=2`. Tabs containing any window with the specified environment variables are matched. Similarly, :code:`var` matches tabs containing any window with the specified user variable.

    The field :code:`state` matches on the state of the tab. Supported states are: :code:`active`, :code:`focused`, :code:`needs_attention`, :code:`parent_active` and :code:`parent_focused`. Active tabs are the tabs that are active in their parent OS window. There is only one focused tab and it is the tab to which keyboard events are delivered. If no tab is focused, the last focused tab is matched.

    Note that you can use the :ref:`kitten @ ls <at-ls>` command to get a list of tabs.

.. _at-env:

kitten @ env
------------------------------------------------------------------------------------------------------------------------
.. program:: kitten @ env


.. highlight:: sh
.. code-block:: sh

  kitten @ env env_var1=val env_var2=val ...

Change the environment variables that will be seen in newly launched windows. Similar to the :opt:`env` option in :file:`kitty.conf`, but affects running kitty instances. If no = is present, the variable is removed from the environment.

.. _at-focus-tab:

kitten @ focus-tab
------------------------------------------------------------------------------------------------------------------------
.. program:: kitten @ focus-tab


.. highlight:: sh
.. code-block:: sh

  kitten @ focus-tab [options] 

The active window in the specified tab will be focused.

Options
______________________________
.. option:: --match <MATCH>, -m <MATCH>

    The tab to match. Match specifications are of the form: :italic:`field:query`. Where :italic:`field` can be one of: :code:`id`, :code:`index`, :code:`title`, :code:`window_id`, :code:`window_title`, :code:`pid`, :code:`cwd`, :code:`cmdline` :code:`env`, :code:`var`, :code:`state`, :code:`session` and :code:`recent`. :italic:`query` is the expression to match. Expressions can be either a number or a regular expression, and can be :ref:`combined using Boolean operators <search_syntax>`.

    The special value :code:`all` matches all tabs.

    For numeric fields: :code:`id`, :code:`index`, :code:`window_id`, :code:`pid` and :code:`recent`, the expression is interpreted as a number, not a regular expression. Negative values for :code:`id`/:code:`window_id` match from the highest id number down, in particular, -1 is the most recently created tab/window.

    When using :code:`title` or :code:`id`, first a matching tab is looked for, and if not found a matching window is looked for, and the tab for that window is used.

    You can also use :code:`window_id` and :code:`window_title` to match the tab that contains the window with the specified id or title.

    The :code:`index` number is used to match the nth tab in the currently active OS window. The :code:`recent` number matches recently active tabs in the currently active OS window, with zero being the currently active tab, one the previously active tab and so on.

    The field :code:`session` matches tabs that were created in the specified session. Use the expression :code:`^$` to match windows that were not created in a session and :code:`.` to match the currently active session and :code:`~` to match either the currently active sesison or the last active session when no session is active.

    When using the :code:`env` field to match on environment variables, you can specify only the environment variable name or a name and value, for example, :code:`env:MY_ENV_VAR=2`. Tabs containing any window with the specified environment variables are matched. Similarly, :code:`var` matches tabs containing any window with the specified user variable.

    The field :code:`state` matches on the state of the tab. Supported states are: :code:`active`, :code:`focused`, :code:`needs_attention`, :code:`parent_active` and :code:`parent_focused`. Active tabs are the tabs that are active in their parent OS window. There is only one focused tab and it is the tab to which keyboard events are delivered. If no tab is focused, the last focused tab is matched.

    Note that you can use the :ref:`kitten @ ls <at-ls>` command to get a list of tabs.

.. option:: --no-response [=no]

    Don't wait for a response indicating the success of the action. Note that using this option means that you will not be notified of failures.
    Default: :code:`false`

.. _at-focus-window:

kitten @ focus-window
------------------------------------------------------------------------------------------------------------------------
.. program:: kitten @ focus-window


.. highlight:: sh
.. code-block:: sh

  kitten @ focus-window [options] 

Focus the specified window, if no window is specified, focus the window this command is run inside.

Options
______________________________
.. option:: --match <MATCH>, -m <MATCH>

    The window to match. Match specifications are of the form: :italic:`field:query`. Where :italic:`field` can be one of: :code:`id`, :code:`title`, :code:`pid`, :code:`cwd`, :code:`cmdline`, :code:`num`, :code:`env`, :code:`var`, :code:`state`, :code:`neighbor`, :code:`session` and :code:`recent`. :italic:`query` is the expression to match. Expressions can be either a number or a regular expression, and can be :ref:`combined using Boolean operators <search_syntax>`.

    The special value :code:`all` matches all windows.

    For numeric fields: :code:`id`, :code:`pid`, :code:`num` and :code:`recent`, the expression is interpreted as a number, not a regular expression. Negative values for :code:`id` match from the highest id number down, in particular, -1 is the most recently created window.

    The field :code:`num` refers to the window position in the current tab, starting from zero and counting clockwise (this is the same as the order in which the windows are reported by the :ref:`kitten @ ls <at-ls>` command).

    The window id of the current window is available as the :envvar:`KITTY_WINDOW_ID` environment variable.

    The field :code:`recent` refers to recently active windows in the currently active tab, with zero being the currently active window, one being the previously active window and so on.

    The field :code:`neighbor` refers to a neighbor of the active window in the specified direction, which can be: :code:`left`, :code:`right`, :code:`top` or :code:`bottom`.

    The field :code:`session` matches windows that were created in the specified session. Use the expression :code:`^$` to match windows that were not created in a session and :code:`.` to match the currently active session and :code:`~` to match either the currently active sesison or the last active session when no session is active.

    When using the :code:`env` field to match on environment variables, you can specify only the environment variable name or a name and value, for example, :code:`env:MY_ENV_VAR=2`.

    Similarly, the :code:`var` field matches on user variables set on the window. You can specify name or name and value as with the :code:`env` field.

    The field :code:`state` matches on the state of the window. Supported states are: :code:`active`, :code:`focused`, :code:`needs_attention`, :code:`parent_active`, :code:`parent_focused`, :code:`self`, :code:`overlay_parent`.  Active windows are the windows that are active in their parent tab. There is only one focused window and it is the window to which keyboard events are delivered. If no window is focused, the last focused window is matched. The value :code:`self` matches the window in which the remote control command is run. The value :code:`overlay_parent` matches the window that is under the :code:`self` window, when the self window is an overlay.

    Note that you can use the :ref:`kitten @ ls <at-ls>` command to get a list of windows.

.. option:: --no-response [=no]

    Don't wait for a response from kitty. This means that even if no matching window is found, the command will exit with a success code.
    Default: :code:`false`

.. _at-get-colors:

kitten @ get-colors
------------------------------------------------------------------------------------------------------------------------
.. program:: kitten @ get-colors


.. highlight:: sh
.. code-block:: sh

  kitten @ get-colors [options] 

Get the terminal colors for the specified window (defaults to active window). Colors will be output to STDOUT in the same syntax as used for :file:`kitty.conf`.

To get a single color use:
  get-colors | grep "^background " | tr -s | cut -d" " -f2

Change background above to whatever color you are interested in.

Options
______________________________
.. option:: --configured [=no], -c [=no]

    Instead of outputting the colors for the specified window, output the currently configured colors.

.. option:: --match <MATCH>, -m <MATCH>

    The window to match. Match specifications are of the form: :italic:`field:query`. Where :italic:`field` can be one of: :code:`id`, :code:`title`, :code:`pid`, :code:`cwd`, :code:`cmdline`, :code:`num`, :code:`env`, :code:`var`, :code:`state`, :code:`neighbor`, :code:`session` and :code:`recent`. :italic:`query` is the expression to match. Expressions can be either a number or a regular expression, and can be :ref:`combined using Boolean operators <search_syntax>`.

    The special value :code:`all` matches all windows.

    For numeric fields: :code:`id`, :code:`pid`, :code:`num` and :code:`recent`, the expression is interpreted as a number, not a regular expression. Negative values for :code:`id` match from the highest id number down, in particular, -1 is the most recently created window.

    The field :code:`num` refers to the window position in the current tab, starting from zero and counting clockwise (this is the same as the order in which the windows are reported by the :ref:`kitten @ ls <at-ls>` command).

    The window id of the current window is available as the :envvar:`KITTY_WINDOW_ID` environment variable.

    The field :code:`recent` refers to recently active windows in the currently active tab, with zero being the currently active window, one being the previously active window and so on.

    The field :code:`neighbor` refers to a neighbor of the active window in the specified direction, which can be: :code:`left`, :code:`right`, :code:`top` or :code:`bottom`.

    The field :code:`session` matches windows that were created in the specified session. Use the expression :code:`^$` to match windows that were not created in a session and :code:`.` to match the currently active session and :code:`~` to match either the currently active sesison or the last active session when no session is active.

    When using the :code:`env` field to match on environment variables, you can specify only the environment variable name or a name and value, for example, :code:`env:MY_ENV_VAR=2`.

    Similarly, the :code:`var` field matches on user variables set on the window. You can specify name or name and value as with the :code:`env` field.

    The field :code:`state` matches on the state of the window. Supported states are: :code:`active`, :code:`focused`, :code:`needs_attention`, :code:`parent_active`, :code:`parent_focused`, :code:`self`, :code:`overlay_parent`.  Active windows are the windows that are active in their parent tab. There is only one focused window and it is the window to which keyboard events are delivered. If no window is focused, the last focused window is matched. The value :code:`self` matches the window in which the remote control command is run. The value :code:`overlay_parent` matches the window that is under the :code:`self` window, when the self window is an overlay.

    Note that you can use the :ref:`kitten @ ls <at-ls>` command to get a list of windows.

.. _at-get-text:

kitten @ get-text
------------------------------------------------------------------------------------------------------------------------
.. program:: kitten @ get-text


.. highlight:: sh
.. code-block:: sh

  kitten @ get-text [options] 

Get text from the specified window

Options
______________________________
.. option:: --match <MATCH>, -m <MATCH>

    The window to match. Match specifications are of the form: :italic:`field:query`. Where :italic:`field` can be one of: :code:`id`, :code:`title`, :code:`pid`, :code:`cwd`, :code:`cmdline`, :code:`num`, :code:`env`, :code:`var`, :code:`state`, :code:`neighbor`, :code:`session` and :code:`recent`. :italic:`query` is the expression to match. Expressions can be either a number or a regular expression, and can be :ref:`combined using Boolean operators <search_syntax>`.

    The special value :code:`all` matches all windows.

    For numeric fields: :code:`id`, :code:`pid`, :code:`num` and :code:`recent`, the expression is interpreted as a number, not a regular expression. Negative values for :code:`id` match from the highest id number down, in particular, -1 is the most recently created window.

    The field :code:`num` refers to the window position in the current tab, starting from zero and counting clockwise (this is the same as the order in which the windows are reported by the :ref:`kitten @ ls <at-ls>` command).

    The window id of the current window is available as the :envvar:`KITTY_WINDOW_ID` environment variable.

    The field :code:`recent` refers to recently active windows in the currently active tab, with zero being the currently active window, one being the previously active window and so on.

    The field :code:`neighbor` refers to a neighbor of the active window in the specified direction, which can be: :code:`left`, :code:`right`, :code:`top` or :code:`bottom`.

    The field :code:`session` matches windows that were created in the specified session. Use the expression :code:`^$` to match windows that were not created in a session and :code:`.` to match the currently active session and :code:`~` to match either the currently active sesison or the last active session when no session is active.

    When using the :code:`env` field to match on environment variables, you can specify only the environment variable name or a name and value, for example, :code:`env:MY_ENV_VAR=2`.

    Similarly, the :code:`var` field matches on user variables set on the window. You can specify name or name and value as with the :code:`env` field.

    The field :code:`state` matches on the state of the window. Supported states are: :code:`active`, :code:`focused`, :code:`needs_attention`, :code:`parent_active`, :code:`parent_focused`, :code:`self`, :code:`overlay_parent`.  Active windows are the windows that are active in their parent tab. There is only one focused window and it is the window to which keyboard events are delivered. If no window is focused, the last focused window is matched. The value :code:`self` matches the window in which the remote control command is run. The value :code:`overlay_parent` matches the window that is under the :code:`self` window, when the self window is an overlay.

    Note that you can use the :ref:`kitten @ ls <at-ls>` command to get a list of windows.

.. option:: --extent <EXTENT>

    What text to get. The default of :code:`screen` means all text currently on the screen. :code:`all` means all the screen+scrollback and :code:`selection` means the currently selected text. :code:`first_cmd_output_on_screen` means the output of the first command that was run in the window on screen. :code:`last_cmd_output` means the output of the last command that was run in the window. :code:`last_visited_cmd_output` means the first command output below the last scrolled position via scroll_to_prompt. :code:`last_non_empty_output` is the output from the last command run in the window that had some non empty output. The last four require :ref:`shell_integration` to be enabled.
    Default: :code:`screen`
    Choices: :code:`all`, :code:`first\_cmd\_output\_on\_screen`, :code:`last\_cmd\_output`, :code:`last\_non\_empty\_output`, :code:`last\_visited\_cmd\_output`, :code:`screen`, :code:`selection`

.. option:: --ansi [=no]

    By default, only plain text is returned. With this flag, the text will include the ANSI formatting escape codes for colors, bold, italic, etc.

.. option:: --add-cursor [=no]

    Add ANSI escape codes specifying the cursor position and style to the end of the text.

.. option:: --add-wrap-markers [=no]

    Add carriage returns at every line wrap location (where long lines are wrapped at screen edges).

.. option:: --clear-selection [=no]

    Clear the selection in the matched window, if any.

.. option:: --self [=no]

    Get text from the window this command is run in, rather than the active window.

.. _at-goto-layout:

kitten @ goto-layout
------------------------------------------------------------------------------------------------------------------------
.. program:: kitten @ goto-layout


.. highlight:: sh
.. code-block:: sh

  kitten @ goto-layout [options] LAYOUT_NAME

Set the window layout in the specified tabs (or the active tab if not specified). You can use special match value :code:`all` to set the layout in all tabs. In case there are multiple layouts with the same name but different options, specify the full layout definition or a unique prefix of the full definition.

Options
______________________________
.. option:: --match <MATCH>, -m <MATCH>

    The tab to match. Match specifications are of the form: :italic:`field:query`. Where :italic:`field` can be one of: :code:`id`, :code:`index`, :code:`title`, :code:`window_id`, :code:`window_title`, :code:`pid`, :code:`cwd`, :code:`cmdline` :code:`env`, :code:`var`, :code:`state`, :code:`session` and :code:`recent`. :italic:`query` is the expression to match. Expressions can be either a number or a regular expression, and can be :ref:`combined using Boolean operators <search_syntax>`.

    The special value :code:`all` matches all tabs.

    For numeric fields: :code:`id`, :code:`index`, :code:`window_id`, :code:`pid` and :code:`recent`, the expression is interpreted as a number, not a regular expression. Negative values for :code:`id`/:code:`window_id` match from the highest id number down, in particular, -1 is the most recently created tab/window.

    When using :code:`title` or :code:`id`, first a matching tab is looked for, and if not found a matching window is looked for, and the tab for that window is used.

    You can also use :code:`window_id` and :code:`window_title` to match the tab that contains the window with the specified id or title.

    The :code:`index` number is used to match the nth tab in the currently active OS window. The :code:`recent` number matches recently active tabs in the currently active OS window, with zero being the currently active tab, one the previously active tab and so on.

    The field :code:`session` matches tabs that were created in the specified session. Use the expression :code:`^$` to match windows that were not created in a session and :code:`.` to match the currently active session and :code:`~` to match either the currently active sesison or the last active session when no session is active.

    When using the :code:`env` field to match on environment variables, you can specify only the environment variable name or a name and value, for example, :code:`env:MY_ENV_VAR=2`. Tabs containing any window with the specified environment variables are matched. Similarly, :code:`var` matches tabs containing any window with the specified user variable.

    The field :code:`state` matches on the state of the tab. Supported states are: :code:`active`, :code:`focused`, :code:`needs_attention`, :code:`parent_active` and :code:`parent_focused`. Active tabs are the tabs that are active in their parent OS window. There is only one focused tab and it is the tab to which keyboard events are delivered. If no tab is focused, the last focused tab is matched.

    Note that you can use the :ref:`kitten @ ls <at-ls>` command to get a list of tabs.

.. _at-kitten:

kitten @ kitten
------------------------------------------------------------------------------------------------------------------------
.. program:: kitten @ kitten


.. highlight:: sh
.. code-block:: sh

  kitten @ kitten [options] kitten_name

Run a kitten over the specified windows (active window by default). The :italic:`kitten_name` can be either the name of a builtin kitten or the path to a Python file containing a custom kitten. If a relative path is used it is searched for in the :ref:`kitty config directory <confloc>`. If the kitten is a :italic:`no_ui` kitten and its handle response method returns a string or boolean, this is printed out to stdout.

Options
______________________________
.. option:: --match <MATCH>, -m <MATCH>

    The window to match. Match specifications are of the form: :italic:`field:query`. Where :italic:`field` can be one of: :code:`id`, :code:`title`, :code:`pid`, :code:`cwd`, :code:`cmdline`, :code:`num`, :code:`env`, :code:`var`, :code:`state`, :code:`neighbor`, :code:`session` and :code:`recent`. :italic:`query` is the expression to match. Expressions can be either a number or a regular expression, and can be :ref:`combined using Boolean operators <search_syntax>`.

    The special value :code:`all` matches all windows.

    For numeric fields: :code:`id`, :code:`pid`, :code:`num` and :code:`recent`, the expression is interpreted as a number, not a regular expression. Negative values for :code:`id` match from the highest id number down, in particular, -1 is the most recently created window.

    The field :code:`num` refers to the window position in the current tab, starting from zero and counting clockwise (this is the same as the order in which the windows are reported by the :ref:`kitten @ ls <at-ls>` command).

    The window id of the current window is available as the :envvar:`KITTY_WINDOW_ID` environment variable.

    The field :code:`recent` refers to recently active windows in the currently active tab, with zero being the currently active window, one being the previously active window and so on.

    The field :code:`neighbor` refers to a neighbor of the active window in the specified direction, which can be: :code:`left`, :code:`right`, :code:`top` or :code:`bottom`.

    The field :code:`session` matches windows that were created in the specified session. Use the expression :code:`^$` to match windows that were not created in a session and :code:`.` to match the currently active session and :code:`~` to match either the currently active sesison or the last active session when no session is active.

    When using the :code:`env` field to match on environment variables, you can specify only the environment variable name or a name and value, for example, :code:`env:MY_ENV_VAR=2`.

    Similarly, the :code:`var` field matches on user variables set on the window. You can specify name or name and value as with the :code:`env` field.

    The field :code:`state` matches on the state of the window. Supported states are: :code:`active`, :code:`focused`, :code:`needs_attention`, :code:`parent_active`, :code:`parent_focused`, :code:`self`, :code:`overlay_parent`.  Active windows are the windows that are active in their parent tab. There is only one focused window and it is the window to which keyboard events are delivered. If no window is focused, the last focused window is matched. The value :code:`self` matches the window in which the remote control command is run. The value :code:`overlay_parent` matches the window that is under the :code:`self` window, when the self window is an overlay.

    Note that you can use the :ref:`kitten @ ls <at-ls>` command to get a list of windows.

.. _at-last-used-layout:

kitten @ last-used-layout
------------------------------------------------------------------------------------------------------------------------
.. program:: kitten @ last-used-layout


.. highlight:: sh
.. code-block:: sh

  kitten @ last-used-layout [options] 

Switch to the last used window layout in the specified tabs (or the active tab if not specified).

Options
______________________________
.. option:: --all [=no], -a [=no]

    Change the layout in all tabs.

.. option:: --no-response [=no]

    Don't wait for a response from kitty. This means that even if no matching tab is found, the command will exit with a success code.
    Default: :code:`false`

.. option:: --match <MATCH>, -m <MATCH>

    The tab to match. Match specifications are of the form: :italic:`field:query`. Where :italic:`field` can be one of: :code:`id`, :code:`index`, :code:`title`, :code:`window_id`, :code:`window_title`, :code:`pid`, :code:`cwd`, :code:`cmdline` :code:`env`, :code:`var`, :code:`state`, :code:`session` and :code:`recent`. :italic:`query` is the expression to match. Expressions can be either a number or a regular expression, and can be :ref:`combined using Boolean operators <search_syntax>`.

    The special value :code:`all` matches all tabs.

    For numeric fields: :code:`id`, :code:`index`, :code:`window_id`, :code:`pid` and :code:`recent`, the expression is interpreted as a number, not a regular expression. Negative values for :code:`id`/:code:`window_id` match from the highest id number down, in particular, -1 is the most recently created tab/window.

    When using :code:`title` or :code:`id`, first a matching tab is looked for, and if not found a matching window is looked for, and the tab for that window is used.

    You can also use :code:`window_id` and :code:`window_title` to match the tab that contains the window with the specified id or title.

    The :code:`index` number is used to match the nth tab in the currently active OS window. The :code:`recent` number matches recently active tabs in the currently active OS window, with zero being the currently active tab, one the previously active tab and so on.

    The field :code:`session` matches tabs that were created in the specified session. Use the expression :code:`^$` to match windows that were not created in a session and :code:`.` to match the currently active session and :code:`~` to match either the currently active sesison or the last active session when no session is active.

    When using the :code:`env` field to match on environment variables, you can specify only the environment variable name or a name and value, for example, :code:`env:MY_ENV_VAR=2`. Tabs containing any window with the specified environment variables are matched. Similarly, :code:`var` matches tabs containing any window with the specified user variable.

    The field :code:`state` matches on the state of the tab. Supported states are: :code:`active`, :code:`focused`, :code:`needs_attention`, :code:`parent_active` and :code:`parent_focused`. Active tabs are the tabs that are active in their parent OS window. There is only one focused tab and it is the tab to which keyboard events are delivered. If no tab is focused, the last focused tab is matched.

    Note that you can use the :ref:`kitten @ ls <at-ls>` command to get a list of tabs.

.. _at-launch:

kitten @ launch
------------------------------------------------------------------------------------------------------------------------
.. program:: kitten @ launch


.. highlight:: sh
.. code-block:: sh

  kitten @ launch [options] [CMD ...]

Prints out the id of the newly opened window. Any command line arguments are assumed to be the command line used to run in the new window, if none are provided, the default shell is run. For example::

    kitten @ launch --title=Email mutt

Options
______________________________
.. option:: --match <MATCH>, -m <MATCH>

    The tab to match. Match specifications are of the form: :italic:`field:query`. Where :italic:`field` can be one of: :code:`id`, :code:`index`, :code:`title`, :code:`window_id`, :code:`window_title`, :code:`pid`, :code:`cwd`, :code:`cmdline` :code:`env`, :code:`var`, :code:`state`, :code:`session` and :code:`recent`. :italic:`query` is the expression to match. Expressions can be either a number or a regular expression, and can be :ref:`combined using Boolean operators <search_syntax>`.

    The special value :code:`all` matches all tabs.

    For numeric fields: :code:`id`, :code:`index`, :code:`window_id`, :code:`pid` and :code:`recent`, the expression is interpreted as a number, not a regular expression. Negative values for :code:`id`/:code:`window_id` match from the highest id number down, in particular, -1 is the most recently created tab/window.

    When using :code:`title` or :code:`id`, first a matching tab is looked for, and if not found a matching window is looked for, and the tab for that window is used.

    You can also use :code:`window_id` and :code:`window_title` to match the tab that contains the window with the specified id or title.

    The :code:`index` number is used to match the nth tab in the currently active OS window. The :code:`recent` number matches recently active tabs in the currently active OS window, with zero being the currently active tab, one the previously active tab and so on.

    The field :code:`session` matches tabs that were created in the specified session. Use the expression :code:`^$` to match windows that were not created in a session and :code:`.` to match the currently active session and :code:`~` to match either the currently active sesison or the last active session when no session is active.

    When using the :code:`env` field to match on environment variables, you can specify only the environment variable name or a name and value, for example, :code:`env:MY_ENV_VAR=2`. Tabs containing any window with the specified environment variables are matched. Similarly, :code:`var` matches tabs containing any window with the specified user variable.

    The field :code:`state` matches on the state of the tab. Supported states are: :code:`active`, :code:`focused`, :code:`needs_attention`, :code:`parent_active` and :code:`parent_focused`. Active tabs are the tabs that are active in their parent OS window. There is only one focused tab and it is the tab to which keyboard events are delivered. If no tab is focused, the last focused tab is matched.

    Note that you can use the :ref:`kitten @ ls <at-ls>` command to get a list of tabs.

.. option:: --wait-for-child-to-exit [=no]

    Wait until the launched program exits and print out its exit code. The exit code is printed out instead of the window id. If the program exited nromally its exit code is printed, which is always greater than or equal to zero. If the program was killed by a signal, the symbolic name of the SIGNAL is printed, if available, otherwise the signal number with a leading minus sign is printed.

.. option:: --response-timeout <RESPONSE_TIMEOUT>

    The time in seconds to wait for the started process to exit, when using the :option:`--wait-for-child-to-exit` option. Defaults to one day.
    Default: :code:`86400`

.. option:: --no-response [=no]

    Do not print out the id of the newly created window.

.. option:: --self [=no]

    If specified the tab containing the window this command is run in is used instead of the active tab

.. option:: --source-window <SOURCE_WINDOW>

    A match expression to select the window from which data such as title, colors, env vars, screen contents, etc. are copied. When not specified the currently active window is used. See :ref:`search_syntax` for the syntax used for specifying windows.

.. option:: --title <WINDOW_TITLE>, --window-title <WINDOW_TITLE>

    The title to set for the new window. By default, title is controlled by the child process. The special value :code:`current` will copy the title from the :option:`source window <launch --source-window>`.

.. option:: --tab-title <TAB_TITLE>

    The title for the new tab if launching in a new tab. By default, the title of the active window in the tab is used as the tab title. The special value :code:`current` will copy the title from the tab containing the :option:`source window <launch --source-window>`.

.. option:: --type <TYPE>

    Where to launch the child process:

    :code:`window`
        A new :term:`kitty window <window>` in the current tab

    :code:`tab`
        A new :term:`tab` in the current OS window. Not available when the :doc:`launch <launch>` command is used in :ref:`startup sessions <sessions>`.

    :code:`os-window`
        A new :term:`operating system window <os_window>`.  Not available when the :doc:`launch <launch>` command is used in :ref:`startup sessions <sessions>`.

    :code:`overlay`
        An :term:`overlay window <overlay>` covering the current active kitty window

    :code:`overlay-main`
        An :term:`overlay window <overlay>` covering the current active kitty window. Unlike a plain overlay window, this window is considered as a :italic:`main` window which means it is used as the active window for getting the current working directory, the input text for kittens, launch commands, etc. Useful if this overlay is intended to run for a long time as a primary window.

    :code:`background`
        The process will be run in the :italic:`background`, without a kitty window. Note that if :option:`kitten @ launch --allow-remote-control` is specified the :envvar:`KITTY_LISTEN_ON` environment variable will be set to a dedicated socket pair file descriptor that the process can use for remote control.

    :code:`clipboard`, :code:`primary`
        These two are meant to work with :option:`--stdin-source <launch --stdin-source>` to copy data to the :italic:`system clipboard` or :italic:`primary selection`.

    :code:`os-panel`
        Similar to :code:`os-window`, except that it creates the new OS Window as a desktop panel. Only works on platforms that support this, such as Wayand compositors that support the layer shell protocol. Use the :option:`kitten @ launch --os-panel` option to configure the panel.


    Default: :code:`window`
    Choices: :code:`background`, :code:`clipboard`, :code:`os-panel`, :code:`os-window`, :code:`overlay`, :code:`overlay-main`, :code:`primary`, :code:`tab`, :code:`window`

.. option:: --dont-take-focus [=no], --keep-focus [=no]

    Keep the focus on the currently active window instead of switching to the newly opened window.

.. option:: --cwd <CWD>

    The working directory for the newly launched child. Use the special value :code:`current` to use the working directory of the :option:`source window <launch --source-window>` The special value :code:`last_reported` uses the last working directory reported by the shell (needs :ref:`shell_integration` to work). The special value :code:`oldest` works like :code:`current` but uses the working directory of the oldest foreground process associated with the currently active window rather than the newest foreground process. Finally, the special value :code:`root` refers to the process that was originally started when the window was created.

    When opening in the same working directory as the current window causes the new window to connect to a remote host, you can use the :option:`--hold-after-ssh` flag to prevent the new window from closing when the connection is terminated.

.. option:: --add-to-session <ADD_TO_SESSION>

    Add the newly created window/tab to the specified session. Use :code:`.` to add to the session of the :option:`source window <launch --source-window>`, if any. See :ref:`sessions` for what a session is and how to use one. By default, the window is added to the session of the :option:`source window <launch --source-window>` when :option:`kitten @ launch --cwd` is set to use the the working directory from that window, otherwise the newly created window does not belong to any session. To force adding to no session, use the value :code:`!`. Adding a newly created window to a session is purely temporary, it does not change the actual session file, for that you have to resave the session. Note that using this flag in a launch command within a session file has no effect as the window is always added to the session belonging to that file.

.. option:: --env <ENV>

    Environment variables to set in the child process. Can be specified multiple times to set different environment variables. Syntax: :code:`name=value`. Using :code:`name=` will set to empty string and just :code:`name` will remove the environment variable.

.. option:: --var <VAR>

    User variables to set in the created window. Can be specified multiple times to set different user variables. Syntax: :code:`name=value`. Using :code:`name=` will set to empty string.

.. option:: --hold [=no]

    Keep the window open even after the command being executed exits, at a shell prompt. The shell will be run after the launched command exits.

.. option:: --copy-colors [=no]

    Set the colors of the newly created window to be the same as the colors in the :option:`source window <launch --source-window>`.

.. option:: --copy-cmdline [=no]

    Ignore any specified command line and instead use the command line from the :option:`source window <launch --source-window>`.

.. option:: --copy-env [=no]

    Copy the environment variables from the :option:`source window <launch --source-window>` into the newly launched child process. Note that this only copies the environment when the window was first created, as it is not possible to get updated environment variables from arbitrary processes. To copy that environment, use either the :ref:`clone-in-kitty <clone_shell>` feature or the kitty remote control feature with :option:`kitten @ launch --copy-env`.

.. option:: --location <LOCATION>

    Where to place the newly created window when it is added to a tab which already has existing windows in it. :code:`after` and :code:`before` place the new window before or after the active window. :code:`neighbor` is a synonym for :code:`after`. Also applies to creating a new tab, where the value of :code:`after` will cause the new tab to be placed next to the current tab instead of at the end. The values of :code:`vsplit`, :code:`hsplit` and :code:`split` are only used by the :code:`splits` layout and control if the new window is placed in a vertical, horizontal or automatic split with the currently active window. The default is to place the window in a layout dependent manner, typically, after the currently active window. See :option:`--next-to <launch --next-to>` to use a window other than the currently active window.
    Default: :code:`default`
    Choices: :code:`after`, :code:`before`, :code:`default`, :code:`first`, :code:`hsplit`, :code:`last`, :code:`neighbor`, :code:`split`, :code:`vsplit`

.. option:: --next-to <NEXT_TO>

    A match expression to select the window next to which the new window is created. See :ref:`search_syntax` for the syntax for specifying windows. If not specified defaults to the active window. When used via remote control and a target tab is specified this option is ignored unless the matched window is in the specified tab. When using :option:`--type <launch --type>` of :code:`tab`, the tab will be created in the OS Window containing the matched window.

.. option:: --bias <BIAS>

    The bias used to alter the size of the window. It controls what fraction of available space the window takes. The exact meaning of bias depends on the current layout.

    * Splits layout: The bias is interpreted as a percentage between 0 and 100. When splitting a window into two, the new window will take up the specified fraction of the space allotted to the original window and the original window will take up the remainder of the space.

    * Vertical/horizontal layout: The bias is interpreted as adding/subtracting from the normal size of the window. It should be a number between -90 and 90. This number is the percentage of the OS Window size that should be added to the window size. So for example, if a window would normally have been size 50 in the layout inside an OS Window that is size 80 high and --bias -10 is used it will become *approximately* size 42 high. Note that sizes are approximations, you cannot use this method to create windows of fixed sizes.

    * Tall layout: If the window being created is the *first* window in a column, then the bias is interpreted as a percentage, as for the splits layout, splitting the OS Window width between columns. If the window is a second or subsequent window in a column the bias is interpreted as adding/subtracting from the window size as for the vertical layout above.

    * Fat layout: Same as tall layout except it goes by rows instead of columns.

    * Grid layout: The bias is interpreted the same way as for the Vertical and Horizontal layouts, as something to be added/subtracted to the normal size. However, the since in a grid layout there are rows *and* columns, the bias on the first window in a column operates on the columns. Any later windows in that column operate on the row. So, for example, if you bias the first window in a grid layout it will change the width of the first column, the second window, the width of the second column, the third window, the height of the second row and so on.

    The bias option was introduced in kitty version 0.36.0.
    Default: :code:`0`

.. option:: --allow-remote-control [=no]

    Programs running in this window can control kitty (even if remote control is not enabled in :file:`kitty.conf`). Note that any program with the right level of permissions can still write to the pipes of any other program on the same computer and therefore can control kitty. It can, however, be useful to block programs running on other computers (for example, over SSH) or as other users. See :option:`--remote-control-password` for ways to restrict actions allowed by remote control.

.. option:: --remote-control-password <REMOTE_CONTROL_PASSWORD>

    Restrict the actions remote control is allowed to take. This works like :opt:`remote_control_password`. You can specify a password and list of actions just as for :opt:`remote_control_password`. For example::

        --remote-control-password '"my passphrase" get-* set-colors'

    This password will be in effect for this window only. Note that any passwords you have defined for :opt:`remote_control_password` in :file:`kitty.conf` are also in effect. You can override them by using the same password here. You can also disable all :opt:`remote_control_password` global passwords for this window, by using::

        --remote-control-password '!'

    This option only takes effect if :option:`--allow-remote-control` is also specified. Can be specified multiple times to create multiple passwords. This option was added to kitty in version 0.26.0

.. option:: --stdin-source <STDIN_SOURCE>

    Pass the screen contents as :file:`STDIN` to the child process.

    :code:`@selection`
        is the currently selected text in the :option:`source window <launch --source-window>`.

    :code:`@screen`
        is the contents of the :option:`source window <launch --source-window>`.

    :code:`@screen_scrollback`
        is the same as :code:`@screen`, but includes the scrollback buffer as well.

    :code:`@alternate`
        is the secondary screen of the :option:`source window <launch --source-window>`. For example if you run a full screen terminal application, the secondary screen will be the screen you return to when quitting the application.

    :code:`@first_cmd_output_on_screen`
        is the output from the first command run in the shell on screen.

    :code:`@last_cmd_output`
        is the output from the last command run in the shell.

    :code:`@last_visited_cmd_output`
        is the first output below the last scrolled position via :ac:`scroll_to_prompt`, this needs :ref:`shell integration <shell_integration>` to work.


    Default: :code:`none`
    Choices: :code:`@alternate`, :code:`@alternate\_scrollback`, :code:`@first\_cmd\_output\_on\_screen`, :code:`@last\_cmd\_output`, :code:`@last\_visited\_cmd\_output`, :code:`@screen`, :code:`@screen\_scrollback`, :code:`@selection`, :code:`none`

.. option:: --stdin-add-formatting [=no]

    When using :option:`--stdin-source <launch --stdin-source>` add formatting escape codes, without this only plain text will be sent.

.. option:: --stdin-add-line-wrap-markers [=no]

    When using :option:`--stdin-source <launch --stdin-source>` add a carriage return at every line wrap location (where long lines are wrapped at screen edges). This is useful if you want to pipe to program that wants to duplicate the screen layout of the screen.

.. option:: --marker <MARKER>

    Create a marker that highlights text in the newly created window. The syntax is the same as for the :ac:`toggle_marker` action (see :doc:`/marks`).

.. option:: --os-window-class <OS_WINDOW_CLASS>

    Set the :italic:`WM_CLASS` property on X11 and the application id property on Wayland for the newly created OS window when using :option:`--type=os-window <launch --type>`. Defaults to whatever is used by the parent kitty process, which in turn defaults to :code:`kitty`.

.. option:: --os-window-name <OS_WINDOW_NAME>

    Set the :italic:`WM_NAME` property on X11 for the newly created OS Window when using :option:`--type=os-window <launch --type>`. Defaults to :option:`--os-window-class <launch --os-window-class>`.

.. option:: --os-window-title <OS_WINDOW_TITLE>

    Set the title for the newly created OS window. This title will override any titles set by programs running in kitty. The special value :code:`current` will copy the title from the OS Window containing the :option:`source window <launch --source-window>`.

.. option:: --os-window-state <OS_WINDOW_STATE>

    The initial state for the newly created OS Window.
    Default: :code:`normal`
    Choices: :code:`fullscreen`, :code:`maximized`, :code:`minimized`, :code:`normal`

.. option:: --logo <LOGO>

    Path to a PNG image to use as the logo for the newly created window. See :opt:`window_logo_path`. Relative paths are resolved from the kitty configuration directory.

.. option:: --logo-position <LOGO_POSITION>

    The position for the window logo. Only takes effect if :option:`--logo` is specified. See :opt:`window_logo_position`.

.. option:: --logo-alpha <LOGO_ALPHA>

    The amount the window logo should be faded into the background. Only takes effect if :option:`--logo` is specified. See :opt:`window_logo_alpha`.
    Default: :code:`-1`

.. option:: --color <COLOR>

    Change colors in the newly launched window. You can either specify a path to a :file:`.conf` file with the same syntax as :file:`kitty.conf` to read the colors from, or specify them individually, for example::

        --color background=white --color foreground=red

.. option:: --spacing <SPACING>

    Set the margin and padding for the newly created window. For example: :code:`margin=20` or :code:`padding-left=10` or :code:`margin-h=30`. The shorthand form sets all values, the :code:`*-h` and :code:`*-v` variants set horizontal and vertical values. Can be specified multiple times. Note that this is ignored for overlay windows as these use the settings from the base window.

.. option:: --watcher <WATCHER>, -w <WATCHER>

    Path to a Python file. Appropriately named functions in this file will be called for various events, such as when the window is resized, focused or closed. See the section on watchers in the launch command documentation: :ref:`watchers`. Relative paths are resolved relative to the :ref:`kitty config directory <confloc>`. Global watchers for all windows can be specified with :opt:`watcher` in :file:`kitty.conf`.

.. option:: --os-panel <OS_PANEL>

    Options to control the creation of desktop panels. Takes the same settings as the :doc:`panel kitten </kittens/panel>`, except for :option:`--override <kitty +kitten panel --override>` and :option:`--config <kitty +kitten panel --config>`. Can be specified multiple times. For example, to create a desktop panel at the bottom of the screen two lines high::

        launch --type os-panel --os-panel lines=2 --os-panel edge=bottom sh -c "echo; echo; echo hello; sleep 5s"

.. option:: --hold-after-ssh [=no]

    When using :option:`--cwd`:code:`=current` or similar from a window that is running the ssh kitten, the new window will run a local shell after disconnecting from the remote host, when this option is specified.

.. _at-load-config:

kitten @ load-config
------------------------------------------------------------------------------------------------------------------------
.. program:: kitten @ load-config


.. highlight:: sh
.. code-block:: sh

  kitten @ load-config [options] CONF_FILE ...

(Re)load the specified kitty.conf config files(s). If no files are specified the previously specified config file is reloaded. Note that the specified paths must exist and be readable by the kitty process on the computer that process is running on. Relative paths are resolved with respect to the kitty config directory on the computer running kitty.

Options
______________________________
.. option:: --ignore-overrides [=no]

    By default, any config overrides previously specified at the kitty invocation command line or a previous load-config-file command are respected. Use this option to have them ignored instead.

.. option:: --override <OVERRIDE>, -o <OVERRIDE>

    Override individual configuration options, can be specified multiple times. Syntax: :italic:`name=value`. For example: :option:`kitty -o` font_size=20

.. option:: --no-response [=no]

    Don't wait for a response indicating the success of the action. Note that using this option means that you will not be notified of failures.
    Default: :code:`false`

.. _at-ls:

kitten @ ls
------------------------------------------------------------------------------------------------------------------------
.. program:: kitten @ ls


.. highlight:: sh
.. code-block:: sh

  kitten @ ls [options] 

List windows. The list is returned as JSON tree. The top-level is a list of operating system kitty windows. Each OS window has an :italic:`id` and a list of :italic:`tabs`. Each tab has its own :italic:`id`, a :italic:`title` and a list of :italic:`windows`. Each window has an :italic:`id`, :italic:`title`, :italic:`current working directory`, :italic:`process id (PID)`, :italic:`command-line` and :italic:`environment` of the process running in the window. Additionally, when running the command inside a kitty window, that window can be identified by the :italic:`is_self` parameter.

You can use these criteria to select windows/tabs for the other commands.

You can limit the windows/tabs in the output by using the :option:`--match` and :option:`--match-tab` options.

Options
______________________________
.. option:: --all-env-vars [=no]

    Show all environment variables in output, not just differing ones.

.. option:: --self [=no]

    Only list the window this command is run in.

.. option:: --output-format <OUTPUT_FORMAT>

    Output in JSON or kitty session format
    Default: :code:`json`
    Choices: :code:`json`, :code:`session`

.. option:: --match <MATCH>, -m <MATCH>

    The window to match. Match specifications are of the form: :italic:`field:query`. Where :italic:`field` can be one of: :code:`id`, :code:`title`, :code:`pid`, :code:`cwd`, :code:`cmdline`, :code:`num`, :code:`env`, :code:`var`, :code:`state`, :code:`neighbor`, :code:`session` and :code:`recent`. :italic:`query` is the expression to match. Expressions can be either a number or a regular expression, and can be :ref:`combined using Boolean operators <search_syntax>`.

    The special value :code:`all` matches all windows.

    For numeric fields: :code:`id`, :code:`pid`, :code:`num` and :code:`recent`, the expression is interpreted as a number, not a regular expression. Negative values for :code:`id` match from the highest id number down, in particular, -1 is the most recently created window.

    The field :code:`num` refers to the window position in the current tab, starting from zero and counting clockwise (this is the same as the order in which the windows are reported by the :ref:`kitten @ ls <at-ls>` command).

    The window id of the current window is available as the :envvar:`KITTY_WINDOW_ID` environment variable.

    The field :code:`recent` refers to recently active windows in the currently active tab, with zero being the currently active window, one being the previously active window and so on.

    The field :code:`neighbor` refers to a neighbor of the active window in the specified direction, which can be: :code:`left`, :code:`right`, :code:`top` or :code:`bottom`.

    The field :code:`session` matches windows that were created in the specified session. Use the expression :code:`^$` to match windows that were not created in a session and :code:`.` to match the currently active session and :code:`~` to match either the currently active sesison or the last active session when no session is active.

    When using the :code:`env` field to match on environment variables, you can specify only the environment variable name or a name and value, for example, :code:`env:MY_ENV_VAR=2`.

    Similarly, the :code:`var` field matches on user variables set on the window. You can specify name or name and value as with the :code:`env` field.

    The field :code:`state` matches on the state of the window. Supported states are: :code:`active`, :code:`focused`, :code:`needs_attention`, :code:`parent_active`, :code:`parent_focused`, :code:`self`, :code:`overlay_parent`.  Active windows are the windows that are active in their parent tab. There is only one focused window and it is the window to which keyboard events are delivered. If no window is focused, the last focused window is matched. The value :code:`self` matches the window in which the remote control command is run. The value :code:`overlay_parent` matches the window that is under the :code:`self` window, when the self window is an overlay.

    Note that you can use the :ref:`kitten @ ls <at-ls>` command to get a list of windows.

.. option:: --match-tab <MATCH_TAB>, -t <MATCH_TAB>

    The tab to match. Match specifications are of the form: :italic:`field:query`. Where :italic:`field` can be one of: :code:`id`, :code:`index`, :code:`title`, :code:`window_id`, :code:`window_title`, :code:`pid`, :code:`cwd`, :code:`cmdline` :code:`env`, :code:`var`, :code:`state`, :code:`session` and :code:`recent`. :italic:`query` is the expression to match. Expressions can be either a number or a regular expression, and can be :ref:`combined using Boolean operators <search_syntax>`.

    The special value :code:`all` matches all tabs.

    For numeric fields: :code:`id`, :code:`index`, :code:`window_id`, :code:`pid` and :code:`recent`, the expression is interpreted as a number, not a regular expression. Negative values for :code:`id`/:code:`window_id` match from the highest id number down, in particular, -1 is the most recently created tab/window.

    When using :code:`title` or :code:`id`, first a matching tab is looked for, and if not found a matching window is looked for, and the tab for that window is used.

    You can also use :code:`window_id` and :code:`window_title` to match the tab that contains the window with the specified id or title.

    The :code:`index` number is used to match the nth tab in the currently active OS window. The :code:`recent` number matches recently active tabs in the currently active OS window, with zero being the currently active tab, one the previously active tab and so on.

    The field :code:`session` matches tabs that were created in the specified session. Use the expression :code:`^$` to match windows that were not created in a session and :code:`.` to match the currently active session and :code:`~` to match either the currently active sesison or the last active session when no session is active.

    When using the :code:`env` field to match on environment variables, you can specify only the environment variable name or a name and value, for example, :code:`env:MY_ENV_VAR=2`. Tabs containing any window with the specified environment variables are matched. Similarly, :code:`var` matches tabs containing any window with the specified user variable.

    The field :code:`state` matches on the state of the tab. Supported states are: :code:`active`, :code:`focused`, :code:`needs_attention`, :code:`parent_active` and :code:`parent_focused`. Active tabs are the tabs that are active in their parent OS window. There is only one focused tab and it is the tab to which keyboard events are delivered. If no tab is focused, the last focused tab is matched.

    Note that you can use the :ref:`kitten @ ls <at-ls>` command to get a list of tabs.

.. _at-new-window:

kitten @ new-window
------------------------------------------------------------------------------------------------------------------------
.. program:: kitten @ new-window


.. highlight:: sh
.. code-block:: sh

  kitten @ new-window [options] [CMD ...]

DEPRECATED: Use the :ref:`launch <at-launch>` command instead.

Open a new window in the specified tab. If you use the :option:`kitten @ new-window --match` option the first matching tab is used. Otherwise the currently active tab is used. Prints out the id of the newly opened window (unless :option:`--no-response` is used). Any command line arguments are assumed to be the command line used to run in the new window, if none are provided, the default shell is run. For example::

    kitten @ new-window --title Email mutt

Options
______________________________
.. option:: --match <MATCH>, -m <MATCH>

    The tab to match. Match specifications are of the form: :italic:`field:query`. Where :italic:`field` can be one of: :code:`id`, :code:`index`, :code:`title`, :code:`window_id`, :code:`window_title`, :code:`pid`, :code:`cwd`, :code:`cmdline` :code:`env`, :code:`var`, :code:`state`, :code:`session` and :code:`recent`. :italic:`query` is the expression to match. Expressions can be either a number or a regular expression, and can be :ref:`combined using Boolean operators <search_syntax>`.

    The special value :code:`all` matches all tabs.

    For numeric fields: :code:`id`, :code:`index`, :code:`window_id`, :code:`pid` and :code:`recent`, the expression is interpreted as a number, not a regular expression. Negative values for :code:`id`/:code:`window_id` match from the highest id number down, in particular, -1 is the most recently created tab/window.

    When using :code:`title` or :code:`id`, first a matching tab is looked for, and if not found a matching window is looked for, and the tab for that window is used.

    You can also use :code:`window_id` and :code:`window_title` to match the tab that contains the window with the specified id or title.

    The :code:`index` number is used to match the nth tab in the currently active OS window. The :code:`recent` number matches recently active tabs in the currently active OS window, with zero being the currently active tab, one the previously active tab and so on.

    The field :code:`session` matches tabs that were created in the specified session. Use the expression :code:`^$` to match windows that were not created in a session and :code:`.` to match the currently active session and :code:`~` to match either the currently active sesison or the last active session when no session is active.

    When using the :code:`env` field to match on environment variables, you can specify only the environment variable name or a name and value, for example, :code:`env:MY_ENV_VAR=2`. Tabs containing any window with the specified environment variables are matched. Similarly, :code:`var` matches tabs containing any window with the specified user variable.

    The field :code:`state` matches on the state of the tab. Supported states are: :code:`active`, :code:`focused`, :code:`needs_attention`, :code:`parent_active` and :code:`parent_focused`. Active tabs are the tabs that are active in their parent OS window. There is only one focused tab and it is the tab to which keyboard events are delivered. If no tab is focused, the last focused tab is matched.

    Note that you can use the :ref:`kitten @ ls <at-ls>` command to get a list of tabs.

.. option:: --title <TITLE>

    The title for the new window. By default it will use the title set by the program running in it.

.. option:: --cwd <CWD>

    The initial working directory for the new window. Defaults to whatever the working directory for the kitty process you are talking to is.

.. option:: --dont-take-focus [=no], --keep-focus [=no]

    Keep the current window focused instead of switching to the newly opened window.

.. option:: --window-type <WINDOW_TYPE>

    What kind of window to open. A kitty window or a top-level OS window.
    Default: :code:`kitty`
    Choices: :code:`kitty`, :code:`os`

.. option:: --new-tab [=no]

    Open a new tab.

.. option:: --tab-title <TAB_TITLE>

    Set the title of the tab, when open a new tab.

.. option:: --no-response [=no]

    Don't wait for a response giving the id of the newly opened window. Note that using this option means that you will not be notified of failures and that the id of the new window will not be printed out.
    Default: :code:`false`

.. _at-remove-marker:

kitten @ remove-marker
------------------------------------------------------------------------------------------------------------------------
.. program:: kitten @ remove-marker


.. highlight:: sh
.. code-block:: sh

  kitten @ remove-marker [options] 

Remove the currently set marker, if any.

Options
______________________________
.. option:: --match <MATCH>, -m <MATCH>

    The window to match. Match specifications are of the form: :italic:`field:query`. Where :italic:`field` can be one of: :code:`id`, :code:`title`, :code:`pid`, :code:`cwd`, :code:`cmdline`, :code:`num`, :code:`env`, :code:`var`, :code:`state`, :code:`neighbor`, :code:`session` and :code:`recent`. :italic:`query` is the expression to match. Expressions can be either a number or a regular expression, and can be :ref:`combined using Boolean operators <search_syntax>`.

    The special value :code:`all` matches all windows.

    For numeric fields: :code:`id`, :code:`pid`, :code:`num` and :code:`recent`, the expression is interpreted as a number, not a regular expression. Negative values for :code:`id` match from the highest id number down, in particular, -1 is the most recently created window.

    The field :code:`num` refers to the window position in the current tab, starting from zero and counting clockwise (this is the same as the order in which the windows are reported by the :ref:`kitten @ ls <at-ls>` command).

    The window id of the current window is available as the :envvar:`KITTY_WINDOW_ID` environment variable.

    The field :code:`recent` refers to recently active windows in the currently active tab, with zero being the currently active window, one being the previously active window and so on.

    The field :code:`neighbor` refers to a neighbor of the active window in the specified direction, which can be: :code:`left`, :code:`right`, :code:`top` or :code:`bottom`.

    The field :code:`session` matches windows that were created in the specified session. Use the expression :code:`^$` to match windows that were not created in a session and :code:`.` to match the currently active session and :code:`~` to match either the currently active sesison or the last active session when no session is active.

    When using the :code:`env` field to match on environment variables, you can specify only the environment variable name or a name and value, for example, :code:`env:MY_ENV_VAR=2`.

    Similarly, the :code:`var` field matches on user variables set on the window. You can specify name or name and value as with the :code:`env` field.

    The field :code:`state` matches on the state of the window. Supported states are: :code:`active`, :code:`focused`, :code:`needs_attention`, :code:`parent_active`, :code:`parent_focused`, :code:`self`, :code:`overlay_parent`.  Active windows are the windows that are active in their parent tab. There is only one focused window and it is the window to which keyboard events are delivered. If no window is focused, the last focused window is matched. The value :code:`self` matches the window in which the remote control command is run. The value :code:`overlay_parent` matches the window that is under the :code:`self` window, when the self window is an overlay.

    Note that you can use the :ref:`kitten @ ls <at-ls>` command to get a list of windows.

.. option:: --self [=no]

    Apply marker to the window this command is run in, rather than the active window.

.. _at-resize-os-window:

kitten @ resize-os-window
------------------------------------------------------------------------------------------------------------------------
.. program:: kitten @ resize-os-window


.. highlight:: sh
.. code-block:: sh

  kitten @ resize-os-window [options] [OS Panel settings ...]

Resize (or other operations) on the specified OS Windows. Note that some window managers/environments do not allow applications to resize their windows, for example, tiling window managers.

To modify OS Panels created with the panel kitten, use :option:`--action`:code:`=:code:`os-panel``. Specify the modifications in the same syntax as used by the panel kitten, without the leading dashes. Use the :option:`--incremental` option to only change the specified panel settings. For example, move the panel to bottom edge and make it two lines tall: :code:`--action=os-panel --incremental lines=2 edge=bottom`

Options
______________________________
.. option:: --match <MATCH>, -m <MATCH>

    The window to match. Match specifications are of the form: :italic:`field:query`. Where :italic:`field` can be one of: :code:`id`, :code:`title`, :code:`pid`, :code:`cwd`, :code:`cmdline`, :code:`num`, :code:`env`, :code:`var`, :code:`state`, :code:`neighbor`, :code:`session` and :code:`recent`. :italic:`query` is the expression to match. Expressions can be either a number or a regular expression, and can be :ref:`combined using Boolean operators <search_syntax>`.

    The special value :code:`all` matches all windows.

    For numeric fields: :code:`id`, :code:`pid`, :code:`num` and :code:`recent`, the expression is interpreted as a number, not a regular expression. Negative values for :code:`id` match from the highest id number down, in particular, -1 is the most recently created window.

    The field :code:`num` refers to the window position in the current tab, starting from zero and counting clockwise (this is the same as the order in which the windows are reported by the :ref:`kitten @ ls <at-ls>` command).

    The window id of the current window is available as the :envvar:`KITTY_WINDOW_ID` environment variable.

    The field :code:`recent` refers to recently active windows in the currently active tab, with zero being the currently active window, one being the previously active window and so on.

    The field :code:`neighbor` refers to a neighbor of the active window in the specified direction, which can be: :code:`left`, :code:`right`, :code:`top` or :code:`bottom`.

    The field :code:`session` matches windows that were created in the specified session. Use the expression :code:`^$` to match windows that were not created in a session and :code:`.` to match the currently active session and :code:`~` to match either the currently active sesison or the last active session when no session is active.

    When using the :code:`env` field to match on environment variables, you can specify only the environment variable name or a name and value, for example, :code:`env:MY_ENV_VAR=2`.

    Similarly, the :code:`var` field matches on user variables set on the window. You can specify name or name and value as with the :code:`env` field.

    The field :code:`state` matches on the state of the window. Supported states are: :code:`active`, :code:`focused`, :code:`needs_attention`, :code:`parent_active`, :code:`parent_focused`, :code:`self`, :code:`overlay_parent`.  Active windows are the windows that are active in their parent tab. There is only one focused window and it is the window to which keyboard events are delivered. If no window is focused, the last focused window is matched. The value :code:`self` matches the window in which the remote control command is run. The value :code:`overlay_parent` matches the window that is under the :code:`self` window, when the self window is an overlay.

    Note that you can use the :ref:`kitten @ ls <at-ls>` command to get a list of windows.

.. option:: --action <ACTION>

    The action to perform.
    Default: :code:`resize`
    Choices: :code:`hide`, :code:`os-panel`, :code:`resize`, :code:`show`, :code:`toggle-fullscreen`, :code:`toggle-maximized`, :code:`toggle-visibility`

.. option:: --unit <UNIT>

    The unit in which to interpret specified sizes.
    Default: :code:`cells`
    Choices: :code:`cells`, :code:`pixels`

.. option:: --width <WIDTH>

    Change the width of the window. Zero leaves the width unchanged.
    Default: :code:`0`

.. option:: --height <HEIGHT>

    Change the height of the window. Zero leaves the height unchanged.
    Default: :code:`0`

.. option:: --incremental [=no]

    Treat the specified sizes as increments on the existing window size instead of absolute sizes. When using :option:`--action`:code:`=:code:`os-panel`,` only the specified settings are changed, otherwise non-specified settings keep their current value.

.. option:: --self [=no]

    Resize the window this command is run in, rather than the active window.

.. option:: --no-response [=no]

    Don't wait for a response indicating the success of the action. Note that using this option means that you will not be notified of failures.
    Default: :code:`false`

.. _at-resize-window:

kitten @ resize-window
------------------------------------------------------------------------------------------------------------------------
.. program:: kitten @ resize-window


.. highlight:: sh
.. code-block:: sh

  kitten @ resize-window [options] 

Resize the specified windows in the current layout. Note that not all layouts can resize all windows in all directions.

Options
______________________________
.. option:: --match <MATCH>, -m <MATCH>

    The window to match. Match specifications are of the form: :italic:`field:query`. Where :italic:`field` can be one of: :code:`id`, :code:`title`, :code:`pid`, :code:`cwd`, :code:`cmdline`, :code:`num`, :code:`env`, :code:`var`, :code:`state`, :code:`neighbor`, :code:`session` and :code:`recent`. :italic:`query` is the expression to match. Expressions can be either a number or a regular expression, and can be :ref:`combined using Boolean operators <search_syntax>`.

    The special value :code:`all` matches all windows.

    For numeric fields: :code:`id`, :code:`pid`, :code:`num` and :code:`recent`, the expression is interpreted as a number, not a regular expression. Negative values for :code:`id` match from the highest id number down, in particular, -1 is the most recently created window.

    The field :code:`num` refers to the window position in the current tab, starting from zero and counting clockwise (this is the same as the order in which the windows are reported by the :ref:`kitten @ ls <at-ls>` command).

    The window id of the current window is available as the :envvar:`KITTY_WINDOW_ID` environment variable.

    The field :code:`recent` refers to recently active windows in the currently active tab, with zero being the currently active window, one being the previously active window and so on.

    The field :code:`neighbor` refers to a neighbor of the active window in the specified direction, which can be: :code:`left`, :code:`right`, :code:`top` or :code:`bottom`.

    The field :code:`session` matches windows that were created in the specified session. Use the expression :code:`^$` to match windows that were not created in a session and :code:`.` to match the currently active session and :code:`~` to match either the currently active sesison or the last active session when no session is active.

    When using the :code:`env` field to match on environment variables, you can specify only the environment variable name or a name and value, for example, :code:`env:MY_ENV_VAR=2`.

    Similarly, the :code:`var` field matches on user variables set on the window. You can specify name or name and value as with the :code:`env` field.

    The field :code:`state` matches on the state of the window. Supported states are: :code:`active`, :code:`focused`, :code:`needs_attention`, :code:`parent_active`, :code:`parent_focused`, :code:`self`, :code:`overlay_parent`.  Active windows are the windows that are active in their parent tab. There is only one focused window and it is the window to which keyboard events are delivered. If no window is focused, the last focused window is matched. The value :code:`self` matches the window in which the remote control command is run. The value :code:`overlay_parent` matches the window that is under the :code:`self` window, when the self window is an overlay.

    Note that you can use the :ref:`kitten @ ls <at-ls>` command to get a list of windows.

.. option:: --increment <INCREMENT>, -i <INCREMENT>

    The number of cells to change the size by, can be negative to decrease the size.
    Default: :code:`2`

.. option:: --axis <AXIS>, -a <AXIS>

    The axis along which to resize. If :code:`horizontal`, it will make the window wider or narrower by the specified increment. If :code:`vertical`, it will make the window taller or shorter by the specified increment. The special value :code:`reset` will reset the layout to its default configuration.
    Default: :code:`horizontal`
    Choices: :code:`horizontal`, :code:`reset`, :code:`vertical`

.. option:: --self [=no]

    Resize the window this command is run in, rather than the active window.

.. _at-run:

kitten @ run
------------------------------------------------------------------------------------------------------------------------
.. program:: kitten @ run


.. highlight:: sh
.. code-block:: sh

  kitten @ run [options] CMD ...

Run the specified program on the computer in which kitty is running. When STDIN is not a TTY it is forwarded to the program as its STDIN. STDOUT and STDERR from the the program are forwarded here. The exit status of this invocation will be the exit status of the executed program. If you wish to just run a program without waiting for a response,  use @ launch --type=background instead.

Options
______________________________
.. option:: --env <ENV>

    Environment variables to set in the child process. Can be specified multiple times to set different environment variables. Syntax: :code:`name=value`. Using :code:`name=` will set to empty string and just :code:`name` will remove the environment variable.

.. option:: --allow-remote-control [=no]

    The executed program will have privileges to run remote control commands in kitty.

.. option:: --remote-control-password <REMOTE_CONTROL_PASSWORD>

    Restrict the actions remote control is allowed to take. This works like :opt:`remote_control_password`. You can specify a password and list of actions just as for :opt:`remote_control_password`. For example::

        --remote-control-password '"my passphrase" get-* set-colors'

    This password will be in effect for this window only. Note that any passwords you have defined for :opt:`remote_control_password` in :file:`kitty.conf` are also in effect. You can override them by using the same password here. You can also disable all :opt:`remote_control_password` global passwords for this window, by using::

        --remote-control-password '!'

    This option only takes effect if :option:`--allow-remote-control` is also specified. Can be specified multiple times to create multiple passwords. This option was added to kitty in version 0.26.0

.. _at-scroll-window:

kitten @ scroll-window
------------------------------------------------------------------------------------------------------------------------
.. program:: kitten @ scroll-window


.. highlight:: sh
.. code-block:: sh

  kitten @ scroll-window [options] SCROLL_AMOUNT

Scroll the specified windows, if no window is specified, scroll the window this command is run inside. :italic:`SCROLL_AMOUNT` can be either the keywords :code:`start` or :code:`end` or an argument of the form :italic:`<number>[unit][+-]`. :code:`unit` can be :code:`l` for lines, :code:`p` for pages, :code:`u` for unscroll and :code:`r` for scroll to prompt. If unspecified, :code:`l` is the default. For example, :code:`30` will scroll down 30 lines, :code:`2p-` will scroll up 2 pages and :code:`0.5p` will scroll down half page. :code:`3u` will *unscroll* by 3 lines, which means that 3 lines will move from the scrollback buffer onto the top of the screen. :code:`1r-` will scroll to the previous prompt and 1r to the next prompt. See :ac:`scroll_to_prompt` for details on how scrolling to prompt works.

Options
______________________________
.. option:: --match <MATCH>, -m <MATCH>

    The window to match. Match specifications are of the form: :italic:`field:query`. Where :italic:`field` can be one of: :code:`id`, :code:`title`, :code:`pid`, :code:`cwd`, :code:`cmdline`, :code:`num`, :code:`env`, :code:`var`, :code:`state`, :code:`neighbor`, :code:`session` and :code:`recent`. :italic:`query` is the expression to match. Expressions can be either a number or a regular expression, and can be :ref:`combined using Boolean operators <search_syntax>`.

    The special value :code:`all` matches all windows.

    For numeric fields: :code:`id`, :code:`pid`, :code:`num` and :code:`recent`, the expression is interpreted as a number, not a regular expression. Negative values for :code:`id` match from the highest id number down, in particular, -1 is the most recently created window.

    The field :code:`num` refers to the window position in the current tab, starting from zero and counting clockwise (this is the same as the order in which the windows are reported by the :ref:`kitten @ ls <at-ls>` command).

    The window id of the current window is available as the :envvar:`KITTY_WINDOW_ID` environment variable.

    The field :code:`recent` refers to recently active windows in the currently active tab, with zero being the currently active window, one being the previously active window and so on.

    The field :code:`neighbor` refers to a neighbor of the active window in the specified direction, which can be: :code:`left`, :code:`right`, :code:`top` or :code:`bottom`.

    The field :code:`session` matches windows that were created in the specified session. Use the expression :code:`^$` to match windows that were not created in a session and :code:`.` to match the currently active session and :code:`~` to match either the currently active sesison or the last active session when no session is active.

    When using the :code:`env` field to match on environment variables, you can specify only the environment variable name or a name and value, for example, :code:`env:MY_ENV_VAR=2`.

    Similarly, the :code:`var` field matches on user variables set on the window. You can specify name or name and value as with the :code:`env` field.

    The field :code:`state` matches on the state of the window. Supported states are: :code:`active`, :code:`focused`, :code:`needs_attention`, :code:`parent_active`, :code:`parent_focused`, :code:`self`, :code:`overlay_parent`.  Active windows are the windows that are active in their parent tab. There is only one focused window and it is the window to which keyboard events are delivered. If no window is focused, the last focused window is matched. The value :code:`self` matches the window in which the remote control command is run. The value :code:`overlay_parent` matches the window that is under the :code:`self` window, when the self window is an overlay.

    Note that you can use the :ref:`kitten @ ls <at-ls>` command to get a list of windows.

.. option:: --no-response [=no]

    Don't wait for a response indicating the success of the action. Note that using this option means that you will not be notified of failures.
    Default: :code:`false`

.. _at-select-window:

kitten @ select-window
------------------------------------------------------------------------------------------------------------------------
.. program:: kitten @ select-window


.. highlight:: sh
.. code-block:: sh

  kitten @ select-window [options] 

Prints out the id of the selected window. Other commands can then be chained to make use of it.

Options
______________________________
.. option:: --match <MATCH>, -m <MATCH>

    The tab to match. Match specifications are of the form: :italic:`field:query`. Where :italic:`field` can be one of: :code:`id`, :code:`index`, :code:`title`, :code:`window_id`, :code:`window_title`, :code:`pid`, :code:`cwd`, :code:`cmdline` :code:`env`, :code:`var`, :code:`state`, :code:`session` and :code:`recent`. :italic:`query` is the expression to match. Expressions can be either a number or a regular expression, and can be :ref:`combined using Boolean operators <search_syntax>`.

    The special value :code:`all` matches all tabs.

    For numeric fields: :code:`id`, :code:`index`, :code:`window_id`, :code:`pid` and :code:`recent`, the expression is interpreted as a number, not a regular expression. Negative values for :code:`id`/:code:`window_id` match from the highest id number down, in particular, -1 is the most recently created tab/window.

    When using :code:`title` or :code:`id`, first a matching tab is looked for, and if not found a matching window is looked for, and the tab for that window is used.

    You can also use :code:`window_id` and :code:`window_title` to match the tab that contains the window with the specified id or title.

    The :code:`index` number is used to match the nth tab in the currently active OS window. The :code:`recent` number matches recently active tabs in the currently active OS window, with zero being the currently active tab, one the previously active tab and so on.

    The field :code:`session` matches tabs that were created in the specified session. Use the expression :code:`^$` to match windows that were not created in a session and :code:`.` to match the currently active session and :code:`~` to match either the currently active sesison or the last active session when no session is active.

    When using the :code:`env` field to match on environment variables, you can specify only the environment variable name or a name and value, for example, :code:`env:MY_ENV_VAR=2`. Tabs containing any window with the specified environment variables are matched. Similarly, :code:`var` matches tabs containing any window with the specified user variable.

    The field :code:`state` matches on the state of the tab. Supported states are: :code:`active`, :code:`focused`, :code:`needs_attention`, :code:`parent_active` and :code:`parent_focused`. Active tabs are the tabs that are active in their parent OS window. There is only one focused tab and it is the tab to which keyboard events are delivered. If no tab is focused, the last focused tab is matched.

    Note that you can use the :ref:`kitten @ ls <at-ls>` command to get a list of tabs.

.. option:: --response-timeout <RESPONSE_TIMEOUT>

    The time in seconds to wait for the user to select a window.
    Default: :code:`60`

.. option:: --self [=no]

    Select window from the tab containing the window this command is run in, instead of the active tab.

.. option:: --title <TITLE>

    A title that will be displayed to the user to describe what this selection is for.

.. option:: --exclude-active [=no]

    Exclude the currently active window from the list of windows to pick.

.. option:: --reactivate-prev-tab [=no]

    When the selection is finished, the tab in the same OS window that was activated before the selection will be reactivated. The last activated OS window will also be refocused.

.. _at-send-key:

kitten @ send-key
------------------------------------------------------------------------------------------------------------------------
.. program:: kitten @ send-key


.. highlight:: sh
.. code-block:: sh

  kitten @ send-key [options] [KEYS TO SEND ...]

Send arbitrary key presses to specified windows. All specified keys are sent first as press events then as release events in reverse order. Keys are sent to the programs running in the windows. They are sent only if the current keyboard mode for the program supports the particular key. For example: send-key ctrl+a ctrl+b. Note that errors are not reported, for technical reasons, so send-key always succeeds, even if no key was sent to any window.

Options
______________________________
.. option:: --match <MATCH>, -m <MATCH>

    The window to match. Match specifications are of the form: :italic:`field:query`. Where :italic:`field` can be one of: :code:`id`, :code:`title`, :code:`pid`, :code:`cwd`, :code:`cmdline`, :code:`num`, :code:`env`, :code:`var`, :code:`state`, :code:`neighbor`, :code:`session` and :code:`recent`. :italic:`query` is the expression to match. Expressions can be either a number or a regular expression, and can be :ref:`combined using Boolean operators <search_syntax>`.

    The special value :code:`all` matches all windows.

    For numeric fields: :code:`id`, :code:`pid`, :code:`num` and :code:`recent`, the expression is interpreted as a number, not a regular expression. Negative values for :code:`id` match from the highest id number down, in particular, -1 is the most recently created window.

    The field :code:`num` refers to the window position in the current tab, starting from zero and counting clockwise (this is the same as the order in which the windows are reported by the :ref:`kitten @ ls <at-ls>` command).

    The window id of the current window is available as the :envvar:`KITTY_WINDOW_ID` environment variable.

    The field :code:`recent` refers to recently active windows in the currently active tab, with zero being the currently active window, one being the previously active window and so on.

    The field :code:`neighbor` refers to a neighbor of the active window in the specified direction, which can be: :code:`left`, :code:`right`, :code:`top` or :code:`bottom`.

    The field :code:`session` matches windows that were created in the specified session. Use the expression :code:`^$` to match windows that were not created in a session and :code:`.` to match the currently active session and :code:`~` to match either the currently active sesison or the last active session when no session is active.

    When using the :code:`env` field to match on environment variables, you can specify only the environment variable name or a name and value, for example, :code:`env:MY_ENV_VAR=2`.

    Similarly, the :code:`var` field matches on user variables set on the window. You can specify name or name and value as with the :code:`env` field.

    The field :code:`state` matches on the state of the window. Supported states are: :code:`active`, :code:`focused`, :code:`needs_attention`, :code:`parent_active`, :code:`parent_focused`, :code:`self`, :code:`overlay_parent`.  Active windows are the windows that are active in their parent tab. There is only one focused window and it is the window to which keyboard events are delivered. If no window is focused, the last focused window is matched. The value :code:`self` matches the window in which the remote control command is run. The value :code:`overlay_parent` matches the window that is under the :code:`self` window, when the self window is an overlay.

    Note that you can use the :ref:`kitten @ ls <at-ls>` command to get a list of windows.

.. option:: --match-tab <MATCH_TAB>, -t <MATCH_TAB>

    The tab to match. Match specifications are of the form: :italic:`field:query`. Where :italic:`field` can be one of: :code:`id`, :code:`index`, :code:`title`, :code:`window_id`, :code:`window_title`, :code:`pid`, :code:`cwd`, :code:`cmdline` :code:`env`, :code:`var`, :code:`state`, :code:`session` and :code:`recent`. :italic:`query` is the expression to match. Expressions can be either a number or a regular expression, and can be :ref:`combined using Boolean operators <search_syntax>`.

    The special value :code:`all` matches all tabs.

    For numeric fields: :code:`id`, :code:`index`, :code:`window_id`, :code:`pid` and :code:`recent`, the expression is interpreted as a number, not a regular expression. Negative values for :code:`id`/:code:`window_id` match from the highest id number down, in particular, -1 is the most recently created tab/window.

    When using :code:`title` or :code:`id`, first a matching tab is looked for, and if not found a matching window is looked for, and the tab for that window is used.

    You can also use :code:`window_id` and :code:`window_title` to match the tab that contains the window with the specified id or title.

    The :code:`index` number is used to match the nth tab in the currently active OS window. The :code:`recent` number matches recently active tabs in the currently active OS window, with zero being the currently active tab, one the previously active tab and so on.

    The field :code:`session` matches tabs that were created in the specified session. Use the expression :code:`^$` to match windows that were not created in a session and :code:`.` to match the currently active session and :code:`~` to match either the currently active sesison or the last active session when no session is active.

    When using the :code:`env` field to match on environment variables, you can specify only the environment variable name or a name and value, for example, :code:`env:MY_ENV_VAR=2`. Tabs containing any window with the specified environment variables are matched. Similarly, :code:`var` matches tabs containing any window with the specified user variable.

    The field :code:`state` matches on the state of the tab. Supported states are: :code:`active`, :code:`focused`, :code:`needs_attention`, :code:`parent_active` and :code:`parent_focused`. Active tabs are the tabs that are active in their parent OS window. There is only one focused tab and it is the tab to which keyboard events are delivered. If no tab is focused, the last focused tab is matched.

    Note that you can use the :ref:`kitten @ ls <at-ls>` command to get a list of tabs.

.. option:: --all [=no]

    Match all windows.

.. option:: --exclude-active [=no]

    Do not send text to the active window, even if it is one of the matched windows.

.. _at-send-text:

kitten @ send-text
------------------------------------------------------------------------------------------------------------------------
.. program:: kitten @ send-text


.. highlight:: sh
.. code-block:: sh

  kitten @ send-text [options] [TEXT TO SEND]

Send arbitrary text to specified windows. The text follows Python escaping rules. So you can use :link:`escapes <https://www.gnu.org/software/bash/manual/html_node/ANSI_002dC-Quoting.html>` like :code:`'\\e'` to send control codes and :code:`'\\u21fa'` to send Unicode characters. Remember to use single-quotes otherwise the backslash is interpreted as a shell escape character. If you use the :option:`kitten @ send-text --match` option the text will be sent to all matched windows. By default, text is sent to only the currently active window. Note that errors are not reported, for technical reasons, so send-text always succeeds, even if no text was sent to any window.

Options
______________________________
.. option:: --match <MATCH>, -m <MATCH>

    The window to match. Match specifications are of the form: :italic:`field:query`. Where :italic:`field` can be one of: :code:`id`, :code:`title`, :code:`pid`, :code:`cwd`, :code:`cmdline`, :code:`num`, :code:`env`, :code:`var`, :code:`state`, :code:`neighbor`, :code:`session` and :code:`recent`. :italic:`query` is the expression to match. Expressions can be either a number or a regular expression, and can be :ref:`combined using Boolean operators <search_syntax>`.

    The special value :code:`all` matches all windows.

    For numeric fields: :code:`id`, :code:`pid`, :code:`num` and :code:`recent`, the expression is interpreted as a number, not a regular expression. Negative values for :code:`id` match from the highest id number down, in particular, -1 is the most recently created window.

    The field :code:`num` refers to the window position in the current tab, starting from zero and counting clockwise (this is the same as the order in which the windows are reported by the :ref:`kitten @ ls <at-ls>` command).

    The window id of the current window is available as the :envvar:`KITTY_WINDOW_ID` environment variable.

    The field :code:`recent` refers to recently active windows in the currently active tab, with zero being the currently active window, one being the previously active window and so on.

    The field :code:`neighbor` refers to a neighbor of the active window in the specified direction, which can be: :code:`left`, :code:`right`, :code:`top` or :code:`bottom`.

    The field :code:`session` matches windows that were created in the specified session. Use the expression :code:`^$` to match windows that were not created in a session and :code:`.` to match the currently active session and :code:`~` to match either the currently active sesison or the last active session when no session is active.

    When using the :code:`env` field to match on environment variables, you can specify only the environment variable name or a name and value, for example, :code:`env:MY_ENV_VAR=2`.

    Similarly, the :code:`var` field matches on user variables set on the window. You can specify name or name and value as with the :code:`env` field.

    The field :code:`state` matches on the state of the window. Supported states are: :code:`active`, :code:`focused`, :code:`needs_attention`, :code:`parent_active`, :code:`parent_focused`, :code:`self`, :code:`overlay_parent`.  Active windows are the windows that are active in their parent tab. There is only one focused window and it is the window to which keyboard events are delivered. If no window is focused, the last focused window is matched. The value :code:`self` matches the window in which the remote control command is run. The value :code:`overlay_parent` matches the window that is under the :code:`self` window, when the self window is an overlay.

    Note that you can use the :ref:`kitten @ ls <at-ls>` command to get a list of windows.

.. option:: --match-tab <MATCH_TAB>, -t <MATCH_TAB>

    The tab to match. Match specifications are of the form: :italic:`field:query`. Where :italic:`field` can be one of: :code:`id`, :code:`index`, :code:`title`, :code:`window_id`, :code:`window_title`, :code:`pid`, :code:`cwd`, :code:`cmdline` :code:`env`, :code:`var`, :code:`state`, :code:`session` and :code:`recent`. :italic:`query` is the expression to match. Expressions can be either a number or a regular expression, and can be :ref:`combined using Boolean operators <search_syntax>`.

    The special value :code:`all` matches all tabs.

    For numeric fields: :code:`id`, :code:`index`, :code:`window_id`, :code:`pid` and :code:`recent`, the expression is interpreted as a number, not a regular expression. Negative values for :code:`id`/:code:`window_id` match from the highest id number down, in particular, -1 is the most recently created tab/window.

    When using :code:`title` or :code:`id`, first a matching tab is looked for, and if not found a matching window is looked for, and the tab for that window is used.

    You can also use :code:`window_id` and :code:`window_title` to match the tab that contains the window with the specified id or title.

    The :code:`index` number is used to match the nth tab in the currently active OS window. The :code:`recent` number matches recently active tabs in the currently active OS window, with zero being the currently active tab, one the previously active tab and so on.

    The field :code:`session` matches tabs that were created in the specified session. Use the expression :code:`^$` to match windows that were not created in a session and :code:`.` to match the currently active session and :code:`~` to match either the currently active sesison or the last active session when no session is active.

    When using the :code:`env` field to match on environment variables, you can specify only the environment variable name or a name and value, for example, :code:`env:MY_ENV_VAR=2`. Tabs containing any window with the specified environment variables are matched. Similarly, :code:`var` matches tabs containing any window with the specified user variable.

    The field :code:`state` matches on the state of the tab. Supported states are: :code:`active`, :code:`focused`, :code:`needs_attention`, :code:`parent_active` and :code:`parent_focused`. Active tabs are the tabs that are active in their parent OS window. There is only one focused tab and it is the tab to which keyboard events are delivered. If no tab is focused, the last focused tab is matched.

    Note that you can use the :ref:`kitten @ ls <at-ls>` command to get a list of tabs.

.. option:: --all [=no]

    Match all windows.

.. option:: --exclude-active [=no]

    Do not send text to the active window, even if it is one of the matched windows.

.. option:: --stdin [=no]

    Read the text to be sent from :italic:`stdin`. Note that in this case the text is sent as is, not interpreted for escapes. If stdin is a terminal, you can press :kbd:`Ctrl+D` to end reading.

.. option:: --from-file <FROM_FILE>

    Path to a file whose contents you wish to send. Note that in this case the file contents are sent as is, not interpreted for escapes.

.. option:: --bracketed-paste <BRACKETED_PASTE>

    When sending text to a window, wrap the text in bracketed paste escape codes. The default is to not do this. A value of :code:`auto` means, bracketed paste will be used only if the program running in the window has turned on bracketed paste mode.
    Default: :code:`disable`
    Choices: :code:`auto`, :code:`disable`, :code:`enable`

.. _at-set-background-image:

kitten @ set-background-image
------------------------------------------------------------------------------------------------------------------------
.. program:: kitten @ set-background-image


.. highlight:: sh
.. code-block:: sh

  kitten @ set-background-image [options] PATH_TO_PNG_IMAGE

Set the background image for the specified OS windows. You must specify the path to an image that will be used as the background. If you specify the special value :code:`none` then any existing image will be removed. Supported image formats are: PNG, JPEG, WEBP, GIF, BMP, TIFF

Options
______________________________
.. option:: --all [=no], -a [=no]

    By default, background image is only changed for the currently active OS window. This option will cause the image to be changed in all windows.

.. option:: --configured [=no], -c [=no]

    Change the configured background image which is used for new OS windows.

.. option:: --layout <LAYOUT>

    How the image should be displayed. A value of :code:`configured` will use the configured value.
    Default: :code:`configured`
    Choices: :code:`clamped`, :code:`configured`, :code:`mirror-tiled`, :code:`scaled`, :code:`tiled`

.. option:: --no-response [=no]

    Don't wait for a response from kitty. This means that even if setting the background image failed, the command will exit with a success code.
    Default: :code:`false`

.. option:: --match <MATCH>, -m <MATCH>

    The window to match. Match specifications are of the form: :italic:`field:query`. Where :italic:`field` can be one of: :code:`id`, :code:`title`, :code:`pid`, :code:`cwd`, :code:`cmdline`, :code:`num`, :code:`env`, :code:`var`, :code:`state`, :code:`neighbor`, :code:`session` and :code:`recent`. :italic:`query` is the expression to match. Expressions can be either a number or a regular expression, and can be :ref:`combined using Boolean operators <search_syntax>`.

    The special value :code:`all` matches all windows.

    For numeric fields: :code:`id`, :code:`pid`, :code:`num` and :code:`recent`, the expression is interpreted as a number, not a regular expression. Negative values for :code:`id` match from the highest id number down, in particular, -1 is the most recently created window.

    The field :code:`num` refers to the window position in the current tab, starting from zero and counting clockwise (this is the same as the order in which the windows are reported by the :ref:`kitten @ ls <at-ls>` command).

    The window id of the current window is available as the :envvar:`KITTY_WINDOW_ID` environment variable.

    The field :code:`recent` refers to recently active windows in the currently active tab, with zero being the currently active window, one being the previously active window and so on.

    The field :code:`neighbor` refers to a neighbor of the active window in the specified direction, which can be: :code:`left`, :code:`right`, :code:`top` or :code:`bottom`.

    The field :code:`session` matches windows that were created in the specified session. Use the expression :code:`^$` to match windows that were not created in a session and :code:`.` to match the currently active session and :code:`~` to match either the currently active sesison or the last active session when no session is active.

    When using the :code:`env` field to match on environment variables, you can specify only the environment variable name or a name and value, for example, :code:`env:MY_ENV_VAR=2`.

    Similarly, the :code:`var` field matches on user variables set on the window. You can specify name or name and value as with the :code:`env` field.

    The field :code:`state` matches on the state of the window. Supported states are: :code:`active`, :code:`focused`, :code:`needs_attention`, :code:`parent_active`, :code:`parent_focused`, :code:`self`, :code:`overlay_parent`.  Active windows are the windows that are active in their parent tab. There is only one focused window and it is the window to which keyboard events are delivered. If no window is focused, the last focused window is matched. The value :code:`self` matches the window in which the remote control command is run. The value :code:`overlay_parent` matches the window that is under the :code:`self` window, when the self window is an overlay.

    Note that you can use the :ref:`kitten @ ls <at-ls>` command to get a list of windows.

.. _at-set-background-opacity:

kitten @ set-background-opacity
------------------------------------------------------------------------------------------------------------------------
.. program:: kitten @ set-background-opacity


.. highlight:: sh
.. code-block:: sh

  kitten @ set-background-opacity [options] OPACITY

Set the background opacity for the specified windows. This will only work if you have turned on :opt:`dynamic_background_opacity` in :file:`kitty.conf`. The background opacity affects all kitty windows in a single OS window. For example::

    kitten @ set-background-opacity 0.5

Options
______________________________
.. option:: --all [=no], -a [=no]

    By default, background opacity are only changed for the currently active OS window. This option will cause background opacity to be changed in all windows.

.. option:: --toggle [=no]

    When specified, the background opacity for the matching OS windows will be reset to default if it is currently equal to the specified value, otherwise it will be set to the specified value.

.. option:: --match <MATCH>, -m <MATCH>

    The window to match. Match specifications are of the form: :italic:`field:query`. Where :italic:`field` can be one of: :code:`id`, :code:`title`, :code:`pid`, :code:`cwd`, :code:`cmdline`, :code:`num`, :code:`env`, :code:`var`, :code:`state`, :code:`neighbor`, :code:`session` and :code:`recent`. :italic:`query` is the expression to match. Expressions can be either a number or a regular expression, and can be :ref:`combined using Boolean operators <search_syntax>`.

    The special value :code:`all` matches all windows.

    For numeric fields: :code:`id`, :code:`pid`, :code:`num` and :code:`recent`, the expression is interpreted as a number, not a regular expression. Negative values for :code:`id` match from the highest id number down, in particular, -1 is the most recently created window.

    The field :code:`num` refers to the window position in the current tab, starting from zero and counting clockwise (this is the same as the order in which the windows are reported by the :ref:`kitten @ ls <at-ls>` command).

    The window id of the current window is available as the :envvar:`KITTY_WINDOW_ID` environment variable.

    The field :code:`recent` refers to recently active windows in the currently active tab, with zero being the currently active window, one being the previously active window and so on.

    The field :code:`neighbor` refers to a neighbor of the active window in the specified direction, which can be: :code:`left`, :code:`right`, :code:`top` or :code:`bottom`.

    The field :code:`session` matches windows that were created in the specified session. Use the expression :code:`^$` to match windows that were not created in a session and :code:`.` to match the currently active session and :code:`~` to match either the currently active sesison or the last active session when no session is active.

    When using the :code:`env` field to match on environment variables, you can specify only the environment variable name or a name and value, for example, :code:`env:MY_ENV_VAR=2`.

    Similarly, the :code:`var` field matches on user variables set on the window. You can specify name or name and value as with the :code:`env` field.

    The field :code:`state` matches on the state of the window. Supported states are: :code:`active`, :code:`focused`, :code:`needs_attention`, :code:`parent_active`, :code:`parent_focused`, :code:`self`, :code:`overlay_parent`.  Active windows are the windows that are active in their parent tab. There is only one focused window and it is the window to which keyboard events are delivered. If no window is focused, the last focused window is matched. The value :code:`self` matches the window in which the remote control command is run. The value :code:`overlay_parent` matches the window that is under the :code:`self` window, when the self window is an overlay.

    Note that you can use the :ref:`kitten @ ls <at-ls>` command to get a list of windows.

.. option:: --match-tab <MATCH_TAB>, -t <MATCH_TAB>

    The tab to match. Match specifications are of the form: :italic:`field:query`. Where :italic:`field` can be one of: :code:`id`, :code:`index`, :code:`title`, :code:`window_id`, :code:`window_title`, :code:`pid`, :code:`cwd`, :code:`cmdline` :code:`env`, :code:`var`, :code:`state`, :code:`session` and :code:`recent`. :italic:`query` is the expression to match. Expressions can be either a number or a regular expression, and can be :ref:`combined using Boolean operators <search_syntax>`.

    The special value :code:`all` matches all tabs.

    For numeric fields: :code:`id`, :code:`index`, :code:`window_id`, :code:`pid` and :code:`recent`, the expression is interpreted as a number, not a regular expression. Negative values for :code:`id`/:code:`window_id` match from the highest id number down, in particular, -1 is the most recently created tab/window.

    When using :code:`title` or :code:`id`, first a matching tab is looked for, and if not found a matching window is looked for, and the tab for that window is used.

    You can also use :code:`window_id` and :code:`window_title` to match the tab that contains the window with the specified id or title.

    The :code:`index` number is used to match the nth tab in the currently active OS window. The :code:`recent` number matches recently active tabs in the currently active OS window, with zero being the currently active tab, one the previously active tab and so on.

    The field :code:`session` matches tabs that were created in the specified session. Use the expression :code:`^$` to match windows that were not created in a session and :code:`.` to match the currently active session and :code:`~` to match either the currently active sesison or the last active session when no session is active.

    When using the :code:`env` field to match on environment variables, you can specify only the environment variable name or a name and value, for example, :code:`env:MY_ENV_VAR=2`. Tabs containing any window with the specified environment variables are matched. Similarly, :code:`var` matches tabs containing any window with the specified user variable.

    The field :code:`state` matches on the state of the tab. Supported states are: :code:`active`, :code:`focused`, :code:`needs_attention`, :code:`parent_active` and :code:`parent_focused`. Active tabs are the tabs that are active in their parent OS window. There is only one focused tab and it is the tab to which keyboard events are delivered. If no tab is focused, the last focused tab is matched.

    Note that you can use the :ref:`kitten @ ls <at-ls>` command to get a list of tabs.

.. _at-set-colors:

kitten @ set-colors
------------------------------------------------------------------------------------------------------------------------
.. program:: kitten @ set-colors


.. highlight:: sh
.. code-block:: sh

  kitten @ set-colors [options] COLOR_OR_FILE ...

Set the terminal colors for the specified windows/tabs (defaults to active window). You can either specify the path to a conf file (in the same format as :file:`kitty.conf`) to read the colors from or you can specify individual colors, for example::

    kitten @ set-colors foreground=red background=white

Options
______________________________
.. option:: --all [=no], -a [=no]

    By default, colors are only changed for the currently active window. This option will cause colors to be changed in all windows.

.. option:: --configured [=no], -c [=no]

    Also change the configured colors (i.e. the colors kitty will use for new windows or after a reset).

.. option:: --reset [=no]

    Restore all colors to the values they had at kitty startup. Note that if you specify this option, any color arguments are ignored and :option:`kitten @ set-colors --configured` and :option:`kitten @ set-colors --all` are implied.

.. option:: --match <MATCH>, -m <MATCH>

    The window to match. Match specifications are of the form: :italic:`field:query`. Where :italic:`field` can be one of: :code:`id`, :code:`title`, :code:`pid`, :code:`cwd`, :code:`cmdline`, :code:`num`, :code:`env`, :code:`var`, :code:`state`, :code:`neighbor`, :code:`session` and :code:`recent`. :italic:`query` is the expression to match. Expressions can be either a number or a regular expression, and can be :ref:`combined using Boolean operators <search_syntax>`.

    The special value :code:`all` matches all windows.

    For numeric fields: :code:`id`, :code:`pid`, :code:`num` and :code:`recent`, the expression is interpreted as a number, not a regular expression. Negative values for :code:`id` match from the highest id number down, in particular, -1 is the most recently created window.

    The field :code:`num` refers to the window position in the current tab, starting from zero and counting clockwise (this is the same as the order in which the windows are reported by the :ref:`kitten @ ls <at-ls>` command).

    The window id of the current window is available as the :envvar:`KITTY_WINDOW_ID` environment variable.

    The field :code:`recent` refers to recently active windows in the currently active tab, with zero being the currently active window, one being the previously active window and so on.

    The field :code:`neighbor` refers to a neighbor of the active window in the specified direction, which can be: :code:`left`, :code:`right`, :code:`top` or :code:`bottom`.

    The field :code:`session` matches windows that were created in the specified session. Use the expression :code:`^$` to match windows that were not created in a session and :code:`.` to match the currently active session and :code:`~` to match either the currently active sesison or the last active session when no session is active.

    When using the :code:`env` field to match on environment variables, you can specify only the environment variable name or a name and value, for example, :code:`env:MY_ENV_VAR=2`.

    Similarly, the :code:`var` field matches on user variables set on the window. You can specify name or name and value as with the :code:`env` field.

    The field :code:`state` matches on the state of the window. Supported states are: :code:`active`, :code:`focused`, :code:`needs_attention`, :code:`parent_active`, :code:`parent_focused`, :code:`self`, :code:`overlay_parent`.  Active windows are the windows that are active in their parent tab. There is only one focused window and it is the window to which keyboard events are delivered. If no window is focused, the last focused window is matched. The value :code:`self` matches the window in which the remote control command is run. The value :code:`overlay_parent` matches the window that is under the :code:`self` window, when the self window is an overlay.

    Note that you can use the :ref:`kitten @ ls <at-ls>` command to get a list of windows.

.. option:: --match-tab <MATCH_TAB>, -t <MATCH_TAB>

    The tab to match. Match specifications are of the form: :italic:`field:query`. Where :italic:`field` can be one of: :code:`id`, :code:`index`, :code:`title`, :code:`window_id`, :code:`window_title`, :code:`pid`, :code:`cwd`, :code:`cmdline` :code:`env`, :code:`var`, :code:`state`, :code:`session` and :code:`recent`. :italic:`query` is the expression to match. Expressions can be either a number or a regular expression, and can be :ref:`combined using Boolean operators <search_syntax>`.

    The special value :code:`all` matches all tabs.

    For numeric fields: :code:`id`, :code:`index`, :code:`window_id`, :code:`pid` and :code:`recent`, the expression is interpreted as a number, not a regular expression. Negative values for :code:`id`/:code:`window_id` match from the highest id number down, in particular, -1 is the most recently created tab/window.

    When using :code:`title` or :code:`id`, first a matching tab is looked for, and if not found a matching window is looked for, and the tab for that window is used.

    You can also use :code:`window_id` and :code:`window_title` to match the tab that contains the window with the specified id or title.

    The :code:`index` number is used to match the nth tab in the currently active OS window. The :code:`recent` number matches recently active tabs in the currently active OS window, with zero being the currently active tab, one the previously active tab and so on.

    The field :code:`session` matches tabs that were created in the specified session. Use the expression :code:`^$` to match windows that were not created in a session and :code:`.` to match the currently active session and :code:`~` to match either the currently active sesison or the last active session when no session is active.

    When using the :code:`env` field to match on environment variables, you can specify only the environment variable name or a name and value, for example, :code:`env:MY_ENV_VAR=2`. Tabs containing any window with the specified environment variables are matched. Similarly, :code:`var` matches tabs containing any window with the specified user variable.

    The field :code:`state` matches on the state of the tab. Supported states are: :code:`active`, :code:`focused`, :code:`needs_attention`, :code:`parent_active` and :code:`parent_focused`. Active tabs are the tabs that are active in their parent OS window. There is only one focused tab and it is the tab to which keyboard events are delivered. If no tab is focused, the last focused tab is matched.

    Note that you can use the :ref:`kitten @ ls <at-ls>` command to get a list of tabs.

.. _at-set-enabled-layouts:

kitten @ set-enabled-layouts
------------------------------------------------------------------------------------------------------------------------
.. program:: kitten @ set-enabled-layouts


.. highlight:: sh
.. code-block:: sh

  kitten @ set-enabled-layouts [options] LAYOUT ...

Set the enabled layouts in the specified tabs (or the active tab if not specified). You can use special match value :code:`all` to set the enabled layouts in all tabs. If the current layout of the tab is not included in the enabled layouts, its layout is changed to the first enabled layout.

Options
______________________________
.. option:: --match <MATCH>, -m <MATCH>

    The tab to match. Match specifications are of the form: :italic:`field:query`. Where :italic:`field` can be one of: :code:`id`, :code:`index`, :code:`title`, :code:`window_id`, :code:`window_title`, :code:`pid`, :code:`cwd`, :code:`cmdline` :code:`env`, :code:`var`, :code:`state`, :code:`session` and :code:`recent`. :italic:`query` is the expression to match. Expressions can be either a number or a regular expression, and can be :ref:`combined using Boolean operators <search_syntax>`.

    The special value :code:`all` matches all tabs.

    For numeric fields: :code:`id`, :code:`index`, :code:`window_id`, :code:`pid` and :code:`recent`, the expression is interpreted as a number, not a regular expression. Negative values for :code:`id`/:code:`window_id` match from the highest id number down, in particular, -1 is the most recently created tab/window.

    When using :code:`title` or :code:`id`, first a matching tab is looked for, and if not found a matching window is looked for, and the tab for that window is used.

    You can also use :code:`window_id` and :code:`window_title` to match the tab that contains the window with the specified id or title.

    The :code:`index` number is used to match the nth tab in the currently active OS window. The :code:`recent` number matches recently active tabs in the currently active OS window, with zero being the currently active tab, one the previously active tab and so on.

    The field :code:`session` matches tabs that were created in the specified session. Use the expression :code:`^$` to match windows that were not created in a session and :code:`.` to match the currently active session and :code:`~` to match either the currently active sesison or the last active session when no session is active.

    When using the :code:`env` field to match on environment variables, you can specify only the environment variable name or a name and value, for example, :code:`env:MY_ENV_VAR=2`. Tabs containing any window with the specified environment variables are matched. Similarly, :code:`var` matches tabs containing any window with the specified user variable.

    The field :code:`state` matches on the state of the tab. Supported states are: :code:`active`, :code:`focused`, :code:`needs_attention`, :code:`parent_active` and :code:`parent_focused`. Active tabs are the tabs that are active in their parent OS window. There is only one focused tab and it is the tab to which keyboard events are delivered. If no tab is focused, the last focused tab is matched.

    Note that you can use the :ref:`kitten @ ls <at-ls>` command to get a list of tabs.

.. option:: --configured [=no]

    Change the default enabled layout value so that the new value takes effect for all newly created tabs as well.

.. _at-set-font-size:

kitten @ set-font-size
------------------------------------------------------------------------------------------------------------------------
.. program:: kitten @ set-font-size


.. highlight:: sh
.. code-block:: sh

  kitten @ set-font-size [options] FONT_SIZE

Sets the font size to the specified size, in pts. Note that in kitty all sub-windows in the same OS window must have the same font size. A value of zero resets the font size to default. Prefixing the value with a :code:`+`, :code:`-`, :code:`*` or :code:`/` changes the font size by the specified amount. Use -- before using - to have it not mistaken for a option. For example: kitten @ set-font-size -- -2

Options
______________________________
.. option:: --all [=no], -a [=no]

    By default, the font size is only changed in the active OS window, this option will cause it to be changed in all OS windows. It also changes the font size for any newly created OS Windows in the future.

.. _at-set-spacing:

kitten @ set-spacing
------------------------------------------------------------------------------------------------------------------------
.. program:: kitten @ set-spacing


.. highlight:: sh
.. code-block:: sh

  kitten @ set-spacing [options] MARGIN_OR_PADDING ...

Set the paddings and margins for the specified windows (defaults to active window). For example: :code:`margin=20` or :code:`padding-left=10` or :code:`margin-h=30`. The shorthand form sets all values, the :code:`*-h` and :code:`*-v` variants set horizontal and vertical values. The special value :code:`default` resets to using the default value. If you specify a tab rather than a window, all windows in that tab are affected.

Options
______________________________
.. option:: --all [=no], -a [=no]

    By default, settings are only changed for the currently active window. This option will cause paddings and margins to be changed in all windows.

.. option:: --configured [=no], -c [=no]

    Also change the configured paddings and margins (i.e. the settings kitty will use for new windows).

.. option:: --match <MATCH>, -m <MATCH>

    The window to match. Match specifications are of the form: :italic:`field:query`. Where :italic:`field` can be one of: :code:`id`, :code:`title`, :code:`pid`, :code:`cwd`, :code:`cmdline`, :code:`num`, :code:`env`, :code:`var`, :code:`state`, :code:`neighbor`, :code:`session` and :code:`recent`. :italic:`query` is the expression to match. Expressions can be either a number or a regular expression, and can be :ref:`combined using Boolean operators <search_syntax>`.

    The special value :code:`all` matches all windows.

    For numeric fields: :code:`id`, :code:`pid`, :code:`num` and :code:`recent`, the expression is interpreted as a number, not a regular expression. Negative values for :code:`id` match from the highest id number down, in particular, -1 is the most recently created window.

    The field :code:`num` refers to the window position in the current tab, starting from zero and counting clockwise (this is the same as the order in which the windows are reported by the :ref:`kitten @ ls <at-ls>` command).

    The window id of the current window is available as the :envvar:`KITTY_WINDOW_ID` environment variable.

    The field :code:`recent` refers to recently active windows in the currently active tab, with zero being the currently active window, one being the previously active window and so on.

    The field :code:`neighbor` refers to a neighbor of the active window in the specified direction, which can be: :code:`left`, :code:`right`, :code:`top` or :code:`bottom`.

    The field :code:`session` matches windows that were created in the specified session. Use the expression :code:`^$` to match windows that were not created in a session and :code:`.` to match the currently active session and :code:`~` to match either the currently active sesison or the last active session when no session is active.

    When using the :code:`env` field to match on environment variables, you can specify only the environment variable name or a name and value, for example, :code:`env:MY_ENV_VAR=2`.

    Similarly, the :code:`var` field matches on user variables set on the window. You can specify name or name and value as with the :code:`env` field.

    The field :code:`state` matches on the state of the window. Supported states are: :code:`active`, :code:`focused`, :code:`needs_attention`, :code:`parent_active`, :code:`parent_focused`, :code:`self`, :code:`overlay_parent`.  Active windows are the windows that are active in their parent tab. There is only one focused window and it is the window to which keyboard events are delivered. If no window is focused, the last focused window is matched. The value :code:`self` matches the window in which the remote control command is run. The value :code:`overlay_parent` matches the window that is under the :code:`self` window, when the self window is an overlay.

    Note that you can use the :ref:`kitten @ ls <at-ls>` command to get a list of windows.

.. option:: --match-tab <MATCH_TAB>, -t <MATCH_TAB>

    The tab to match. Match specifications are of the form: :italic:`field:query`. Where :italic:`field` can be one of: :code:`id`, :code:`index`, :code:`title`, :code:`window_id`, :code:`window_title`, :code:`pid`, :code:`cwd`, :code:`cmdline` :code:`env`, :code:`var`, :code:`state`, :code:`session` and :code:`recent`. :italic:`query` is the expression to match. Expressions can be either a number or a regular expression, and can be :ref:`combined using Boolean operators <search_syntax>`.

    The special value :code:`all` matches all tabs.

    For numeric fields: :code:`id`, :code:`index`, :code:`window_id`, :code:`pid` and :code:`recent`, the expression is interpreted as a number, not a regular expression. Negative values for :code:`id`/:code:`window_id` match from the highest id number down, in particular, -1 is the most recently created tab/window.

    When using :code:`title` or :code:`id`, first a matching tab is looked for, and if not found a matching window is looked for, and the tab for that window is used.

    You can also use :code:`window_id` and :code:`window_title` to match the tab that contains the window with the specified id or title.

    The :code:`index` number is used to match the nth tab in the currently active OS window. The :code:`recent` number matches recently active tabs in the currently active OS window, with zero being the currently active tab, one the previously active tab and so on.

    The field :code:`session` matches tabs that were created in the specified session. Use the expression :code:`^$` to match windows that were not created in a session and :code:`.` to match the currently active session and :code:`~` to match either the currently active sesison or the last active session when no session is active.

    When using the :code:`env` field to match on environment variables, you can specify only the environment variable name or a name and value, for example, :code:`env:MY_ENV_VAR=2`. Tabs containing any window with the specified environment variables are matched. Similarly, :code:`var` matches tabs containing any window with the specified user variable.

    The field :code:`state` matches on the state of the tab. Supported states are: :code:`active`, :code:`focused`, :code:`needs_attention`, :code:`parent_active` and :code:`parent_focused`. Active tabs are the tabs that are active in their parent OS window. There is only one focused tab and it is the tab to which keyboard events are delivered. If no tab is focused, the last focused tab is matched.

    Note that you can use the :ref:`kitten @ ls <at-ls>` command to get a list of tabs.

.. _at-set-tab-color:

kitten @ set-tab-color
------------------------------------------------------------------------------------------------------------------------
.. program:: kitten @ set-tab-color


.. highlight:: sh
.. code-block:: sh

  kitten @ set-tab-color [options] COLORS


Change the color of the specified tabs in the tab bar

The foreground and background colors when active and inactive can be overridden using this command. The syntax for specifying colors is: active_fg=color active_bg=color inactive_fg=color inactive_bg=color. Where color can be either a color name or a value of the form #rrggbb or the keyword NONE to revert to using the default colors.


Options
______________________________
.. option:: --match <MATCH>, -m <MATCH>

    The tab to match. Match specifications are of the form: :italic:`field:query`. Where :italic:`field` can be one of: :code:`id`, :code:`index`, :code:`title`, :code:`window_id`, :code:`window_title`, :code:`pid`, :code:`cwd`, :code:`cmdline` :code:`env`, :code:`var`, :code:`state`, :code:`session` and :code:`recent`. :italic:`query` is the expression to match. Expressions can be either a number or a regular expression, and can be :ref:`combined using Boolean operators <search_syntax>`.

    The special value :code:`all` matches all tabs.

    For numeric fields: :code:`id`, :code:`index`, :code:`window_id`, :code:`pid` and :code:`recent`, the expression is interpreted as a number, not a regular expression. Negative values for :code:`id`/:code:`window_id` match from the highest id number down, in particular, -1 is the most recently created tab/window.

    When using :code:`title` or :code:`id`, first a matching tab is looked for, and if not found a matching window is looked for, and the tab for that window is used.

    You can also use :code:`window_id` and :code:`window_title` to match the tab that contains the window with the specified id or title.

    The :code:`index` number is used to match the nth tab in the currently active OS window. The :code:`recent` number matches recently active tabs in the currently active OS window, with zero being the currently active tab, one the previously active tab and so on.

    The field :code:`session` matches tabs that were created in the specified session. Use the expression :code:`^$` to match windows that were not created in a session and :code:`.` to match the currently active session and :code:`~` to match either the currently active sesison or the last active session when no session is active.

    When using the :code:`env` field to match on environment variables, you can specify only the environment variable name or a name and value, for example, :code:`env:MY_ENV_VAR=2`. Tabs containing any window with the specified environment variables are matched. Similarly, :code:`var` matches tabs containing any window with the specified user variable.

    The field :code:`state` matches on the state of the tab. Supported states are: :code:`active`, :code:`focused`, :code:`needs_attention`, :code:`parent_active` and :code:`parent_focused`. Active tabs are the tabs that are active in their parent OS window. There is only one focused tab and it is the tab to which keyboard events are delivered. If no tab is focused, the last focused tab is matched.

    Note that you can use the :ref:`kitten @ ls <at-ls>` command to get a list of tabs.

.. option:: --self [=no]

    Close the tab this command is run in, rather than the active tab.

.. _at-set-tab-title:

kitten @ set-tab-title
------------------------------------------------------------------------------------------------------------------------
.. program:: kitten @ set-tab-title


.. highlight:: sh
.. code-block:: sh

  kitten @ set-tab-title [options] TITLE ...

Set the title for the specified tabs. If you use the :option:`kitten @ set-tab-title --match` option the title will be set for all matched tabs. By default, only the tab in which the command is run is affected. If you do not specify a title, the title of the currently active window in the tab is used.

Options
______________________________
.. option:: --match <MATCH>, -m <MATCH>

    The tab to match. Match specifications are of the form: :italic:`field:query`. Where :italic:`field` can be one of: :code:`id`, :code:`index`, :code:`title`, :code:`window_id`, :code:`window_title`, :code:`pid`, :code:`cwd`, :code:`cmdline` :code:`env`, :code:`var`, :code:`state`, :code:`session` and :code:`recent`. :italic:`query` is the expression to match. Expressions can be either a number or a regular expression, and can be :ref:`combined using Boolean operators <search_syntax>`.

    The special value :code:`all` matches all tabs.

    For numeric fields: :code:`id`, :code:`index`, :code:`window_id`, :code:`pid` and :code:`recent`, the expression is interpreted as a number, not a regular expression. Negative values for :code:`id`/:code:`window_id` match from the highest id number down, in particular, -1 is the most recently created tab/window.

    When using :code:`title` or :code:`id`, first a matching tab is looked for, and if not found a matching window is looked for, and the tab for that window is used.

    You can also use :code:`window_id` and :code:`window_title` to match the tab that contains the window with the specified id or title.

    The :code:`index` number is used to match the nth tab in the currently active OS window. The :code:`recent` number matches recently active tabs in the currently active OS window, with zero being the currently active tab, one the previously active tab and so on.

    The field :code:`session` matches tabs that were created in the specified session. Use the expression :code:`^$` to match windows that were not created in a session and :code:`.` to match the currently active session and :code:`~` to match either the currently active sesison or the last active session when no session is active.

    When using the :code:`env` field to match on environment variables, you can specify only the environment variable name or a name and value, for example, :code:`env:MY_ENV_VAR=2`. Tabs containing any window with the specified environment variables are matched. Similarly, :code:`var` matches tabs containing any window with the specified user variable.

    The field :code:`state` matches on the state of the tab. Supported states are: :code:`active`, :code:`focused`, :code:`needs_attention`, :code:`parent_active` and :code:`parent_focused`. Active tabs are the tabs that are active in their parent OS window. There is only one focused tab and it is the tab to which keyboard events are delivered. If no tab is focused, the last focused tab is matched.

    Note that you can use the :ref:`kitten @ ls <at-ls>` command to get a list of tabs.

.. _at-set-user-vars:

kitten @ set-user-vars
------------------------------------------------------------------------------------------------------------------------
.. program:: kitten @ set-user-vars


.. highlight:: sh
.. code-block:: sh

  kitten @ set-user-vars [options] [NAME=VALUE ...]

Set user variables for the specified windows. If you use the :option:`kitten @ set-user-vars --match` option the variables will be set for all matched windows. By default, only the window in which the command is run is affected. If you do not specify any variables, the current variables are printed out, one per line. To unset a variable specify just its name.

Options
______________________________
.. option:: --match <MATCH>, -m <MATCH>

    The window to match. Match specifications are of the form: :italic:`field:query`. Where :italic:`field` can be one of: :code:`id`, :code:`title`, :code:`pid`, :code:`cwd`, :code:`cmdline`, :code:`num`, :code:`env`, :code:`var`, :code:`state`, :code:`neighbor`, :code:`session` and :code:`recent`. :italic:`query` is the expression to match. Expressions can be either a number or a regular expression, and can be :ref:`combined using Boolean operators <search_syntax>`.

    The special value :code:`all` matches all windows.

    For numeric fields: :code:`id`, :code:`pid`, :code:`num` and :code:`recent`, the expression is interpreted as a number, not a regular expression. Negative values for :code:`id` match from the highest id number down, in particular, -1 is the most recently created window.

    The field :code:`num` refers to the window position in the current tab, starting from zero and counting clockwise (this is the same as the order in which the windows are reported by the :ref:`kitten @ ls <at-ls>` command).

    The window id of the current window is available as the :envvar:`KITTY_WINDOW_ID` environment variable.

    The field :code:`recent` refers to recently active windows in the currently active tab, with zero being the currently active window, one being the previously active window and so on.

    The field :code:`neighbor` refers to a neighbor of the active window in the specified direction, which can be: :code:`left`, :code:`right`, :code:`top` or :code:`bottom`.

    The field :code:`session` matches windows that were created in the specified session. Use the expression :code:`^$` to match windows that were not created in a session and :code:`.` to match the currently active session and :code:`~` to match either the currently active sesison or the last active session when no session is active.

    When using the :code:`env` field to match on environment variables, you can specify only the environment variable name or a name and value, for example, :code:`env:MY_ENV_VAR=2`.

    Similarly, the :code:`var` field matches on user variables set on the window. You can specify name or name and value as with the :code:`env` field.

    The field :code:`state` matches on the state of the window. Supported states are: :code:`active`, :code:`focused`, :code:`needs_attention`, :code:`parent_active`, :code:`parent_focused`, :code:`self`, :code:`overlay_parent`.  Active windows are the windows that are active in their parent tab. There is only one focused window and it is the window to which keyboard events are delivered. If no window is focused, the last focused window is matched. The value :code:`self` matches the window in which the remote control command is run. The value :code:`overlay_parent` matches the window that is under the :code:`self` window, when the self window is an overlay.

    Note that you can use the :ref:`kitten @ ls <at-ls>` command to get a list of windows.

.. _at-set-window-logo:

kitten @ set-window-logo
------------------------------------------------------------------------------------------------------------------------
.. program:: kitten @ set-window-logo


.. highlight:: sh
.. code-block:: sh

  kitten @ set-window-logo [options] PATH_TO_PNG_IMAGE

Set the logo image for the specified windows. You must specify the path to an image that will be used as the logo. If you specify the special value :code:`none` then any existing logo will be removed. Supported image formats are: PNG, JPEG, WEBP, GIF, BMP, TIFF

Options
______________________________
.. option:: --match <MATCH>, -m <MATCH>

    The window to match. Match specifications are of the form: :italic:`field:query`. Where :italic:`field` can be one of: :code:`id`, :code:`title`, :code:`pid`, :code:`cwd`, :code:`cmdline`, :code:`num`, :code:`env`, :code:`var`, :code:`state`, :code:`neighbor`, :code:`session` and :code:`recent`. :italic:`query` is the expression to match. Expressions can be either a number or a regular expression, and can be :ref:`combined using Boolean operators <search_syntax>`.

    The special value :code:`all` matches all windows.

    For numeric fields: :code:`id`, :code:`pid`, :code:`num` and :code:`recent`, the expression is interpreted as a number, not a regular expression. Negative values for :code:`id` match from the highest id number down, in particular, -1 is the most recently created window.

    The field :code:`num` refers to the window position in the current tab, starting from zero and counting clockwise (this is the same as the order in which the windows are reported by the :ref:`kitten @ ls <at-ls>` command).

    The window id of the current window is available as the :envvar:`KITTY_WINDOW_ID` environment variable.

    The field :code:`recent` refers to recently active windows in the currently active tab, with zero being the currently active window, one being the previously active window and so on.

    The field :code:`neighbor` refers to a neighbor of the active window in the specified direction, which can be: :code:`left`, :code:`right`, :code:`top` or :code:`bottom`.

    The field :code:`session` matches windows that were created in the specified session. Use the expression :code:`^$` to match windows that were not created in a session and :code:`.` to match the currently active session and :code:`~` to match either the currently active sesison or the last active session when no session is active.

    When using the :code:`env` field to match on environment variables, you can specify only the environment variable name or a name and value, for example, :code:`env:MY_ENV_VAR=2`.

    Similarly, the :code:`var` field matches on user variables set on the window. You can specify name or name and value as with the :code:`env` field.

    The field :code:`state` matches on the state of the window. Supported states are: :code:`active`, :code:`focused`, :code:`needs_attention`, :code:`parent_active`, :code:`parent_focused`, :code:`self`, :code:`overlay_parent`.  Active windows are the windows that are active in their parent tab. There is only one focused window and it is the window to which keyboard events are delivered. If no window is focused, the last focused window is matched. The value :code:`self` matches the window in which the remote control command is run. The value :code:`overlay_parent` matches the window that is under the :code:`self` window, when the self window is an overlay.

    Note that you can use the :ref:`kitten @ ls <at-ls>` command to get a list of windows.

.. option:: --self [=no]

    Act on the window this command is run in, rather than the active window.

.. option:: --position <POSITION>

    The position for the window logo. See :opt:`window_logo_position`.

.. option:: --alpha <ALPHA>

    The amount the window logo should be faded into the background. See :opt:`window_logo_position`.
    Default: :code:`-1`

.. option:: --no-response [=no]

    Don't wait for a response from kitty. This means that even if setting the image failed, the command will exit with a success code.
    Default: :code:`false`

.. _at-set-window-title:

kitten @ set-window-title
------------------------------------------------------------------------------------------------------------------------
.. program:: kitten @ set-window-title


.. highlight:: sh
.. code-block:: sh

  kitten @ set-window-title [options] [TITLE ...]

Set the title for the specified windows. If you use the :option:`kitten @ set-window-title --match` option the title will be set for all matched windows. By default, only the window in which the command is run is affected. If you do not specify a title, the last title set by the child process running in the window will be used.

Options
______________________________
.. option:: --temporary [=no]

    By default, the title will be permanently changed and programs running in the window will not be able to change it again. If you want to allow other programs to change it afterwards, use this option.

.. option:: --match <MATCH>, -m <MATCH>

    The window to match. Match specifications are of the form: :italic:`field:query`. Where :italic:`field` can be one of: :code:`id`, :code:`title`, :code:`pid`, :code:`cwd`, :code:`cmdline`, :code:`num`, :code:`env`, :code:`var`, :code:`state`, :code:`neighbor`, :code:`session` and :code:`recent`. :italic:`query` is the expression to match. Expressions can be either a number or a regular expression, and can be :ref:`combined using Boolean operators <search_syntax>`.

    The special value :code:`all` matches all windows.

    For numeric fields: :code:`id`, :code:`pid`, :code:`num` and :code:`recent`, the expression is interpreted as a number, not a regular expression. Negative values for :code:`id` match from the highest id number down, in particular, -1 is the most recently created window.

    The field :code:`num` refers to the window position in the current tab, starting from zero and counting clockwise (this is the same as the order in which the windows are reported by the :ref:`kitten @ ls <at-ls>` command).

    The window id of the current window is available as the :envvar:`KITTY_WINDOW_ID` environment variable.

    The field :code:`recent` refers to recently active windows in the currently active tab, with zero being the currently active window, one being the previously active window and so on.

    The field :code:`neighbor` refers to a neighbor of the active window in the specified direction, which can be: :code:`left`, :code:`right`, :code:`top` or :code:`bottom`.

    The field :code:`session` matches windows that were created in the specified session. Use the expression :code:`^$` to match windows that were not created in a session and :code:`.` to match the currently active session and :code:`~` to match either the currently active sesison or the last active session when no session is active.

    When using the :code:`env` field to match on environment variables, you can specify only the environment variable name or a name and value, for example, :code:`env:MY_ENV_VAR=2`.

    Similarly, the :code:`var` field matches on user variables set on the window. You can specify name or name and value as with the :code:`env` field.

    The field :code:`state` matches on the state of the window. Supported states are: :code:`active`, :code:`focused`, :code:`needs_attention`, :code:`parent_active`, :code:`parent_focused`, :code:`self`, :code:`overlay_parent`.  Active windows are the windows that are active in their parent tab. There is only one focused window and it is the window to which keyboard events are delivered. If no window is focused, the last focused window is matched. The value :code:`self` matches the window in which the remote control command is run. The value :code:`overlay_parent` matches the window that is under the :code:`self` window, when the self window is an overlay.

    Note that you can use the :ref:`kitten @ ls <at-ls>` command to get a list of windows.

.. _at-signal-child:

kitten @ signal-child
------------------------------------------------------------------------------------------------------------------------
.. program:: kitten @ signal-child


.. highlight:: sh
.. code-block:: sh

  kitten @ signal-child [options] [SIGNAL_NAME ...]

Send one or more signals to the foreground process in the specified windows. If you use the :option:`kitten @ signal-child --match` option the signal will be sent for all matched windows. By default, only the active window is affected. If you do not specify any signals, :code:`SIGINT` is sent by default. You can also map :ac:`signal_child` to a shortcut in :file:`kitty.conf`, for example::

    map f1 signal_child SIGTERM

Options
______________________________
.. option:: --no-response [=no]

    Don't wait for a response indicating the success of the action. Note that using this option means that you will not be notified of failures.
    Default: :code:`false`

.. option:: --match <MATCH>, -m <MATCH>

    The window to match. Match specifications are of the form: :italic:`field:query`. Where :italic:`field` can be one of: :code:`id`, :code:`title`, :code:`pid`, :code:`cwd`, :code:`cmdline`, :code:`num`, :code:`env`, :code:`var`, :code:`state`, :code:`neighbor`, :code:`session` and :code:`recent`. :italic:`query` is the expression to match. Expressions can be either a number or a regular expression, and can be :ref:`combined using Boolean operators <search_syntax>`.

    The special value :code:`all` matches all windows.

    For numeric fields: :code:`id`, :code:`pid`, :code:`num` and :code:`recent`, the expression is interpreted as a number, not a regular expression. Negative values for :code:`id` match from the highest id number down, in particular, -1 is the most recently created window.

    The field :code:`num` refers to the window position in the current tab, starting from zero and counting clockwise (this is the same as the order in which the windows are reported by the :ref:`kitten @ ls <at-ls>` command).

    The window id of the current window is available as the :envvar:`KITTY_WINDOW_ID` environment variable.

    The field :code:`recent` refers to recently active windows in the currently active tab, with zero being the currently active window, one being the previously active window and so on.

    The field :code:`neighbor` refers to a neighbor of the active window in the specified direction, which can be: :code:`left`, :code:`right`, :code:`top` or :code:`bottom`.

    The field :code:`session` matches windows that were created in the specified session. Use the expression :code:`^$` to match windows that were not created in a session and :code:`.` to match the currently active session and :code:`~` to match either the currently active sesison or the last active session when no session is active.

    When using the :code:`env` field to match on environment variables, you can specify only the environment variable name or a name and value, for example, :code:`env:MY_ENV_VAR=2`.

    Similarly, the :code:`var` field matches on user variables set on the window. You can specify name or name and value as with the :code:`env` field.

    The field :code:`state` matches on the state of the window. Supported states are: :code:`active`, :code:`focused`, :code:`needs_attention`, :code:`parent_active`, :code:`parent_focused`, :code:`self`, :code:`overlay_parent`.  Active windows are the windows that are active in their parent tab. There is only one focused window and it is the window to which keyboard events are delivered. If no window is focused, the last focused window is matched. The value :code:`self` matches the window in which the remote control command is run. The value :code:`overlay_parent` matches the window that is under the :code:`self` window, when the self window is an overlay.

    Note that you can use the :ref:`kitten @ ls <at-ls>` command to get a list of windows.

