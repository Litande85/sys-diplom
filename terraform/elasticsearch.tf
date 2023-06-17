resource "yandex_compute_instance" "elasticsearch" {
  name        = "elasticsearch"
  hostname    = "elasticsearch"
  zone        = "ru-central1-c"

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
    subnet_id  = yandex_vpc_subnet.private-subnet-3.id
    security_group_ids = [yandex_vpc_security_group.private-sg.id]
    ip_address         = "10.3.0.100"
  }

  metadata = {
    user-data = "${file("./meta.txt")}"
  }

  scheduling_policy {  
    preemptible = true
  }

}