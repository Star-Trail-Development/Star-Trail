// const gravel = new Map([
//     ['create:experience_nugget', 0.35],
//     ['projectvibrantjourneys:rocks', 0.80],
//     ['minecraft:flint', 0.20],
//     ['minecraft:coal', 0.15],
//     ['create:crushed_raw_zinc', 0.10],
//     ['mekanism:dirty_dust_copper', 0.12],
//     ['mekanism:dirty_dust_tin', 0.10],
//     ['mekanism:dirty_dust_iron', 0.10],
//     ['mekanism:dirty_dust_gold', 0.06],
//     ['mekanism:dirty_dust_osmium', 0.08],
//     ['mekanism:dirty_dust_lead', 0.07],
//     ['mekanism:dirty_dust_uranium', 0.05],
//     ['create_new_age:thorium', 0.07],
//     ['mekanism:fluorite_gem', 0.10],
//     ['minecraft:lapis_lazuli', 0.07],
//     ['minecraft:diamond', 0.05],
//     ['minecraft:emerald', 0.03],
//     ['ultramarine:hematite_dust', 0.10],
//     ['ultramarine:magnesite', 0.10],
//     ['ultramarine:jade', 0.06],
//     ['swem:star_worm', 0.06],
//     ['swem:cantazarite', 0.06],
// ]);

// ServerEvents.recipes(event => {

//     const sifter = event.recipes.createsifter;

//     function sifting(output, input, mesh, second, isWater) {
//         if (second == undefined) second = 5;
//         if (isWater == undefined) isWater = false;
//         sifter.sifting(output, [input, mesh], second * 20, isWater);
//     }

//     function to2DOutputArray(itemMap) {
//         if (itemMap instanceof Map) {
//             let count = 0, index = 0; 
//             let array2D = [[]];
//             itemMap.forEach(function(chance, item) {
//                 array2D[index].push(OutputItem.of(item, chance));
//                 count++
//                 if (count == 12) {
//                     array2D.push([]);
//                     count = 0;
//                     index++
//                 }
//             });
//             if (array2D[index].length === 0) { array2D.pop(); }
//             return array2D;
//         }   
//     }

//     function toOutputArray(itemMap) {
//         if (itemMap instanceof Map) {
//             let array = [];
//             itemMap.forEach(function(chance, item) {
//                 array.push(OutputItem.of(item, chance));
//             });
//             return array;
//         }   
//     }

//     event.remove({ type: 'createsifter:sifting' });

//     sifting(toOutputArray(gravel), 'minecraft:gravel', 'createsifter:string_mesh');

//     // for (let array1D of to2DOutputArray(gravel)) {
//     //     sifting(array1D, 'minecraft:gravel', 'createsifter:string_mesh');
//     // }

//     // //mesh recipes
//     // const mc = event.recipes.minecraft;
//     // mc.crafting_shaped();
//     //"createsifter:string_mesh", "startrail:copper_mesh", "startrail:iron_mesh", "startrail:gold_mesh", "startrail:diamond_mesh", "startrail:emerald_mesh"

// });

// // PlayerEvents.chat(event => {
// //     event.player.sendSystemMessage();
// // });