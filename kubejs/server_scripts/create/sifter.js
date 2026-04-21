ServerEvents.recipes(event => {

    //sifting
    const sifter = event.recipes.createsifter;
    sifter.sifting(
        [
            OutputItem.of('regions_unexplored:fireweed').withChance(0.75)
        ], ['minecraft:sand', 'createsifter:string_mesh']
    );

    // //mesh recipes
    // const mc = event.recipes.minecraft;
    // mc.crafting_shaped();

});