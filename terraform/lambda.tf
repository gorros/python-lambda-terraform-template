# we can use one zip file for all lambdas, but if you wish you can define
# separate archives for each lambda
data "archive_file" "lambda_archive" {
  type        = "zip"
  source_dir  = "../lambda/src"
  output_path = "${var.project_name}-${terraform.workspace}-lambda.zip"
}

# here we define archive for lambda layer
# we will use CI/CD to put corresponding Python libraries to source_dir
data "archive_file" "lambda_layer_archive" {
  type        = "zip"
  source_dir  = var.lambda_packages_path
  output_path = "${var.project_name}-${terraform.workspace}-lambda-layer.zip"
}

resource "aws_lambda_layer_version" "lambda_layer" {
  layer_name = "${var.project_name}-${terraform.workspace}-lambda-layer"

  filename         = data.archive_file.lambda_layer_archive.output_path
  source_code_hash = data.archive_file.lambda_layer_archive.output_base64sha256

  compatible_runtimes = ["python3.7", "python3.8"]
}