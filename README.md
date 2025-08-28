# ZEDEDA Terraform Demo

This repository, `sathiyadev-zededa/terraform-demo`, provides a Terraform configuration for managing edge infrastructure on the ZEDEDA Cloud platform. It deploys edge nodes, network instances, and applications using the ZEDEDA Terraform Provider. The configuration supports two edge nodes (`node1` and `node2`), each with a network instance and a PPE detection demo application.

## Table of Contents
- [Prerequisites](#prerequisites)
- [Repository Structure](#repository-structure)
- [Setup Instructions](#setup-instructions)
- [Usage](#usage)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)

## Prerequisites
- **Terraform**: Version 2.5.0 or higher.
- **ZEDEDA Cloud Account**: Access to ZEDEDA Cloud with a valid API token.
- **Git**: To clone and manage this repository.
- **Environment Variables**:
  - `TF_VAR_zedcloud_token`: Your ZEDEDA API token.

## Repository structure
terraform-demo/
├── provider.tf                   # Provider and variable definitions
├── zededa_resource_edge_nodes.tf  # Edge nodes and network instances
├── zededa_resource_zedge_apps.tf  # Application configurations
├── output.tf                 # Output definitions (node names and IDs)
├── terraform.tfvars          # Variable values (customize as needed)
└── .gitignore                # Excludes state files and Terraform artifacts


## Setup Instructions

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/sathiyadev-zededa/terraform-demo.git
   cd terraform-demo
2. **Configuration Parameter**
```bash
node1 = "node1"
node2 = "node2"
serial1 = "your-actual-serial-1"
serial2 = "your-actual-serial-2"
project_name = "your-project-name"
4. **Initialize Terraform:**
terraform init
5. **Exclude State Files:**
Ensure .gitignore includes:
```bash
terraform.tfstate
terraform.tfstate.*.backup
.terraform/
.terraform.lock.hcl

## Usage

Plan the Deployment:
```bash
terraform plan
Review the plan to ensure it creates:

Edge nodes (node1, node2)
Network instances (node1-eth0, node2-eth0)
Applications (ppe-detection-node1, ppe-detection-node2)


Apply the Configuration:

