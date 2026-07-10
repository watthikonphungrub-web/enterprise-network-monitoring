terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
    }
  }
}

provider "docker" {}

# 1. สร้างโครงข่ายส่วนตัว (Network) ให้เซิร์ฟเวอร์คุยกันเองได้
resource "docker_network" "monitoring_net" {
  name = "monitoring_network"
}

# 2. เสก Node Exporter (ตัวเก็บสถิติ)
resource "docker_image" "node_exporter" {
  name         = "prom/node-exporter:latest"
  keep_locally = false
}
resource "docker_container" "node_exporter" {
  image = docker_image.node_exporter.image_id
  name  = "node_exporter"
  ports {
    internal = 9100
    external = 9100
  }
  networks_advanced {
    name = docker_network.monitoring_net.name
  }
}

# 3. เสก Prometheus (ฐานข้อมูลรวบรวมสถิติ)
resource "docker_image" "prometheus" {
  name         = "prom/prometheus:latest"
  keep_locally = false
}
resource "docker_container" "prometheus" {
  image = docker_image.prometheus.image_id
  name  = "prometheus"
  ports {
    internal = 9090
    external = 9090
  }
  networks_advanced {
    name = docker_network.monitoring_net.name
}
volumes {
    host_path      = "${abspath(path.cwd)}/prometheus.yml"
    container_path = "/etc/prometheus/prometheus.yml"
  }
  volumes {
    host_path      = "${abspath(path.cwd)}/alert.rules.yml"
    container_path = "/etc/prometheus/alert.rules.yml"
  }
}

# 4. เสก Grafana (หน้าปัดแสดงผล Dashboard)
resource "docker_image" "grafana" {
  name         = "grafana/grafana:latest"
  keep_locally = false
}
resource "docker_container" "grafana" {
  image = docker_image.grafana.image_id
  name  = "grafana"
  ports {
    internal = 3000
    external = 3000
  }
  networks_advanced {
    name = docker_network.monitoring_net.name
  }
}
# ----------------------------------------
# 🚨 Alertmanager (ระบบโทรโข่งแจ้งเตือน)
# ----------------------------------------
resource "docker_image" "alertmanager" {
  name         = "prom/alertmanager:latest"
  keep_locally = false
}

resource "docker_container" "alertmanager" {
  image = docker_image.alertmanager.image_id
  name  = "alertmanager"
  
  # เปิดพอร์ต 9093 ให้เราเข้าไปดูหน้าเว็บของ Alertmanager ได้
  ports {
    internal = 9093
    external = 9093
  }
  
  # จับเข้า Network วงเดียวกับ Prometheus
  networks_advanced {
    name = docker_network.monitoring_net.name
  }
}
# 5. เสก cAdvisor (สายลับส่องคอนเทนเนอร์)
resource "docker_image" "cadvisor" {
  name         = "gcr.io/cadvisor/cadvisor:latest"
  keep_locally = false
}

resource "docker_container" "cadvisor" {
  image = docker_image.cadvisor.image_id
  name  = "cadvisor"
  ports {
    internal = 8080
    external = 8080
  }
  networks_advanced {
    name = docker_network.monitoring_net.name
  }
  volumes {
    host_path      = "/"
    container_path = "/rootfs"
    read_only      = true
  }
  volumes {
    host_path      = "/var/run"
    container_path = "/var/run"
    read_only      = true
  }
  volumes {
    host_path      = "/sys"
    container_path = "/sys"
    read_only      = true
  }
  volumes {
    host_path      = "/var/lib/docker"
    container_path = "/var/lib/docker"
    read_only      = true
  }
}
# 1. สั่งให้ Terraform ไปดาวน์โหลดพิมพ์เขียวของ SNMP Exporter มาเตรียมไว้
resource "docker_image" "snmp_exporter" {
  name         = "prom/snmp-exporter:latest"
  keep_locally = true
}

# 2. สั่งสร้าง Container วุ้นแปลภาษา และเปิดประตูพอร์ต 9116 ให้มัน
resource "docker_container" "snmp_exporter" {
  name  = "snmp_exporter"
  image = docker_image.snmp_exporter.name
  ports {
    internal = 9116
    external = 9116
  }
}
