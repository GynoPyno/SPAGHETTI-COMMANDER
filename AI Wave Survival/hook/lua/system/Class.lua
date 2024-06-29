--stripping the asserts
function ChangeState(obj, newstate)
    --LOG('*DEBUG: CHANGESTATE: ', repr(obj), repr(newstate))
    if type(newstate)=='string' then
        newstate = obj[newstate]
    end

    -- Ignore redundant state changes.
    if getmetatable(obj)==newstate then
        debug.traceback(nil, "Ignoring no-op state change...")
        return
    end

    -- Call state on-exit function, if there is one
    local OnExitState = obj.OnExitState
    if OnExitState then
        OnExitState(obj)
    end

    local old_main_thread = obj.__mainthread
    obj.__mainthread = nil

    -- Actually change the state
    setmetatable(obj,newstate)

    -- Call the state on-enter function, if there is one
    local OnEnterState = obj.OnEnterState
    if OnEnterState then
        OnEnterState(obj)
    end

    -- Start the new main thread. Note that OnEnterState() might have switched states on us, in which case the main
    -- thread will already have been started by that state switch. We test for obj.__mainthread to avoid starting
    -- it twice.
    local Main = obj.Main
    if Main and not obj.__mainthread then
        obj.__mainthread = ForkThread(Main,obj)
    end

    -- Kill the old main thread. We do this AFTER calling OnEnterState and starting the new main thread,
    -- because the thread we destroy may be ourselves.
    if old_main_thread then
        old_main_thread:Destroy()
    end
end