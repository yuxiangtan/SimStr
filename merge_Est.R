cDIR=getwd()
f_path=paste(cDIR,"/abund_prof_merge",sep = "")
ind_pattern <- "profile*"
out_name=paste(f_path,"/Est_merged_matrix.tsv",sep = "")
Est_merge <- function(f_path, out_name,ind_pattern){
  file_list <- list.files(path=f_path,pattern=ind_pattern)
  Count_Est=0
  for (Est_gene_table in file_list) {
    print(Est_gene_table)
    Est_gene <-read.table(paste(f_path,Est_gene_table,sep = "/"),header = T,sep="\t",comment.char = "")
    #Sample_ID <- colnames(Est_gene)[2]
    #Est_gene$Sample <- rep(Sample_ID,length(rownames(Est_gene)))
    if(Count_Est==0){
      Est_gene_merge <- Est_gene
    } else{
      Est_gene_merge <- merge(Est_gene_merge, Est_gene, by="OTU")
    }
    Count_Est=+1
  }
  write.table(Est_gene_merge, file=out_name,sep="\t", quote=F, row.names= FALSE )
  return(Est_gene_merge)
}
#因为有些文件里面有'符号，所以要先在linux： for i in $(ls *.gene*);do sed -i -e "s/'//g" $i;; done   ;否则读入会报错!!!!!!!!!!!!!!!!!!!!!!
Est_gene_merge <- Est_merge(f_path, out_name,ind_pattern)
