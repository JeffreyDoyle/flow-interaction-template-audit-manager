pub contract FlowInteractionAudit {

  pub event AuditAdded(templateId: String, auditor: Address)
  pub event AuditRevoked(templateId: String, auditor: Address)
  pub event AuditorCreated()

  pub let FlowInteractionAuditManagerStoragePath: StoragePath = /storage/flowInteractionAuditManagerStoragePath
  pub let FlowInteractionAuditManagerPublicPath: PublicPath = /public/flowInteractionAuditManagerPublicPath
  pub let FlowInteractionAuditManagerPrivatePath: PrivatePath = /private/flowInteractionAuditManagerPrivatePath

  pub resource interface FlowInteractionAuditManagerPublic {
    pub fun getAudits(): [String]
    pub fun getHasAuditedTemplate(templateId: String): Bool
  }

  pub resource interface FlowInteractionAuditManagerPrivate {
    pub fun addAudit(templateId: String)
    pub fun revokeAudit(templateId: String)
  }

  pub resource FlowInteractionAuditManager: FlowInteractionAuditManagerPublic, FlowInteractionAuditManagerPrivate {
    private var audits: {String:Bool}
    
    init() {
      self.audits = {}
      emit AuditorCreated()
    }

    pub fun getAudits(): [String] {
      return self.audits.keys
    }

    pub fun getHasAuditedTemplate(templateId: String): Bool {
      return self.audits.containsKey(templateId)
    }
  
    pub fun addAudit(templateId: String) {
      self.audits.insert(key: templateId, true)
      emit AuditAdded(templateId: templateId, auditor: self.owner?.address)
    }

    pub fun revokeAudit(templateId: String) {
      self.audits.remove(key: templateId)
      emit AuditRevoked(templateId: templateId, auditor: self.owner?.address)
    }
  }

  pub fun createFlowInteractionAuditManager(): @FlowInteractionAuditManager {
    return <- create FlowInteractionAuditManager()
  }

  init() { 

  }
}