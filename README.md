# ECS
Overview

This project involves containerizing Amazon’s threat modelling application using Docker, with multi-stage builds to optimize image size and performance. The Docker images are stored in Amazon Elastic Container Registry (ECR). Infrastructure for deploying the application is managed via Terraform, provisioning an ECS task, service, and cluster. The deployment includes a Virtual Private Cloud (VPC) and load balancer for high availability and scalability. Fully automated pipelines enable an end-to-end DevOps workflow, from code to production.

Below is a live instance of the threat modelling tool:


<img width="823" height="463" alt="image" src="https://github.com/user-attachments/assets/18f25b34-097b-46b6-9c00-283f4b674a00" />


Features

Containerized Application: Dockerized Amazon’s threat modelling tool for consistent, portable deployments.

Optimized Docker Builds: Multi-stage builds to reduce image size and improve performance.

ECR Integration: Docker images pushed to Amazon Elastic Container Registry for versioned, secure storage.

Infrastructure as Code: Provisioned ECS cluster, tasks, and services using Terraform for repeatable and scalable deployments.

High Availability: Configured VPC, subnets, and load balancer to ensure scalable and reliable application delivery.

Automated Pipelines: End-to-end CI/CD workflow with GitHub Actions, enabling automated builds, tests, and deployments.

Security and Compliance Checks: Integrated tools like Trivy and TFLint to scan for vulnerabilities in containers and infrastructure.

End-to-End DevOps Solution: Complete workflow from container build to infrastructure provisioning and automated deployment.


1. Local Application Setup

To run the Threat Modelling tool locally:

Clone the repository

git clone <ecs-project-url>
cd <app-directory>


Install dependencies

yarn install


Start the application

yarn start


Open your browser at http://localhost:3000
 to interact with the application.

2. Local Docker Container Setup

To run the application in Docker:

Build the Docker image

docker build -t <image-name> .


Run the Docker container

docker run -d -p 3000:3000 --name <container-name> <image-name>


Stop the container

docker stop <container-name>

