module type CONFIG = sig end

module Make (_ : CONFIG) = struct
  let platform = "telegram_bot"
end
