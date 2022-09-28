global __highlight := new Highlight()

class Highlight {
    highlightWorthyInventoryItems() {
        items := ptask.inventory.getItems()
        for i, item in items {
            ptask.inventory.highlight(item)
        }
    }

    __blur(aItem) {
        r := ptask.inventory.getRectByIndex(aItem.Index)
        ptask.c.fill_rect(r.l + .5, r.t + 1.5, r.w - .5, r.h - .5, "#555", 0.8)
    }
}