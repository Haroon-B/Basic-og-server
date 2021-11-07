ESX.StartPayCheck = function()

	function payCheck()
		local xPlayers = ESX.GetPlayers()

		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			local job     = xPlayer.job.grade_name
			local salary  = xPlayer.job.grade_salary

			if salary > 0 then
				if job == 'unemployed' then 
					xPlayer.addAccountMoney('bank', salary)
					TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'You have recieved a paycheck for: $'..salary, length = 8000})
				elseif Config.EnableSocietyPayouts then 
					TriggerEvent('society:getSociety', xPlayer.job.name, function (society)
						if society ~= nil then
							TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function (account)
								if account.money >= salary then 
									xPlayer.addAccountMoney('bank', salary)
									account.removeMoney(salary)
									TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'You have recieved a paycheck for: $'..salary, length = 8000})
								else
									TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'The company you are employed at is unable to send you a paycheck at this time due to insufficient funds.', length = 8000})
								end
							end)
						else 
							xPlayer.addAccountMoney('bank', salary)
							TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'You have recieved a paycheck for: $'..salary, length = 8000})
						end
					end)
				else 
					xPlayer.addAccountMoney('bank', salary)
					TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'You have recieved a paycheck for: $'..salary, length = 8000})
				end
			end

		end

		SetTimeout(Config.PaycheckInterval, payCheck)

	end

	SetTimeout(Config.PaycheckInterval, payCheck)

end
