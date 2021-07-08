# SimStr
A pipeline to generate simulation datasets for evaluation on strain analysis from metagenomic data

Software requirmentL
Conda
SIM_str (所有R要用conda装好）
docker panphlan （265157181057.dkr.ecr.cn-northwest-1.amazonaws.com.cn/panphlan:v1.2.4， 这个是不是能允许公开下载？）


Workflow
1. Generate the list of candidate strains of a specific species:
  sh /Path_to_SimStr/SIM_str_ANI_PAN_mash.sh sra_result.csv SraRunInfo.csv Ecoli_strs.csv Ecoli_target_str_info /Path_to_SimStr/ wide 95
  Required:
    sra_result.csv:
    SraRunInfo.csv:
    Ecoli_strs.csv
    Ecoli_target_str_info
    
  Optional:
    wide:
    95:
    
  THere are two main steps of this part of pipeline, if the first part of pangenome generation finished, and you do not want to rerun the first part, you can run SIM_str_ANI_PAN_mash_part2.sh instead of SIM_str_ANI_PAN_mash.sh.
2. 
