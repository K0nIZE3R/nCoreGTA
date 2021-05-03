----------------
-- PLAYER GETTER EXPORTS--
----------------
--exports.nCoreGTA:GetPlayerUniqueId()
function GetPlayerUniqueId()
    return config.Player.id
end

--exports.nCoreGTA:GetPlayerJob()
function GetPlayerJob()
    return config.Player.job
end

--exports.nCoreGTA:GetPlayerJobGrade()
function GetPlayerJobGrade()
    return config.Player.grade
end

--exports.nCoreGTA:GetPlayerBank()
function GetPlayerBank()
    return config.Player.banque
end

--exports.nCoreGTA:GetPlayerInv()
function GetPlayerInv()
    return {inventaire = config.Player.inventaire, weight = config.Player.weight}
end

--exports.nCoreGTA:GetPlayerIdentity()
function GetPlayerIdentity()
    return config.Player.identiter
end

--exports.nCoreGTA:GetIsPlayerAdmin()
function GetIsPlayerAdmin()
    return config.Player.isAdmin
end