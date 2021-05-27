# %%
# load modules
module load freebayes/1.3.4
module load tabix/0.2.6

# %%
# call with freebayes
mkdir vcf
BAMS=bamlist.txt
ls bam/*.bam > $BAMS
REF=fasta/PGSC_DM_v4.03_pseudomolecules_ALL.fasta
VCF=vcf/PRJNA414303.CHR5.vcf.gz
bsub << EOF
#!/bin/bash
#BSUB -o calling.out
#BSUB -e calling.err
freebayes \
    -f $REF \
    -L $BAMS \
    --ploidy 4 \
    --hwe-priors-off \
    --min-mapping-quality 10 \
    --haplotype-length -1 \
    --genotype-qualities \
    --strict-vcf \
    | bgzip > $VCF
EOF
