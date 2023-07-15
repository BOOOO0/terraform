resource "ncloud_vpc" "ncloud-vpc1" {
  name            = "ncloud-vpc1"
  ipv4_cidr_block = "10.0.0.0/16"
}

# Public Subnet
resource "ncloud_subnet" "subnet_public" {
  name           = "ncloud-vpc1-public"
  vpc_no         = ncloud_vpc.ncloud-vpc1.vpc_no
  subnet         = cidrsubnet(ncloud_vpc.ncloud-vpc1.ipv4_cidr_block, 8, 0) // "10.0.0.0/24"
  zone           = "KR-2"
  network_acl_no = ncloud_network_acl.network_acl_public.id
  subnet_type    = "PUBLIC" // PUBLIC(Public)
}
# Private Subnet
resource "ncloud_subnet" "subnet_private" {
  name           = "ncloud-vpc1-private"
  vpc_no         = ncloud_vpc.ncloud-vpc1.vpc_no
  subnet         = cidrsubnet(ncloud_vpc.ncloud-vpc1.ipv4_cidr_block, 8, 1) // "10.0.1.0/24"
  zone           = "KR-2"
  network_acl_no = ncloud_network_acl.network_acl_private.id
  subnet_type    = "PRIVATE" // PRIVATE(Private)
}
# Network ACL
resource "ncloud_network_acl" "network_acl_public" {
  vpc_no = ncloud_vpc.ncloud-vpc1.id
  name   = "ncloud-vpc1-public-acl"
}
resource "ncloud_network_acl" "network_acl_private" {
  vpc_no = ncloud_vpc.ncloud-vpc1.id
  name   = "ncloud-vpc1-private-acl"
}