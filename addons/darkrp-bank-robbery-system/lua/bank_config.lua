--[[
MIT License

Copyright (c) 2017 Matheus de Moraes Gonçalves Malheiros

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
]]

BANK_CONFIG = {} 
BANK_CONFIG.MinGovernment = 0 -- Minimum number of teams considered cops by the Bank needed to start a robbery. (0 to disable)
BANK_CONFIG.MinBankers = 0 -- Minimum number of teams considered bankers by the Bank needed to start a robbery. (0 to disable)
BANK_CONFIG.MinPlayers = 0 -- Minimum of players needed to start a robbery. (0 to disable)
BANK_CONFIG.BaseReward = 25000 -- The amount of money that each vault starts with.
BANK_CONFIG.Interest = 5000 -- The amount to increase in each interest.
BANK_CONFIG.CooldownTime = 540 -- The amount of time that you need to wait before you can rob the bank again after a failed/sucessfull robbery.
BANK_CONFIG.RobberyTime = 180 --  The amount of time needed to finish a bank robbery.
BANK_CONFIG.MaxDistance = 920 -- The maximum distance that you can go from the vault during a robbery.
BANK_CONFIG.LoopSiren = true -- Should the siren sound loop?
BANK_CONFIG.MaxReward = 150000 -- The maximum reward for a successful robbery.
BANK_CONFIG.InterestTime = 180 -- The delay between increasing the vault's reward.
BANK_CONFIG.SaviorReward = 8000 -- The reward for killing the robber.
BANK_CONFIG.Government = { -- The teams considered cops by the bank.
    ['SWAT'] = true, -- uses the name displayed in the F4 menu. (Uses the name displayed in the F4 menu)
    ['SWAT Medic'] = true,
    ['Police Officer'] = true,
    ['Police Chief'] = true,
    ['Secret Service'] = true,
}
BANK_CONFIG.Bankers = { -- The teams considered bankers by the bank. (Uses the name displayed in the F4 menu)
    ['Banker'] = true,
    ['Example Name'] = true,
}
BANK_CONFIG.Robbers = { -- The teams that can rob the vault. (Uses the name displayed in the F4 menu)
    ['Thief'] = true, 
    ['Mafia'] = true,
    ['The Godfather'] = true,
}