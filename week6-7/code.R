## Data frame reading with base-r

pt <- proc.time()

df <- read.table("test.vcf", header=TRUE)

proc.time()-pt





## Tibble reading with readr

pt <- proc.time()

vcf <- read_tsv("test.vcf")

proc.time()-pt



