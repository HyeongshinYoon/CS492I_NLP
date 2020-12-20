# 2020 Fall CS492I NLP project Team4 Repository

## Introduction
- This repository is for 2020 Fall CS492I NLP project of Team 4.  
- In this [```README.md```](https://github.com/HyeongshinYoon/CS492I_NLP/blob/master/README.md) we mainly explain about our **Main model with Highest Accuracy**.
	### Members
	    Hyunjin Kim 20170191
		Hyeongshin Yoon 20170438
		Kyoung Hur 20180717
***

## Directory Structure
<pre><code>CS492I_NLP
|- Dockerfile
|- electra_model.py
|- open_squad.py
|- open_squad_metrics.py
|- run_local.sh
|- run_nsml.sh
|- run_squad.py
|- setup.py
|- README.md
</code></pre>

## Requirements
### NSML Installation
<pre><code>1) Download the compressed file from the link below
    https://ai.nsml.navercorp.com/download
2) Decompress the file
    $ tar -xvzf < downloaded archive >
3) Register installed path to PATH
    $ export PATH=$PATH:< NSML_ROOT_PATH >
</code></pre>
### Package Installation
- All packages/libraries that we used is defined in [```setup.py```](https://github.com/HyeongshinYoon/CS492I_NLP/blob/master/setup.py)
### Dockerfile
- KoELECTRA-v3 requires pytorch version 1.6 or higher.   
So we build [new docker image](https://hub.docker.com/r/auswls0727/cs492_env)(auswls0727/cs492_env:20.06) which installs pytorch 1.6.

## Dataset
- We use ```KorQuAD-open Dataset``` for training and evaluation.

## Path to Pre-trained Model 
- It is the session and checkpoint name of **Main model with highest accuracy**
> <pre><code>kaist004/korquad-open-ldbd3/312 koelectra_best
> </code></pre>
> ### Download pre-trained model from NSML
> <pre><code>nsml model pull kaist004/korquad-open-ldbd3/312 > koelectra_best ./
> </code></pre>
> ### Download and Unpack pre-trained model from Google Drive
> * Download the pre-trained model from [Google Drive](https://drive.google.com/file/d/13E6f_hOcuP_2KWxpxN9MeuD8x7TlA9l6/view?usp=sharing) and move this file into project directory

## Commands to train/test
> ### Before Training/Testing
> <pre><code> 1) Register installed path to PATH
>   $ export PATH=$PATH:< NSML_ROOT_PATH >
> 
> 2) Login to NSML
>   $ nsml login
>   -> Then put your github ID & password
> </code></pre>
> 
> ### 2. For Training
> ```bash
> $ cd < your working dir >
> ```
>> #### Train in NSML
>> ```bash
>> sh run_nsml.sh
>> ```
>> #### Train in Local
>> ```bash
>> sh run_local.sh
>> ```
> 1) Run a NSML session   
> Change the options in [run_nsml.sh](https://github.com/HyeongshinYoon/CS492I_NLP/blob/main/run_nsml.sh)
>> ```
>>   * Running Options
>>   -d : Dataset to use in the session
>>       (eg. -d korquad-open-ldbd3)
>>   -m : Write the message for session
>>       (eg. "koelectra (pretrained : base(v3), per_qa_paragraph_cnt > 3)")
>>   -g : Define the number of GPUs 
>>       (eg. -g 1)
>>   -c : Define the number of CPUs 
>>       (eg. -c 2)
>>   -e : Name of file to execute
>>       (eg. -e run_squad.py)
>>   -a : Define the value of arguments for executing file
>>       (eg. -a "--model_type koelectra
>>                --model_name_or_path monologg/koelectra-base-v3-discriminator
>>                --example_style iter")
>>       * Added arguments
>>         --select_by_addition : Set to True if addition method is to be used for selecting predictions
>>         --hidden_dropout_prob : The dropout probability for all fully connected layers in the embeddings, encoder, and pooler
>>         --attention_probs_dropout_prob : The dropout ratio for the attention probabilities
>>         --example_style : Change the selecting styles of example paragraphs. ['iter', 'rand', 'rele']
>> ```
> 2) Terminate NSML session
>> <pre><code>$ nsml rm -f [SESSION]
>> </code></pre>
> ### 3. For Testing
> <pre><code>$ nsml submit [Options] [SESSION_NAME] [CHECKPOINT]
>   (eg. nsml submit kaist004/korquad-open-ldbd3/312 koelectra_best)
> 
>   * Options
>   -t, --test : Submit the session as debug mode(test mode) to find the errors from dataset or codes before actual submission
> </code></pre>

***

## Result
- About Main model
  - Use KoELECTRA with tuned dropout rates, number of paragraphs,  
  - Difference between Base Model
    - Model : KoELECTRA with pre-trained model
    - Dropout([hidden_dropout_prob, attention_probs_dropout_prob, summary_last_dropout]) : [0.3, 0.3, 0.0] (Base Model : [0.1, 0.1, 0.1])
    - The maximum number of per_qa_paragraph_cnt : 1 (Base Model : 3)
  
||Model|Dropout|per_qa_paragraph_cnt|test F1 score|Session (checkpoint)|
|:------:|:---:|:---:|:---:|:---:|:---:|
|Base|BERT|(0.1, 0.1, 0.1)|3|0.361|kaist004/korquad-open-ldbd3/37 (bert_best)
|Main model|KoELECTRA|(0.3, 0.3, 0.0)|1|0.445|kaist004/korquad-open-ldbd3/312 (koelectra_best)