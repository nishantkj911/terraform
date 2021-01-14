variable "instance_type" {
  default = "t2.micro"
}

variable "access_key" {
  description = "The AWS access key of the gen account"
}

variable "secret_key" {
  description = "The secret of the provided access key"
}

variable "image_id" {
  default = "ami-04b1ddd35fd71475a" // Amazon Linux 2 AMI 64-bit x86
  description = "The ID of the image being used to deploy the instance"
}