#Include, %A_ScriptDir%\extras\Trader.ahk

global __autoTrader := new AutoTrader()

class AutoTrader {
    isEnabled := false
    currentTradeItem := null

    __new() {
        base.__new("Trader",, 900, 600)
        this.onMessage(WM_AREA_CHANGED, "__onAreaChanged")
        this.onMessage(WM_NEW_MESSAGE, "__onMessage")
        this.addBroker(new TradeBroker())
    }

    enable() {
        isEnabled = true
    }

    watch() {

    }

    __startSession() {

    }

    __grabItemFromStash() {

    }

    __putItemInTradeWindow() {

    }

    __checkTrade() {

    }

    __doTrade() {

    }

    __endSession() {

    }

    __putEarningsInStash() {

    }
}