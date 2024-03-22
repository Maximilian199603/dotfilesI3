## My dotfiles



# Issues
## Critical Issues

### Issues
- rofi cannot find powermenu script
#### Non Important Issues
- Hard coded path to the rofi-wifi-menu.sh script. rofi cannot find script even though it is in the $PATH variable. Maybe it is because it is called before the folder is added. .xinitrc might be a solution.
- Hard coded the path to randomFromDir.sh into the i3 config. When $Path is available this is no longer necessary.