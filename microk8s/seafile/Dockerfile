# CE version: No Basic File name search
# FROM seafileltd/seafile-mc:7.1.4
# FROM seafileltd/seafile-mc:latest

# PE version: 3 free accounts
FROM docker.seadrive.org/seafileltd/seafile-pro-mc:7.1.4
# FROM docker.seadrive.org/seafileltd/seafile-pro-mc:latest

COPY seafile.nginx.conf.template /templates/seafile.nginx.conf.template

# To generte thumbnails for video. Works on Seaflie 6.3.13.
# Video thumbnail generation is not supported anymore on Seafile 7+.
# RUN apt-get update && apt-get -y install ffmpeg && pip install pillow moviepy
