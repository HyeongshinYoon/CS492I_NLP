#!/usr/bin/env bash

nsml run \
  -m 'koelectra (pretrained : base(v3), epoch: 2, dropout (0.3, 0.3, 0.0))' \
  -d korquad-open-ldbd3 \
  -g 1 \
  -c 2 \
  -e run_squad.py \
  -a "--model_type koelectra
    --model_name_or_path monologg/koelectra-base-v3-discriminator
    --do_train
    --do_eval
    --data_dir train
    --num_train_epochs 2
    --per_gpu_train_batch_size 24
    --per_gpu_eval_batch_size 24
    --verbose_logging
    --output_dir output
    --overwrite_output_dir
    --version_2_with_negative
    --example_style iter"
