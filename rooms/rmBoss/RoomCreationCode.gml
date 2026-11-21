switch (global.environment) {
    case 0:
        __background_set( e__BG.Index, 0, bgEmeraldHill )
        __background_set( e__BG.Y, 0, 0 );
        
        
        __background_set( e__BG.Index, 1, bgEmeraldHill2 )
        __background_set( e__BG.Y, 1, 70 );
        
        __background_set( e__BG.Index, 2, bgEmeraldBlock )
        break;
    case 1:
        __background_set( e__BG.Index, 0, bgChemicalPlant )
        __background_set( e__BG.Y, 0, 135 );
        
        
        __background_set( e__BG.Index, 1, bgChemicalPlant2 )
        __background_set( e__BG.Y, 1, 385 );
        
        __background_set( e__BG.Index, 2, bgChemicalBlock )
        break;
    case 2:
        __background_set( e__BG.Index, 0, bgMystic1 )
        __background_set( e__BG.Y, 0, 0 );
        
        
        __background_set( e__BG.Index, 1, bgMystic2 )
        __background_set( e__BG.Y, 1, 545 );
        
        __background_set( e__BG.Index, 2, bgMysticBlock )
        break;           
    case 3:
        __background_set( e__BG.Index, 0, bgOilOcean1 )
        __background_set( e__BG.Y, 0, 0 );
        
        
        __background_set( e__BG.Index, 1, bgOilOcean2 )
        __background_set( e__BG.Y, 1, 260 );
        
        __background_set( e__BG.Index, 2, bgOilBlock )
        break; 
}

__background_set( e__BG.Y, 2, room_height - background_get_height(__background_get( e__BG.Index, 2 )) )
instance_create(0, 0, objGround);