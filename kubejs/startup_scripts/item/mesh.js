StartupEvents.registry('item', event => {
    const meshes = [
        { id: 'copper', name: Text.translate('item.startrail.copper_mesh') },
        { id: 'iron', name: Text.translate('item.startrail.iron_mesh') },
        { id: 'gold', name: Text.translate('item.startrail.gold_mesh') },
        { id: 'diamond', name: Text.translate('item.startrail.diamond_mesh') },
        { id: 'emerald', name: Text.translate('item.startrail.emerald_mesh') }
    ];

    for (const mesh of meshes) {
        event.create(`startrail:${mesh.id}_mesh`, 'createsifter:mesh')
            .displayName(mesh.name)
            .parentModel('createsifter:block/meshes/mesh')
            .texture('mesh', `startrail:item/${mesh.id}_mesh`)
    }
});