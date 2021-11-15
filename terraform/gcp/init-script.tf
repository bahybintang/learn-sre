# Render a part using a `template_file`
data "template_file" "build-init" {
  template = file("../scripts/build-server.tpl")

  # vars = {
  #   consul_address = "${aws_instance.consul.private_ip}"
  # }
}

# Render a multi-part cloud-init config making use of the part
# above, and other source files
data "template_cloudinit_config" "build-config" {
  gzip          = false
  base64_encode = false

  # Main cloud-config configuration file.
  part {
    content_type = "text/cloud-config"
    content      = data.template_file.build-init.rendered
  }

  # part {
  #   content_type = "text/x-shellscript"
  #   content      = "baz"
  # }

  # part {
  #   content_type = "text/x-shellscript"
  #   content      = "ffbaz"
  # }
}
