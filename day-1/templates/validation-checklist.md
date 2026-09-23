# Landing Zone & Networking Validation Checklist

Run through after deploying any of the [`bicep/`](../bicep/) templates to confirm the environment matches the intended pattern.

- [ ] Foundry account provisioned with `publicNetworkAccess` set as intended for the chosen pattern
- [ ] `disableLocalAuth` enabled (managed identity / Entra ID only)
- [ ] Private endpoint created and connected (network-isolated / hub-spoke patterns)
- [ ] Private DNS zone group linked and resolving correctly from within the VNET
- [ ] RBAC roles assigned to the correct Foundry account/project scope
- [ ] Outbound/egress path confirmed (firewall, proxy, or forced tunneling as applicable)
- [ ] Diagnostic settings / logging enabled and flowing to the target Log Analytics workspace
- [ ] Deployment reproducible from source control (no manual portal-only changes)
