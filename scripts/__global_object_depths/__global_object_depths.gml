function __global_object_depths() {
	// Initialise the global array that allows the lookup of the depth of a given object
	// GM2.0 does not have a depth on objects so on import from 1.x a global array is created
	// NOTE: MacroExpansion is used to insert the array initialisation at import time
	gml_pragma( "global", "__global_object_depths()");

	// insert the generated arrays here
	global.__objectDepths[0] = 0; // objDeltaTime
	global.__objectDepths[1] = 0; // objEggBase01
	global.__objectDepths[2] = 0; // objWorkshop
	global.__objectDepths[3] = 0; // objComponent
	global.__objectDepths[4] = -9999; // objAttachPoint
	global.__objectDepths[5] = -2000; // objLaser
	global.__objectDepths[6] = -2000; // objPoker
	global.__objectDepths[7] = -1500; // objFork
	global.__objectDepths[8] = -1500; // objBendUp
	global.__objectDepths[9] = -1500; // objBendDown
	global.__objectDepths[10] = -1500; // objStraightFork
	global.__objectDepths[11] = 0; // objStraight
	global.__objectDepths[12] = -2000; // objDrill
	global.__objectDepths[13] = -2000; // objSpike
	global.__objectDepths[14] = 0; // objSelector
	global.__objectDepths[15] = 0; // objBossRoom
	global.__objectDepths[16] = 0; // objLevelFloor
	global.__objectDepths[17] = 0; // objSonic
	global.__objectDepths[18] = 0; // objWall
	global.__objectDepths[19] = 0; // objRing
	global.__objectDepths[20] = 0; // objRingPickup
	global.__objectDepths[21] = 0; // objLaserBeam
	global.__objectDepths[22] = 0; // objLaserHit
	global.__objectDepths[23] = -99999999; // objExplosion
	global.__objectDepths[24] = 0; // objGround
	global.__objectDepths[25] = 0; // objRingLine
	global.__objectDepths[26] = 0; // objMapCamera
	global.__objectDepths[27] = 0; // objMapNode
	global.__objectDepths[28] = 0; // objMap
	global.__objectDepths[29] = -2000; // objWCharSel
	global.__objectDepths[30] = -2000; // objWEnvSel
	global.__objectDepths[31] = 0; // objWSonAI
	global.__objectDepths[32] = 0; // objWGo
	global.__objectDepths[33] = 0; // objWSave
	global.__objectDepths[34] = 0; // objWLoad
	global.__objectDepths[35] = -1000; // objWTailsAI
	global.__objectDepths[36] = 0; // objWMotorDir
	global.__objectDepths[37] = 0; // objMotorSlider
	global.__objectDepths[38] = -9999999; // objSaveInput
	global.__objectDepths[39] = -9999999; // objLoadSelection


	global.__objectNames[0] = "objDeltaTime";
	global.__objectNames[1] = "objEggBase01";
	global.__objectNames[2] = "objWorkshop";
	global.__objectNames[3] = "objComponent";
	global.__objectNames[4] = "objAttachPoint";
	global.__objectNames[5] = "objLaser";
	global.__objectNames[6] = "objPoker";
	global.__objectNames[7] = "objFork";
	global.__objectNames[8] = "objBendUp";
	global.__objectNames[9] = "objBendDown";
	global.__objectNames[10] = "objStraightFork";
	global.__objectNames[11] = "objStraight";
	global.__objectNames[12] = "objDrill";
	global.__objectNames[13] = "objSpike";
	global.__objectNames[14] = "objSelector";
	global.__objectNames[15] = "objBossRoom";
	global.__objectNames[16] = "objLevelFloor";
	global.__objectNames[17] = "objSonic";
	global.__objectNames[18] = "objWall";
	global.__objectNames[19] = "objRing";
	global.__objectNames[20] = "objRingPickup";
	global.__objectNames[21] = "objLaserBeam";
	global.__objectNames[22] = "objLaserHit";
	global.__objectNames[23] = "objExplosion";
	global.__objectNames[24] = "objGround";
	global.__objectNames[25] = "objRingLine";
	global.__objectNames[26] = "objMapCamera";
	global.__objectNames[27] = "objMapNode";
	global.__objectNames[28] = "objMap";
	global.__objectNames[29] = "objWCharSel";
	global.__objectNames[30] = "objWEnvSel";
	global.__objectNames[31] = "objWSonAI";
	global.__objectNames[32] = "objWGo";
	global.__objectNames[33] = "objWSave";
	global.__objectNames[34] = "objWLoad";
	global.__objectNames[35] = "objWTailsAI";
	global.__objectNames[36] = "objWMotorDir";
	global.__objectNames[37] = "objMotorSlider";
	global.__objectNames[38] = "objSaveInput";
	global.__objectNames[39] = "objLoadSelection";


	// create another array that has the correct entries
	var len = array_length_1d(global.__objectDepths);
	global.__objectID2Depth = [];
	for( var i=0; i<len; ++i ) {
		var objID = asset_get_index( global.__objectNames[i] );
		if (objID >= 0) {
			global.__objectID2Depth[ objID ] = global.__objectDepths[i];
		} // end if
	} // end for


}
