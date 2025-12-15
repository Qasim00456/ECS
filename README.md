# ECS
Overview

This project involves containerizing Amazon’s threat modelling application using Docker, with multi-stage builds to optimize image size and performance. The Docker images are stored in Amazon Elastic Container Registry (ECR). Infrastructure for deploying the application is managed via Terraform, provisioning an ECS task, service, and cluster. The deployment includes a Virtual Private Cloud (VPC) and load balancer for high availability and scalability. Fully automated pipelines enable an end-to-end DevOps workflow, from code to production.

Below is a live instance of the threat modelling tool:


<img width="823" height="463" alt="image" src="https://github.com/user-attachments/assets/18f25b34-097b-46b6-9c00-283f4b674a00" />


# Features

Containerized Application: Dockerized Amazon’s threat modelling tool for consistent, portable deployments.

Optimized Docker Builds: Multi-stage builds to reduce image size and improve performance.

ECR Integration: Docker images pushed to Amazon Elastic Container Registry for versioned, secure storage.

Infrastructure as Code: Provisioned ECS cluster, tasks, and services using Terraform for repeatable and scalable deployments.

High Availability: Configured VPC, subnets, and load balancer to ensure scalable and reliable application delivery.

Automated Pipelines: End-to-end CI/CD workflow with GitHub Actions, enabling automated builds, tests, and deployments.

Security and Compliance Checks: Integrated tools like Trivy and TFLint to scan for vulnerabilities in containers and infrastructure.

End-to-End DevOps Solution: Complete workflow from container build to infrastructure provisioning and automated deployment.


# 1 Local Application Setup

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

# 2. Local Docker Container Setup

To run the application in Docker:

Build the Docker image

docker build -t <image-name> .


Run the Docker container

docker run -d -p 3000:3000 --name <container-name> <image-name>


Stop the container

docker stop <container-name>


# Project Breakdown

## Terraform Breakdown

The Terraform configuration for the Threat Composer application is organized into multiple **modules**, each responsible for deploying specific AWS infrastructure components. This modular approach ensures a **clean, scalable, and reusable** codebase.

The central control point is the `main.tf` file in the root directory, which pulls together individual modules (ECS, ALB, VPC, and Route 53) to create a cohesive infrastructure environment. This setup defines the overall configuration and how modules interact.

**Key benefits of this modular approach:**

- **Simplified Management:** Manage and update infrastructure components independently without impacting others.  
- **Reusability:** Modules can be reused across projects or environments, e.g., the VPC module can serve multiple applications.  
- **Scalability:** Components can be scaled or modified independently to fit project growth.  

---

## Module Breakdown

### 1. ECS Module

Responsible for deploying the containerized application, the ECS module provisions the ECS cluster and creates task definitions and services to run Docker containers.

**Key components:**

- **ECS Cluster:** Scalable cluster hosting Docker containers.  
- **Task Definitions & Services:** Define container deployment settings like CPU, memory, networking, and scaling policies.  

### 2. ALB Module

The Application Load Balancer (ALB) module configures the ALB to route incoming traffic to ECS services, ensuring availability and reliability.

**Key components:**

- **Load Balancer:** Distributes incoming traffic across containers for high availability.  
- **Target Groups & Health Checks:** Manage traffic routing and monitor container health to serve only healthy instances.  

### 3. VPC Module

Provisions a dedicated Virtual Private Cloud (VPC) network environment, including subnets, route tables, and security groups, to secure and isolate the application infrastructure.

**Key components:**

- **Subnets (Public & Private):** Separate network resources by accessibility — public subnets host load balancers, private subnets host ECS containers.  
- **Security Groups:** Control inbound/outbound traffic to secure communication.  
- **Route Tables:** Manage routing between subnets and internet gateways.  

### 4. Route 53 Module

Manages DNS and domain routing, enabling access to the application via a custom domain and integrating with AWS Certificate Manager (ACM) for SSL.

**Key components:**

- **Hosted Zones & DNS Records:** Route user requests through a friendly domain name.  
- **SSL Certificates (ACM):** Enable HTTPS for secure communication.  


