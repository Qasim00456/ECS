variable "ecs_cluster_name" {
  type        = string
  default     = "name-ecs-cluster"
}

variable "ecs_task_family" {
  type        = string
  default     = "threat-modelling-app"
}

variable "ecs_task_cpu" {
  type        = string
  default     = "1024"
}

variable "ecs_task_memory" {
  type        = string
  default     = "3072"
}

variable "ecs_container_name" {
  type        = string
  default     = "threat-modelling-app"
}

variable "ecs_container_image" {
  type        = string
  default     = "281127105286.dkr.ecr.eu-north-1.amazonaws.com/yarn-app"
}

variable "ecs_container_port" {
  type        = number
  default     = 3000
}

variable "ecs_host_port" {
  type = number
  default = 3000

}

variable "desired_count" {
  type = number
  default = 1
}

variable "ecs_service_name" {
  type        = string
  default     = "threat-model-app-service"
}

variable "subnet_ids" {
  type = list(string)
  description = "List of subnet IDs where ECS tasks should run"
}

variable "sg_id" {
  type = list(string)
  description = "Security group ID for ECS tasks"

}



variable "alb_id" {

}

variable "target_group_arn" {
  type = string
  
}
  
  variable "execution_role_arn" {
  type = string
  description = "The ARN of the ECS execution role"
}


