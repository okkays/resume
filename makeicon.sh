#!/bin/bash
convert -resize 16 -quality 80 favicon.png web/favicon.png
convert -resize 192 -quality 80 favicon.png web/icons/Icon-192.png
convert -resize 512 -quality 80 favicon.png web/icons/Icon-512.png
convert -resize 192 -quality 80 favicon.png web/icons/Icon-maskable-192.png
convert -resize 512 -quality 80 favicon.png web/icons/Icon-maskable-512.png
