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

Dockerfile Breakdown
The Dockerfile now consists of two distinct stages labeled "build" and "production". Below is a detailed examination of each stage:

Stage 1: Build
For the initial stage, we use node:18-alpine as the base image, which is known for its minimal footprint compared to the standard Node.js images. The operations performed in this stage include:

Setting Up the Working Directory:

We establish /app as the working directory.
Copying Necessary Files:

Key files such as package.json and yarn.lock are transferred into the image.
Installing Dependencies:

We execute yarn install with an extended network timeout to ensure all dependencies are thoroughly fetched and installed.
Copying Application Files:

All necessary application files are copied into the Docker image.
This stage focuses on assembling the application in a controlled, Docker-contained environment. It ensures that only essential dependencies and build tools are included in the final production image.

Stage 2: Production
The second stage also starts with the node:18-alpine base image. This part of the process is streamlined to include only what is necessary for running the application in a production environment:

Preparing the Application:

The entire application directory from the build stage is copied over to the new stage. This method ensures that the production image contains only the compiled application and its runtime dependencies, excluding any build-specific tools and intermediate files.
Exposing the Port:

The Dockerfile specifies port 3000 for the application, making it accessible on this port.
Starting the Application:

The final command in the Dockerfile is set to run the application using yarn start.
Importance of Multi-Stage Builds
Multi-stage builds provide significant advantages:

Efficiency in Image Size:

By separating the build environment from the production environment, we significantly reduce the final image size, which speeds up the deployment process and minimizes runtime resource utilization.
Security:

Smaller images generally contain fewer components, which can reduce the attack surface of the container.
Cost-Effective:

Smaller images mean less storage and bandwidth consumption, translating to cost savings, especially in scaled environments.
CICD Pipelines
Docker.Yaml
The docker.yaml pipeline is explained below, it is the pipeline we have that is responsible for building the docker image and uploading it to Amazon ECR, it is defined so that the build and push only triggers when a change has been made to the application code

Checkout Code:
Pulls the latest code from the repository.
Log in to Amazon ECR:
Authenticates Docker with ECR, allowing it to push images to your ECR repository.
Build and Push Docker Image:
Builds the Docker image from the Dockerfile in the app directory.
Pushes the tagged image to the specified ECR repository.
Terraform YAML files
The terraform pipelines we have, are responsible for terraform plan, apply and destroy. They are triggered only when a change has been made to the tf config

The terraform plan pipeline is set which means it runs on a push from any branch. The terraform apply and destroy pipelines can only be triggered manually using workflow-dispatch on the main branch (Once a PR has been completed).

Checkout Code:

Retrieves the latest repository files.
Setup Terraform:

Installs and sets up Terraform in the workflow environment.
Terraform Init:

Initializes the Terraform configuration and downloads provider plugins.
Terraform Plan:

Creates an execution plan, displaying the resources Terraform will create or modify.
Terraform Apply:

Applies the configuration to provision the infrastructure if triggered manually.
Terraform Destroy:

Applies the destroy to the infrastructure if triggered manually within the main branch.

