#   Copyright {2015} Yuxiang Tan
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

#usage example: Rscript bench_WGS_table_converter.R sim_table=benchmark_comp_WGS.csv add_name=_WGSerr_r rep_add_time=3 name_out=bench_Ecoli2_WGS_all
#the output will be a str profile table from the bench table, replicate names and data tye will be added and expanded

#update log:2021-03-11 by Yuxiang Tan
##recongize the read length of each WGS data automatically (rather than default input now, which will cause mistake when WGS of different strains had different read length)
###the read_len column was added to be neglect, changed the row53 SIM_matrix assign
###the description of this script was updated as well in the Columns section of input csv.


#check arguments
for (e in commandArgs()) {
        ta = strsplit(e,"=",fixed=TRUE)
        if(! is.na(ta[[1]][2])) {
                temp = ta[[1]][2]
                if(substr(ta[[1]][1],nchar(ta[[1]][1]),nchar(ta[[1]][1])) == "I") {
                temp = as.integer(temp)
                }
        if(substr(ta[[1]][1],nchar(ta[[1]][1]),nchar(ta[[1]][1])) == "N") {
                temp = as.numeric(temp)
                }
        assign(ta[[1]][1],temp)
        } else {
        assign(ta[[1]][1],TRUE)
        }
}

#check whether the file in is exist
if (!exists("sim_table")) {
	stop("\nRscript bench_WGS_table_converter.R sim_table=benchmark_comp_WGS.csv \nWarning: Usage: pan_ref file is not exist, please check the path. \n\n")
}

#sim_table <- "benchmark_comp_WGS.csv"
#add_name <- "_WGSerr_r"
#rep_add_time <- 3
#name_out <- "bench_Ecoli2_WGS_all"

#get bench data
SIM_in <- read.csv(sim_table)
SIM_matrix <- SIM_in[-1,6:dim(SIM_in)[2]]
rownames(SIM_matrix) <- SIM_in[-1,2]

#add the data type and replicate into sample names
rep_add=0
col_n <-colnames(SIM_matrix)
if (rep_add_time>1){
    col_n_m <- paste(col_n,add_name,rep_add,sep="")
    col_n_m_l <- col_n_m
    rep_add=rep_add+1
    for (i in 2:rep_add_time){
        col_n_m <- paste(col_n,add_name,rep_add,sep="")
        col_n_m_l <-c(col_n_m_l,col_n_m)
        rep_add=rep_add+1
    }
} else {
    col_n_m <- paste(col_n,add_name,"0",sep="")
    col_n_m_l <- col_n_m
}

#expand the data dimension
if (rep_add_time>1){
    SIM_matrix_f <- SIM_matrix
    for (i in 2:rep_add_time){
        SIM_matrix_f <- cbind(SIM_matrix_f,SIM_matrix)
    }
    colnames(SIM_matrix_f) <- col_n_m_l
} else {
    SIM_matrix_f <- SIM_matrix
    colnames(SIM_matrix_f) <- col_n_m_l
}

SIM_matrix_out <- SIM_matrix_f
#turn into relative abund
c_s <- apply(SIM_matrix_f,2,sum)
for(i in names(c_s)){
  SIM_matrix_out[,i] <- SIM_matrix_f[,i]/c_s[i]
}

write.table(SIM_matrix_out, file=(paste(name_out,"_str_prof.csv",sep="")),sep=",", quote=F, row.names= TRUE, col.names= TRUE, fileEncoding="UTF-8" )

#然后再写一个比较两个这种matrix的脚本（BC距离），如果方法输出比模拟输出多，额外的行也一样算进去距离里。



