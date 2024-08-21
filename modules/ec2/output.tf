output "instances_id" {
  value = aws_instance.instances.*.id
}