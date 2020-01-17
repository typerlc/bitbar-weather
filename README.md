# bitbar-weather

Displays weather information using [bitbar](https://getbitbar.com) on a Mac

Requires jq, curl, darksky-weather to be installed in the PATH or /usr/local/bin/

## Overriding location

You can create a shell script in the bitbar plugins with the same name as this plugin, with '.location' appended to it.  This will get loaded by the plugin on start.  To force a different location, set the LOCATION variable with the name of your location.

You could also have some automated mapping based on IP addresses e.g.

```
map_ip_to_location() {
    IP=$(curl -s https://ifconfig.co/)
    case "$IP" in
        a.b.c.d) echo 'Some Location, Somewhere' ;;
        *) ;;
    esac
}
LOCATION=$(map_ip_to_location)
```

If $LOCATION is not set or empty, then your location will be automatically determined.
