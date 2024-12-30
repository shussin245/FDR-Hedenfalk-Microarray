if (!require("qvalue", quietly = TRUE))
  BiocManager::install('qvalue')

load("~/hedenfalk_log_scaled.RData")

hedenfalk_log_scaled$t   <- apply(hedenfalk_log_scaled[,4:18],1,function(x)t.test(unlist(x[1:7]),unlist(x[8:15]))$statistic)
hedenfalk_log_scaled$t.p <- apply(hedenfalk_log_scaled[,4:18],1,function(x)t.test(unlist(x[1:7]),unlist(x[8:15]))$p.value)

library(qvalue)
data(hedenfalk)
numperms <- 3171*100
hedenfalk_log_scaled$t_perm.p <- sapply(hedenfalk_log_scaled$t,function(x)sum(abs(as.vector(hedenfalk$stat0)) >= abs(x))/numperms)

hedenfalk_log_scaled$wilcox.p <- apply(hedenfalk_log_scaled[,4:18],1,function(x)wilcox.test(unlist(x[1:7]),unlist(x[8:15]))$p.value)

library(FDRestimation)
p.fdr.obj <- p.fdr(p=hedenfalk_log_scaled$t.p)
hedenfalk_log_scaled$t.p.fdrs <- p.fdr.obj$fdrs
plot(p.fdr.obj, main="FDR Statistics for Hedenfalk Data and Welch-Satterthwaite Parametric p-values")

p.fdr.obj <- p.fdr(p=hedenfalk_log_scaled$t_perm.p)
hedenfalk_log_scaled$t_perm.p.fdrs <- p.fdr.obj$fdrs
plot(p.fdr.obj, main="FDR Statistics for Hedenfalk Data and Permutation p-values")
p.fdr.obj <- p.fdr(p=hedenfalk_log_scaled$wilcox.p)
hedenfalk_log_scaled$wilcox.p.fdrs <- p.fdr.obj$fdrs
plot(p.fdr.obj, main="FDR Statistics for Hedenfalk Data and Wilcoxon p-values")

answer <- sum(hedenfalk_log_scaled$t.p.fdrs <= 0.05)
print(answer)

answer <- sum(hedenfalk_log_scaled$wilcox.p.fdrs <= 0.05)
print(answer)

answer <- sum(hedenfalk_log_scaled$t_perm.p.fdrs <= 0.05)
print(answer)

p.fdr.obj <- p.fdr(p=hedenfalk_log_scaled$t_perm.p,set.pi0 = 0.67)
answer <- sum(p.fdr.obj$fdrs <= 0.05)
print(answer)
plot(p.fdr.obj, main="FDR Statistics for Hedenfalk Data, Permutation p-values and Estimated 67% Fraction of Truly Null-Effect Genes")

p.fdr.obj <- p.fdr(p=hedenfalk_log_scaled$t_perm.p,set.pi0 = 0.67)
hedenfalk_log_scaled$t_perm.p.fdrs.67 <- p.fdr.obj$fdrs
answer <- hedenfalk_log_scaled[hedenfalk_log_scaled$t_perm.p.fdrs.67 <= 0.02, 1:3]
print(answer)

