table.insert(options.ui.items,
    {
        title = "Rheclaim: Color",
        key = 'reclaim_color',
        type = 'toggle',
        default = 'GtoO',
        tip = 'Reclaim color gradient',
        custom = {
            states = {
                {text = "Green --> Orange", key = 'GtoO'},
                {text = "Orange --> Green", key = 'OtoG'},
                {text = "Grey --> White", key = 'GrtoW'},
                {text = "Off", key = 'gradientOff'}
            },
        },
    })

table.insert(options.ui.items,
  {
      title = "Rheclaim: Size",
      key = 'reclaim_size',
      type = 'toggle',
      default = 'SizeOn',
      tip = 'Reclaim size gradient',
      custom = {
          states = {
              {text = "On", key = 'SizeOn'},
              {text = "Off", key = 'SizeOff'},
          },
      }
    })
