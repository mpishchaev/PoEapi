
global __autoDiscounter := new AutoDiscounter()

class AutoDiscounter {
    setDiscountOnActiveStashTab() {
        for i, item in ptask.stash.Tab.getItems() {
            ptask.stash.Tab.moveTo(i)
            Sleep, 50

            loop, 50 {
                if (hoveredItem := ptask.getHoveredItem())
                    break
                Sleep, 50
            }
            SendInput, {RButton}

            price := $(hoveredItem)
            loop, 5 {
                Sleep, 50
                e := ptask.getIngameUI().getChild(130, 1)
                if (e.isVisible()) {
                    tag := e.getChild(1, 2, 2, 1)
                    if (RegExMatch(tag.getText(), "~(b/o|price) ([0-9./]+) (.+)", matched)) {
                        debug("current price:    {} {}", matched2, matched3)
                        if (matched3 == "chaos") {
                            price := Floor(matched2 * 0.85)
                            if (price <= 3) {
                                SendInput, {Esc}
                                if (item.size == 1) {
                                    ptask.stash.Tab.move(item)
                                }
                                break
                            } else {
                                this.__setCurrentCurrencyPrice(price, matched3, e)
                            }
                        } else {
                            price := Round(matched2 * 0.95, 1)
                            if (price < 1) {
                                this.__setNotePrice(price, matched3, e)
                            } else {
                                this.__setCurrentCurrencyPrice(price, matched3, e)
                            }
                        }
                    }
                }
                break
            }

            Sleep, 350
        }
    }

    __setCurrentCurrencyPrice(price, curr, e) {
        debug("discount floored price:    {} {}", price, curr)

        tag := e.getChild(1, 2, 3, 1)
        tag.getPos(x, y)

        MouseMove, x,  y, 0
        Sleep, 50
        SendInput, {Click}{Click}

        SendInput, %price%,
        Sleep, 50
        SendInput, {NumpadEnter}
    }

    __setNotePrice(price, curr, e) {
        debug("converting {} {} to chaos", price, curr)
        if (curr == "divine") {
            price := Round(price * $divine)
        } else if (curr == "exalted") {
            price := Round(price * $exalted)
        } else {
            return
        }
        note := Format("~b/o {:.f} chaos", price)

        tag := e.getChild(1, 2, 3, 1)
        tag.getPos(x, y)

        MouseMove, x-50,  y, 0
        Sleep, 50
        SendInput, {Click}

        MouseMove, x-50,  y+30, 0
        Sleep, 50
        SendInput, {Click}

        MouseMove, x,  y, 0
        Sleep, 50
        SendInput, {Click}
        Sleep, 25
        SendInput, ^a

        SendInput, %note%
        Sleep, 50
        SendInput, {NumpadEnter}
    }
}