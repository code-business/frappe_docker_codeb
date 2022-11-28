variable "FRAPPE_VERSION" {
  default = "v14.16.0"
}
variable "ERPNEXT_VERSION" {
  default = "v14.8.0"
}

group "default" {
  targets = ["backend", "frontend"]
}

target "backend" {
  dockerfile = "backend.Dockerfile"
  tags       = ["custom_app/worker:latest"]
  args = {
    "ERPNEXT_VERSION" = ERPNEXT_VERSION
  }
}

target "frontend" {
  dockerfile = "frontend.Dockerfile"
  tags       = ["custom_app/nginx:latest"]
  args = {
    "FRAPPE_VERSION"  = FRAPPE_VERSION
    "ERPNEXT_VERSION" = ERPNEXT_VERSION
  }
}
