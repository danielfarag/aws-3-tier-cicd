output "gateway_url" {
  value = "https://${aws_api_gateway_rest_api.my_api_gateway.id}.execute-api.${var.region}.amazonaws.com/${aws_api_gateway_stage.my_stage.stage_name}/${aws_api_gateway_resource.resource.path_part}"
}