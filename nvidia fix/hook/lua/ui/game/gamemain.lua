-- save original CreateUI function.
local originalCreateUI = CreateUI 

-- overwrite original CreateUI function.
function CreateUI(isReplay) 
	-- call original function first.
	originalCreateUI(isReplay) 

    ForkThread(function()
        WaitSeconds(2)
        ConExecute('d3d_WindowsCursor')  
    end)
end