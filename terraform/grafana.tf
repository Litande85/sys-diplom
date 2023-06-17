resource "yandex_compute_instance" "grafana" {
  name        = "grafana"
  hostname    = "grafana"
  zone        = "ru-central1-c"

  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8456n7d102l8p6ipgl" #Debian 11
      type     = "network-ssd"
      size     = "16"    
      }
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.public-subnet.id
    security_group_ids = [yandex_vpc_security_group.private-sg.id, yandex_vpc_security_group.grafana-sg.id]
    ip_address         = "10.4.0.11"
    nat = true
  }

  metadata = {
    user-data = "${file("./meta.txt")}"
  }

  scheduling_policy {  
    preemptible = true
  }

}