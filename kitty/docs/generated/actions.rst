
.. _action-group-cp:

Copy/paste
----------


.. action:: clear_selection

Clear the current selection


.. action:: copy_and_clear_or_interrupt

Copy the selected text from the active window to the clipboard and clear selection, if no selection, send SIGINT (aka :kbd:`ctrl+c`)


.. action:: copy_ansi_to_clipboard

Copy the selected text from the active window to the clipboard with ANSI formatting codes


.. action:: copy_or_interrupt

Copy the selected text from the active window to the clipboard, if no selection, send SIGINT (aka :kbd:`ctrl+c`)


.. action:: copy_or_noop

Copy the selected text from the active window to the clipboard, if no selection, pass the key through to the application running in the terminal.


Default shortcuts using this action:
:sc:`kitty.copy_or_noop`

.. action:: copy_to_clipboard

Copy the selected text from the active window to the clipboard


Default shortcuts using this action:
:sc:`kitty.copy_to_clipboard`

.. action:: pass_selection_to_program

Pass the selected text from the active window to the specified program


Default shortcuts using this action:
:sc:`kitty.pass_selection_to_program`

.. action:: paste

Paste the specified text into the current window. ANSI C escapes are decoded.


.. action:: show_first_command_output_on_screen

Show output from the first shell command on screen in a pager like less

Requires :ref:`shell_integration` to work

.. action:: show_last_command_output

Show output from the last shell command in a pager like less

Requires :ref:`shell_integration` to work

Default shortcuts using this action:
:sc:`kitty.show_last_command_output`

.. action:: show_last_non_empty_command_output

Show the last non-empty output from a shell command in a pager like less

Requires :ref:`shell_integration` to work

.. action:: show_last_visited_command_output

Show the first command output below the last scrolled position via scroll_to_prompt

or the last mouse clicked command output in a pager like less

Requires :ref:`shell_integration` to work

.. action:: show_scrollback

Show scrollback in a pager like less


Default shortcuts using this action:
:sc:`kitty.show_scrollback`

.. action:: copy_to_buffer

Copy the selection from the active window to the specified buffer

See :ref:`cpbuf` for details.

.. action:: paste_from_buffer

Paste from the specified buffer to the active window

See :ref:`cpbuf` for details.

.. action:: paste_from_clipboard

Paste from the clipboard to the active window


Default shortcuts using this action:
:sc:`kitty.paste_from_clipboard`

.. action:: paste_from_selection

Paste from the primary selection, if present, otherwise the clipboard to the active window


Default shortcuts using this action:
:sc:`kitty.paste_from_selection`

.. _action-group-debug:

Debugging
---------


.. action:: dump_lines_with_attrs

Show a dump of the current lines in the scrollback + screen with their line attributes


.. action:: close_shared_ssh_connections

Close all shared SSH connections

See :opt:`share_connections <kitten-ssh.share_connections>` for details.

.. action:: debug_config

Show the effective configuration kitty is running with


Default shortcuts using this action:
:sc:`kitty.debug_config`

.. action:: show_kitty_env_vars

Show the environment variables that the kitty process sees


.. action:: simulate_color_scheme_preference_change

Simulate a change in OS color scheme preference


.. _action-group-lay:

Layouts
-------


.. action:: goto_layout

Switch to the named layout

In case there are multiple layouts with the same name and different options,
specify the full layout definition or a unique prefix of the full definition.

For example::

    map f1 goto_layout tall
    map f2 goto_layout fat:bias=20

.. action:: last_used_layout

Go to the previously used layout


.. action:: layout_action

Perform a layout specific action. See :doc:`layouts` for details


.. action:: next_layout

Go to the next enabled layout. Can optionally supply an integer to jump by the specified number.


Default shortcuts using this action:
:sc:`kitty.next_layout`

.. action:: toggle_layout

Toggle the named layout

Switches to the named layout if another layout is current, otherwise
switches to the last used layout. Useful to "zoom" a window temporarily
by switching to the stack layout. See also :opt:`scrollback_fill_enlarged_window`
if you would like content from the scrollback buffer to scroll down into the
zoomed window. For example::

    map f1 toggle_layout stack

.. _action-group-mk:

Marks
-----


.. action:: remove_marker

Remove a previously created marker


.. action:: scroll_to_mark

Scroll to the next or previous mark of the specified type


.. action:: toggle_marker

Toggle the current marker on/off


.. action:: create_marker

Create a new marker


.. _action-group-misc:

Miscellaneous
-------------


.. action:: send_key

Send the specified keys to the active window.

Note that the key will be sent only if the current keyboard mode of the program running in the terminal supports it.
Both key press and key release are sent. First presses for all specified keys and then releases in reverse order.
To send a pattern of press and release for multiple keys use the :ac:`combine` action. For example::

    map f1 send_key ctrl+x alt+y
    map f1 combine : send_key ctrl+x : send_key alt+y

.. action:: send_text

Send the specified text to the active window

See :sc:`send_text <send_text>` for details.

Default shortcuts using this action:
:sc:`kitty.send_text`

.. action:: show_kitty_doc

Display the specified kitty documentation, preferring a local copy, if found.

For example::

    # show the config docs
    map f1 show_kitty_doc conf
    # show the ssh kitten docs
    map f1 show_kitty_doc kittens/ssh

Default shortcuts using this action:
:sc:`kitty.show_kitty_doc`

.. action:: signal_child

Send the specified SIGNAL to the foreground process in the active window

For example::

    map f1 signal_child SIGTERM

.. action:: clear_terminal

Clear the terminal

See :sc:`reset_terminal <reset_terminal>` for details. For example::

    # Reset the terminal
    map f1 clear_terminal reset active
    # Clear the terminal screen by erasing all contents
    map f1 clear_terminal clear active
    # Clear the terminal scrollback by erasing it
    map f1 clear_terminal scrollback active
    # Scroll the contents of the screen into the scrollback
    map f1 clear_terminal scroll active
    # Clear everything on screen up to the line with the cursor or the start of the current prompt (needs shell integration)
    # Useful for clearing the screen up to the shell prompt and moving the shell prompt to the top of the screen.
    map f1 clear_terminal to_cursor active
    # Same as above except cleared lines are moved into scrollback
    map f1 clear_terminal to_cursor_scroll active
    # Erase the last command and its output (needs shell integration to work)
    map f1 clear_terminal last_command active

Default shortcuts using this action:
:sc:`kitty.clear_last_command`, :sc:`kitty.clear_screen`, :sc:`kitty.clear_scrollback`, :sc:`kitty.clear_terminal_and_scrollback`, :sc:`kitty.reset_terminal`

.. action:: combine

Combine multiple actions and map to a single keypress

The syntax is::

    map key combine <separator> action1 <separator> action2 <separator> action3 ...

For example::

    map kitty_mod+e combine : new_window : next_layout
    map kitty_mod+e combine | new_tab | goto_tab -1

.. action:: disable_ligatures_in

Turn on/off ligatures in the specified window

See :opt:`disable_ligatures` for details

.. action:: discard_event

Discard this event completely ignoring it


.. action:: edit_config_file

Edit the kitty.conf config file in your favorite text editor


Default shortcuts using this action:
:sc:`kitty.edit_config_file`

.. action:: grab_keyboard

Grab the keyboard. This means global shortcuts defined in the OS will be passed to kitty instead. Useful if

you want to create an OS modal window. How well this
works depends on the OS/window manager/desktop environment. On Wayland it works only if the compositor implements
the :link:`inhibit-keyboard-shortcuts protocol <https://wayland.app/protocols/keyboard-shortcuts-inhibit-unstable-v1>`.
On macOS Apple doesn't allow applications to grab the keyboard without special permissions, so it doesn't work.

.. action:: hide_macos_app

Hide macOS kitty application


Default shortcuts using this action:
:sc:`kitty.hide_macos_app`

.. action:: hide_macos_other_apps

Hide macOS other applications


Default shortcuts using this action:
:sc:`kitty.hide_macos_other_apps`

.. action:: input_unicode_character

Input an arbitrary unicode character. See :doc:`/kittens/unicode_input` for details.


.. action:: kitten

Run the specified kitten. See :doc:`/kittens/custom` for details


Default shortcuts using this action:

- :doc:`kittens/hints` - :sc:`kitty.insert_selected_hash` Insert selected hash
- :doc:`kittens/hints` - :sc:`kitty.insert_selected_line` Insert selected line
- :doc:`kittens/hints` - :sc:`kitty.insert_selected_path` Insert selected path
- :doc:`kittens/hints` - :sc:`kitty.insert_selected_word` Insert selected word
- :doc:`kittens/hints` - :sc:`kitty.open_selected_path` Open selected path
- :doc:`kittens/hints` - :sc:`kitty.goto_file_line` Open the selected file at the selected line
- :doc:`kittens/hints` - :sc:`kitty.open_selected_hyperlink` Open the selected hyperlink
- :doc:`kittens/unicode_input` - :sc:`kitty.input_unicode_character` Unicode input

.. action:: kitty_shell

Run the kitty shell to control kitty with commands


Default shortcuts using this action:
:sc:`kitty.kitty_shell`

.. action:: launch

Launch the specified program in a new window/tab/etc.

See :doc:`launch` for details

.. action:: load_config_file

Reload the config file

If mapped without arguments reloads the default config file, otherwise loads
the specified config files, in order. Loading a config file *replaces* all
config options. For example::

    map f5 load_config_file /path/to/some/kitty.conf

Default shortcuts using this action:
:sc:`kitty.reload_config_file`

.. action:: minimize_macos_window

Minimize macOS window


Default shortcuts using this action:
:sc:`kitty.minimize_macos_window`

.. action:: open_url

Open the specified URL


Default shortcuts using this action:
:sc:`kitty.open_kitty_website`

.. action:: open_url_with_hints

Click a URL using the keyboard


Default shortcuts using this action:
:sc:`kitty.open_url`

.. action:: pop_keyboard_mode

End the current keyboard mode switching to the previous mode.


.. action:: push_keyboard_mode

Switch to the specified keyboard mode, pushing it onto the stack of keyboard modes.


.. action:: remote_control

Run a remote control command without needing to allow remote control

For example::

    map f1 remote_control set-spacing margin=30

See :ref:`rc_mapping` for details.

.. action:: remote_control_script

Run a remote control script without needing to allow remote control

For example::

    map f1 remote_control_script /path/to/script arg1 arg2 ...

See :ref:`rc_mapping` for details.

.. action:: set_colors

Change colors in the specified windows

For details, see :ref:`at-set-colors`. For example::

    map f5 set_colors --configured /path/to/some/config/file/colors.conf

.. action:: show_error

Show an error message with the specified title and text


.. action:: sleep

Sleep for the specified time period. Suffix can be s for seconds, m, for minutes, h for hours and d for days. The time can be fractional.


.. action:: toggle_macos_secure_keyboard_entry

Toggle macOS secure keyboard entry


Default shortcuts using this action:
:sc:`kitty.toggle_macos_secure_keyboard_entry`

.. action:: ungrab_keyboard

Ungrab the keyboard if it was previously grabbed


.. action:: no_op

Unbind a shortcut

Mapping a shortcut to no_op causes kitty to not intercept the key stroke anymore, instead passing it to the program running inside it.

.. _action-group-mouse:

Mouse actions
-------------


.. action:: mouse_click_url

Click the URL under the mouse


.. action:: mouse_click_url_or_select

Click the URL under the mouse only if the screen has no selection


.. action:: mouse_handle_click

Handle a mouse click

Try to perform the specified actions one after the other till one of them is successful.
Supported actions are::

    selection - check for a selection and if one exists abort processing
    link - if a link exists under the mouse, click it
    prompt - if the mouse click happens at a shell prompt move the cursor to the mouse location

For examples, see :ref:`conf-kitty-mouse.mousemap`

.. action:: mouse_select_command_output

Select clicked command output

Requires :ref:`shell_integration` to work

.. action:: mouse_selection

Manipulate the selection based on the current mouse position

For examples, see :ref:`conf-kitty-mouse.mousemap`

.. action:: mouse_show_command_output

Show clicked command output in a pager like less

Requires :ref:`shell_integration` to work

.. action:: paste_selection

Paste the current primary selection


.. action:: paste_selection_or_clipboard

Paste the current primary selection or the clipboard if no selection is present


.. _action-group-sc:

Scrolling
---------


.. action:: scroll_end

Scroll to the bottom of the scrollback buffer when in main screen


Default shortcuts using this action:
:sc:`kitty.scroll_end`

.. action:: scroll_home

Scroll to the top of the scrollback buffer when in main screen


Default shortcuts using this action:
:sc:`kitty.scroll_home`

.. action:: scroll_line_down

Scroll down by one line when in main screen. To scroll by different amounts, you can map the remote_control scroll-window action.


Default shortcuts using this action:
:sc:`kitty.scroll_line_down`

.. action:: scroll_line_up

Scroll up by one line when in main screen. To scroll by different amounts, you can map the remote_control scroll-window action.


Default shortcuts using this action:
:sc:`kitty.scroll_line_up`

.. action:: scroll_page_down

Scroll down by one page when in main screen. To scroll by different amounts, you can map the remote_control scroll-window action.


Default shortcuts using this action:
:sc:`kitty.scroll_page_down`

.. action:: scroll_page_up

Scroll up by one page when in main screen. To scroll by different amounts, you can map the remote_control scroll-window action.


Default shortcuts using this action:
:sc:`kitty.scroll_page_up`

.. action:: scroll_prompt_to_bottom

Scroll prompt to the bottom of the screen, filling in extra lines from the scrollback buffer, when in main screen


.. action:: scroll_prompt_to_top

Scroll prompt to the top of the screen, filling screen with empty lines, when in main screen. To avoid putting the lines above the prompt into the scrollback use scroll_prompt_to_top y


.. action:: scroll_to_prompt

Scroll to the previous/next shell command prompt

Allows easy jumping from one command to the next. Requires working
:ref:`shell_integration`. Takes two optional numbers as arguments:

The first is the number of prompts to jump; negative values jump up and
positive values jump down. A value of zero will jump to the last prompt
visited by this action. Defaults to -1

The second is the number of lines to show above the prompt that was
jumped to. This is somewhat like `less`'s `--jump-target` option or
vim's `scrolloff` setting. Defaults to 0.

For example::

    map ctrl+p scroll_to_prompt -1 3  # jump to previous, showing 3 lines prior
    map ctrl+n scroll_to_prompt 1     # jump to next
    map ctrl+o scroll_to_prompt 0     # jump to last visited

Default shortcuts using this action:
:sc:`kitty.scroll_to_next_prompt`, :sc:`kitty.scroll_to_previous_prompt`

.. _action-group-session:

Sessions
--------


.. action:: close_session

Close a session, that is, close all windows that belong to the session.

Examples::
    # Ask for the session to close
    map f1 close_session
    # Close the currently active session
    map f1 close_session .
    # Close session by name
    map f1 close_session "my session"
    # Close session by path to session file
    map f1 close_session "/path/to/session/file.kitty-session"

.. action:: goto_session

Switch to the specified session, creating it if not already present. See :ref:`goto_session`.


.. action:: save_as_session

Save the current kitty state as a session file. See :ref:`save_as_session`.


.. _action-group-tab:

Tab management
--------------


.. action:: close_other_tabs_in_os_window

Close all the tabs in the current OS window other than the currently active tab


.. action:: close_tab

Close the current tab


Default shortcuts using this action:
:sc:`kitty.close_tab`

.. action:: detach_tab

Detach a tab, moving it to another OS Window

See :ref:`detaching windows <detach_window>` for details.

.. action:: goto_tab

Go to the specified tab, by number, starting with 1

Zero and negative numbers go to previously active tabs.
Use the :ac:`select_tab` action to interactively select a tab
to go to.

.. action:: move_tab_backward

Move the active tab backward


Default shortcuts using this action:
:sc:`kitty.move_tab_backward`

.. action:: move_tab_forward

Move the active tab forward


Default shortcuts using this action:
:sc:`kitty.move_tab_forward`

.. action:: new_tab

Create a new tab


Default shortcuts using this action:
:sc:`kitty.new_tab`

.. action:: new_tab_with_cwd

Create a new tab with working directory for the window in it set to the same as the active window.

The tab is added to the currently active :ref:`session <sessions>`, if any.

.. action:: next_tab

Make the next tab active


Default shortcuts using this action:
:sc:`kitty.next_tab`

.. action:: previous_tab

Make the previous tab active


Default shortcuts using this action:
:sc:`kitty.previous_tab`

.. action:: select_tab

Interactively select a tab to switch to


.. action:: set_tab_title

Change the title of the active tab interactively, by typing in the new title.

If you specify an argument to this action then that is used as the title instead of asking for it.
Use the empty string ("") to reset the title to default. Use a space (" ") to indicate that the
prompt should not be pre-filled. For example::

    # interactive usage
    map f1 set_tab_title
    # set a specific title
    map f2 set_tab_title some title
    # reset to default
    map f3 set_tab_title ""
    # interactive usage without prefilled prompt
    map f3 set_tab_title " "

Default shortcuts using this action:
:sc:`kitty.set_tab_title`

.. _action-group-win:

Window management
-----------------


.. action:: set_window_title

Change the title of the active window interactively, by typing in the new title.

If you specify an argument to this action then that is used as the title instead of asking for it.
Use the empty string ("") to reset the title to default. Use a space (" ") to indicate that the
prompt should not be pre-filled. For example::

    # interactive usage
    map f1 set_window_title
    # set a specific title
    map f2 set_window_title some title
    # reset to default
    map f3 set_window_title ""
    # interactive usage without prefilled prompt
    map f3 set_window_title " "

.. action:: close_other_windows_in_tab

Close all windows in the tab other than the currently active window


.. action:: eighth_window

Focus the eighth window


Default shortcuts using this action:
:sc:`kitty.eighth_window`

.. action:: fifth_window

Focus the fifth window


Default shortcuts using this action:
:sc:`kitty.fifth_window`

.. action:: first_window

Focus the first window


Default shortcuts using this action:
:sc:`kitty.first_window`

.. action:: focus_visible_window

Focus a visible window by pressing the number of the window. Window numbers are displayed

over the windows for easy selection in this mode. See :opt:`visual_window_select_characters`.

Default shortcuts using this action:
:sc:`kitty.focus_visible_window`

.. action:: fourth_window

Focus the fourth window


Default shortcuts using this action:
:sc:`kitty.fourth_window`

.. action:: move_window

Move the window in the specified direction

For example::

    map ctrl+left move_window left
    map ctrl+down move_window bottom

.. action:: move_window_backward

Move active window backward (swap it with the previous window)


Default shortcuts using this action:
:sc:`kitty.move_window_backward`

.. action:: move_window_forward

Move active window forward (swap it with the next window)


Default shortcuts using this action:
:sc:`kitty.move_window_forward`

.. action:: move_window_to_top

Move active window to the top (make it the first window)


Default shortcuts using this action:
:sc:`kitty.move_window_to_top`

.. action:: neighboring_window

Focus the neighboring window in the current tab

For example::

    map ctrl+left neighboring_window left
    map ctrl+down neighboring_window bottom

.. action:: next_window

Focus the next window in the current tab


Default shortcuts using this action:
:sc:`kitty.next_window`

.. action:: ninth_window

Focus the ninth window


Default shortcuts using this action:
:sc:`kitty.ninth_window`

.. action:: nth_window

Focus the nth window if positive or the previously active windows if negative. When the number is larger

than the number of windows focus the last window. For example::

    # focus the previously active window
    map ctrl+p nth_window -1
    # focus the first window
    map ctrl+1 nth_window 0

.. action:: previous_window

Focus the previous window in the current tab


Default shortcuts using this action:
:sc:`kitty.previous_window`

.. action:: reset_window_sizes

Reset window sizes undoing any dynamic resizing of windows


.. action:: resize_window

Resize the active window by the specified amount

See :ref:`window_resizing` for details.

.. action:: second_window

Focus the second window


Default shortcuts using this action:
:sc:`kitty.second_window`

.. action:: seventh_window

Focus the seventh window


Default shortcuts using this action:
:sc:`kitty.seventh_window`

.. action:: sixth_window

Focus the sixth window


Default shortcuts using this action:
:sc:`kitty.sixth_window`

.. action:: swap_with_window

Swap the current window with another window in the current tab, selected visually. See :opt:`visual_window_select_characters`


Default shortcuts using this action:
:sc:`kitty.swap_with_window`

.. action:: tenth_window

Focus the tenth window


Default shortcuts using this action:
:sc:`kitty.tenth_window`

.. action:: third_window

Focus the third window


Default shortcuts using this action:
:sc:`kitty.third_window`

.. action:: change_font_size

Change the font size for the current or all OS Windows

See :ref:`conf-kitty-shortcuts.fonts` for details.

Default shortcuts using this action:
:sc:`kitty.decrease_font_size`, :sc:`kitty.increase_font_size`, :sc:`kitty.reset_font_size`

.. action:: close_os_window

Close the currently active OS Window


Default shortcuts using this action:
:sc:`kitty.close_os_window`

.. action:: close_other_os_windows

Close all other OS Windows other than the OS Window containing the currently active window


.. action:: close_window

Close the currently active window


Default shortcuts using this action:
:sc:`kitty.close_window`

.. action:: close_window_with_confirmation

Close window with confirmation

Asks for confirmation before closing the window. If you don't want the
confirmation when the window is sitting at a shell prompt
(requires :ref:`shell_integration`), use::

    map f1 close_window_with_confirmation ignore-shell

.. action:: detach_window

Detach a window, moving it to another tab or OS Window

See :ref:`detaching windows <detach_window>` for details.

.. action:: new_os_window

New OS Window


Default shortcuts using this action:
:sc:`kitty.new_os_window`

.. action:: new_os_window_with_cwd

New OS Window with the same working directory as the currently active window.

The new OS Window is added to the currently active :ref:`session <sessions>`, if any.

.. action:: new_window

Create a new window


Default shortcuts using this action:
:sc:`kitty.new_window`

.. action:: new_window_with_cwd

Create a new window with working directory same as that of the active window.

The new window will belong to the active :ref:`session <sessions>` if any.

.. action:: nth_os_window

Focus the nth OS window if positive or the previously active OS windows if negative. When the number is larger

than the number of OS windows focus the last OS window. A value of zero will refocus the currently focused OS window,
this is useful if focus is not on any kitty OS window at all, however, it will only work if the window manager
allows applications to grab focus. For example::

    # focus the previously active kitty OS window
    map ctrl+p nth_os_window -1
    # focus the current kitty OS window (grab focus)
    map ctrl+0 nth_os_window 0
    # focus the first kitty OS window
    map ctrl+1 nth_os_window 1
    # focus the last kitty OS window
    map ctrl+1 nth_os_window 999

.. action:: quit

Quit, closing all windows


Default shortcuts using this action:
:sc:`kitty.quit`

.. action:: set_background_opacity

Set the background opacity for the active OS Window

For example::

    map f1 set_background_opacity +0.1
    map f2 set_background_opacity -0.1
    map f3 set_background_opacity 0.5

Default shortcuts using this action:
:sc:`kitty.decrease_background_opacity`, :sc:`kitty.full_background_opacity`, :sc:`kitty.increase_background_opacity`, :sc:`kitty.reset_background_opacity`

.. action:: start_resizing_window

Resize the active window interactively

See :ref:`window_resizing` for details.

Default shortcuts using this action:
:sc:`kitty.start_resizing_window`

.. action:: toggle_fullscreen

Toggle the fullscreen status of the active OS Window


Default shortcuts using this action:
:sc:`kitty.toggle_fullscreen`

.. action:: toggle_maximized

Toggle the maximized status of the active OS Window


Default shortcuts using this action:
:sc:`kitty.toggle_maximized`

.. action:: toggle_tab

Toggle to the tab matching the specified expression

Switches to the matching tab if another tab is current, otherwise
switches to the last used tab. Useful to easily switch to and back from a
tab using a single shortcut. Note that toggling works only between
tabs in the same OS window. See :ref:`search_syntax` for details
on the match expression. For example::

    map f1 toggle_tab title:mytab