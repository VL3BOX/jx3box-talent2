-----------------------------------------------
-- ?????    :  Talent.lua
-- ??????    :  linjiaqi
-- ???????  :  2011-02-25
-- ???(???):  ????
-- ???  	 :  Server????????
------------------------------------------------
Include("scripts/skill/??/TalentTab.lua")

function UpdaetTalentSkill(player, nTalentID, nTalentLevel)
    -- ????????
    local TalentSkill = GetSkill(nTalentID, 1)
    if not TalentSkill then return ERR_TALENT_ERROR end

    if not player or nTalentID <= 0 or nTalentLevel <= 0 then
        return ERR_TALENT_ERROR
    end

    if not TALENT_TAB[player.dwForceID] then
        return ERR_TALENT_NOT_FIRST_FORCE
    end

    if player.nLevel < TALENT_BEGIN_LEVEL then return ERR_TALENT_LEVEL_LOWER end

    local nMaxTalentPoint, nUsedTalentPoint, nHadTalentPoint, TalentPointTab,
          TalentSubsectionInfo = StatisticsTalentInfo(player)
    local nSeriesID, nRow, nColum = GetPositionBySkillID(player.dwForceID,
                                                         nTalentID)
    local tCondition = GetTalentCondition(player.dwForceID, nTalentID)
    local nTalentOldLevel = player.GetSkillLevel(nTalentID)

    if nTalentLevel <= nTalentOldLevel then return ERR_TALENT_ERROR end
    if nTalentLevel > TalentSkill.dwMaxLevel then return ERR_TALENT_ERROR end

    if not tCondition then return ERR_TALENT_ERROR end
    if nSeriesID == 0 or nRow == 0 or nColum == 0 or not TalentPointTab or
        not TalentSubsectionInfo then return ERR_TALENT_ERROR end

    if nHadTalentPoint <= 0 then return ERR_TALENT_NOT_ENOUGH_POINT end

    local nAddPoint = nTalentLevel - nTalentOldLevel
    if nHadTalentPoint < nAddPoint then return ERR_TALENT_NOT_ENOUGH_POINT end

    -- ??????
    if player.nLevel < tCondition.nNeedLevel then
        return ERR_TALENT_LEVEL_LOWER
    end

    if nTalentOldLevel >= TalentSkill.dwMaxLevel then
        return ERR_TALENT_MAX_SKILL_LEVEL
    end

    if not TalentSubsectionInfo[nSeriesID] or
        not TalentSubsectionInfo[nSeriesID][nRow] then
        return ERR_TALENT_ERROR
    end
    if TalentSubsectionInfo[nSeriesID][nRow] < tCondition.nAllPoint then
        return ERR_TALENT_NOT_ENOUGH_ADDUP_POINT
    end

    -- ????????,?????§Ø????????
    -- ??????????????¦Ì????0??TALENT_OPEN_SERIES_POINT?????
    if not TalentSubsectionInfo[1] or not TalentSubsectionInfo[2] then
        return ERR_TALENT_ERROR
    end
    local nSeriesATotalPoint = TalentSubsectionInfo[1].nTotal
    local nSeriesBTotalPoint = TalentSubsectionInfo[2].nTotal
    if nSeriesID == 1 then
        nSeriesATotalPoint = nSeriesATotalPoint + nAddPoint
    elseif nSeriesID == 2 then
        nSeriesBTotalPoint = nSeriesBTotalPoint + nAddPoint
    end
    if nSeriesATotalPoint > 0 and nSeriesATotalPoint < TALENT_OPEN_SERIES_POINT and
        nSeriesBTotalPoint > 0 and nSeriesBTotalPoint < TALENT_OPEN_SERIES_POINT then
        return ERR_TALENT_NOT_ENOUGH_SERIES_POINT
    end

    for _, tSkill in pairs(tCondition.PreviousTab) do
        local nOrderSkillID, nOrderSkillMinLevel = tSkill[1], tSkill[2]
        local nOrderSkillLevel = player.GetSkillLevel(nOrderSkillID)
        if nOrderSkillLevel < nOrderSkillMinLevel then
            return ERR_TALENT_NOT_ENOUGH_SKILL_POINT
        end
    end

    -- ??????
    player.UpdateTalentSkill(nTalentID, nTalentLevel)

    return ERR_TALENT_SUCCESS
end

function UpdateTalentSkillList(player, tUpdateTalentSkillTab)
    local nResult = ERR_TALENT_ERROR
    local tResultTab = {}

    if not player or not tUpdateTalentSkillTab then
        return nResult, tResultTab
    end

    for k, v in ipairs(tUpdateTalentSkillTab) do
        local nRetCode = ERR_TALENT_ERROR
        local dwSkillID = v.dwSkillID
        local nSkillLevel = v.nLevel

        nRetCode = UpdaetTalentSkill(player, dwSkillID, nSkillLevel)
        if nRetCode ~= ERR_TALENT_SUCCESS then
            -- ??????????????
            nResult = nRetCode
            return nResult, tResultTab
        end

        tResultTab[k] = v
    end

    return ERR_TALENT_SUCCESS, tResultTab
end

-- ???????????????????
-- bNeedSave???????????????????????????
function UnApplyTalentSetSkill(player, dwSetID, bNeedSave)
    if not player then return false end

    if not TALENT_TAB[player.dwForceID] then return false end

    if bNeedSave then player.ClearTalentSkill(dwSetID) end

    for nSeriesID = 1, #TALENT_TAB[player.dwForceID] do
        for nRow = 1, #TALENT_TAB[player.dwForceID][nSeriesID] do
            for nColum = 1, #TALENT_TAB[player.dwForceID][nSeriesID][nRow] do
                if TALENT_TAB[player.dwForceID][nSeriesID][nRow][nColum] > 0 then
                    local nSkillID =
                        TALENT_TAB[player.dwForceID][nSeriesID][nRow][nColum]
                    if nSkillID > 0 then
                        local nSkillLevel = player.GetSkillLevel(nSkillID)
                        if nSkillLevel > 0 then
                            if bNeedSave then
                                player.SaveTalentSkill(dwSetID, nSkillID,
                                                       nSkillLevel)
                            end

                            -- ????????
                            player.UpdateTalentSkill(nSkillID, 0)
                        end
                    end
                end
            end
        end
    end

    return true
end

-- ????·Ú??Reset????????????????????????????????????????§Ù?????????
function ResetTalent(player)
    if not player then return false end
    return true
end
