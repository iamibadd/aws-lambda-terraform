resource "aws_s3_object" "source_layers" {
  bucket = var.source_code_bucket
  key    = "nodejs_layers.zip"
  source = data.archive_file.layers.output_path
  etag   = filemd5(data.archive_file.layers.output_path)
}

resource "aws_lambda_layer_version" "layers" {
  s3_bucket                = aws_s3_object.source_layers.bucket
  s3_key                   = aws_s3_object.source_layers.key
  layer_name               = "nodejs_layers"
  compatible_runtimes      = [var.nodejs_version]
  compatible_architectures = ["x86_64"] # important to define
}