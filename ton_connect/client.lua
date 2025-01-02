RegisterNUICallback('linkWallet', function(data, cb)
    print("NUI Callback received:", json.encode(data)) -- Debug log
    
    if data.walletAddress and data.nfts then
        TriggerServerEvent('ps-housing:linkWallet', data.walletAddress, data.nfts)
        cb({status = 'success'})
    else
        print("Invalid data received from UI")
        cb({status = 'error', message = 'Invalid data'})
    end
end)