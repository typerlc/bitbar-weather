#!/usr/bin/env bash

# <bitbar.title>Weather</bitbar.title>
# <bitbar.version>v0.0.0</bitbar.version>
# <bitbar.author>Richard Colley</bitbar.author>
# <bitbar.author.github>typerlc</bitbar.author.github>
# <bitbar.desc>Display local weather collected using darksky-weather (install from brew).</bitbar.desc>
# <bitbar.dependencies>darksky-weather,curl,jq</bitbar.dependencies>
# <bitbar.image>https://github.com/typerlc/bitbar-weather/raw/master/weather_preview.png</bitbar.image>

[ -f $0.location ] && . $0.location

print_weather_icon() {
    case $1 in
        clear*) echo -n ☀️  ;;
        cloud*) echo -n ☁️ ;;
        fog|haze*|mist) echo -n 🌫 ;;
        partly-cloudy) echo -n ⛅️ ;;
        rain) echo -n 🌧 ;;
        sleet|snow) echo -n 🌨 ;;
        thunderstorm) echo -n ⛈  ;;
        tornado) echo -n 🌪 ;;
        wind) echo -n 🌬 ;;
        *) echo -n "?" ;;
    esac
}

print_temperature() {
    temperature=$1
    units=$2
    case $units in
        celsius|si) unit_string=C ;;
        fahrenheit|us) unit_string=F ;;
        *) unit_string=C ;;
    esac
    echo -n "$temperature°$unit_string"
}


export PATH="/usr/local/bin:${PATH}"

[ -n "$LOCATION" ] && LOCATION_OPT=-l

WEATHER_DATA="$(weather -json $LOCATION_OPT "$LOCATION")"
NOW_ALERTS=$(echo $WEATHER_DATA | jq -r '.alerts')
NOW_SUMMARY=$(echo $WEATHER_DATA | jq -r '.currently.summary')
NOW_TEMP=$(echo $WEATHER_DATA | jq -r '.currently.temperature')
UNITS=$(echo $WEATHER_DATA | jq -r '.flags.units')
NOW_ICON=$(echo $WEATHER_DATA | jq -r '.currently.icon')
NOW_HUMIDITY=$(echo $WEATHER_DATA | jq -r '.currently.humidity')
NOW_PRECIP_TYPE=$(echo $WEATHER_DATA | jq -r '.currently.precipType')
NOW_PRECIP_PROB=$(echo $WEATHER_DATA | jq -r '.currently.precipProbability')
NOW_PRECIP_PROB=$(echo $WEATHER_DATA | jq -r '.currently.precipProbability')

FORECAST_SUMMARY=$(echo $WEATHER_DATA | jq -r '.daily.summary')
FORECAST_ICON=$(echo $WEATHER_DATA | jq -r '.daily.icon')

echo "$(print_weather_icon $NOW_ICON)   $(print_temperature $NOW_TEMP $UNITS)"
echo "---"
weather --hide-icon $LOCATION_OPT "$LOCATION"
echo "---"
echo "Refresh... | refresh=true"
