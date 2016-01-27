do

  --Callbacks for get_dialog_list
  local function cb_getdialog(extra, success, result)
    local data = load_data(_config.moderation.data)
    for k,v in pairs(result) do
      if v.peer.id and v.peer.title then
        if not data[tostring(v.peer.id)] then
          chat_del_user("chat#id"..v.peer.id, 'user#id'..our_id, ok_cb, false)
        end
      end
    end
  end

  local function run(msg, matches)
    if is_admin(msg.from.id, msg.to.id) then
      if matches[1] == 'leave' then
        chat_del_user("chat#id"..msg.to.id, 'user#id'..our_id, ok_cb, false)
      elseif matches[1] == 'leaveall' then
        get_dialog_list(cb_getdialog, {chat_id=msg.to.id})
      end
    end
    if msg.action and msg.action.type == 'chat_add_user' and not is_sudo(msg.from.id) then
      local data = load_data(_config.moderation.data)
      if not data[tostring(msg.to.id)] then
        print '>>> autoleave: Zart  Pool Nadari Group Bekhari? Heh.. Khob Kir Shodi Be Ja In Kos Kalak Bazia Bia Group Daemi Bekhar Bye :)   Admin: @iSepehr2001 Leaving...'
        chat_del_user('chat#id'..msg.to.id, 'user#id'..our_id, ok_cb, false)
      end
    end
  end

  return {
    description = 'Exit from unmanaged groups.',
    usage = {
      admin = {
        ' ^!leave : Exit from this group.',
        ' ^!leaveall : Exit from all unmanaged groups.'
      },
    },
    patterns = {
      '^!(leave)$',
      '^!(leaveall)$',
      '^!!tgservice (chat_add_user)$'
    },
    run = run
  }

end
