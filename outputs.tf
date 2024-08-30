output "tags_out" {
    value = merge(var.common_tags,var.global_tags)
  
}