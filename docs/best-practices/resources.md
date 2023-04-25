# Resources

- Use resources that do not require more than `Contributor` role at the resource group scope.
  If you need to use a higher role, create an example instead.

- Don't create resources that are automatically created by Azure, e.g. hidden resources such as the `master` database for an Azure SQL server:

  ![hidden resources](img/hidden-resources.png)

- A single module call should create a single instance of the main resource created by the module. For example, the `web-app` module should create a single web app, and the `sql` module should create a single database. This creates a common expectation for the behavior of our modules.

- There should be a one-to-one mapping between module calls and visible resources in Azure.

  For example, consider the following module calls:

  | Module name | Module source | Created Azure resources |
  | --- | --- | --- |
  | log-analytics | `equinor/log-analytics/azurerm` | Log Analytics workspace + extension resources (diagnostic setting)
  | automation | `equinor/automation/azurerm` | Automation account + child resources (schedules, modules, credentials, connections, certificates, variables) and extension resources (diagnostic setting) |
  | runbook | `equinor/automation/azurerm//modules/runbook` | Automation runbook + child resources (job schedules) |

  Each module call corresponds to a single visible resource in the Azure portal:

  ![module to resource mapping](img/module-to-resource-mapping.png)

- A module should only perform control plane operations (e.g., managing Storage account or Key vault), not data plane operations (e.g., managing Storage container or Key vault secret). See [control plane and data plane](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/control-plane-and-data-plane) in Microsoft docs.

  Performing data plane operations usually require workarounds for dealing with firewalls when run from an automated pipeline that deviate from the deterministic approach promoted by Terraform (e.g, temporarily disabling firewall or temporarily adding own IP to firewall).
  This may lead to the decision of disabling a resource firewall because it is preventing data plane operations from a pipeline, lowering the security of the resource.

  Data plane operations should be handled outside of Terraform.

  > **Note** Might be irrelevant depending on the implementation of github/roadmap#614.
