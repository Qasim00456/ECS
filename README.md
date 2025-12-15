# ECS
Overview

This project involves containerizing Amazon’s threat modelling application using Docker, with multi-stage builds to optimize image size and performance. The Docker images are stored in Amazon Elastic Container Registry (ECR). Infrastructure for deploying the application is managed via Terraform, provisioning an ECS task, service, and cluster. The deployment includes a Virtual Private Cloud (VPC) and load balancer for high availability and scalability. Fully automated pipelines enable an end-to-end DevOps workflow, from code to production.

Below is a live instance of the threat modelling tool:
