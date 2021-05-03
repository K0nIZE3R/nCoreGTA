--> Voici comment fonctionne le systeme de vêtement : 
--> Site pour le system de vêtement : https://wiki.rage.mp/index.php?title=Clothes
--[[
    EXEMPLE ICI :
    https://wiki.rage.mp/index.php?title=Male_Tops
    ["T-Shirt Blanc"] = {1, 0, 5, 0}, 
    Le premier chiffre représente le draw id[Torsos]
    Le deuxieme représente la couleur
    Le troisieme reprèsente le prix.
    Le quatrième reprèsente les bras[Torsos].
    Le 5ieme reprèsente le sous tshirt [Undershirts].
]]

Config = {
    Locations = {
        [1] = {
            ["MagasinDeVetement"] = {
                ["x"] = -822.61, ["y"] = -1077.64, ["z"] = 11.33,

                ["TShirtPos"] = { 
                   ["x"] = -822.61, ["y"] = -1077.64, ["z"] = 11.33,
                },

                ["PullPos"] = { 
                    ["x"] = -825.25, ["y"] = -1075.99, ["z"] = 11.32,
                },

                ["VestePos"] = { 
                    ["x"] = -827.47, ["y"] = -1079.88, ["z"] = 11.32,
                },

                ["PantalonPos"] = { 
                    ["x"] = -824.82, ["y"] = -1080.55, ["z"] = 11.32,
                },

                ["ChaussurePos"] = { 
                    ["x"] = -822.31, ["y"] = -1080.2, ["z"] = 11.32,
                },

                ["ChapeauPos"] = { 
                    ["x"] = -829.56, ["y"] = -1075.55, ["z"] = 11.32,
                },

                ["AccessoirePos"] = { 
                    ["x"] = -821.06, ["y"] = -1072.58, ["z"] = 11.32,
                },

                ["GardeRobPos"] = { 
                    ["x"] = -822.38, ["y"] = -1073.55, ["z"] = 11.32,
                },
            },
            
            ["Homme"] = { 
                ["Tshirt"] = {
                    ["T-Shirt blanc"] = {1, 0, 5, 0, 15}, --> DrawID, CouleurID, Prix, Torsos, Undershirts.
                    ["T-Shirt gris"] = {16, 0, 5, 0, 15}, --> DrawID, CouleurID, Prix, Torsos, Undershirts.
                    ["T-Shirt gris rayé"] = {33, 0, 5, 0, 15}, --> DrawID, CouleurID, Prix, Torsos, Undershirts.
                    ["T-Shirt gris noir"] = {34, 0, 5, 0, 15}, --> DrawID, CouleurID, Prix, Torsos, Undershirts.
                    ["T-Shirt gris noir"] = {34, 0, 5, 0, 15}, --> DrawID, CouleurID, Prix, Torsos, Undershirts.
                    ["Polo gris"] = {9, 1, 5, 0, 15}, --> DrawID, CouleurID, Prix, Torsos, Undershirts.
                },

                ["Pull"] = {
                    ["Pull gris"] = {38, 0, 5, 8, 15}, --> DrawID, CouleurID, Prix, Torsos, Undershirts.
                },

                ["Veste"] = {
                    ["Veste en cuir"] = {37, 0, 5, 14, 15}, --> DrawID, CouleurID, Prix, Torsos, Undershirts.
                    ["Chemise blanche"] = {13, 0, 5, 11, 15}, --> DrawID, CouleurID, Prix, Torsos, Undershirts.
                    ["Veste légère"] = {3, 0, 5, 14, 15}, --> DrawID, CouleurID, Prix, Torsos, Undershirts.
                },

                ["Pantalon"] = {
                    ["Jean bleu marine"] = {0, 0, 5}, --> DrawID, CouleurID, Prix.
                    ["Jean noir"] = {1, 0, 5}, --> DrawID, CouleurID, Prix.
                },

                ["Chaussure"] = {
                    ["Pied nu"] = {34, 0, 5}, --> DrawID, CouleurID, Prix.
                    ["Tong basic"] = {5, 0, 5}, --> DrawID, CouleurID, Prix.
                },

                ["Chapeau"] = {
                    ["Bonnet noir"] = {2, 5}, --> DrawID, Prix.
                    ["Casquette ls"] = {4, 5}, --> DrawID, Prix.
                    ["Bob vert"] = {20, 5}, --> DrawID, Prix.
                },

                ["Accessoire"] = {
                    ["Cravate blanche"] = {12, 5}, --> DrawID, Prix.
                    ["Cravate rouge"] = {18, 5}, --> DrawID, Prix.
                    ["Cravate bleu"] = {21, 5}, --> DrawID, Prix.
                    ["Echarpe blanche"] = {31, 5}, --> DrawID, Prix.
                    ["Echarpe rouge"] = {34, 5}, --> DrawID, Prix.
                    ["Rien"] = { 0, 5}, --> DrawID, Prix.
                },
            },

            ["Femme"] = { 
                ["Tshirt"] = {
                    ["Polo blanc"] = {14, 0, 5, 14, 15}, --> DrawID, CouleurID, Prix, Torsos, Undershirts.
                    ["Débardeur rouge"] = {16, 0, 5, 12, 2}, --> DrawID, CouleurID, Prix, Torsos, Undershirts.
                },

                ["Pull"] = {
                    ["Pull gris"] = {38, 0, 5, 8, 15}, --> DrawID, CouleurID, Prix, Torsos, Undershirts.
                },

                ["Veste"] = {
                    ["Veste en cuir"] = {6, 0, 5, 5, 37}, --> DrawID, CouleurID, Prix, Torsos, Undershirts.
                    ["Veste légère blanche"] = {3, 0, 5, 3, 2}, --> DrawID, CouleurID, Prix, Torsos, Undershirts.
                    ["Veste jean"] = {1, 0, 5, 5, 2}, --> DrawID, CouleurID, Prix, Torsos, Undershirts.
                },

                ["Pantalon"] = {
                    ["Jean bleu marine"] = {0, 0, 5}, --> DrawID, CouleurID, Prix.
                },

                ["Chaussure"] = {
                    ["Pied nu"] = {34, 0, 5}, --> DrawID, CouleurID, Prix.
                },

                ["Chapeau"] = {
                    ["Bonnet noir"] = {2, 5}, --> DrawID, Prix.
                    ["Casquette ls"] = {4, 5}, --> DrawID, Prix.
                    ["Bob vert"] = {20, 5}, --> DrawID, Prix.
                },

                ["Accessoire"] = {
                    ["Cravate blanche"] = {12, 5}, --> DrawID, Prix.
                    ["Cravate rouge"] = {18, 5}, --> DrawID, Prix.
                    ["Cravate bleu"] = {21, 5}, --> DrawID, Prix.
                    ["Echarpe blanche"] = {31, 5}, --> DrawID, Prix.
                    ["Echarpe rouge"] = {34, 5}, --> DrawID, Prix.
                },
            }
        },
    },
}