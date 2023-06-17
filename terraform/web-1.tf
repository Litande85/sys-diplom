resource "yandex_compute_instance" "web-1" {
  name        = "web-1"
  hostname    = "web-1"
  zone        = "ru-central1-a"

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
    subnet_id  = yandex_vpc_subnet.private-subnet-1.id
    security_group_ids = [yandex_vpc_security_group.private-sg.id]
    ip_address         = "10.1.0.10"
  }

  metadata = {
    user-data = "${file("./meta.txt")}"
  }

  scheduling_policy {  
    preemptible = true
  }

}