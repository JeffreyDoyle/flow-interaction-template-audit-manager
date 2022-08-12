import FlowInteractionAudit from 0xFlowInteractionAudit

transaction(templateId: String) {
  let flowInteractionAuditManagerPrivateRef: &FlowInteractionAudit.FlowInteractionAuditManager{FlowInteractionAudit.FlowInteractionAuditManagerPrivate}

  prepare(account: AuthAccount) {
    self.flowInteractionAuditManagerPrivateRef = 
      account.borrow<&FlowInteractionAudit.FlowInteractionAuditManager{FlowInteractionAudit.FlowInteractionAuditManagerPrivate}>(from: FlowInteractionAudit.FlowInteractionAuditManagerStoragePath)
        ?? panic("Could not borrow ref to FlowInteractionAuditManagerPrivate")
  }

  execute {
    self.flowInteractionAuditManagerPrivateRef.revokeAudit(templateId: templateId)
  }
}