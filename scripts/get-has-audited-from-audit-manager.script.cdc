import FlowInteractionAudit from 0xFlowInteractionAudit

pub fun main(auditor: Address, templateId: String): Bool {
  let auditManagerRef = getAccount(account)
    .getCapability(FlowInteractionAudit.FlowInteractionAuditManagerPublicPath)
    .borrow<&FlowInteractionAudit.FlowInteractionAuditManager{FlowInteractionAudit.FlowInteractionAuditManagerPublic}>()
    ?? panic("Could not borrow Audit Manager public reference")

  return auditManagerRef.getHasAuditedTemplate(templateId: templateId)
}