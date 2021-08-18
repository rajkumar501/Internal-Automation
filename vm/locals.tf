locals{
app = lower(var.app)
availability_zones = flatten(toset([for az in var.availability_zones : az.zones if az.region == lower(var.location)]))
virtual_machines = flatten([
    for ip in range(length(var.vm_ip_addresses)) :{
        id = format("%s%s", replace(local.app,"/-|_/",""), format("%03d", ip+1))
        size = var.size
        ip_address = element(var.vm_ip_addresses, ip)
        zone = local.availability_zones != [] ? element(try(local.availability_zones, []), ip ) : null
        backup_enabled = try(var.vm_backup_enabled, false)
        data_disks = try(var.data_disks, [])
        location = var.location
        resourcegroup = var.resourcegroup
        username = var.username
        vm_os_storagetype = var.vm_os_storagetype
        vm_image_offer = var.vm_image_offer
        vm_image_publisher = var.vm_image_publisher
        vm_image_sku = var.vm_image_sku
        vm_image_version = var.vm_image_version
        boot_diagnostics_sa = var.boot_diagnostics
    }
])

}