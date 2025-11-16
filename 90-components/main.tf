/* module "components" {
    for_each = var.components
    source = "../../terraform-roboshop-component"
    component = var.component
    rule_priority = 10
} */

module "components" {
    for_each = var.components
    source = "git::https://github.com/Chakradhar-Jeereddy/terraform-roboshop-component.git?ref=main"
    component = each.key
    rule_priority = each.value.rule_priority
}

