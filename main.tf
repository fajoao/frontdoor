provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "fabiofd-rg" {
  name     = "fabiofd-rg"
  location = "eastus2"
}

resource "azurerm_frontdoor" "fjsfd" {
  name                  = "fjsfd"
  resource_group_name   = azurerm_resource_group.fabiofd-rg.name

  routing_rule {
    name               = "roteamento"
    accepted_protocols = ["Http", "Https"]
    patterns_to_match  = ["/celulares"]
    frontend_endpoints = ["FrontendEndpoint1"]
    forwarding_configuration {
      forwarding_protocol = "MatchRequest"
      backend_pool_name   = "mlaBackend"
    }
  }

  backend_pool_load_balancing {
    name = "LoadBalancingSettings1"
  }

  backend_pool_health_probe {
    name = "HealthProbeSetting1"
    path = "/celulares"
  }

  backend_pool {
    name = "mlaBackend"
    backend {
      host_header = "apimla.azurewebsites.net"
      address     = "apimla.azurewebsites.net"
      http_port   = 80
      https_port  = 443
    }
    load_balancing_name = "LoadBalancingSettings1"
    health_probe_name   = "HealthProbeSetting1"
  }

  backend_pool {
    name = "mlbBackend"
    backend {
      host_header = "apimlb.azurewebsites.net"
      address     = "apimlb.azurewebsites.net"
      http_port   = 80
      https_port  = 443
    }
    load_balancing_name = "LoadBalancingSettings1"
    health_probe_name   = "HealthProbeSetting1"
  }

  backend_pool {
    name = "mlcBackend"
    backend {
      host_header = "apimlc.azurewebsites.net"
      address     = "apimlc.azurewebsites.net"
      http_port   = 80
      https_port  = 443
    }
    load_balancing_name = "LoadBalancingSettings1"
    health_probe_name   = "HealthProbeSetting1"
  }

  backend_pool {
    name = "mlmBackend"
    backend {
      host_header = "apimlm.azurewebsites.net"
      address     = "apimlm.azurewebsites.net"
      http_port   = 80
      https_port  = 443
    }
    load_balancing_name = "LoadBalancingSettings1"
    health_probe_name   = "HealthProbeSetting1"
  }

  backend_pool {
    name = "apis"
    backend {
      host_header = "apimla.azurewebsites.net"
      address     = "apimla.azurewebsites.net"
      http_port   = 80
      https_port  = 443
    }
    backend {
      host_header = "apimlb.azurewebsites.net"
      address     = "apimlb.azurewebsites.net"
      http_port   = 80
      https_port  = 443
    }
    backend {
      host_header = "apimlc.azurewebsites.net"
      address     = "apimlc.azurewebsites.net"
      http_port   = 80
      https_port  = 443
    }
    backend {
      host_header = "apimlm.azurewebsites.net"
      address     = "apimlm.azurewebsites.net"
      http_port   = 80
      https_port  = 443
    }
    load_balancing_name = "LoadBalancingSettings1"
    health_probe_name   = "HealthProbeSetting1"
  }

  frontend_endpoint {
    name      = "FrontendEndpoint1"
    host_name = "fjsfd.azurefd.net"
  }
}
