variable "aws_region" {
  description = "AWS region to launch servers."
}

variable "iam_name" {
  default = "report_lambda"
}

variable "file_name" {
  default = "Report.Lambda.zip"
}

variable "function_name" {
  default = "landcheck-report-lambda"
}

variable "handler" {
  default = "Report.Lambda::Report.Lambda.GenerateReportHandler::FunctionHandler"
}
