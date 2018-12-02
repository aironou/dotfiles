from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.command import lazy
from libqtile import layout, bar, widget
try:
    from typing import List
except ImportError:
    pass

web_browser = 'firefox'
terminal = 'kitty'
editor = 'atom'

keys = [
    Key(['mod1'], 'F4', lazy.window.kill()),
    Key(['control', 'mod4'], 'F4', lazy.shutdown()),
    Key(['control', 'mod4'], 'r', lazy.restart()),
    Key(['mod1'], 'Tab', lazy.group.next_window()),
    Key(['mod1', 'shift'], 'Tab', lazy.group.prev_window()),
    Key(['mod4'], 'r', lazy.spawncmd()),
    Key(['mod1'], 'F2', lazy.spawncmd()),
    Key(['mod4'], 'q', lazy.spawn(editor)),
    Key(['mod4'], 'w', lazy.spawn(web_browser)),
    Key(['mod4'], 'Return', lazy.spawn(terminal))
]

groups = [Group(group) for group in '1']
for group in groups:
    keys.extend([
        Key(['mod4'], group.name, lazy.group[group.name].toscreen()),
        Key(['mod4', 'shift'], group.name, lazy.window.togroup(group.name))
    ])

layouts = [
    layout.Max()
]

widget_defaults = dict(font='sans', fontsize=12, padding=3)
extension_defaults = widget_defaults.copy()

screens = [Screen(
    top=bar.Bar([
        widget.Prompt(),
        widget.Spacer(10),
        widget.TaskList(
            highlight_method='block',
            spacing=5,
            max_title_width=100
        ),
        widget.Sep(),
        widget.Spacer(5),
        widget.Memory(fmt='{MemAvailable}M/{MemTotal}M', update_interval=5),
        widget.Spacer(5),
        widget.Battery(low_percentage=0.16),
        widget.Spacer(5),
        widget.ThermalSensor(),
        widget.Spacer(5),
        widget.Sep(),
        widget.Spacer(5),
        widget.Notify(),
        widget.Spacer(5),
        widget.Volume(),
        widget.Spacer(5),
        widget.Systray(),
        widget.Spacer(5),
        widget.Sep(),
        widget.Spacer(5),
        widget.Clock(format='%A, %d/%m/%Y - %H:%M:%S')
    ], 24)
)]

mouse = []

dgroups_key_binder = None
dgroups_app_rules = []
main = None
follow_mouse_focus = True
bring_front_click = True
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
    {'wmclass': 'confirmreset'},
    {'wmclass': 'makebranch'},
    {'wmclass': 'maketag'},
    {'wname': 'branchdialog'},
    {'wname': 'pinentry'},
    {'wmclass': 'ssh-askpass'}
])

auto_fullscreen = True
focus_on_window_activation = "smart"
