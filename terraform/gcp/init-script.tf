# Render a part using a `template_file`
data "template_file" "build-init" {
  template = file("../scripts/build-init-gcp.sh")
}

# Render a multi-part cloud-init config making use of the part
# above, and other source files
data "template_cloudinit_config" "build-config" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.build-init.rendered
  }
}
