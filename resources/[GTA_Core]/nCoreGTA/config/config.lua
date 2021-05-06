--@Super.Cool.Ninja
config = {}

config.Player = {}

config.versionCore = "Version 1.7"
config.activerPoliceWanted = false
config.activerPvp = true 
config.salaireTime = 900000
config.timerSignalEMS = 60000 --> Definis le temps d'attente entre chaque envoi de signal pour les ems si le joueur est dans le coma.
config.timerPlayerSyncPos = 60000 --> Toute les 60 secondes une synchronisation de la position du player est effectuer.
config.timerPlayerSynchronisation = 300000 --> Toute les 5 Minutes une synchronisation du player est effectuer.

--> Valeur de départ Joueur : 
config.argentPropre = 500
config.argentSale = 150
config.banque = 5000


--> List D'Item disponible :
config.maxWeight = 40 --> Poids.
config.itemList = {
    ["pistol"] = {label = "Pistolet", weight = 1, type = "armes"},
    ["pistol_ammo"] = {label = "9mm", weight = 1, type = "armes"},
    ["marteau"] = {label = "Marteau", weight = 1, type = "armes"},
    ["batte"] = {label = "Batte", weight = 1, type = "armes"},
    ["pied_biche"] = {label = "Pied de biche", weight = 1, type = "armes"},
    ["couteau"] = {label = "Couteau", weight = 1, type = "armes"},
    ["menotte"] = {label = "Menotte", weight = 1, type = "vide"},
    ["hache"] = {label = "Hache", weight = 1, type = "armes"},
    ["machette"] = {label = "Machette", weight = 1, type = "armes"},
    ["poing_americain"] = {label = "Poing américain", weight = 1, type = "armes"},
    ["tazer"] = {label = "Tazer", weight = 1, type = "armes"},
    ["matraque"] = {label = "Matraque", weight = 1, type = "armes"},
    ["seringe_adrenaline"] = {label = "Seringe-Adrenaline", weight = 1, type = "medical"},
    ["soda"] = {label = "Soda", weight = 1, type = "boissons"},
    ["phone"] = {label = "Téléphone", weight = 1, type = "vide"},
    ["pain"] = {label = "Pain", weight = 1, type = "nourriture"},
    ["eau"] = {label = "Eau", weight = 1, type = "boissons"},
    ["cash"] = {label = "Argent Propre", weight = -1, type = "vide"},
    ["dirty"] = {label = "Argent Sale", weight = -1, type = "vide"},
    ["uzi"] = {label = "Uzi", weight = 1, type = "armes"},
    ["uzi_ammo"] = {label = "Munition Uzi", weight = 1, type = "armes"},
}

config.itemDepart = { --> Item reçu a votre arrivé :
    {
        ["item_name"] = "cash",
        ["item_qty"] = config.argentPropre,
    },
    {
        ["item_name"] = "dirty",
        ["item_qty"] = config.argentSale,
    }
}

--> Pour avoir la license du player, faite le connecter une fois au serveur sans qui puisse rejoindre, il sera afficher sur la console.
config.activerWhitelist = false
config.lienDiscord  = 'https://discord.gg/NKHJTqn'

-- Listes des joueurs whitelist :
config.JoueursWhitelist    = {
    --[[ EXEMPLE :
        'license:40423b6fc9a87b1c16c005a43d3a74863fdd96db'
    ]]
    
    'license:40423b6fc9a87b1c16c005a43d3a74863fdd96db'
}