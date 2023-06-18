resource "yandex_compute_instance" "web-2" {
  name        = "web-2"
  hostname    = "web-2"
  zone        = "ru-central1-b"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.container-optimized-image.id
    }
    
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.private-subnet-2.id
    security_group_ids = [yandex_vpc_security_group.private-sg.id]
    ip_address         = "10.2.0.10"
  }

  metadata = {
    user-data = "${file("./meta.txt")}"
  }



}