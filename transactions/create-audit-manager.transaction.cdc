import FlowInteractionAudit from 0xFlowInteractionAudit

transaction() {
  prepare(auditor: AuthAccount) {
    if auditor.borrow<&FlowInteractionAudit.FlowInteractionAuditManager>(from: FlowInteractionAudit.FlowInteractionAuditManagerStoragePath) == nil {
      let flowInteractionAuditManager <- FlowInteractionAudit.createFlowInteractionAuditManager()

      auditor.save(
        <- flowInteractionAuditManager, 
        to: FlowInteractionAudit.FlowInteractionAuditManagerStoragePath,
      )
            
      auditor.link<&FlowInteractionAudit.FlowInteractionAuditManager{FlowInteractionAudit.FlowInteractionAuditManagerPublic}>(
        FlowInteractionAudit.FlowInteractionAuditManagerPublicPath,
        target: FlowInteractionAudit.FlowInteractionAuditManagerStoragePath
      )

      auditor.link<&FlowInteractionAudit.FlowInteractionAuditManager{FlowInteractionAudit.FlowInteractionAuditManagerPrivate}>(
        FlowInteractionAudit.FlowInteractionAuditManagerPrivatePath,
        target: FlowInteractionAudit.FlowInteractionAuditManagerStoragePath
      )
    } else {
      panic("Cannot create new FlowInteractionAuditManager, one already exists.")
    }
  }
}