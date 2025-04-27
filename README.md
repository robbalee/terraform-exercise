# Terraform Cloud Provider Modules

This repository contains a collection of Terraform modules for various public cloud providers (AWS, Azure) designed to simplify infrastructure provisioning and management. The modules follow best practices for each cloud provider and implement consistent patterns for state management using Terragrunt.

## Purpose

This repository serves as a centralized location for reusable Terraform modules that can be used across different environments and projects. The primary goals are:

- Provide standardized, reusable modules for AWS and Azure resources
- Implement proper state management using Terragrunt
- Enable consistent infrastructure patterns across different cloud providers
- Demonstrate best practices for Terraform module design and implementation

## Repository Structure

```
terraform-exercise/
├── dev/                  # Development environment configurations
│   ├── aws/              # AWS-specific development resources
│   └── Azure/            # Azure-wspecific development resources
├── modules/              # Reusable Terraform modules
│   ├── aad_b2c/          # Azure AD B2C module
│   ├── hashicorp_backend/# Terraform backend management
│   ├── key_vault/        # Azure Key Vault module
│   ├── resource_group/   # Azure Resource Group module
│   └── VPC/              # AWS VPC module
├── prod/                 # Production environment configurations
└── stag/                 # Staging environment configurations
```

## Available Modules

### AWS Modules
- **VPC**: Creates AWS VPC with customizable CIDR blocks and subnets
- **AWS Backend**: S3 bucket and DynamoDB table for Terraform state management

### Azure Modules
- **Resource Group**: Creates and manages Azure resource groups
- **Key Vault**: Secure key management with Azure Key Vault
- **AAD B2C**: Azure Active Directory B2C for identity management
- **Azure Backend**: Storage account and container for Terraform state management
- **Virtual Network**: Azure networking components
- **Azure VM with Ansible**: VM deployment with Ansible configuration

## How to Use

### Prerequisites

- Terraform >= 0.14.x
- Terragrunt >= 0.35.x
- AWS CLI (for AWS resources)
- Azure CLI (for Azure resources)

### Setting Up

1. **Clone this repository**

   ```bash
   git clone https://github.com/robbalee/terraform-exercise.git
   cd terraform-exercise
   ```

2. **Create environment variables file**

   Each environment requires an `environment_vars.yaml` file:

   For AWS:
   ```yaml
   environment: "dev"
   region: "us-west-2"
   ```

   For Azure:
   ```yaml
   environment: "dev"
   location: "westeurope"
   subscription: "your-subscription-id"
   tenant_id: "your-tenant-id"
   ```

3. **Initialize and apply using Terragrunt**

   ```bash
   cd dev/Azure/key_vault  # Example: deploying a Key Vault
   terragrunt init
   terragrunt plan
   terragrunt apply
   ```

### Module Usage Examples

#### AWS VPC Module

```hcl
module "vpc" {
  source = "github.com/robbalee/terraform-exercise//modules/VPC"
  
  vpc_cidr       = "10.0.0.0/16"
  vpc_name       = "main-vpc"
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
}
```

#### Azure Key Vault Module

```hcl
module "key_vault" {
  source = "github.com/robbalee/terraform-exercise//modules/key_vault"
  
  name              = "example-vault"
  resource_group    = "example-rg"
  location          = "westeurope"
  tenant_id         = var.tenant_id
}
```

## Best Practices

This repository follows these best practices:

- **Module Isolation**: Each module performs a specific function
- **State Management**: Remote state with locking
- **Variable Validation**: Input variables are validated
- **Consistent Structure**: Standard module structure with main.tf, variables.tf, outputs.tf
- **Documentation**: Each module includes documentation and examples

## Roadmap

### Current Focus
- Complete Azure module documentation
- Add support for Azure Container Registry
- Improve AWS module testing

### OpenTofu Integration Roadmap

[OpenTofu](https://opentofu.org/) is an open source fork of Terraform that aims to preserve the open nature of infrastructure as code. Our plan to integrate OpenTofu:

#### Phase 1: Compatibility Testing (Q2 2025)
- Test existing modules with OpenTofu
- Document any compatibility issues
- Create separate branch for OpenTofu-specific changes

#### Phase 2: Dual Support (Q3 2025)
- Add OpenTofu configuration options in Terragrunt files
- Update documentation with OpenTofu usage examples
- Create CI/CD pipelines for testing both Terraform and OpenTofu

#### Phase 3: Native OpenTofu Support (Q4 2025)
- Create OpenTofu-optimized modules
- Implement OpenTofu-specific features
- Provide migration guides from Terraform to OpenTofu

#### Phase 4: Full Transition Option (2026)
- Complete feature parity between Terraform and OpenTofu implementations
- Maintain both options for users

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-module`)
3. Commit your changes (`git commit -m 'Add some amazing module'`)
4. Push to the branch (`git push origin feature/amazing-module`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
