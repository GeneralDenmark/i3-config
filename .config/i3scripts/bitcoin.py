#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Simple script which sends crypto price notifications."""

import requests
import schedule
import time
import os

ALERT_INTERVAL = 15  # Send a notification every x minutes.
MONITOR_LIST = [
    "bitcoin",
    "monero",
    "eos",
    "basic-attention-token"
]


def send_notification(message):
    """Sends the user a notification using notify-send."""
    os.system("notify-send '{0}'".format(message))


def main():
    """Builds the notification which is then sent to the user."""
    message = ""

    for i, currency_id in enumerate(MONITOR_LIST):
        response = 
requests.get("https://api.coinmarketcap.com/v1/ticker/{0}/".format(currency_id)).json()
        currency_name = response[0]["name"]
        currency_price = round(float(response[0]["price_usd"]), 2)
        currency_change = response[0]["percent_change_24h"]

        message += "{0}: ${1} ({2}%)".format(currency_name, currency_price, 
currency_change)

        if i is not len(MONITOR_LIST) - 1:
            message += "\n"

    send_notification(message)


if __name__ == '__main__':
    try:

        schedule.every(ALERT_INTERVAL).minutes.do(main)

        while True:
            schedule.run_pending()
            time.sleep(1)
    except KeyboardInterrupt:
        pass
