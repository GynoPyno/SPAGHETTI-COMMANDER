function getOptions()
  local Prefs = import('/lua/user/prefs.lua')
  return Prefs.GetFromCurrentProfile('options')
end

local options = getOptions(true)
local gradientOption
local sizeOption

if options['reclaim_color'] == nil then
  gradientOption = 'GtoO'
else
  gradientOption = options['reclaim_color']
end

if options['reclaim_size'] == nil or options['reclaim_size'] == 'On' then
  sizeOption = 'SizeOn'
else
  sizeOption = options['reclaim_size']
end


colorOptions = {
  GtoO = function(mass)
        local RGBhex = {}
        RGBhex[0] = 'ff'

        if mass < 1001 then
          --green to yellow
          RGBhex[1] = STR_itox(math.floor(127+getRGBchange(mass, .4, 3.2, 1000)*.5))
          RGBhex[2] = 'ff'
          RGBhex[3] = '01'
        else
          --yellow to orange
          RGBhex[1] = 'ff'
          RGBhex[2] = STR_itox(math.floor(255-getRGBchange(mass-1000, .5, 18.1, 7000)*.4))
          RGBhex[3] = '01'
        end
        return RGBhex[0] .. RGBhex[1] .. RGBhex[2] .. RGBhex[3]
      end,

    OtoG = function(mass)
          local RGBhex = {}
          RGBhex[0] = 'ff'

          if mass < 1001 then
            --orange to yellow
            RGBhex[1] = 'ff'
            RGBhex[2] = STR_itox(math.floor(153+getRGBchange(mass, .4, 3.2, 1000)*.4))
            RGBhex[3] = '01'
          else
            --yellow to green
            RGBhex[1] = STR_itox(math.floor(255-getRGBchange(mass-1000, .5, 18.1, 7000)*.5))
            RGBhex[2] = 'ff'
            RGBhex[3] = '01'
          end
          return RGBhex[0] .. RGBhex[1] .. RGBhex[2] .. RGBhex[3]
        end,

      GrtoW = function(mass)
            --grey to white
            local RGBhex = {}
            RGBhex[0] = 'ff'
            finalrgbvalue = STR_itox(math.floor(127+getRGBchange(mass, .3, 4, 4500)*.5))
            RGBhex[1] = finalrgbvalue
            RGBhex[2] = finalrgbvalue
            RGBhex[3] = finalrgbvalue
          return RGBhex[0] .. RGBhex[1] .. RGBhex[2] .. RGBhex[3]
        end,

      gradientOff = function()
        --color gradient disabled
        return 'ffc7ff8f'
      end

}

sizeOptions = {
  SizeOn = function(mass)
    return math.max(math.ceil((math.pow(mass, .18)*1.9)+5), 8)
  end,

  SizeOff = function(mass)
    return 10
  end
}

function getRGBchange(mass, expo, divider, max)
  local mass_rt = math.pow(mass, expo)
  local max_rt = math.pow(max, expo)
  local color_decimal = (mass_rt/max_rt)-((mass-((mass_rt/max_rt)-(1-mass)))/divider)
  return math.max(255*math.min(color_decimal, 1),0)
end

function CreateReclaimLabel(view)
    local label = WorldLabel(view, Vector(0, 0, 0))
    label.mass = Bitmap(label)
    label.oldMass = 0 --fix compare bug
    label.mass:SetTexture(UIUtil.UIFile('/game/build-ui/icon-mass_bmp.dds'))
    LayoutHelpers.AtLeftIn(label.mass, label)
    LayoutHelpers.AtVerticalCenterIn(label.mass, label)
    label.mass.Height:Set(12)
    label.mass.Width:Set(12)
    label.text = UIUtil.CreateText(label, "", 10, UIUtil.bodyFont)
    label.text:SetColor('ffc7ff8f')
    label.text:SetDropShadow(true)
    LayoutHelpers.AtLeftIn(label.text, label, 16)
    LayoutHelpers.AtVerticalCenterIn(label.text, label)
    label:DisableHitTest(true)
    label.OnHide = function(self, hidden)
        self:SetNeedsFrameUpdate(not hidden)
    end

    label.Update = function(self)
        local view = self.parent.view
        local proj = view:Project(self.position)
        LayoutHelpers.AtLeftTopIn(self, self.parent, proj.x - self.Width() / 2, proj.y - self.Height() / 2 + 1)
        self.proj = {x=proj.x, y=proj.y }
    end

    label.DisplayReclaim = function(self, r)
        if self:IsHidden() then
            self:Show()
        end
        self:SetPosition(r.position)

        if r.mass ~= self.oldMass then
          local mass = tostring(math.floor(0.5 + r.mass))
          self.text:SetText(mass)
          self.oldMass = r.mass
        end

        local reclaimTextSize = sizeOptions[sizeOption](r.mass)
        self.text:SetFont(UIUtil.bodyFont, reclaimTextSize)
        self.text.Depth:Set(r.mass)
        self.text:SetColor(colorOptions[gradientOption](r.mass))
      end

    label:Update()
    return label
end

function ShowReclaim(show)
    options = getOptions(true)
    --gradientOption = options['reclaim_color']
    --sizeOption = options['reclaim_size']

    if options['reclaim_color'] == nil then
      gradientOption = 'GtoO'
    else
      gradientOption = options['reclaim_color']
    end

    if options['reclaim_size'] == nil or options['reclaim_size'] == 'On' then
      sizeOption = 'SizeOn'
    else
      sizeOption = options['reclaim_size']
    end

    local view = import('/lua/ui/game/worldview.lua').viewLeft
    view.ShowingReclaim = show
    if show and not view.ReclaimThread then
        view.ReclaimThread = ForkThread(ShowReclaimThread)
    end
end
