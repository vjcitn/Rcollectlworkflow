version 1.0

task Rcollectl_hca_loom {
    input {
        Boolean knitr_eval
        String fileId
        String sample
        Int mem_gb = 60
    }

    command {
        Rscript /tmp/run_Rcollectl.R ${knitr_eval} ${fileId} ${sample}
    }

    output {
        File workflow_hca_loom = "workflow_hca_loom.html"
    }

    runtime {
        docker: "ycheng2022/bioconductor_docker_workflow_hca_loom:devel"
        memory: "${mem_gb} GB"
    }
}

workflow RcollectlWorkflow {
    meta {
        description: "Provide a single-cell analysis Workflow as well as computing resources usage tracking with package Rcollectl"
    }
    
    input {
        Boolean knitr_eval
        String fileId
        String sample
        Int mem_gb = 60
    }

    call Rcollectl_hca_loom {
        input: 
        knitr_eval = knitr_eval, 
        fileId = fileId, 
        sample = sample,
        mem_gb = mem_gb
    }
    
    output {
    	File workflow_hca_loom = Rcollectl_hca_loom.workflow_hca_loom
    }
}
