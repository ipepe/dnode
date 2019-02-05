#!/bin/bash
if [[ "$PASSENGER_APP_ENV" != "" ]]; then
    if [[ "$PASSENGER_APP_ENV" != "production" ]]; then
        echo "passenger_friendly_error_pages on;" >> /etc/nginx/conf.d/00_app_env.conf
    fi
fi
