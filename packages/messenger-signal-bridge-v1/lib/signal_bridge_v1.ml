module type CONFIG = sig end

module Make (_ : CONFIG) = struct
  let platform = "signal_bridge"
end
