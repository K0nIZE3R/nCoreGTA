Config = {
    Locations = {
        [1] = {
            ["Blip"] = { --> Position du poste de police.
                ["x"] = 459.21, ["y"] = -1008.07, ["z"] = 28.26
            },

            ["Service"] = { --> Position prise de service.
                ["x"] = 450.174, ["y"] = -992.276, ["z"] = 30.6896
            },

            ["Garage"] = {

                --> Position d'accès au garage.
                ["GaragePosition"] = {
                    ["x"] = 459.21, ["y"] = -1008.07, ["z"] = 28.26
                },

                --> Position du véhicule pour le ranger.
                ["RentrerVehicule"] = { 
                    ["x"] = 451.89, ["y"] = -997.19, ["z"] = 25.76
                },

                ["MenuGaragePos"] = {
                    ["x"] = 405.467, ["y"] = -951.877, ["z"] = -99.0041
                }
            },

            --> Position pour vous procurer votre equipement.
            ["Armurerie"] = {
                ["x"] = 452.372, ["y"] = -980.519, ["z"] = 30.6896,
                ["Items"] = {
                    itemName = {"Pistolet", "Tazer", "Menotte", "Matraque", "Munition 9mm"},
                }
            },
        },
    },
}

Config.Police = {
    job = " ",
    grade = " ",
    service = false
}