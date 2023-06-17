resource "yandex_compute_snapshot_schedule" "snapshot" {
  name = "snapshot"

  schedule_policy {
    expression = "0 0 ? * *"
  }

  snapshot_count = 7

  snapshot_spec {
    description = "daily-snapshot"
  }

  disk_ids = ["${yandex_compute_instance.bastion.boot_disk.0.disk_id}", "${yandex_compute_instance.web-1.boot_disk.0.disk_id}", "${yandex_compute_instance.web-2.boot_disk.0.disk_id}", "${yandex_compute_instance.prometheus.boot_disk.0.disk_id}", "${yandex_compute_instance.grafana.boot_disk.0.disk_id}", "${yandex_compute_instance.elasticsearch.boot_disk.0.disk_id}", "${yandex_compute_instance.kibana.boot_disk.0.disk_id}",]
}
