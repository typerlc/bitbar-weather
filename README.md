# bitbar-weather

Displays weather information using [bitbar](https://getbitbar.com) on a Mac

Requires jq, curl, darksky-weather to be installed in the PATH or /usr/local/bin/

## Overriding location

You can create a shell script in the bitbar plugins with the same name as this plugin, with '.location' appended to it.  This will get loaded by the plugin on start.  To force a different location, set the LOCATION variable with the name of your location.

```
LOCATION='Some Location, Somewhere'
```

You could also have some automated mapping based on IP addresses e.g.

```
IP=$(curl -s https://ifconfig.co/)
case "$IP" in
    1.2.3.4) LOCATION="Some Location, Somewhere" ;;
    6.7.8.9) LOCATION="Somewhere Else" ;;
esac
```

If $LOCATION is not set or empty, then your location will be automatically determined.
