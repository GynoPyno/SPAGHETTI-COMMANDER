package.path = package.path .. ";../?.lua"
luaunit = require('luaunit')
modScripts = ''

function GetVersion()
    return 3756
end

local OtherArmyResultStrings = {
    --TODO add localization tags and update strings when integrating with FAF
    victory  =   ' has won this game! ',      -- <LOC usersync_0001>
    defeat   =    'has been defeated by',    -- <LOC usersync_0002>
    draw     = '   has drawn with   ',          -- <LOC usersync_0003>
    gameOver = 'Game Over.',              -- <LOC usersync_0004>
}

local MyArmyResultStrings = {
    --TODO add localization tags and update strings when integrating with FAF
    victory =    " You have won this game! ",    -- <LOC GAMERESULT_0000>
    defeat  =     "You have been defeated by",  -- <LOC GAMERESULT_0001>
    draw    = "    You have draw with   ",         -- <LOC GAMERESULT_0002>
    replay  = "Replay Finished.",           -- <LOC GAMERESULT_0003>
}

gameresult = require('../modules/gameresultnew')
updateevent = require('../modules/score_events')

--mock function
function AnnounceDraw(armyID, message, killerId)
    luaunit.assert_equals(1, armyID)
end

--mock function
function GetFocusArmy()
    return 1
end

--mock function
function LOC(string)
    return string
end


local ResultStrings = {}
ResultStrings.OtherArmy = OtherArmyResultStrings
ResultStrings.MyArmy = MyArmyResultStrings

local Announces = {}
Announces.AnnounceDeath        = AnnounceDeath
Announces.AnnounceDeathUnknown = AnnounceDeathUnknown
Announces.AnnounceDraw         = AnnounceDraw
Announces.AnnounceVictory      = AnnounceVictory


-- prepare sync
local sync = {}
local events = sync.Events or { }
sync.Events = events
local acuDestroyed = events.ACUDestroyed or { }
events.ACUDestroyed = acuDestroyed



-- sync the event
table.insert(acuDestroyed, {
    Timestamp = 123,
    InstigatorArmy = 2,
    KilledArmy = 1
})

UpdateEvents(sync.Events)

local events = { }
sync.Events = events
local acuDestroyed = events.ACUDestroyed or { }
events.ACUDestroyed = acuDestroyed

table.insert(acuDestroyed, {
    Timestamp = 234,
    InstigatorArmy = 3,
    KilledArmy = 2
})

UpdateEvents(sync.Events)


local events = { }
sync.Events = events
local acuDestroyed = events.ACUDestroyed or { }
events.ACUDestroyed = acuDestroyed

table.insert(acuDestroyed, {
    Timestamp = 234,
    InstigatorArmy = 10,
    KilledArmy = 11
})
table.insert(acuDestroyed, {
    Timestamp = 234,
    InstigatorArmy = 11,
    KilledArmy = 10
})

UpdateEvents(sync.Events)




-- Test is run here
-- first assert function


TestGameresult = {}
    TestGameresult.Announces = {}
    function TestGameresult:setUp()
        TestGameresult.AnnounceDeathCalled = false
        TestGameresult.AnnounceDrawCalled = false
        Resetdrawnotified()
        
        function AnnounceDeath(armyID, message, killerId)
            TestGameresult.AnnounceDeathCalled = true
        end
        function AnnounceDraw(armyID, message, killerId)
            TestGameresult.AnnounceDrawCalled = true
        end
        function AnnounceVictory(armyID, message)
            TestGameresult.AnnounceVictoryCalled = true
        end
        
        TestGameresult.Announces.AnnounceDeath   = AnnounceDeath
        TestGameresult.Announces.AnnounceDraw    = AnnounceDraw
        TestGameresult.Announces.AnnounceVictory = AnnounceVictory
    end

    function TestGameresult:testCheckIfVictoryExits()
        DoGameResultNew(1, 'victory', CurrentEvents, ResultStrings, TestGameresult.Announces)
        luaunit.assert_false(TestGameresult.AnnounceDeathCalled)
        luaunit.assert_false(TestGameresult.AnnounceDrawCalled)
    end

    function TestGameresult:testCheckDefeat()
        DoGameResultNew(1, 'defeat', events, ResultStrings, TestGameresult.Announces)

        luaunit.assert_true(TestGameresult.AnnounceDeathCalled)
    end


    function TestGameresult:testCheckDefeat2()
        DoGameResultNew(2, 'defeat', CurrentEvents, ResultStrings, TestGameresult.Announces)

        luaunit.assert_true(TestGameresult.AnnounceDeathCalled)
    end

    function TestGameresult:testDraw()
        DoGameResultNew(10, 'defeat', CurrentEvents, ResultStrings, TestGameresult.Announces)

        luaunit.assert_false(TestGameresult.AnnounceDeathCalled)
        luaunit.assert_true(TestGameresult.AnnounceDrawCalled)
    end

    function TestGameresult:testDrawOnlyOnce()
        DoGameResultNew(10, 'defeat', CurrentEvents, ResultStrings, TestGameresult.Announces)
        luaunit.assert_false(TestGameresult.AnnounceDeathCalled)
        luaunit.assert_true(TestGameresult.AnnounceDrawCalled)
    
        TestGameresult.AnnounceDeathCalled = false
        TestGameresult.AnnounceDrawCalled = false
    
        DoGameResultNew(11, 'defeat', CurrentEvents, ResultStrings, TestGameresult.Announces)
        luaunit.assert_false(TestGameresult.AnnounceDeathCalled)
        luaunit.assert_false(TestGameresult.AnnounceDrawCalled)
    end

    function TestGameresult:testVictory()
        function AnnounceVictoryMock(armyID, Resultstring)
            luaunit.assert_equals(Resultstring, MyArmyResultStrings.victory)
        end
        TestGameresult.Announces.AnnounceVictory = AnnounceVictoryMock
        DoGameResultNew(1, 'victory', CurrentEvents, ResultStrings, TestGameresult.Announces)
        luaunit.assert_false(TestGameresult.AnnounceDeathCalled)
        luaunit.assert_false(TestGameresult.AnnounceDrawCalled)
        luaunit.assert_true(TestGameresult.AnnounceVictoryCalled)
    end

    function TestGameresult:testVictoryOtherArmy()
        function AnnounceVictoryMock(armyID, Resultstring)
            luaunit.assert_equals(Resultstring, OtherArmyResultStrings.victory)
        end
        TestGameresult.Announces.AnnounceVictory = AnnounceVictoryMock
        DoGameResultNew(2, 'victory', CurrentEvents, ResultStrings, TestGameresult.Announces)
        luaunit.assert_false(TestGameresult.AnnounceDeathCalled)
        luaunit.assert_false(TestGameresult.AnnounceDrawCalled)
        luaunit.assert_true(TestGameresult.AnnounceVictoryCalled)
    end


    function TestGameresult:tearDown()
    end

--separate test, which is not using the global sync structure
function testCheckNoKillSyncedThereforeSuicide()
    -- reset these
    acuDestroyed = {} 
    events.ACUDestroyed = acuDestroyed
    Resetdrawnotified()
    local AnnounceDeathCalled = false
    local AnnounceDrawCalled = false
    function AnnounceDeath(armyID, message, killerId)
        AnnounceDeathCalled = true
        luaunit.assert_equals(armyID, killerId)
        luaunit.assertEquals(' killed by suicide ', message)
    end
    Announces.AnnounceDeath = AnnounceDeath
    function AnnounceDraw(armyID, message, killerId)
        AnnounceDrawCalled = true
    end
    Announces.AnnounceDraw = AnnounceDraw

    DoGameResultNew(1, 'defeat', events, ResultStrings, Announces)


    luaunit.assert_true(AnnounceDeathCalled)
    luaunit.assert_false(AnnounceDrawCalled)
end

-- test, which is not using the global sync structure
function testCheckKillthenDraw()
    -- reset these
    acuDestroyed = {} 
    events.ACUDestroyed = acuDestroyed

    table.insert(acuDestroyed, {
        Timestamp = 234,
        InstigatorArmy = 10,
        KilledArmy = 11
    })

    Resetdrawnotified()
    local AnnounceDeathCalled = false
    local AnnounceDrawCalled = false
    function AnnounceDeath(armyID, message, killerId)
        AnnounceDeathCalled = true
        luaunit.assert_equals(armyID, killerId)
        luaunit.assertEquals(' killed by suicide ', message)
    end
    Announces.AnnounceDeath = AnnounceDeath
    function AnnounceDraw(armyID, message, killerId)
        AnnounceDrawCalled = true
    end
    Announces.AnnounceDraw = AnnounceDraw

    DoGameResultNew(10, 'defeat', events, ResultStrings, Announces)


    luaunit.assert_true(AnnounceDeathCalled)
    luaunit.assert_false(AnnounceDrawCalled)

    AnnounceDeathCalled = false

    table.insert(acuDestroyed, {
        Timestamp = 234,
        InstigatorArmy = 11,
        KilledArmy = 10
    })

    DoGameResultNew(11, 'defeat', CurrentEvents, ResultStrings, Announces)

    luaunit.assert_false(AnnounceDeathCalled)
    luaunit.assert_true(AnnounceDrawCalled)
end





os.exit( luaunit.LuaUnit.run() )