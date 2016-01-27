do

-- Check Member
local function check_member_autorealm(cb_extra, success, result)
  local receiver = cb_extra.receiver
  local data = cb_extra.data
  local msg = cb_extra.msg
  for k,v in pairs(result.members) do
    local member_id = v.id
    if member_id ~= our_id then
      -- Group configuration
      data[tostring(msg.to.id)] = {
        group_type = 'Realm',
        settings = {
          set_name = string.gsub(msg.to.print_name, '_', ' '),
          lock_name = 'yes',
          lock_photo = 'no',
          lock_member = 'no',
          flood = 'yes'
        }
      }
      save_data(_config.moderation.data, data)
      local realms = 'realms'
      if not data[tostring(realms)] then
        data[tostring(realms)] = {}
        save_data(_config.moderation.data, data)
      end
      data[tostring(realms)][tostring(msg.to.id)] = msg.to.id
      save_data(_config.moderation.data, data)
      return send_large_msg(receiver, 'Welcome to your new realm !')
    end
  end
end
local function check_member_realm_add(cb_extra, success, result)
  local receiver = cb_extra.receiver
  local data = cb_extra.data
  local msg = cb_extra.msg
  for k,v in pairs(result.members) do
    local member_id = v.id
    if member_id ~= our_id then
      -- Group configuration
      data[tostring(msg.to.id)] = {
        group_type = 'Realm',
        settings = {
          set_name = string.gsub(msg.to.print_name, '_', ' '),
          lock_name = 'yes',
          lock_photo = 'no',
          lock_member = 'no',
          flood = 'yes'
        }
      }
      save_data(_config.moderation.data, data)
      local realms = 'realms'
      if not data[tostring(realms)] then
        data[tostring(realms)] = {}
        save_data(_config.moderation.data, data)
      end
      data[tostring(realms)][tostring(msg.to.id)] = msg.to.id
      save_data(_config.moderation.data, data)
      return send_large_msg(receiver, 'Realm has been added!')
    end
  end
end
function check_member_group(cb_extra, success, result)
  local receiver = cb_extra.receiver
  local data = cb_extra.data
  local msg = cb_extra.msg
  for k,v in pairs(result.members) do
    local member_id = v.id
    if member_id ~= our_id then
      -- Group configuration
      data[tostring(msg.to.id)] = {
        group_type = 'Normal',
        moderators = {},
        set_owner = member_id ,
        settings = {
          set_name = string.gsub(msg.to.print_name, '_', ' '),
          lock_name = 'yes',
          lock_photo = 'no',
          lock_member = 'no',
          flood = 'yes',
        }
      }
      save_data(_config.moderation.data, data)
      local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = {}
        save_data(_config.moderation.data, data)
      end
      data[tostring(groups)][tostring(msg.to.id)] = msg.to.id
      save_data(_config.moderation.data, data)
      return send_large_msg(receiver, 'شما به عنوان صاحب گروه انتخاب شدید')
    end
  end
end
local function check_member_modadd(cb_extra, success, result)
  local receiver = cb_extra.receiver
  local data = cb_extra.data
  local msg = cb_extra.msg
  for k,v in pairs(result.members) do
    local member_id = v.id
    if member_id ~= our_id then
      -- Group configuration
      data[tostring(msg.to.id)] = {
        group_type = 'Group',
        moderators = {},
        set_owner = member_id ,
        settings = {
          set_name = string.gsub(msg.to.print_name, '_', ' '),
          lock_name = 'yes',
          lock_photo = 'no',
          lock_member = 'no',
          flood = 'yes',
        }
      }
      save_data(_config.moderation.data, data)
      local groups = 'Normal'
      if not data[tostring(groups)] then
        data[tostring(groups)] = {}
        save_data(_config.moderation.data, data)
      end
      data[tostring(groups)][tostring(msg.to.id)] = msg.to.id
      save_data(_config.moderation.data, data)
      return send_large_msg(receiver, 'گروه اضافه شد و شما به عنوان صاحب اصلی گروه انتخاب شدید')
    end
  end
end
local function automodadd(msg)
  local data = load_data(_config.moderation.data)
  if msg.action.type == 'chat_created' then
    receiver = get_receiver(msg)
    chat_info(receiver, check_member_group,{receiver=receiver, data=data, msg = msg})
  end
end
local function autorealmadd(msg)
  local data = load_data(_config.moderation.data)
  if msg.action.type == 'chat_created' then
    receiver = get_receiver(msg)
    chat_info(receiver, check_member_autorealm,{receiver=receiver, data=data, msg = msg})
  end
end
local function check_member_realmrem(cb_extra, success, result)
  local receiver = cb_extra.receiver
  local data = cb_extra.data
  local msg = cb_extra.msg
  for k,v in pairs(result.members) do
    local member_id = v.id
    if member_id ~= our_id then
      -- Realm configuration removal
      data[tostring(msg.to.id)] = nil
      save_data(_config.moderation.data, data)
      local realms = 'realms'
      if not data[tostring(realms)] then
        data[tostring(realms)] = nil
        save_data(_config.moderation.data, data)
      end
      data[tostring(realms)][tostring(msg.to.id)] = nil
      save_data(_config.moderation.data, data)
      return send_large_msg(receiver, 'Realm has been removed!')
    end
  end
end
local function check_member_modrem(cb_extra, success, result)
  local receiver = cb_extra.receiver
  local data = cb_extra.data
  local msg = cb_extra.msg
  for k,v in pairs(result.members) do
    local member_id = v.id
    if member_id ~= our_id then
      -- Group configuration removal
      data[tostring(msg.to.id)] = nil
      save_data(_config.moderation.data, data)
      local groups = 'Normal'
      if not data[tostring(groups)] then
        data[tostring(groups)] = nil
        save_data(_config.moderation.data, data)
      end
      data[tostring(groups)][tostring(msg.to.id)] = nil
      save_data(_config.moderation.data, data)
      return send_large_msg(receiver, 'گروه از لیست حذف شد')
    end
  end
end
--End Check Member
local function show_group_settingsmod(msg, data, target)
 	if not is_momod(msg) then
    	return "فقط برای مدیران قابل انجام است!"
  	end
  	local data = load_data(_config.moderation.data)
    if data[tostring(msg.to.id)] then
     	if data[tostring(msg.to.id)]['settings']['flood_msg_max'] then
        	NUM_MSG_MAX = tonumber(data[tostring(msg.to.id)]['settings']['flood_msg_max'])
        	print('custom'..NUM_MSG_MAX)
      	else 
        	NUM_MSG_MAX = 5
      	end
    end
    local bots_protection = "Yes"
    if data[tostring(msg.to.id)]['settings']['lock_bots'] then
    	bots_protection = data[tostring(msg.to.id)]['settings']['lock_bots']
   	end
    local leave_ban = "no"
    if data[tostring(msg.to.id)]['settings']['leave_ban'] then
    	leave_ban = data[tostring(msg.to.id)]['settings']['leave_ban']
   	end
  local settings = data[tostring(target)]['settings']
  local text = "تنظیمات گروه:\nقفل نام گروه : "..settings.lock_name.."\nقفل عکس گروه : "..settings.lock_photo.."\nقفل عضوگیری گرو : "..settings.lock_member.."\nقفل بن شدن در صورت خروج از گروه : "..leave_ban.."\nحساسیت آنتی اسپم : "..NUM_MSG_MAX.."\nقفل ورود ربات : "..bots_protection--"\nPublic: "..public
  return text
end

local function set_descriptionmod(msg, data, target, about)
  if not is_momod(msg) then
    return "فقط برای مدیران قابل انجام است!"
  end
  local data_cat = 'description'
  data[tostring(target)][data_cat] = about
  save_data(_config.moderation.data, data)
  return 'متن درباره گروه ثبت شد:\n'..about
end
local function get_description(msg, data)
  local data_cat = 'description'
  if not data[tostring(msg.to.id)][data_cat] then
    return 'گروه توضیحات ندارد '
  end
  local about = data[tostring(msg.to.id)][data_cat]
  local about = string.gsub(msg.to.print_name, "_", " ")..':\n\n'..about
  return 'About '..about
end
local function lock_group_arabic(msg, data, target)
  if not is_momod(msg) then
    return "فقط برای مدیران قابل انجام است!"
  end
  local group_arabic_lock = data[tostring(target)]['settings']['lock_arabic']
  if group_arabic_lock == 'yes' then
    return 'مقابله با زبان عربی ( فارسی ) قبلا فعال شده است'
  else
    data[tostring(target)]['settings']['lock_arabic'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'مقابله با زبان عربی ( فارسی ) فعال شد'
  end
end

local function unlock_group_arabic(msg, data, target)
  if not is_momod(msg) then
    return "فقط برای مدیران قابل انجام است!"
  end
  local group_arabic_lock = data[tostring(target)]['settings']['lock_arabic']
  if group_arabic_lock == 'no' then
    return 'مقابله با زبان عربی ( فارسی ) قبلا غیرفعال شده است'
  else
    data[tostring(target)]['settings']['lock_arabic'] = 'no'
    save_data(_config.moderation.data, data)
    return 'مقابله با زبان عربی ( فارسی ) غیرفعال شد'
  end
end

local function lock_group_bots(msg, data, target)
  if not is_momod(msg) then
    return "فقط برای مدیران قابل انجام است!"
  end
  local group_bots_lock = data[tostring(target)]['settings']['lock_bots']
  if group_bots_lock == 'yes' then
    return 'مقابله با ربات قبلا فعال شده است'
  else
    data[tostring(target)]['settings']['lock_bots'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'مقابله با ربات فعال شد'
  end
end

local function unlock_group_bots(msg, data, target)
  if not is_momod(msg) then
    return "فقط برای مدیران قابل انجام است!"
  end
  local group_bots_lock = data[tostring(target)]['settings']['lock_bots']
  if group_bots_lock == 'no' then
    return 'مقابله با ربات قبلا غیر فعال شده است'
  else
    data[tostring(target)]['settings']['lock_bots'] = 'no'
    save_data(_config.moderation.data, data)
    return 'مقابله با ربات غیرفعال شد'
  end
end

local function lock_group_namemod(msg, data, target)
  if not is_momod(msg) then
    return "فقط برای مدیران قابل انجام است!"
  end
  local group_name_set = data[tostring(target)]['settings']['set_name']
  local group_name_lock = data[tostring(target)]['settings']['lock_name']
  if group_name_lock == 'yes' then
    return 'نام گروه قبلا قفل شده است'
  else
    data[tostring(target)]['settings']['lock_name'] = 'yes'
    save_data(_config.moderation.data, data)
    rename_chat('chat#id'..target, group_name_set, ok_cb, false)
    return 'نام گروه قفل شد'
  end
end
local function unlock_group_namemod(msg, data, target)
  if not is_momod(msg) then
    return "فقط برای مدیران قابل انجام است!"
  end
  local group_name_set = data[tostring(target)]['settings']['set_name']
  local group_name_lock = data[tostring(target)]['settings']['lock_name']
  if group_name_lock == 'no' then
    return 'نام گروه قبلا باز شده است'
  else
    data[tostring(target)]['settings']['lock_name'] = 'no'
    save_data(_config.moderation.data, data)
    return 'نام گروه باز شد'
  end
end
local function lock_group_floodmod(msg, data, target)
  if not is_owner(msg) then
    return "فقط برای مدیران قابل انجام است!"
  end
  local group_flood_lock = data[tostring(target)]['settings']['flood']
  if group_flood_lock == 'yes' then
    return 'حساسیت گروه قبلا فعال شده است'
  else
    data[tostring(target)]['settings']['flood'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'حساسیت گروه فعال شد'
  end
end

local function unlock_group_floodmod(msg, data, target)
  if not is_owner(msg) then
    return "فقط برای مدیران قابل انجام است!"
  end
  local group_flood_lock = data[tostring(target)]['settings']['flood']
  if group_flood_lock == 'no' then
    return 'حساسیت گروه غیرفعال است'
  else
    data[tostring(target)]['settings']['flood'] = 'no'
    save_data(_config.moderation.data, data)
    return 'حساسیت گروه غیرفعال شد'
  end
end

local function lock_group_membermod(msg, data, target)
  if not is_momod(msg) then
    return "فقط برای مدیران قابل انجام است!"
  end
  local group_member_lock = data[tostring(target)]['settings']['lock_member']
  if group_member_lock == 'yes' then
    return 'عضوگیری گروه قبلا بسته شده است'
  else
    data[tostring(target)]['settings']['lock_member'] = 'yes'
    save_data(_config.moderation.data, data)
  end
  return 'عضوگیری گروه بسته شد'
end

local function unlock_group_membermod(msg, data, target)
  if not is_momod(msg) then
    return "فقط برای مدیران قابل انجام است!"
  end
  local group_member_lock = data[tostring(target)]['settings']['lock_member']
  if group_member_lock == 'no' then
    return 'عضوگیری گروه باز است'
  else
    data[tostring(target)]['settings']['lock_member'] = 'no'
    save_data(_config.moderation.data, data)
    return 'عضوگیری گروه باز شد'
  end
end


local function set_public_membermod(msg, data, target)
  if not is_momod(msg) then
    return "فقط برای مدیران قابل انجام است!"
  end
  local group_member_lock = data[tostring(target)]['settings']['public']
  if group_member_lock == 'yes' then
    return 'گروه قبلا عمومی شده است'
  else
    data[tostring(target)]['settings']['public'] = 'yes'
    save_data(_config.moderation.data, data)
  end
  return 'نوع گروه: عمومی'
end

local function unset_public_membermod(msg, data, target)
  if not is_momod(msg) then
    return "فقط برای مدیران قابل انجام است!"
  end
  local group_member_lock = data[tostring(target)]['settings']['public']
  if group_member_lock == 'no' then
    return 'گروه عمومی نیست'
  else
    data[tostring(target)]['settings']['public'] = 'no'
    save_data(_config.moderation.data, data)
    return 'نوع گروه: خصوصی'
  end
end

local function lock_group_leave(msg, data, target)
  if not is_momod(msg) then
    return "فقط برای مدیران قابل انجام است!"
  end
  local leave_ban = data[tostring(msg.to.id)]['settings']['leave_ban']
  if leave_ban == 'yes' then
    return 'در صورت خروج فرد از گروه به طور خودکار بن می شود'
  else
    data[tostring(msg.to.id)]['settings']['leave_ban'] = 'yes'
    save_data(_config.moderation.data, data)
  end
  return 'در صورت خروج فرد از گروه به طور خودکار بن می شود'
end

local function unlock_group_leave(msg, data, target)
  if not is_momod(msg) then
    return "فقط برای مدیران قابل انجام است!"
  end
  local leave_ban = data[tostring(msg.to.id)]['settings']['leave_ban']
  if leave_ban == 'no' then
    return 'در صورت خروج فرد از گروه به طور خودکار بن نمی شود'
  else
    data[tostring(msg.to.id)]['settings']['leave_ban'] = 'no'
    save_data(_config.moderation.data, data)
    return 'در صورت خروج فرد از گروه به طور خودکار بن نمی شود'
  end
end

local function unlock_group_photomod(msg, data, target)
  if not is_momod(msg) then
    return "فقط برای مدیران قابل انجام است!"
  end
  local group_photo_lock = data[tostring(target)]['settings']['lock_photo']
  if group_photo_lock == 'no' then
    return 'عکس گروه بسته نیست'
  else
    data[tostring(target)]['settings']['lock_photo'] = 'no'
    save_data(_config.moderation.data, data)
    return 'قفل عکس گروه غیرفعال است'
  end
end

local function set_rulesmod(msg, data, target)
  if not is_momod(msg) then
    return "فقط برای مدیران قابل انجام است!"
  end
  local data_cat = 'rules'
  data[tostring(target)][data_cat] = rules
  save_data(_config.moderation.data, data)
  return 'Set group rules to:\n'..rules
end
local function modadd(msg)
  -- superuser and admins only (because sudo are always has privilege)
  if not is_admin(msg) then
    return "شما مدیر نیستید"
  end
  local data = load_data(_config.moderation.data)
  if is_group(msg) then
    return 'گروه قبلا اضافه شده است'
  end
    receiver = get_receiver(msg)
    chat_info(receiver, check_member_modadd,{receiver=receiver, data=data, msg = msg})
end
local function realmadd(msg)
  -- superuser and admins only (because sudo are always has privilege)
  if not is_admin(msg) then
    return "شما مدیر نیستید"
  end
  local data = load_data(_config.moderation.data)
  if is_realm(msg) then
    return 'Relam قبلا اضافه شده است'
  end
    receiver = get_receiver(msg)
    chat_info(receiver, check_member_realm_add,{receiver=receiver, data=data, msg = msg}) 
end
-- Global functions
function modrem(msg)
  -- superuser and admins only (because sudo are always has privilege)
  if not is_admin(msg) then
    return "شما مدیر نیستید"
  end
  local data = load_data(_config.moderation.data)
  if not is_group(msg) then
    return 'گروه اضافه نشده است'
  end
    receiver = get_receiver(msg)
    chat_info(receiver, check_member_modrem,{receiver=receiver, data=data, msg = msg})
end

function realmrem(msg)
  -- superuser and admins only (because sudo are always has privilege)
  if not is_admin(msg) then
    return "شما مدیر نیستید"
  end
  local data = load_data(_config.moderation.data)
  if not is_realm(msg) then
    return 'Relam اضافه نشده است'
  end
    receiver = get_receiver(msg)
    chat_info(receiver, check_member_realmrem,{receiver=receiver, data=data, msg = msg})
end
local function get_rules(msg, data)
  local data_cat = 'rules'
  if not data[tostring(msg.to.id)][data_cat] then
    return 'گروه قوانین ندارد'
  end
  local rules = data[tostring(msg.to.id)][data_cat]
  local rules = 'قوانین گروه:\n'..rules
  return rules
end

local function set_group_photo(msg, success, result)
  local data = load_data(_config.moderation.data)
  local receiver = get_receiver(msg)
  if success then
    local file = 'data/photos/chat_photo_'..msg.to.id..'.jpg'
    print('File downloaded to:', result)
    os.rename(result, file)
    print('File moved to:', file)
    chat_set_photo (receiver, file, ok_cb, false)
    data[tostring(msg.to.id)]['settings']['set_photo'] = file
    save_data(_config.moderation.data, data)
    data[tostring(msg.to.id)]['settings']['lock_photo'] = 'yes'
    save_data(_config.moderation.data, data)
    send_large_msg(receiver, 'عکس ذخیره شد!', ok_cb, false)
  else
    print('Error downloading: '..msg.id)
    send_large_msg(receiver, 'عملیات ناموفق بود لطفا دوباره سعی کنید', ok_cb, false)
  end
end

local function promote(receiver, member_username, member_id)
  local data = load_data(_config.moderation.data)
  local group = string.gsub(receiver, 'chat#id', '')
  if not data[group] then
    return send_large_msg(receiver, 'گروه اضافه نشده است')
  end
  if data[group]['moderators'][tostring(member_id)] then
    return send_large_msg(receiver, member_username..' قبلا مدیر شده است')
  end
  data[group]['moderators'][tostring(member_id)] = member_username
  save_data(_config.moderation.data, data)
  return send_large_msg(receiver, member_username..' مدیر ثبت شد')
end

local function promote_by_reply(extra, success, result)
    local msg = result
    local full_name = (msg.from.first_name or '')..' '..(msg.from.last_name or '')
    if msg.from.username then
      member_username = '@'.. msg.from.username
    else
      member_username = full_name
    end
    local member_id = msg.from.id
    if msg.to.type == 'chat' then
      return promote(get_receiver(msg), member_username, member_id)
    end  
end

local function demote(receiver, member_username, member_id)
  local data = load_data(_config.moderation.data)
  local group = string.gsub(receiver, 'chat#id', '')
  if not data[group] then
    return send_large_msg(receiver, 'گروه اضافه نشده است')
  end
  if not data[group]['moderators'][tostring(member_id)] then
    return send_large_msg(receiver, member_username..' مدیر نیست')
  end
  data[group]['moderators'][tostring(member_id)] = nil
  save_data(_config.moderation.data, data)
  return send_large_msg(receiver, member_username..' از مدیریت برکنار شد')
end

local function demote_by_reply(extra, success, result)
    local msg = result
    local full_name = (msg.from.first_name or '')..' '..(msg.from.last_name or '')
    if msg.from.username then
      member_username = '@'..msg.from.username
    else
      member_username = full_name
    end
    local member_id = msg.from.id
    if msg.to.type == 'chat' then
      return demote(get_receiver(msg), member_username, member_id)
    end  
end

local function setowner_by_reply(extra, success, result)
  local msg = result
  local receiver = get_receiver(msg)
  local data = load_data(_config.moderation.data)
  local name_log = msg.from.print_name:gsub("_", " ")
  data[tostring(msg.to.id)]['set_owner'] = tostring(msg.from.id)
      save_data(_config.moderation.data, data)
      savelog(msg.to.id, name_log.." ["..msg.from.id.."] setted ["..msg.from.id.."] as owner")
      local text = msg.from.print_name:gsub("_", " ").." به عنوان صاحب گروه ثبت شد"
      return send_large_msg(receiver, text)
end

local function promote_demote_res(extra, success, result)
--vardump(result)
--vardump(extra)
      local member_id = result.id
      local member_username = "@"..result.username
      local chat_id = extra.chat_id
      local mod_cmd = extra.mod_cmd
      local receiver = "chat#id"..chat_id
      if mod_cmd == 'promote' then
        return promote(receiver, member_username, member_id)
      elseif mod_cmd == 'demote' then
        return demote(receiver, member_username, member_id)
      end
end

local function modlist(msg)
  local data = load_data(_config.moderation.data)
  local groups = "groups"
  if not data[tostring(groups)][tostring(msg.to.id)] then
    return 'گروه اضافه نشده است'
  end
  -- determine if table is empty
  if next(data[tostring(msg.to.id)]['moderators']) == nil then --fix way
    return 'این گروه مدیر ندارد'
  end
  local i = 1
  local message = '\nلیست مدیران گروه' .. string.gsub(msg.to.print_name, '_', ' ') .. ':\n'
  for k,v in pairs(data[tostring(msg.to.id)]['moderators']) do
    message = message ..i..' - '..v..' [' ..k.. '] \n'
    i = i + 1
  end
  return message
end

local function callbackres(extra, success, result)
--vardump(result)
  local user = result.id
  local name = string.gsub(result.print_name, "_", " ")
  local chat = 'chat#id'..extra.chatid
  send_large_msg(chat, user..'\n'..name)
  return user
end


local function help()
  local help_text = tostring(_config.help_text)
  return help_text
end

local function cleanmember(cb_extra, success, result)
  local receiver = cb_extra.receiver
  local chat_id = "chat#id"..result.id
  local chatname = result.print_name
  for k,v in pairs(result.members) do
    kick_user(v.id, result.id)     
  end
end

local function killchat(cb_extra, success, result)
  local receiver = cb_extra.receiver
  local chat_id = "chat#id"..result.id
  local chatname = result.print_name
  for k,v in pairs(result.members) do
    kick_user_any(v.id, result.id)     
  end
end

local function killrealm(cb_extra, success, result)
  local receiver = cb_extra.receiver
  local chat_id = "chat#id"..result.id
  local chatname = result.print_name
  for k,v in pairs(result.members) do
    kick_user_any(v.id, result.id)     
  end
end

local function user_msgs(user_id, chat_id)
  local user_info
  local uhash = 'user:'..user_id
  local user = redis:hgetall(uhash)
  local um_hash = 'msgs:'..user_id..':'..chat_id
  user_info = tonumber(redis:get(um_hash) or 0)
  return user_info
end

local function kick_zero(cb_extra, success, result)
    local chat_id = cb_extra.chat_id
    local chat = "chat#id"..chat_id
    local ci_user
    local re_user
    for k,v in pairs(result.members) do
        local si = false
        ci_user = v.id
        local hash = 'chat:'..chat_id..':users'
        local users = redis:smembers(hash)
        for i = 1, #users do
            re_user = users[i]
            if tonumber(ci_user) == tonumber(re_user) then
                si = true
            end
        end
        if not si then
            if ci_user ~= our_id then
                if not is_momod2(ci_user, chat_id) then
                  chat_del_user(chat, 'user#id'..ci_user, ok_cb, true)
                end
            end
        end
    end
end

local function kick_inactive(chat_id, num, receiver)
    local hash = 'chat:'..chat_id..':users'
    local users = redis:smembers(hash)
    -- Get user info
    for i = 1, #users do
        local user_id = users[i]
        local user_info = user_msgs(user_id, chat_id)
        local nmsg = user_info
        if tonumber(nmsg) < tonumber(num) then
            if not is_momod2(user_id, chat_id) then
              chat_del_user('chat#id'..chat_id, 'user#id'..user_id, ok_cb, true)
            end
        end
    end
    return chat_info(receiver, kick_zero, {chat_id = chat_id})
end

local function run(msg, matches)
  local data = load_data(_config.moderation.data)
  local receiver = get_receiver(msg)
   local name_log = user_print_name(msg.from)
  local group = msg.to.id
  if msg.media then
    if msg.media.type == 'photo' and data[tostring(msg.to.id)]['settings']['set_photo'] == 'waiting' and is_chat_msg(msg) and is_momod(msg) then
      load_photo(msg.id, set_group_photo, msg)
    end
  end
  if matches[1] == 'add' and not matches[2] then
    if is_realm(msg) then
       return 'قبلا به عنوان Relam اضافه شده است'
    end
    print("گروه "..msg.to.print_name.."("..msg.to.id..") اضافه شد")
    return modadd(msg)
  end
   if matches[1] == 'add' and matches[2] == 'realm' then
    if is_group(msg) then
       return 'قبلا به لیست گروه ها اضافه شده است'
    end
    print("گروه "..msg.to.print_name.."("..msg.to.id..") به عنوان Relam اضافه شد")
    return realmadd(msg)
  end
  if matches[1] == 'rem' and not matches[2] then
    print("گروه "..msg.to.print_name.."("..msg.to.id..") از لیست حذف شد")
    return modrem(msg)
  end
  if matches[1] == 'rem' and matches[2] == 'realm' then
    print("گروه "..msg.to.print_name.."("..msg.to.id..") از لیست Realm حذف شد")
    return realmrem(msg)
  end
  if matches[1] == 'chat_created' and msg.from.id == 0 and group_type == "group" then
    return automodadd(msg)
  end
  if matches[1] == 'chat_created' and msg.from.id == 0 and group_type == "realm" then
    return autorealmadd(msg)
  end

  if msg.to.id and data[tostring(msg.to.id)] then
    local settings = data[tostring(msg.to.id)]['settings']
    if matches[1] == 'chat_add_user' then
      if not msg.service then
        return "Are you trying to troll me?"
      end
      local group_member_lock = settings.lock_member
      local user = 'user#id'..msg.action.user.id
      local chat = 'chat#id'..msg.to.id
      if group_member_lock == 'yes' and not is_owner2(msg.action.user.id, msg.to.id) then
        chat_del_user(chat, user, ok_cb, true)
      elseif group_member_lock == 'yes' and tonumber(msg.from.id) == tonumber(our_id) then
        return nil
      elseif group_member_lock == 'no' then
        return nil
      end
    end
    if matches[1] == 'chat_del_user' then
      if not msg.service then
         -- return "Are you trying to troll me?"
      end
      local user = 'user#id'..msg.action.user.id
      local chat = 'chat#id'..msg.to.id
      savelog(msg.to.id, name_log.." ["..msg.from.id.."] deleted user  "..user)
    end
    if matches[1] == 'chat_delete_photo' then
      if not msg.service then
        return "Are you trying to troll me?"
      end
      local group_photo_lock = settings.lock_photo
      if group_photo_lock == 'yes' then
        local picturehash = 'picture:changed:'..msg.to.id..':'..msg.from.id
        redis:incr(picturehash)
        ---
        local picturehash = 'picture:changed:'..msg.to.id..':'..msg.from.id
        local picprotectionredis = redis:get(picturehash) 
        if picprotectionredis then 
          if tonumber(picprotectionredis) == 4 and not is_owner(msg) then 
            kick_user(msg.from.id, msg.to.id)
          end
          if tonumber(picprotectionredis) ==  8 and not is_owner(msg) then 
            ban_user(msg.from.id, msg.to.id)
            local picturehash = 'picture:changed:'..msg.to.id..':'..msg.from.id
            redis:set(picturehash, 0)
          end
        end
        
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] tried to deleted picture but failed  ")
        chat_set_photo(receiver, settings.set_photo, ok_cb, false)
      elseif group_photo_lock == 'no' then
        return nil
      end
    end
    if matches[1] == 'chat_change_photo' and msg.from.id ~= 0 then
      if not msg.service then
        return "Are you trying to troll me?"
      end
      local group_photo_lock = settings.lock_photo
      if group_photo_lock == 'yes' then
        local picturehash = 'picture:changed:'..msg.to.id..':'..msg.from.id
        redis:incr(picturehash)
        ---
        local picturehash = 'picture:changed:'..msg.to.id..':'..msg.from.id
        local picprotectionredis = redis:get(picturehash) 
        if picprotectionredis then 
          if tonumber(picprotectionredis) == 4 and not is_owner(msg) then 
            kick_user(msg.from.id, msg.to.id)
          end
          if tonumber(picprotectionredis) ==  8 and not is_owner(msg) then 
            ban_user(msg.from.id, msg.to.id)
          local picturehash = 'picture:changed:'..msg.to.id..':'..msg.from.id
          redis:set(picturehash, 0)
          end
        end
        
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] tried to change picture but failed  ")
        chat_set_photo(receiver, settings.set_photo, ok_cb, false)
      elseif group_photo_lock == 'no' then
        return nil
      end
    end
    if matches[1] == 'chat_rename' then
      if not msg.service then
        return "Are you trying to troll me?"
      end
      local group_name_set = settings.set_name
      local group_name_lock = settings.lock_name
      local to_rename = 'chat#id'..msg.to.id
      if group_name_lock == 'yes' then
        if group_name_set ~= tostring(msg.to.print_name) then
          local namehash = 'name:changed:'..msg.to.id..':'..msg.from.id
          redis:incr(namehash)
          local namehash = 'name:changed:'..msg.to.id..':'..msg.from.id
          local nameprotectionredis = redis:get(namehash) 
          if nameprotectionredis then 
            if tonumber(nameprotectionredis) == 4 and not is_owner(msg) then 
              kick_user(msg.from.id, msg.to.id)
            end
            if tonumber(nameprotectionredis) ==  8 and not is_owner(msg) then 
              ban_user(msg.from.id, msg.to.id)
              local namehash = 'name:changed:'..msg.to.id..':'..msg.from.id
              redis:set(namehash, 0)
            end
          end
          
          savelog(msg.to.id, name_log.." ["..msg.from.id.."] tried to change name but failed  ")
          rename_chat(to_rename, group_name_set, ok_cb, false)
        end
      elseif group_name_lock == 'no' then
        return nil
      end
    end
    if matches[1] == 'setname' and is_momod(msg) then
      local new_name = string.gsub(matches[2], '_', ' ')
      data[tostring(msg.to.id)]['settings']['set_name'] = new_name
      save_data(_config.moderation.data, data)
      local group_name_set = data[tostring(msg.to.id)]['settings']['set_name']
      local to_rename = 'chat#id'..msg.to.id
      rename_chat(to_rename, group_name_set, ok_cb, false)
      
      savelog(msg.to.id, "Group { "..msg.to.print_name.." }  name changed to [ "..new_name.." ] by "..name_log.." ["..msg.from.id.."]")
    end
    if matches[1] == 'setphoto' and is_momod(msg) then
      data[tostring(msg.to.id)]['settings']['set_photo'] = 'waiting'
      save_data(_config.moderation.data, data)
      return 'لطفا عکس جدید گروه را ارسال کنید'
    end
    if matches[1] == 'promote' and not matches[2] then
      if not is_owner(msg) then
        return "فقط صاحب اصلی میتواند مدیر انتخاب کند"
      end
      if type(msg.reply_id)~="nil" then
          msgr = get_message(msg.reply_id, promote_by_reply, false)
      end
    end
    if matches[1] == 'promote' and matches[2] then
      if not is_momod(msg) then
        return
      end
      if not is_owner(msg) then
        return "فقط صاحب اصلی میتواند مدیر انتخاب کند"
      end
	local member = matches[2]
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] promoted @".. member)
	local cbres_extra = {
	chat_id = msg.to.id,
        mod_cmd = 'promote', 
	from_id = msg.from.id
	}
	local username = matches[2]
	local username = string.gsub(matches[2], '@', '')
	return res_user(username, promote_demote_res, cbres_extra)
    end
    if matches[1] == 'demote' and not matches[2] then
      if not is_owner(msg) then
        return "فقط صاحب اصلی می تواند مدیر را بر کنار کند"
      end
      if type(msg.reply_id)~="nil" then
          msgr = get_message(msg.reply_id, demote_by_reply, false)
      end
    end
    if matches[1] == 'demote' and matches[2] then
      if not is_momod(msg) then
        return
      end
      if not is_owner(msg) then
        return "فقط صاحب اصلی می تواند مدیر را بر کنار کند"
      end
      if string.gsub(matches[2], "@", "") == msg.from.username and not is_owner(msg) then
        return "شما نمیتوانید خودتان را بر کنار کنید"
      end
	local member = matches[2]
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] demoted @".. member)
	local cbres_extra = {
	chat_id = msg.to.id,
        mod_cmd = 'demote', 
	from_id = msg.from.id
	}
	local username = matches[2]
	local username = string.gsub(matches[2], '@', '')
	return res_user(username, promote_demote_res, cbres_extra)
    end
    if matches[1] == 'modlist' then
      savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested group modlist")
      return modlist(msg)
    end
    if matches[1] == 'about' then
      savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested group description")
      return get_description(msg, data)
    end
    if matches[1] == 'rules' then
      savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested group rules")
      return get_rules(msg, data)
    end
    if matches[1] == 'set' then
      if matches[2] == 'rules' then
        rules = matches[3]
        local target = msg.to.id
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] has changed group rules to ["..matches[3].."]")
        return set_rulesmod(msg, data, target)
      end
      if matches[2] == 'about' then
        local data = load_data(_config.moderation.data)
        local target = msg.to.id
        local about = matches[3]
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] has changed group description to ["..matches[3].."]")
        return set_descriptionmod(msg, data, target, about)
      end
    end
    if matches[1] == 'lock' then
      local target = msg.to.id
      if matches[2] == 'name' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked name ")
        return lock_group_namemod(msg, data, target)
      end
      if matches[2] == 'member' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked member ")
        return lock_group_membermod(msg, data, target)
        end
      if matches[2] == 'flood' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked flood ")
        return lock_group_floodmod(msg, data, target)
      end
      if matches[2] == 'arabic' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked arabic ")
        return lock_group_arabic(msg, data, target)
      end
      if matches[2] == 'bots' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked bots ")
        return lock_group_bots(msg, data, target)
      end
    if matches[2] == 'leave' then
       savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked leaving ")
       return lock_group_leave(msg, data, target)
     end
   end
    if matches[1] == 'unlock' then 
      local target = msg.to.id
      if matches[2] == 'name' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked name ")
        return unlock_group_namemod(msg, data, target)
      end
      if matches[2] == 'member' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked member ")
        return unlock_group_membermod(msg, data, target)
      end
      if matches[2] == 'photo' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked photo ")
        return unlock_group_photomod(msg, data, target)
      end
      if matches[2] == 'flood' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked flood ")
        return unlock_group_floodmod(msg, data, target)
      end
      if matches[2] == 'arabic' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked arabic ")
        return unlock_group_arabic(msg, data, target)
      end
      if matches[2] == 'bots' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked bots ")
        return unlock_group_bots(msg, data, target)
      end
    if matches[2] == 'leave' then
       savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked leaving ")
       return unlock_group_leave(msg, data, target)
     end
   end
    if matches[1] == 'settings' then
      local target = msg.to.id
      savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested group settings ")
      return show_group_settingsmod(msg, data, target)
    end	

  --[[if matches[1] == 'public' then
    local target = msg.to.id
    if matches[2] == 'yes' then
      savelog(msg.to.id, name_log.." ["..msg.from.id.."] set group to: public")
      return set_public_membermod(msg, data, target)
    end
    if matches[2] == 'no' then
      savelog(msg.to.id, name_log.." ["..msg.from.id.."] set group to: not public")
      return unset_public_membermod(msg, data, target)
    end
  end]]

    if matches[1] == 'newlink' and not is_realm(msg) then
      if not is_momod(msg) then
        return "فقط برای مدیریت فعال است"
      end
      local function callback (extra , success, result)
        local receiver = 'chat#'..msg.to.id
        if success == 0 then
           return send_large_msg(receiver, 'ناموفق بود \nزیرا ربات گروه را نساخته است')
        end
        send_large_msg(receiver, "لینک جدید ساخته شد")
        data[tostring(msg.to.id)]['settings']['set_link'] = result
        save_data(_config.moderation.data, data)
      end
      local receiver = 'chat#'..msg.to.id
      savelog(msg.to.id, name_log.." ["..msg.from.id.."] revoked group link ")
      return export_chat_link(receiver, callback, true)
    end
    if matches[1] == 'link' then
      if not is_momod(msg) then
        return "فقط برای مدیریت فعال است"
      end
      local group_link = data[tostring(msg.to.id)]['settings']['set_link']
      if not group_link then 
        return "ابتدا با دستور newlink لینک جدید را بسازید"
      end
       savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested group link ["..group_link.."]")
      return "لینک ورود به گروه:\n"..group_link
    end
    if matches[1] == 'setowner' and matches[2] then
      if not is_owner(msg) then
        return "فقط برای صاحب اصلی گروه مجاز است"
      end
      data[tostring(msg.to.id)]['set_owner'] = matches[2]
      save_data(_config.moderation.data, data)
      savelog(msg.to.id, name_log.." ["..msg.from.id.."] set ["..matches[2].."] as owner")
      local text = matches[2].." added as owner"
      return text
    end
    if matches[1] == 'setowner' and not matches[2] then
      if not is_owner(msg) then
        return "فقط برای صاحب اصلی گروه مجاز است"
      end
      if type(msg.reply_id)~="nil" then
          msgr = get_message(msg.reply_id, setowner_by_reply, false)
      end
    end
    if matches[1] == 'owner' then
      local group_owner = data[tostring(msg.to.id)]['set_owner']
      if not group_owner then 
        return "گروه صاحب اصلی ندارد لطفا در گروه پشتیبانی بات از ادمین سوال کنید"
      end
      savelog(msg.to.id, name_log.." ["..msg.from.id.."] used /owner")
      return "Group owner is ["..group_owner..']'
    end
    if matches[1] == 'setgpowner' then
      local receiver = "chat#id"..matches[2]
      if not is_admin(msg) then
        return "فقط برای مدیر و صاحب اصلی گروه مجاز است"
      end
      data[tostring(matches[2])]['set_owner'] = matches[3]
      save_data(_config.moderation.data, data)
      local text = matches[3].." به عنوان صاحب اصلی گروه انتخاب شد"
      send_large_msg(receiver, text)
      return
    end
    if matches[1] == 'setflood' then 
      if not is_momod(msg) then
        return "برای شما مجاز نیست"
      end
      if tonumber(matches[2]) < 5 or tonumber(matches[2]) > 20 then
        return "عدد اشتباه است! مقدار باید بین [20-5] باشد"
      end
      local flood_max = matches[2]
      data[tostring(msg.to.id)]['settings']['flood_msg_max'] = flood_max
      save_data(_config.moderation.data, data)
      savelog(msg.to.id, name_log.." ["..msg.from.id.."] set flood to ["..matches[2].."]")
      return 'حساسیت گروه: '..matches[2]
    end
    if matches[1] == 'clean' then
      if not is_owner(msg) then
        return "فقط صاحب اصلی می تواند حذف کند"
      end
      if matches[2] == 'member' then
        if not is_owner(msg) then
          return "فقط مدیران میتوانند از این دستور استفاده کنند"
        end
        local receiver = get_receiver(msg)
        chat_info(receiver, cleanmember, {receiver=receiver})
      end
      if matches[2] == 'modlist' then
        if next(data[tostring(msg.to.id)]['moderators']) == nil then --fix way
          return 'این گروه مدیر ندارد'
        end
        local message = '\nلیست مدیران گروه' .. string.gsub(msg.to.print_name, '_', ' ') .. ':\n'
        for k,v in pairs(data[tostring(msg.to.id)]['moderators']) do
          data[tostring(msg.to.id)]['moderators'][tostring(k)] = nil
          save_data(_config.moderation.data, data)
        end
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] cleaned modlist")
      end
      if matches[2] == 'rules' then 
        local data_cat = 'rules'
        data[tostring(msg.to.id)][data_cat] = nil
        save_data(_config.moderation.data, data)
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] cleaned rules")
      end
      if matches[2] == 'about' then 
        local data_cat = 'description'
        data[tostring(msg.to.id)][data_cat] = nil
        save_data(_config.moderation.data, data)
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] cleaned about")
      end     
    end
    if matches[1] == 'kill' and matches[2] == 'chat' then
      if not is_admin(msg) then
          return nil
      end
      if not is_realm(msg) then
          local receiver = get_receiver(msg)
          return modrem(msg),
          print("گروه بسته شد..."),
          chat_info(receiver, killchat, {receiver=receiver})
      else
          return 'این گروه Realm است'
      end
   end
    if matches[1] == 'kill' and matches[2] == 'realm' then
     if not is_admin(msg) then
         return nil
     end
     if not is_group(msg) then
        local receiver = get_receiver(msg)
        return realmrem(msg),
        print("گروه Realm بسته شد..."),
        chat_info(receiver, killrealm, {receiver=receiver})
     else
        return 'این جا گروه است'
     end
   end
    if matches[1] == 'help' then
      if not is_momod(msg) or is_realm(msg) then
        return
      end
      savelog(msg.to.id, name_log.." ["..msg.from.id.."] Used help")
      return help()
    end
    if matches[1] == 'res' and is_momod(msg) then 
      local cbres_extra = {
        chatid = msg.to.id
      }
      local username = matches[2]
      local username = username:gsub("@","")
      savelog(msg.to.id, name_log.." ["..msg.from.id.."] Used res "..username)
      return res_user(username,  callbackres, cbres_extra)
    end
    if matches[1] == 'kickinactive' then
      --send_large_msg('chat#id'..msg.to.id, 'I\'m in matches[1]')
	    if not is_momod(msg) then
	      return 'تنها مدیر قادر به انجام آن است'
	    end
	    local num = 1
	    if matches[2] then
	        num = matches[2]
	    end
	    local chat_id = msg.to.id
	    local receiver = get_receiver(msg)
      return kick_inactive(chat_id, num, receiver)
    end
  end 
end

return {
  patterns = {
  "^[Aa]dd$",
  "^[Aa]dd (realm)$",
  "^[Rr]em$",
  "^[Rr]em (realm)$",
  "^[Rr]ules$",
  "^[Aa]bout$",
  "^[Ss]etname (.*)$",
  "^[Ss]etphoto$",
  "^[Pp]romote (.*)$",
  "^[Pp]romote",
  "^[Hh]elp$",
  "^[Cc]lean (.*)$",
  "^[Kk]ill (chat)$",
  "^[Kk]ill (realm)$",
  "^[Dd]emote (.*)$",
  "^[Dd]emote",
  "^[Ss]et ([^%s]+) (.*)$",
  "^[Ll]ock (.*)$",
  "^[Ss]etowner (%d+)$",
  "^[Ss]etowner",
  "^[Oo]wner$",
  "^[Rr]es (.*)$",
  "^[Ss]etgpowner (%d+) (%d+)$",-- (group id) (owner id)
  "^[Uu]nlock (.*)$",
  "^[Ss]etflood (%d+)$",
  "^[Ss]ettings$",
-- "^[Pp]ublic (.*)$",
  "^[Mm]odlist$",
  "^[Nn]ewlink$",
  "^[Ll]ink$",
  "^[Kk]ickinactive$",
  "^[Kk]ickinactive (%d+)$",
  "%[(photo)%]",
  "^!!tgservice (.+)$",
  },
  run = run
}
end


