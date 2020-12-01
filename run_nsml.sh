#!/usr/bin/env bash

nsml run \
  -m '경) DOCQA-original nsml ' \
  -d korquad-open-ldbd3 \
  -g 1 \
  -c 6 \
  -e train.py \
  -a "--base_config korquad/docqa.json
    --train_file_path train"
