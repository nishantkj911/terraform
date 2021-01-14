variable "instance_type" {
  default = "t2.micro"
}

variable "access_key" {
  description = "The AWS access key of the gen account"
}

variable "secret_key" {
  description = "The secret of the provided access key"
}