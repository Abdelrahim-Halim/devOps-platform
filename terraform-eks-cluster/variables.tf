variable "region" {
    type        = string
    default     = "us-east-2"
    description = "AWS region"
}

variable "worker_instance_type" {
    type = string
    default = "t2.small"
    description = "typy of the worker node in the cluster"
}

variable "master_instance_type" {
    type = string
    default = "t2.medium"
    description = "typy of the worker node in the cluster"
}
