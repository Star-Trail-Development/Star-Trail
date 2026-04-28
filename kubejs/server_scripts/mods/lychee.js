const dusts = new Map([
    [],
    [],
    []
])

ServerEvents.recipes(event => {

    function wash(to, from) {
        event.custom({
            "type": "lychee:item_inside",
            "item_in": {"item": from},
            "block_in": {"blocks": ["minecraft:water"]},
            "post": {"type": "drop_item", "item": to}
        });
    }

    

});