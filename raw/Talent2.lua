-- Dec by luadecoda v1.0 by zhupf
-- Input: D:\JX3_CLASSIC\Game\JX3_CLASSIC\bin\classic_yq\bin64\Lua\scripts\skill\天赋 - 副本\Talent.lua 

Include("scripts/skill/天赋/TalentTab.lua")
UpdaetTalentSkill = function(l_1_0, l_1_1, l_1_2)
  local l_1_3 = GetSkill(l_1_1, 1)
  if not l_1_3 then
    return ERR_TALENT_ERROR
  end
  if not l_1_0 or l_1_1 <= 0 or l_1_2 <= 0 then
    return ERR_TALENT_ERROR
  end
  if not TALENT_TAB[l_1_0.dwForceID] then
    return ERR_TALENT_NOT_FIRST_FORCE
  end
  if l_1_0.nLevel < TALENT_BEGIN_LEVEL then
    return ERR_TALENT_LEVEL_LOWER
  end
  local l_1_4, l_1_5, l_1_6, l_1_7, l_1_8 = StatisticsTalentInfo(l_1_0)
  local l_1_9, l_1_10, l_1_11 = GetPositionBySkillID(l_1_0.dwForceID, l_1_1)
  local l_1_12 = GetTalentCondition(l_1_0.dwForceID, l_1_1)
  local l_1_13 = l_1_0.GetSkillLevel(l_1_1)
  if l_1_2 < l_1_13 then
    return ERR_TALENT_ERROR
  end
  if l_1_3.dwMaxLevel < l_1_2 then
    return ERR_TALENT_ERROR
  end
  if not l_1_12 then
    return ERR_TALENT_ERROR
  end
  if l_1_9 == 0 or l_1_10 == 0 or l_1_11 == 0 or not l_1_7 or not l_1_8 then
    return ERR_TALENT_ERROR
  end
  if l_1_6 <= 0 then
    return ERR_TALENT_NOT_ENOUGH_POINT
  end
  if l_1_0.nLevel < l_1_12.nNeedLevel then
    return ERR_TALENT_LEVEL_LOWER
  end
  if l_1_3.dwMaxLevel <= l_1_13 then
    return ERR_TALENT_MAX_SKILL_LEVEL
  end
  if not l_1_8[l_1_9] or not l_1_8[l_1_9][l_1_10] then
    return ERR_TALENT_ERROR
  end
  if l_1_8[l_1_9][l_1_10] < l_1_12.nAllPoint then
    return ERR_TALENT_NOT_ENOUGH_ADDUP_POINT
  end
  if not l_1_8[1] or not l_1_8[2] then
    return ERR_TALENT_ERROR
  end
  do
    if l_1_9 == 1 then
      local l_1_14, l_1_15, l_1_17, l_1_25 = l_1_8[1].nTotal + l_1_2 - l_1_13, l_1_8[2].nTotal
  end
   -- DEC_ERR: may err: usage of registers!

  elseif l_1_9 == 2 then
    local l_1_16, l_1_18, l_1_26 = , l_1_15 + l_1_2 - l_1_13
  end
   -- DEC_ERR: may err: usage of registers!

   -- DEC_ERR: may err: usage of registers!

   -- DEC_ERR: may err: usage of registers!

   -- DEC_ERR: may err: usage of registers!

  if l_1_16 > 0 and l_1_16 < TALENT_OPEN_SERIES_POINT and l_1_18 > 0 and l_1_18 < TALENT_OPEN_SERIES_POINT then
    return ERR_TALENT_NOT_ENOUGH_SERIES_POINT
  end
  for l_1_22,l_1_23 in pairs(l_1_12.PreviousTab) do
    local l_1_19, l_1_20 = nil
     -- DEC_ERR: may err: usage of registers!

    if l_1_0.GetSkillLevel(R20_PC136[1]) < R20_PC136[2] then
      return ERR_TALENT_NOT_ENOUGH_SKILL_POINT
    end
  end
  l_1_0.UpdateTalentSkill(l_1_1, l_1_2)
  return ERR_TALENT_SUCCESS
end

UpdateTalentSkillList = function(l_2_0, l_2_1)
  local l_2_2 = ERR_TALENT_ERROR
  local l_2_3 = {}
  if not l_2_0 or not l_2_1 then
    return l_2_2, l_2_3
  end
  for l_2_7,l_2_8 in ipairs(l_2_1) do
    local l_2_9 = ERR_TALENT_ERROR
    local l_2_10 = l_2_8.dwSkillID
    local l_2_11 = l_2_8.nLevel
    l_2_9 = UpdaetTalentSkill(l_2_0, l_2_10, l_2_11)
    if l_2_9 ~= ERR_TALENT_SUCCESS then
      l_2_2 = l_2_9
      return l_2_2, l_2_3
    end
    l_2_3[l_2_7] = l_2_8
  end
  return ERR_TALENT_SUCCESS, l_2_3
end

UnApplyTalentSetSkill = function(l_3_0, l_3_1, l_3_2)
  if not l_3_0 then
    return false
  end
  if not TALENT_TAB[l_3_0.dwForceID] then
    return false
  end
  if l_3_2 then
    l_3_0.ClearTalentSkill(l_3_1)
  end
  for l_3_6 = 1, #TALENT_TAB[l_3_0.dwForceID] do
    for l_3_10 = 1, #TALENT_TAB[l_3_0.dwForceID][l_3_6] do
      for l_3_14 = 1, #TALENT_TAB[l_3_0.dwForceID][l_3_6][l_3_10] do
        if TALENT_TAB[l_3_0.dwForceID][l_3_6][l_3_10][l_3_14] > 0 then
          local l_3_15 = TALENT_TAB[l_3_0.dwForceID][l_3_6][l_3_10][l_3_14]
        end
        if l_3_15 > 0 then
          local l_3_16 = l_3_0.GetSkillLevel(l_3_15)
        end
        if l_3_16 > 0 then
          if l_3_2 then
            l_3_0.SaveTalentSkill(l_3_1, l_3_15, l_3_16)
          end
          l_3_0.UpdateTalentSkill(l_3_15, 0)
        end
      end
    end
  end
  return true
end

ResetTalent = function(l_4_0)
  if not l_4_0 then
    return false
  end
  local l_4_1 = l_4_0.GetMaxTalentSetCount()
  for l_4_5 = 0, l_4_1 - 1 do
    l_4_0.ResetTalentSet(l_4_5)
  end
  return true
end


