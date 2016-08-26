data(CCLE_data)
data(Mitochondrial_genes)

CCLE.data <- CCLE_data[,-c(1,2)]
mito.loc <- which(as.character(CCLE_data[,2]) %in% Mitochondrial_genes)
CCLE.mito <- CCLE_data[mito.loc,-c(1,2)]
row.names(CCLE.mito) <- CCLE_data[mito.loc,2]

CCLE.seed <- list()
CCLE.cor.vec <- list()

for(i in 1:3){
  set.seed(i)
  CCLE.seed[[i]] <- FindSeed(gem = CCLE.mito,
                             seed.size = 10,
                             iterations = 100,
                             messages = 100)}

for(i in 1:3){
  CCLE.cor.vec[[i]] <-  CVEval(gem.part = CCLE.mito,
                               gem.all = CCLE.data,
                               seed = CCLE.seed[[i]],
                               splits = 10)}



CCLE.cor.df <- (as.data.frame(CCLE.cor.vec))

CVPlot(cv.df = CCLE.cor.df,geneset.loc = mito.loc,
       geneset.name = "Mitochondrial")