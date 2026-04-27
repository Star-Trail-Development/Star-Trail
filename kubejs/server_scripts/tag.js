ServerEvents.tags('item', event => {

    event.add('forge:sand', ['biomeswevegone:sandy_dirt']);
    
    event.add('minecraft:dirt', [
        'biomeswevegone:peat',
        'biomeswevegone:lush_dirt',
        'biomeswevegone:lush_grass_block'
    ]);

    event.add('startrail:mesh', [
        'createsifter:string_mesh',
        'startrail:copper_mesh',
        'startrail:iron_mesh',
        'startrail:gold_mesh',
        'startrail:diamond_mesh',
        'startrail:emerald_mesh'
    ]);
});