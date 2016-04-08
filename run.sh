#!/bin/bash

# Start WebHooks with Puma
bundle exec puma --dir /pxe --debug --tag pxemonister -p 80 #-d
