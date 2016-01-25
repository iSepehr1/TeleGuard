do
local function unblock_user_callback(cb_extra, success, result)
  local receiver = cb_extra.receiver
  local user = 'user#id'..result.id
  if success == 0 then
    return send_large_msg(receiver, “Unblock Process Failed")
  end
  unblock_user(user, cb_ok, false)
end
end

local function run(msg, matches)
 if msg.to.type == 'chat' then
    local user = 'chat#id'..msg.to.id
 local user = matches[2]
  if matches[1] == "user" then
      user = 'user#id'..user
      unblock_user(user, callback, false)
    end
	        if not is_sudo(msg) or is_realm(msg) and is_admin(msg) then
    return ‘UNBLOCK ONLY BY SUDO'
  end
    return "I Have Unblocked User"
  end
end

return {
  patterns = {
    “^[!/]unblock (user) (%d+)$",
  },
  run = run,
}
