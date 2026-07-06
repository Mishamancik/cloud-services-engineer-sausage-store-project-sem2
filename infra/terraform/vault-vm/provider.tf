terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"

  backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    bucket = "finalproject-s3-bucket"
    region = "ru-central1"
    key    = "tf-state.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true

    # Terraform State Lock, чтобы избежать одновременного изменения состояния несколькими пользователями
    dynamodb_endpoint = "https://docapi.serverless.yandexcloud.net/ru-central1/b1gborgk3k44sgna3bvh/etn3fe2lnra305cr05co"
    dynamodb_table    = "ydb524"
  }
}

provider "yandex" {
  service_account_key_file = "authorized_key.json"
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}
