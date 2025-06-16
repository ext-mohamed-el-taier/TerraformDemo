# Introduction
This repository is a demonstration of how to structure and maintain Terraform modules using modern DevOps best practices. It is intended for new customers looking to adopt Terraform at scale with a focus on clean, repeatable infrastructure-as-code patterns.

Included are sample GitHub workflows that represent essential processes for maintaining and deploying Terraform modules—covering linting, security scanning, and validation on every change.

# Framework Components
## Mono Repo for All Central Terraform Pattern Modules
This repository follows a mono-repo approach, where all Terraform modules are stored in a single location. This ensures consistency in how modules are developed, tested, and validated—enabling shared CI/CD pipelines, standardized tooling, and centralized policy enforcement.

## Automated Static Code Analysis on Pull Requests via GitHub Workflows
GitHub Actions are used to automatically run checks on any modules modified in a pull request. These workflows ensure that all Terraform code meets basic standards for syntax, formatting, and security before it is merged.

- Syntax and formatting validation (terraform fmt)

- Linting and style checks (tflint)

- Security scanning (tfsec, checkov)

![image](/images/autochecks.png)

### Terraform Fmt
terraform fmt is used to enforce consistent code formatting across all modules. It automatically checks that Terraform files are properly structured and readable, helping teams maintain a clean and professional codebase.

### TFLint
TFLint is a Terraform linter that detects potential issues such as deprecated syntax, unused declarations, or cloud provider-specific misconfigurations. It helps catch problems early and enforces consistent coding conventions across modules. See .tflint.hcl for configured rules

### TfSec
TfSec is used to scan Terraform code for security issues by checking it against common misconfiguration patterns and security best practices.

### Checkov
Checkov is a static analysis tool that inspects Terraform for compliance with policies and security benchmarks such as CIS. It helps identify issues early in the development lifecycle.

### Git Exclusions
The .gitignore file is configured to exclude sensitive files such as state files, backend configs, and local credentials. This helps prevent accidental commits of data that should never leave a developer’s machine or CI environment.

## Templated GitHub Workflows for Terraform Resource Deployment
A sample reusable, templated GitHub workflow is provided to enforce consistent deployment processes see `(.github/workflows/Deploy-Terraform-Project.yml)`. These include:

-  Standardized checks and validations

- Approval gates for production changes

-  Integration with passwordless authentication using federated identity (OIDC) for secure cloud access

## Considerations and Recommendations
## Dev Containers
CI/CD and quality controls work best when enforced early in the development cycle. This repo support does not use Dev Containers, however it is reccommended to implement and adopt Dev Containers as it allows developers to work in a pre-configured, reproducible environment that mirrors the CI pipeline  —reducing "works on my machine" issues.

### Pre-Commit Checks
Integrating pre-commit hooks ensures code is automatically formatted, validated, and scanned before it's even committed. This includes tools like terraform fmt, tflint, tfsec, and checkov, enabling a "shift-left" approach to testing and quality control.

Additionally, pre-commit hooks can be configured to *automate the creation and updates to Terraform documentation.* This can include automatically generating module descriptions, input/output variable docs, and other necessary documentation directly from the code comments or structure. By ensuring that documentation is part of the commit cycle, you help keep your Terraform resources self-documented and up-to-date without the need for manual intervention.

By using Pre-Commit and Dev Containers, this process becomes part of the development workflow, ensuring consistent, automated documentation alongside code validation.

### GitHub Runner Custom Image
In production environments, it's recommended to use a custom GitHub Actions runner image to avoid the overhead of installing CI/CD tools (like Terraform, TFLint, tfsec, etc.) with every workflow run.

### Terragrunt for Reduced Code Repetition

In production, it's highly recommended to use Terragrunt to simplify the management of Terraform configurations, especially when working with multiple modules and environments.

Terragrunt helps reduce code repetition by:

- Automatically generating common Terraform files, such as variables.tf, backend.tf, and provider configurations, making it easier to manage consistent configurations across all modules. Terragrunt allows you to summarise an entire deployment in a single file using 'include' and 'input' statements

- Centralizing and reusing common configurations, such as state backend settings, in a terragrunt.hcl file to avoid the need for duplication in every module.

Ensuring consistent naming patterns for tfstate files and cloud resources, helping maintain structure and reduce errors across multiple environments or workspaces.