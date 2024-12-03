library(ready4)
library(ready4use)
library(ready4fun)
X <- Ready4useRepos(gh_repo_1L_chr = "ready4-dev/ready4",
                    gh_tag_1L_chr = "Documentation_0.0")
Y <- ingest(X)
X1 <- Ready4useRepos(gh_repo_1L_chr = "avertableburden/avert",
                    gh_tag_1L_chr = "Documentation_0.0")
Y1 <- ingest(X1)
Y@b_Ready4useIngest@objects_ls$fns_dmt_tb <- Y1@b_Ready4useIngest@objects_ls$fns_dmt_tb
Y1@b_Ready4useIngest@objects_ls <- Y@b_Ready4useIngest@objects_ls
Y1 <- share(Y1, type_1L_chr = "prefer_gh")
