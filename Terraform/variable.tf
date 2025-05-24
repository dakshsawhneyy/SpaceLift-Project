variable "ami_id" {
  default = "ami-0e35ddab05955cf57"
}

variable "volume_size" {
  default = 8
}

variable "public_key" {
  type = string
  default = "/mnt/workspace/tf-keyy.pub"
}
