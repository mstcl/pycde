#!/usr/bin/env bash

jupyter lab -y --no-browser --log-level=ERROR --ip "*" --port 8888 --notebook-dir /project --LabApp.token='' "$@"
