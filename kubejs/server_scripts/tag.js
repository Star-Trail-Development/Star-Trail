ServerEvents.tags('item', event => {

    event.add('forge:sand', ['biomeswevegone:sandy_dirt']);
    
    event.add('minecraft:dirt', [
        'biomeswevegone:peat',
        'biomeswevegone:lush_dirt',
        'biomeswevegone:lush_grass_block'
    ]);
});