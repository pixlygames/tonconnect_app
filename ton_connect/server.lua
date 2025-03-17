-- NOT PRODUCTION VERSION ONLY FOR TEST

local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
    MySQL.Async.execute([[
        CREATE TABLE IF NOT EXISTS wallet_mappings (
            citizen_id VARCHAR(50) PRIMARY KEY,
            wallet_address VARCHAR(100),
            last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
    ]])
end)

local NFT_TO_PROPERTY_MAP = {
    ["0:422fa1d5c33ff35b7d235378b31ab411640fcf07bf1bd3483a7cae3a6780d94c"] = 2,
    ["0:7a1c1cc5f4b53f460db889242b28147052b6ce65f984730c8e68659ce85320fc"] = 3,
}

-- Added Player parameter to the function
local function ProcessNFTsForProperties(src, CitizenId, nfts, Player)
    print("Processing NFTs for CitizenId:", CitizenId)
    
    for _, nft in ipairs(nfts) do
        local nftAddress = nft.address
        print("Checking NFT address:", nftAddress)
        
        local propertyId = NFT_TO_PROPERTY_MAP[nftAddress]
        print("Matched property ID:", propertyId)
        
        if propertyId then
            -- Prepare property data
            local propertyData = {
                citizenid = CitizenId,
                property = propertyId,
                identifier = CitizenId,
                charinfo = {
                    firstname = Player.PlayerData.charinfo.firstname,
                    lastname = Player.PlayerData.charinfo.lastname
                }
            }
            
            print("Attempting to update owner with data:", json.encode(propertyData))
            
            TriggerEvent('pmanager:server:buyProperty', propertyData)
            
            -- Notify player
            TriggerClientEvent('QBCore:Notify', src, 'Property assigned based on your NFT!', 'success')
        end
    end
end

RegisterNetEvent('pmanager:linkWallet')
AddEventHandler('pmanager:linkWallet', function(walletAddress, nfts)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if not Player then
        print("Player not found for source:", src)
        return
    end

    local CitizenId = Player.PlayerData.citizenid
    
    if not CitizenId then
        print("CitizenId not found for player")
        return
    end

    if not walletAddress then
        print("Wallet address is nil")
        return
    end

    print("Processing data for CitizenId:", CitizenId)
    print("Wallet Address:", walletAddress)
    print("NFTs:", json.encode(nfts))

    -- Store wallet mapping
    MySQL.Async.execute('INSERT INTO wallet_mappings (citizen_id, wallet_address) VALUES (?, ?) ON DUPLICATE KEY UPDATE wallet_address = ?', 
        {CitizenId, walletAddress, walletAddress},
        function(rowsChanged)
            if rowsChanged > 0 then
                print("Successfully updated wallet mapping")
                -- Pass Player object to the function
                ProcessNFTsForProperties(src, CitizenId, nfts, Player)
            else
                print("Failed to update wallet mapping")
            end
        end
    )
end)
