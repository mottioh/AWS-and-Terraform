output "web_server_public_address" {
    value = aws_instance.web.*.public_ip
}
output "db_private_addresses" {
    value = aws_instance.db.*.private_ip
}
output "web_server_private_address" {
    value = aws_instance.web.*.private_ip
}
output "elb-dns"{
value =aws_elb.web1.dns_name
}