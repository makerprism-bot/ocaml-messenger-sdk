module type CONFIG = sig end

module Make (_ : CONFIG) = struct
  let platform = "whatsapp_cloud"
end
