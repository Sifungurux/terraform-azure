variable "project_name" {
	type = string
	default = "Developemnt of terraform skills"
}
variable "resource_tags" {
	type = map(string)
	default = {}
}

locals {
  required_tags = {
		"project"     = var.project_name,
		"created_at"  = formatdate("MMM DD, YYYY", timestamp())
		"created_by"  = "Jonas Kirk Pedersen"
	}
  tags = merge(var.resource_tags, local.required_tags)

  env_container = {
    dev : {
      access_type = "blob"
    }
	}
}
