terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  zone = "ru-central1-a"
}


resource "yandex_compute_instance" "db1" {

#  count = 3
#  name = "web-$(count.index + 1)"
  name = "db1"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd80le4b8gt2u33lvubr"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "root:${file("~/.ssh/id_rsa.pub")}"
  }
}


resource "yandex_compute_instance" "db2" {

  name = "db2"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd80le4b8gt2u33lvubr"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "root:${file("~/.ssh/id_rsa.pub")}"
  }
}


resource "yandex_compute_instance" "db3" {

  name = "db3"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd80le4b8gt2u33lvubr"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "root:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "hp1" {

  name = "hp1"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd80le4b8gt2u33lvubr"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "root:${file("~/.ssh/id_rsa.pub")}"
  }
}




resource "yandex_vpc_network" "network-1" {
  name = "network"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}


output "internal_ip_address_db1" {
  value = yandex_compute_instance.db1.network_interface.0.ip_address
}

output "internal_ip_address_db2" {
  value = yandex_compute_instance.db2.network_interface.0.ip_address
}

output "internal_ip_address_db3" {
  value = yandex_compute_instance.db3.network_interface.0.ip_address
}

output "internal_ip_address_hp1" {
  value = yandex_compute_instance.hp1.network_interface.0.ip_address
}

output "external_ip_address_db1" {
  value = yandex_compute_instance.db1.network_interface.0.nat_ip_address
}

output "external_ip_address_db2" {
  value = yandex_compute_instance.db2.network_interface.0.nat_ip_address
}

output "external_ip_address_db3" {
  value = yandex_compute_instance.db3.network_interface.0.nat_ip_address
}

output "external_ip_address_hp1" {
  value = yandex_compute_instance.hp1.network_interface.0.nat_ip_address
}
