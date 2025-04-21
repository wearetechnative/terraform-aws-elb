module "bucket_logs" {
  source = "github.com/wearetechnative/terraform-aws-s3.git?ref=945d79d5d12cbc2e281afae53c74367a3c6bfd6e"

  name                                     = var.load_balancer_type == "network" ? "nlb-${local.name}-tl" : "alb-${local.name}-tl"
  kms_key_arn                              = null
  use_sse-s3_encryption_instead_of_sse-kms = true
  bucket_policy_addition                   = jsondecode(var.load_balancer_type == "network" ? data.aws_iam_policy_document.nlb_access.json : data.aws_iam_policy_document.alb_access.json)
}

data "aws_arn" "bucket_logs" {
  arn = module.bucket_logs.s3_arn
}

locals {
  s3_alb_access_logs_allow = {
    "us-east-1" : "127311923021"
    "us-east-2" : "033677994240"
    "us-west-1" : "027434742980"
    "us-west-2" : "797873946194"
    "af-south-1" : "098369216593"
    "ca-central-1" : "985666609251"
    "eu-central-1" : "054676820928"
    "eu-west-1" : "156460612806"
    "eu-west-2" : "652711504416"
    "eu-south-1" : "635631232127"
    "eu-west-3" : "009996457667"
    "eu-north-1" : "897822967062"
    "ap-east-1" : "754344448648"
    "ap-northeast-1" : "582318560864"
    "ap-northeast-2" : "600734575887"
    "ap-northeast-3" : "383597477331"
    "ap-southeast-1" : "114774131450"
    "ap-southeast-2" : "783225319266"
    "ap-southeast-3" : "589379963580"
    "ap-south-1" : "718504428378"
    "me-south-1" : "076674570225"
    "sa-east-1" : "507241528517"
    "us-gov-west-1" : "048591011584"
    "us-gov-east-1" : "190560391635"
    "cn-north-1" : "638102146993"
    "cn-northwest-1" : "037604701340"
  }
}

data "aws_iam_policy_document" "alb_access" {
  # https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-access-logs.html#access-logging-bucket-permissions

  statement {
    sid = "AllowPutObject"

    effect = "Allow"

    actions = [
      "s3:PutObject",
    ]

    principals {
      type        = "AWS"
      identifiers = [local.s3_alb_access_logs_allow[data.aws_region.current.name]]
    }

    resources = ["<bucket>/*"]
  }

  # statement {
  #   sid = "AllowGetBucketAcl"

  #   effect = "Allow"

  #   actions = [
  #     "s3:*",
  #   ]

  #   principals {
  #     type        = "Service"
  #     identifiers = ["logdelivery.elb.amazonaws.com"]
  #   }

  #   resources = ["<bucket>"]
  # }
}

data "aws_iam_policy_document" "nlb_access" {

  statement {
    sid = "AllowPutObject"

    effect = "Allow"

    actions = [
      "s3:PutObject",
    ]

    principals {
      type        = "AWS"
      identifiers = [data.aws_caller_identity.current.account_id]
    }

    resources = ["<bucket>/*"]
  }

  statement {
    sid = "AllowGetBucketAcl"

    effect = "Allow"

    actions = [
      "s3:*",
    ]

    principals {
      type        = "Service"
      identifiers = ["logdelivery.elb.amazonaws.com"]
    }

    resources = ["<bucket>"]
  }

    statement {
    sid    = "AWSLogDeliveryAclCheck"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }
    actions   = ["s3:GetBucketAcl"]
    resources = [module.bucket_logs.s3_arn]
  }

  statement {
    sid    = "AWSLogDeliveryWrite"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }
    actions   = ["s3:PutObject"]
    resources = ["${module.bucket_logs.s3_arn}/AWSLogs/${data.aws_caller_identity.current.account_id}/*"]
    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }
}
