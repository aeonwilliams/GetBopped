-- Aeon Williams, Gerbo-Perenolde, 7/26/21

found = false

local text_frame = CreateFrame("Frame", nil, UIParent)
width, height = 500, 20
text_frame:SetPoint("CENTER")
text_frame:SetSize(width, height)
text_frame:Hide()
local text = text_frame:CreateFontString()
text:SetPoint("CENTER", UIParent, "CENTER", 0, 150)
text:SetSize(width, height)
text:SetFont("Fonts\\FRIZQT__.TTF", 40, "THICKOUTLINE")
text:SetText("|cffff0000BoP! Dispel now!|r")

function HideText()
  text_frame:Hide()
end

local frame = CreateFrame("Frame", "CheckBop", UIParent)
frame:RegisterEvent("UNIT_AURA")
frame:SetScript("OnEvent", function(self, event, ...)
  -- make sure we're only looping if checking the player
  unit = ...
  if unit ~= "player" then
    return
  end
  -- check "all" possible player buffs
  for i = 1, 40 do -- for every magic number, a puppy dies
    local buff = UnitBuff("player", i)
    if buff == "Well Fed" then
      if found ~= true then
        text_frame:Show()
        PlaySoundFile(567397) -- raid warning
        C_Timer.After(1.5, HideText)
      end
      found = true
      return
    end
  end
  found = false
end)
frame:Hide()
