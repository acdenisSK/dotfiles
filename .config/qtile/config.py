# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from libqtile import hook, layout, bar, widget
from libqtile.config import Key, Screen, Group, Drag, Click, Match
from libqtile.lazy import lazy
from libqtile.core.manager import Qtile

from typing import List  # noqa: F401

import os
import subprocess
import socket

keyboards = ["us", "sk"]

@hook.subscribe.startup_once
def autostart():
    subprocess.call([os.path.expanduser("~/.config/qtile/autostart.sh")])

@lazy.function
def next_keyboard(qtile: Qtile):
    qtile.widgets_map["keyboardlayout"].next_keyboard()

mod = "mod4"

keys = [
    # Switch between keyboard layouts
    Key([mod], "space", next_keyboard),

    # Switch between windows in current stack pane
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "k", lazy.layout.up()),
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "l", lazy.layout.right()),

    # Move windows in all directions
    Key([mod, "control"], "h", lazy.layout.shuffle_left()),
    Key([mod, "control"], "k", lazy.layout.shuffle_up()),
    Key([mod, "control"], "j", lazy.layout.shuffle_down()),
    Key([mod, "control"], "l", lazy.layout.shuffle_right()),

    Key([mod, "shift"], "space", lazy.layout.flip()),

    Key([mod], "Return", lazy.spawn("alacritty")),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod], "w", lazy.window.kill()),

    Key([mod, "control"], "r", lazy.restart()),
    Key([mod, "control"], "q", lazy.shutdown()),
    Key([mod], "r", lazy.spawncmd()),
]

colours = [
    "#292e3b", # background colour
    "#636d83", # active text colour
    "#3a3f47", # passive text colour
    "#98c379", # highlight and text box colour
    "#61afef", # alternate highlight and text box colour
    "#8002f5", # border highlight colour
]

layouts = [
    layout.Max(),
    layout.MonadTall(
        name="monadtall",
        border_normal=colours[0],
        border_focus=colours[5],
        margin=3,
    ),
]

groups = [
    Group(
        "web",
        layout="max",
        matches=[
            Match(wm_class=["google-chrome", "Google-chrome"]),
            Match(wm_class=["chromium", "Chromium"]),
            Match(wm_class=["firefox"]),
        ],
    ),
    Group(
        "chat",
        layout="max",
        matches=[Match(wm_class=["discord"])],
    ),
    Group(
        "games",
        layout="max",
        matches=[Match(wm_class=["Steam"])],
    ),
    Group(
        "term",
        layout="monadtall",
    ),
    Group(
        "misc",
        layout="max",
    ),
    Group(
        "misc2",
        layout="max",
    )
]

for i, group in enumerate(groups, 1):
    keys.extend([
        # mod1 + position of group = switch to group
        Key([mod], str(i), lazy.group[group.name].toscreen()),

        # mod1 + shift + position of group = switch to & move focused window to group
        Key([mod, "shift"], str(i), lazy.window.togroup(group.name)),
    ])

prompt = "%s@%s: " % (os.environ["USER"], socket.gethostname())

widget_defaults = dict(
    font="Noto Sans",
    fontsize=12,
    padding=3,
    background=colours[0],
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        wallpaper=os.path.expanduser("~/.config/qtile/wallpaper.jpg"),
        top=bar.Bar(
            [
                widget.GroupBox(
                    font="Noto Sans Bold",
                    active=colours[1],
                    inactive=colours[2],
                    this_current_screen_border=colours[3],
                    borderwidth=5,
                    highlight_method="block",
                    rounded=False,
                    use_mouse_wheel=False,
                    disable_drag=True,
                ),
                widget.Prompt(
                    prompt=prompt,
                    fontsize=14,
                ),
                widget.WindowName(fontsize=14),
                widget.TextBox(
                    font="Ubuntu Mono",
                    text="",
                    padding=0,
                    fontsize=46,
                    foreground=colours[3],
                ),
                widget.Systray(
                    background=colours[3],
                ),
                widget.TextBox(
                    font="Ubuntu Mono",
                    text="",
                    padding=0,
                    fontsize=46,
                    foreground=colours[4],
                    background=colours[3],
                ),
                widget.TextBox(
                    font="Ubuntu Mono",
                    text="⌨️",
                    padding=0,
                    fontsize=17,
                    background=colours[4],
                ),
                widget.KeyboardLayout(
                    font="Ubuntu Mono",
                    fontsize=14,
                    configured_keyboards=keyboards,
                    foreground=colours[0],
                    background=colours[4],
                ),
                widget.TextBox(
                    font="Ubuntu Mono",
                    text="",
                    padding=0,
                    fontsize=46,
                    foreground=colours[3],
                    background=colours[4],
                ),
                widget.TextBox(
                    font="Ubuntu Mono",
                    text="🕗",
                    padding=0,
                    fontsize=17,
                    background=colours[3],
                ),
                widget.Clock(
                    font="Ubuntu Mono",
                    fontsize=14,
                    format="%A %H:%M:%S %Y-%m-%d",
                    foreground=colours[0],
                    background=colours[3],
                ),
            ],
            24,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.toggle_floating())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
])
auto_fullscreen = True
focus_on_window_activation = "smart"

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
