# Terraform AWS ELB ![](https://img.shields.io/github/workflow/status/TechNative-B-V/terraform-aws-module-name/tflint.yaml?style=plastic)

<!-- SHIELDS -->

This module implements AWS Elastic Load Balancer

[![](we-are-technative.png)](https://www.technative.nl)


## Standard ALB using best practices:

- No port 80 forwarding
- Only port 443
- Support for SSL certificates using ACM

## How does it work

### First use after you clone this repository or when .pre-commit-config.yaml is updated

Run `pre-commit install` to install any guardrails implemented using pre-commit.

See [pre-commit installation](https://pre-commit.com/#install) on how to install pre-commit.

...

## Usage

To use this module ...

```hcl
{
  some_conf = "might need explanation"
}
```

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->
