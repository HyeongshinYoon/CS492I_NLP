# nsml: auswls0727/cs492_env:20.06

from distutils.core import setup

setup(
    name='kaist-korquad-test',
    version='1.0',
    install_requires=[
        'boto3', 'regex', 'sacremoses', 'filelock', 'tokenizers',
        'tqdm', 'konlpy', 'sentencepiece==0.1.91', 'dataclasses',
        'transformers==2.11.0'
    ]
)
