variable "component" {
  default = "catalogue"
}
variable "rule_priority" {
    default = 10
}

variable "components" {
    type = map
    default = {
        rule_shipping = {
            priority = 40
        }
        catalogue = {
            rule_priority = 10
        }
        cart = {
            rule_priority = 30
        }
        payment = {
            rule_priority = 50
        }
        user = {
            rule_priority = 20
        }
        frontend = {
            rule_priority = 10
        }
    }
}