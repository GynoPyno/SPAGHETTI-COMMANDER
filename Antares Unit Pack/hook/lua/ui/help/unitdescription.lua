##****************************************************************************
#**  File     :  lua/modules/ui/help/unitdescriptions.lua
#**  Author(s):  Ted Snook
#**
#**  Summary  :  Strings and images for the unit rollover System
#**
#**  Copyright © 2006 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
 
Description = {
##UEF Units


   ##Commanders  
     ['uel0001'] = "<LOC Unit_Description_0303>The most important unit in the field, the ACU houses a Commander and is a combination barracks and command center. The ACU contains all the basic blueprints necessary to build an army from scratch in the field.",
     ['uel0001-tm'] = "<LOC Unit_Description_0004>This mounts a Tactical Cruise Missile Launcher to the back of the ACU. It can create and store two missiles. Anti-missile systems will shoot these missiles down.",
     ['uel0001-aes'] = "<LOC Unit_Description_0005>Commanders looking to expand their ACU's building capacity will typically install this upgrade. This will increase the ACU's building speed.",
     ['uel0001-dsu'] = "<LOC Unit_Description_0006>This equipment package greatly enhances the rate at which the ACU repairs itself. It is a good choice for Commanders who tend to use their ACU offensively.",
     ['uel0001-ees'] = "<LOC Unit_Description_0007>Replaces the Advanced Engineering Suite and further expands the number of schematics available to the Commander. It also further enhances the ACU's build speed.",
     ['uel0001-hamc'] = "<LOC Unit_Description_0008>The upgrade to the Anti-Matter Cannon, the Heavy Anti-Matter Cannon increases the ACU's damage output by several factors.",
     ['uel0001-srtn'] = "<LOC Unit_Description_0009>The Short-Range Tactical Nuke has a smaller range and radius of destruction than a full-size nuclear missile. Strategic Missile Defense Systems will shoot these missiles down.",
     ['uel0001-pqt'] = "<LOC Unit_Description_0010>The Personal Teleporter lets the Commander teleport almost instantly across a range of several miles. The Personal Teleporter requires considerable Energy to activate.",
     ['uel0001-sgf'] = "<LOC Unit_Description_0011>An upgrade to the Personal Shield, the Shield Generator Field expands the area that the ACU's shield protects, allowing the Commander to protect other units.",
     ['uel0001-isb'] = "<LOC Unit_Description_0012>The Resource Allocation System introduces efficiency algorithms that enhance the rate at which the ACU can generate resources.",
     ['uel0001-psg'] = "<LOC Unit_Description_0013>The Personal Shield creates a protective shield around the ACU. The shield will dissipate after taking enough damage and will need to recharge before it can be reactivated.",
     ['uel0001-led'] = "<LOC Unit_Description_0014>The Engineering Drone acts as a secondary engineer, assisting the ACU with whatever it is building or repairing.",
     ['uel0001-red'] = "<LOC Unit_Description_0015>This adds a second Engineering Drone to the ACU. A second drone can only be built if the initial Engineering Drone has already been installed..",
     
     
    ## Support Commanders 
   
   ['uel0301'] = "<LOC Unit_Description_0016>This unit can continually rebuild and repair any unit or structure. The Sub-commander is summoned through a Quantum Gate.",
   ['uel0301-ed'] = "<LOC Unit_Description_0017>The Engineering Drone acts as a secondary engineer, assisting the ACU with whatever it is building or repairing.",
   ['uel0301-psg'] = "<LOC Unit_Description_0018>When activated, the Personal Shield creates a protective shield around the SACU. Like other UEF shields, the Personal Shield will dissipate after taking enough damage and will need to recharge before it can be activated again.",
   ['uel0301-sgf'] = "<LOC Unit_Description_0019>An upgrade to the Personal Shield, the Shield Generator Field expands the area that the SACU's shield protects, allowing the Commander to protect other units.",
   ['uel0301-rj'] = "<LOC Unit_Description_0020>The Radar Jammer creates a number of false radar images to confuse the enemy. Omni Sensors can see through the jamming.",
   ['uel0301-isb'] = "<LOC Unit_Description_0021>The Resource Allocation System introduces efficiency algorithms that enhance the rate at which the ACU can generate resources.",
   ['uel0301-sre'] = "<LOC Unit_Description_0022>This upgrade greatly expands the range of the standard onboard SACU sensor systems. This is a popular choice with Commanders who are often active away from their main base.",
   ['uel0301-acu'] = "<LOC Unit_Description_0023>Utilizing a forced air injection system, the Advanced Cooling Upgrade can cool any weapon mounted on the SACU much more rapidly than normal. This increases the rate of fire.",
   ['uel0301-heo'] = "<LOC Unit_Description_0024>A High Explosive Ordnance system equips the standard SACU Heavy Plasma Cannon with area-effect, or 'splash damage'.",

    
    ##Land
    
    
   ['uel0101'] = "<LOC Unit_Description_0025>The UEF scout is a fast, lightly armored reconnaissance vehicle which sports a machine gun and a state-of-the-art sensor suite.",
      
   ['uel0106'] = "<LOC Unit_Description_0026>The primary role of the Mech Marine is direct fire support. This lightly armored ground unit sacrifices damage potential and staying power for superior speed and maneuverability.",
         
   ['uel0103'] = "<LOC Unit_Description_0027>The Lobo is a versatile mobile artillery unit. Its long range, high ballistic arc, and area damage make it perfect for softening mobile enemy units. It is vulnerable to units that can engage it at short range.",

   ['uel0104'] = "<LOC Unit_Description_0028>An incredibly fast rate of fire and good turret tracking capabilities makes the Archer a great defense against all but the fastest air targets.",
   
   ['uel0201'] = "<LOC Unit_Description_0029>The mainstay of the Earth forces, the Striker packs focused firepower and armor into a sturdy shell. Recent upgrades to the Striker's build pattern have it equipped with a standard Gauss Cannon.",
          
   ['uel0202'] = "<LOC Unit_Description_0030>The heaviest tank in the UEF arsenal, the Pillar features Dual Gauss Cannons which fire High Explosive ordinance. With its heavy armor, the Pillar has become a staple of UEF armies.",
         
   ['uel0203'] = "<LOC Unit_Description_0031>While the UEF's amphibious tank does only light damage, its rate of fire can make quick work of even the thickest hulls. The unit's air cushion lets it traverse across the deepest bodies of water.",
            
   ['uel0111'] = "<LOC Unit_Description_0032>With its Tactical Cruise Missiles, the Flapjack has almost twice the range and firepower of the Lobo. It also features heavier armor and a stabilizer system that allows it to fire when on the move.",
               
   ['uel0205'] = "<LOC Unit_Description_0033>The Sky Boxer is an excellent companion to mobile armor and is often used as a temporary base defense when a Commander has not been able to build the heavier Flak Cannon.",

   ['uel0307'] = "<LOC Unit_Description_0034>The Parashield makes use of the latest generation of UEF Pulse Shield Generators. Mounted on a mobile chassis, the Parashield is extremely useful in protecting moving units.",
   
   ['uel0303'] = "<LOC Unit_Description_0035>Aside from experimental units, the Titan is the biggest, toughest unit in the UEF arsenal. It features dual Heavy Plasma Cannons, giving it an unprecedented level of firepower.",
   
   ['uel0304'] = "<LOC Unit_Description_0036>The preferred mobile artillery piece for many Commanders, the Demolisher fires Anti-Matter Shells from a purpose-built Long Range Artillery Cannon. The Demolisher's cannot fire while moving.",
   
   ['uel0401'] = "<LOC Unit_Description_0037>With armor and firepower equivalent to a standard UEF Battleship, the Fatboy can roll into hostile territory and not only defend itself, but also create an entire army on-the-fly.",
   
   
   
   
   ##AIR
   
   
   ['uea0101'] = "<LOC Unit_Description_0038>The standard air scout for UEF forces, the Hummingbird sacrifices weapons and armor for an advanced optical suite that gives it an excellent field of vision.",
   
   ['uea0102'] = "<LOC Unit_Description_0039>The standard UEF Interceptor, the Cyclone is a fast, maneuverable craft that sports linked Anti-Air Railguns as its armament.",

   ['uea0103'] = "<LOC Unit_Description_0040>The workhorse of the UEF air efforts, the Scorcher is an effective area bomber that is useful against all types of targets, both mobile and stationary.",
 
   ['uea0107'] = "<LOC Unit_Description_0041>The basic UEF transport, the Courier can hold up to 6 units and move them rapidly about the field. However, the Courier is extremely vulnerable to Anti-Air fire and Interceptors.",
  
   ['uea0203'] = "<LOC Unit_Description_0042>The Stinger is armed with a single Riot Gun which fires at an extremely high rate. A transportation clamp allows the Stinger to pick up a single light vehicle or bot and transport it into battle.",
   
   ['uea0204'] = "<LOC Unit_Description_0043>A twin-tailed plane, the Stork carries a payload of Angler torpedoes that it uses to excellent effect against any naval unit.",
    
   ['uea0302'] = "<LOC Unit_Description_0044>Based on an ancient design, the Blackbird carries state-of-the-art electronics and has an active radar system. Though quite fast, the Blackbird lacks any weapons and is vulnerable to Interceptors.",
     
   ['uea0104'] = "<LOC Unit_Description_0045>The C14 is a heavily armed and armored troop transport. The Star Lifter is also capable of carrying tanks, vehicles or any other unit that can fit within the transport's clamp system.",
   
   ['uea0303'] = "<LOC Unit_Description_0046>The next evolution in UEF fighter technology, the Wasp is armed with two Rapid Pulse Beam systems. These beams are designed to inflict maximum damage against lightly armored enemy aircraft",
    
   ['uea0304'] = "<LOC Unit_Description_0047>The Ambassador compliments its small yield nuclear bomb with a single Railgun for light Anti-Air support and defense.",
     
   ['uea0305'] = "<LOC Unit_Description_0048>The upgrade to the Stinger, the Broadsword features two Tactical Rocket Launchers firing Armor Piercing ordinance and an Anti-Air Railgun. It is a ground-attack platform without equal.",
   ['ane_uea003'] = "<LOC Unit_Description_1144>The Lead Air Engineers prove that a simple design can be quite powerful.The Lead Engineer can build,repair or reclaim ,anywhere on the battlefield.",    
   ['ane_uea102'] = "<LOC Unit_Description_1145>The swarm fighter-Designed as a light fast attack fighter for early combat.",
   ['ane_uea205'] = "<LOC Unit_Description_1146>The Hawk is a dogfighter designed to fill the gap between interceptors and ASF's.",
   ['ane_uea306'] = "<LOC Unit_Description_1147>The Star Carrier.Built to carry mass amounts of units right to the enemies doorstep,and sporting the UEF's latest Stratanium Armor,the Star Carrier can punch through even the toughest defences.",
   ['ane_uea307'] = "<LOC Unit_Description_1148>Substiting armor for speed,the Lancer is a high speed bomber able to outrun ASF's and drop it's payload of small yield nuclear warheads.",
   ['ane_uea401'] = "<LOC Unit_Description_1149>Seeing the need to reclaim the title of owning the top gunship.UEF Air Weapons Designers have developed the Avalon.A hard hitting ground assault platform.",
   ['ane_ueb1102'] = "<LOC Unit_Description_1150>Advanced Hydrocarbon Power Plant,capable of upgrading to a Tier2 Hydro Plant.",
   ['ane_ueb2101'] = "<LOC Unit_Description_1151>DM1 Plasma Cannon MKII is one of the latest point defence towers supporting radar jamming capability.", 
   ['ane_ueb2102'] = "<LOC Unit_Description_1152>The Tier2 Hydrocarbon Power Plant is capable of upgrading to a Tier3 Hydrocarbon Plant.",
   ['ane_ueb3102'] = "<LOC Unit_Description_1153>The Tier3 Hydro Power Plant,producing 1,000 Energy Per Second.It is the very latest in Hydrocarbon technology.",
   ['ane_ueb3204'] = "<LOC Unit_Description_1154>The War Hammer.A heavy defence battery containing Stratanium Armor and Hell's Fury Riot Guns .",
   ['ane_ueb4101'] = "<LOC Unit_Description_1155>Annihilator.Simply put,an advanced point defence weapon without equel.",
   ['ane_ueb5101'] = "<LOC Unit_Description_1156>In an effort to keep with Cybran technology,the UEF has utilized their very latest Stratanium Armor for their new wall structures.",
   ['ane_uel203'] = "<LOC Unit_Description_1157>Sniper an anti-tank unit delivering high velocity rounds at a high rate of fire.",
   ['ane_uel301'] = "<LOC Unit_Description_1158>Sending out false radar signals,Mercurry is the UEF's newest Electronic Warfare Drone.",
   ['ane_uel302'] = "<LOC Unit_Description_1159>Built to deal out more damage than itself can withstand,the Smallboy is armed to the teeth and wrapped in Stratanium Armor.",
   ['ane_ues101'] = "<LOC Unit_Description_1160>Skimmer Class is a small attack ship built specificely to target Aeon Shards.",
   ['ane_ues102'] = "<LOC Unit_Description_1161>Made to give UEF commanders a head start against enemy aircraft.The Air Eliminator does it's job well with it's missile flayer and compliment of railguns.",
   ['ane_ues201'] = "<LOC Unit_Description_1162>Further fulfilling it's role as a naval support vessal.The Shield Destroyer carries with it an area of effect shield to protect it and it's neighboring vessels.",
   ['ane_ues301'] = "<LOC Unit_Description_1163>The VimesRan.What started out as a joke back at the naval yards turned into a frightning reality.A submarine carring not one,but three artillery cannons.Bombarding enemy shores from a safe distance away.",
   ['ane_ues304'] = "<LOC Unit_Description_1164>The Federation's counter to the Cybran Defiater,the Dreadnaught is loaded with four anti-air railguns,two Phalanxguns and high powered GuassCannons.",


   



      
    ##SEA
    
      
   ['ues0103'] = "<LOC Unit_Description_0049>The UEF frigate is designed to offer fire support as well as supply a fleet with radar and sonar capabilities. The Thunderhead also houses an onboard radar jammer.",
   
   ['ues0203'] = "<LOC Unit_Description_0050>The Tigershark attack sub is a powerful and fast anti-naval unit. It has dual forward firing torpedo bays and a Plasma Cannon for added firepower when surfaced.",
    
   ['ues0202'] = "<LOC Unit_Description_0051>The Governor's primary role is that of anti-aircraft platform. It houses an anti-missile system, a SAM missile system, a Dual Gauss Cannon and a Tactical Cruise Missile Launcher.",
     
   ['ues0201'] = "<LOC Unit_Description_0052>The Valiant offers a mix of direct fire and anti-submarine weaponry. The Valiant includes an Angler Torpedo Bay and a Smart Depth Charge launcher which can intercept and destroy enemy torpedoes.",
      
   ['ues0302'] = "<LOC Unit_Description_0053>The Summit is a powerful shore bombardment and anti-ship vessel. It houses three Tri-Barreled Heavy Gauss Cannons, four Anti-Air Railguns, and two Anti-Missile Phalanx Guns.",
       
   ['ues0304'] = "<LOC Unit_Description_0054>The Ace is a submersible missile platform. Its primary arsenal is an array of Long Range Tactical Missiles. The Ace can also carry four nuclear warheads.",
       
   ['ues0401'] = "<LOC Unit_Description_0055>With its ability to submerge, the Atlantis can safely transport a fleet of aircraft great distances. It can also act as a mobile Air Staging Platform.",
        
   ##['ues0001'] = "<LOC Unit_Description_0056>The UEF Supreme commander Description",
   
   
   
   ##Buildings 
   
   
   ['ueb2101'] = "<LOC Unit_Description_0057>The standard point defense of most colonies and installations, the DM-1 offers good damage for the construction and operating costs incurred.",
    
   ['ueb2104'] = "<LOC Unit_Description_0058>The UEF's base level anti-air defense is a cheap, efficient air defense turret. This unit can be built on both land and water. When constructed over water it floats on a stabilization platform.",
     
   ['ueb2109'] = "<LOC Unit_Description_0059>The basic anti-navy unit for coastal and facility defense, the DN-1 fires the standard UEF Angler torpedo that is used by almost all UEF anti-navy units. The DN-1 can only be built on water.",
      
   ['ueb5101'] = "<LOC Unit_Description_0060>Formed from calcicrete, an advanced concrete mixture, these wall sections serve to both block enemy movement and provide minor cover from direct fire.",
       
   ['ueb2301'] = "<LOC Unit_Description_0061>The Triad is a potent and decisive base defense. With good range and rate of fire thanks to the three Heavy Gauss Cannons, the Triad can shred any enemy unit that comes within its range.",
        
   ['ueb2204'] = "<LOC Unit_Description_0062>More powerful than the light Anti-Air Railgun, the Air Cleaner Artillery Flak Cannon is a staple of the UEF anti-air efforts. When constructed over water, the Air Cleaner is built on a flotation platform.",
             
   ['ueb4201'] = "<LOC Unit_Description_0063>The Buzzkill has six rotating barrels that fire up to 12,000 rounds a minute. Combined with sophisticated tracking software, Buzzkill destroys missiles with astonishing speed and accuracy.",
          
   ['ueb2205'] = "<LOC Unit_Description_0064>Launching bursts of four Angler torpedoes, the Tsunami is the top-of-the-line UEF naval defense for the most important sea and coastline installations. The Tsunami can only be built on water.",
           
   ['ueb4202'] = "<LOC Unit_Description_0065>The Pulse makes use of the UEF's latest military technology, the Pulse Shield Generator. This shield generator can be upgraded into a T3 version which has a larger area of protection.",
   
   ['ueb2304'] = "<LOC Unit_Description_0066>The Flayer's SAM system is incredibly potent against enemy aircraft. When constructed over water, this SAM launcher is built on a flotation platform.",
     
   ['ueb4302'] = "<LOC Unit_Description_0067>The Eliminator is designed to destroy incoming strategic missiles before they reach their target. The Eliminator must be ordered to construct its defensive missiles.",
       
   ['ueb4301'] = "<LOC Unit_Description_0068>The upgrade to the T2 Shield Generator, the HSD features a larger, more powerful shield, but at an increased operating cost.",
         
   ['ueb2303'] = "<LOC Unit_Description_0069>The permanent support structure allows this artillery installation greater range than its mobile counterpart. It is much more functional against slow moving or stationary targets.",
           
   ['ueb2108'] = "<LOC Unit_Description_0070>The Aloha launches Long Range Cruise Missiles with deadly accuracy. Each missile is constructed by the launcher. The unit must be ordered to construct its missiles.",
             
   ['ueb5202'] = "<LOC Unit_Description_0071>The Air Staging Platform (ASP) is a complete refueling and repair platform that is designed to extend the effective range of aircraft.",
   
   ['ueb2302'] = "<LOC Unit_Description_0072>The largest standard artillery piece in the UEF arsenal, the Duke fires the same anti-matter shell as the \"Demolisher\" Mobile Artillery Piece, but with a much greater range.",
      
   ['ueb2305'] = "<LOC Unit_Description_0073>The Stonager can create and store up to 5 nuclear missiles in a special, hardened storage chamber. The unit must be ordered to construct its missiles.",
         
   ['ueb0304'] = "<LOC Unit_Description_0074>The Tech 3 Quantum Gateway summons a Support Commander to the field of battle.",
            
   ['ueb2401'] = "<LOC Unit_Description_0075>The most advanced of the UEF strategic weaponry, the Mavor delivers devastating, pinpoint-accurate firepower at extreme ranges. The Mavor can provide artillery coverage across any theater, regardless of range.",
   
   
   
   ##Engineers
   
   ['uel0105'] = "<LOC Unit_Description_0076>The Engineer is a multi-purpose construction, repair, capture and reclamation unit. It is amphibious and can skim across the water's surface to construct naval facilities.",
            
   ['uel0208'] = "<LOC Unit_Description_0077>This is the upgraded version of the T1 Engineer and is capable of building more complex structures. It is built at a T2 Factory",
     
   ['uel0309'] = "<LOC Unit_Description_0078>This is the upgraded version of the T2 Engineer and is capable of building the most complex structures. This is the only Engineer that can build Experimental units. It is built at a T3 Factory.",
   
            
   ##Factories
    
    
   ['ueb0101'] = "<LOC Unit_Description_0079>The Land Factory creates the initial mobile units necessary to wage a war. The factory is outfitted to create only land based units. The factory can be upgraded to T2 and can assist other factories. ",
   
   ['ueb0102'] = "<LOC Unit_Description_0080>The Air Factory creates the initial air units necessary to wage a war. The factory is outfitted to create only air based units. The factory can be upgraded to T2 and can assist other factories. ",
            
   ['ueb0103'] = "<LOC Unit_Description_0081>The Naval Factory creates the initial naval units necessary to wage a war. The factory is outfitted to create only naval units. The factory can be upgraded to T2 and can assist other factories. ",
   
   ['ueb0201'] = "<LOC Unit_Description_0082>This is the upgrade to the T1 Land Factory. This factory can be upgraded to T3, which gives the factory access to advanced unit patterns. It can assist other factories.",
            
   ['ueb0202'] = "<LOC Unit_Description_0083>This is the upgrade to the T1 Air Factory. This factory can be upgraded to T3, which gives the factory access to advanced unit patterns. It can assist other factories.",
               
   ['ueb0203'] = "<LOC Unit_Description_0084>This is the upgrade to the T1 Naval Factory. This factory can be upgraded to T3, which gives the factory access to advanced unit patterns. It can assist other factories.",
            
   ['ueb0301'] = "<LOC Unit_Description_0085>This is the upgrade to the T2 Land Factory. This factory cannot be upgraded any further. It can assist other factories.",
   
   
   ['ueb0302'] = "<LOC Unit_Description_0086>This is the upgrade to the T2 Air Factory. This factory cannot be upgraded any further. It can assist other factories.",
            
   ['ueb0303'] = "<LOC Unit_Description_0087>This is the upgrade to the T2 Naval Factory. This factory cannot be upgraded any further. It can assist other factories.",
   
   
   #Buildings
   
   ['ueb1101'] = "<LOC Unit_Description_0088>The Power Generator is a cheap, solid and stable source of Energy generation. Power Generators can be linked to other structures, giving the linked structure a small reduction in operating costs.",
      
   ['ueb1102'] = "<LOC Unit_Description_0089>Deposits of hydrocarbon-containing natural resources remain a viable form of Energy to this day. The HCPP is much more efficient than a standard Power Generator.",
         
   ['ueb1105'] = "<LOC Unit_Description_0090>The Energy Storage Unit increases the maximum Energy capacity of a Commander's economy. Build adjacent to Generators to receive a bonus.",
   
   ['ueb1103'] = "<LOC Unit_Description_0091>Mass is a valuable resource in the Infinite War and is mined by Mass Extractors. The Mass Extractor can be upgraded to a more efficient version, the Mass Pump.",
      
   ['ueb1104'] = "<LOC Unit_Description_0092>The Mass Fabricator is an ingenious system for converting pure Energy into usable Mass. The Energy costs are immense, so it is only viable when little or no Mass is available.",
         
   ['ueb1106'] = "<LOC Unit_Description_0093>The Mass Storage Unit increases the maximum Mass capacity of a Commander's economy. Build adjacent to Extractors and Fabricators to receive a bonus.",
   
   ['ueb1201'] = "<LOC Unit_Description_0094>The upgrade to the Power Generator, the Fusion Reactor's construction cost is high. Construction of structures next to a Fusion Reactor improves the operating efficiency of the adjacent structures.",
      
   ['ueb1202'] = "<LOC Unit_Description_0095>The Mass Pump is upgraded from the Mass Extractor or built by a T2 Engineer. This version is more costly to maintain, but results in much faster Mass collection.",
         
   ['ueb1301'] = "<LOC Unit_Description_0096>The Fusion Reactor Array is the best front-line Energy supply available. Construction of structures next to a Fusion Array improves the operating efficiency of the adjacent structures.",
   
   ['ueb1302'] = "<LOC Unit_Description_0097>The Mass Pump 3 is upgraded from the Mass Pump or built by a T3 Engineer. This version is more costly to maintain, but results in much faster Mass collection.",
      
   ['ueb1303'] = "<LOC Unit_Description_0098>The Mass Fabrication Facility produces a large amount of Mass at an exorbitant Energy cost. Only an infrastructure with a tremendous amount of Energy would be able to operate one of these facilities.",
         
   ['ueb3101'] = "<LOC Unit_Description_0099>The UEF's standard radar installation is an effective way to monitor an area for unauthorized trespassing. The light version has a limited range and armor, but can be upgraded.",
   
   ['ueb3102'] = "<LOC Unit_Description_0100>The UEF's sonar installation is very similar to the radar equivalent. Serving as a cheap, short range detection mechanism, the SP1 does its job well. The SP1's sensor package can be upgraded.",
      
   ['ueb3201'] = "<LOC Unit_Description_0101>The SA2 is a long range equivalent to the light radar system. The T2 Radar Installation can be upgraded into the T3 Omni sensor.",
         
   ['ueb3202'] = "<LOC Unit_Description_0102>The SP2 is a long-range equivalent to the light sonar system. This Tech 2 Sonar Installation can be upgraded from the Tech 1 version and into a mobile variant.",
   
   ['ueb4203'] = "<LOC Unit_Description_0103>The Stealth Field Generator covers a sizable area with an advanced radar-stealth field. This field masks the presence of any units in it from the radar, but has no effect on line-of-sight.",
      
   ['ues0305'] = "<LOC Unit_Description_0104>The SP3 is a mobile equivalent to the long-range sonar system. In addition to a superior sonar range and mobility, the SP3 comes with a bottom mounted torpedo turret.",
         
   ['ueb3104'] = "<LOC Unit_Description_0105>The Omni Sensor Array is the ultimate in intelligence gathering. In addition to a very long range, the Omni will also defeat Stealth Fields and other cloaking technology.",
   
   
   
   
   
   
   
   ##CYBRAN UNITS
   
   
   #Commanders  
   
   ['url0001'] = "<LOC Unit_Description_0304>The most important unit in the field, the ACU houses a Commander and is a combination barracks and command center. The ACU contains all the basic blueprints necessary to build an army from scratch in the field.",   
   ['url0001-isb'] = "<LOC Unit_Description_0106>The Resource Allocation System introduces efficiency algorithms that enhance the rate at which the ACU can generate resources.",
   ['url0001-pcg'] = "<LOC Unit_Description_0107>The Personal Cloaking Generator allows their ACU to become invisible to Optical Sensors. Like other cloaking fields, it does not work against radar and is broken by Omni-Sensors.",
   ['url0001-psg'] = "<LOC Unit_Description_0108>The upgrade to the Personal Cloaking Generator, the Personal Stealth Generator adds a stealth field to the existing Cloaking Generator. This effectively renders the ACU invisible to everything except an Omni-Sensor.",
   ['url0001-pqt'] = "<LOC Unit_Description_0109>The Personal Quantum Teleporter allows the Commander to teleport almost instantly across a range of several miles. The Teleporter requires considerable Energy to activate.",
   ['url0001-aes'] = "<LOC Unit_Description_0110>Commanders looking to expand their ACU's building capacity will typically install this upgrade. This will increase the ACU's building speed.",
   ['url0001-ees'] = "<LOC Unit_Description_0111>Replaces the Advanced Engineering Suite and further expands the number of schematics available to the Commander. It also further enhances the ACU's build speed.",
   ['url0001-acu'] = "<LOC Unit_Description_0112>Utilizing a liquid nitrogen system, the Advanced Cooling Upgrade can cool any weapon mounted on the ACU much more rapidly than normal. This increases most weapons' fire rate.",
   ['url0001-mlg'] = "<LOC Unit_Description_0113>The Microwave Laser Generator lets the ACU generate a beam laser that sweeps over enemy units.",
   ['url0001-ntt'] = "<LOC Unit_Description_0114>This installation mounts a standard Cybran Nanite Torpedo Tube onto the ACU, enabling the Commander to more effectively combat enemy naval units.",
  
    
     
    ## Support Commanders 
   
   ['url0301'] = "<LOC Unit_Description_0115>This unit can continually rebuild and repair any unit or structure. The Sub-commander is summoned through a Quantum Gate.",
   ['url0301-cfs'] = "<LOC Unit_Description_0116>A popular choice among Cybran Commanders, the Personal Cloaking Generator allows their SACU to become invisible to Optical Sensors. Like other cloaking fields, it does not work against radar and is broken by Omni-Sensors.",
   ['url0301-emp'] = "<LOC Unit_Description_0117>The EMP Charge effectively 'freezes' enemy units in an area for a few seconds, forcing them to reset their on-board computers.",
   ['url0301-fc'] = "<LOC Unit_Description_0118>The Focus Converter focuses the standard Disintegrator Pulse Laser through a series of special lenses, greatly enhancing the beam's cohesion and almost doubling its damage output.",
   ['url0301-nms'] = "<LOC Unit_Description_0119>The Nanite Missile System adds a standard Cybran SAM Nanite Missile System to the SACU. This gives the SACU considerable anti-air capability.",
   ['url0301-isb'] = "<LOC Unit_Description_0120>The Resource Allocation System introduces efficiency algorithms that enhance the rate at which the ACU can generate resources.",
   ['url0301-ses'] = "<LOC Unit_Description_0121>Commanders looking to expand their SACU's building capacity will typically install the Engineering Suite. This enables the SACU to build more structures, faster.",
   ['url0301-srs'] = "<LOC Unit_Description_0122>This equipment package greatly enhances the rate at which the SACU repairs itself. It is a good choice for Commanders who tend to use their SACU offensively.",
   ['url0301-sfs'] = "<LOC Unit_Description_0123>The upgrade to the Personal Cloaking Generator, the Personal Stealth Generator adds a stealth field to the existing Cloaking Generator. This effectively renders the SACU invisible to everything except an Omni-Sensor.",
   ['anc_url300'] = "<LOC Unit_Description_0115>This unit can continually rebuild and repair any unit or structure. The Sub-commander is summoned through a Quantum Gate.",
   ['anc_url300-isb'] = "<LOC Unit_Description_2137>The Resource Allocation System introduces efficiency algorithms that enhance the rate at which the ACU can generate resources.",
   ['anc_url300-pcg'] = "<LOC Unit_Description_2138>The Personal Cloaking Generator allows their ACU to become invisible to Optical Sensors. Like other cloaking fields, it does not work against radar and is broken by Omni-Sensors.",
   ['anc_url300-psg'] = "<LOC Unit_Description_2139>The upgrade to the Personal Cloaking Generator, the Personal Stealth Generator adds a stealth field to the existing Cloaking Generator. This effectively renders the ACU invisible to everything except an Omni-Sensor.",
   ['anc_url300-pqt'] = "<LOC Unit_Description_2140>The Personal Quantum Teleporter allows the Commander to teleport almost instantly across a range of several miles. The Teleporter requires considerable Energy to activate.",
   ['anc_url300-ses'] = "<LOC Unit_Description_2141>Commanders looking to expand their ACU's building capacity will typically install this upgrade. This will increase the ACU's building speed.",
   ['anc_url300-acu'] = "<LOC Unit_Description_2143>Utilizing a liquid nitrogen system, the Advanced Cooling Upgrade can cool any weapon mounted on the ACU much more rapidly than normal. This increases most weapons' fire rate.",
   ['anc_url300-mlg'] = "<LOC Unit_Description_2144>The Microwave Laser Generator lets the ACU generate a beam laser that sweeps over enemy units.",
   ['anc_url300-ntt'] = "<LOC Unit_Description_2145>This installation mounts a standard Cybran Nanite Torpedo Tube onto the ACU, enabling the Commander to more effectively combat enemy naval units.",
   ['anc_url300-srs'] = "<LOC Unit_Description_0122>This equipment package greatly enhances the rate at which the SACU repairs itself. It is a good choice for Commanders who tend to use their SACU offensively.",
   
   ##land units
   
   ['url0101'] = "<LOC Unit_Description_0124>The Mole forgoes weapons to make room for a cloaking field which makes the Mole invisible to line-of-sight, though it is still visible to radar and an Omni sensor will reveal it to optical sensors.",
   ['url0106'] = "<LOC Unit_Description_0125>The Hunter is a fast strike bot designed to work in groups. Though it's lightly armored and does moderate damage, its relatively low cost allows for many to be built quickly and deployed as support or a light task force.",
   ['url0107'] = "<LOC Unit_Description_0126>Sporting a Heavy Laser Autogun in each arm, the Mantis can lay down an impressive field of fire. It also has a stripped down Engineering Suite which can repair the unit.",
   ['url0103'] = "<LOC Unit_Description_0127>The Medusa fires small yield EMP grenades which can destroy light units and seriously damage tougher ones.",
   ['url0104'] = "<LOC Unit_Description_0128>The Slammer incorporates a new Nano-Dart system, which fires a small rocket-propelled dart that has exceptional speed and homing ability. The Nano-Dart can also be set to fire on land targets.",
   ['url0202'] = "<LOC Unit_Description_0129>The Rhino is a favorite of many Cybran Commanders. Its Dual Particle Cannon packs a powerful punch that compliments its role as a front line attacker.",
   ['url0203'] = "<LOC Unit_Description_0130>While surfaced, the Wagner utilizes a Heavy Electron Bolter. When submerged, the Wagner reconfigures its Bolter to fire torpedoes.",
   ['url0111'] = "<LOC Unit_Description_0131>The Viper is the upgrade to the Medusa, substituting EMP Grenades, for a Loa Missile System. In addition, the Viper has superior armor and handling characteristics.",
   ['url0205'] = "<LOC Unit_Description_0132>The Banger fires a shell that creates a temporary electromagnetic storm in a small radius. This damages enemy electronics and will cause failures in the enemy systems, destroying the unit.",
   ['url0306'] = "<LOC Unit_Description_0133>When the Mobile Stealth System is active, radar signals are dampened. This effect causes units linked to the Deceiver to not show up on enemy radars. This has no effect on optical sensors, however.",
   ['url0303'] = "<LOC Unit_Description_0134>The Loyalist is the Cybran's heaviest conventional direct fire weapon. It employs a Disintegrator Pulse Laser as its primary armament and utilizes a Heavy Electron Bolter to deal with lighter forces.",
   ['url0304'] = "<LOC Unit_Description_0135>One of the biggest guns in the Cybran arsenal, it is necessary for the Trebuchet to extend its stabilizing arms before it can fire. It cannot fire while moving.",
   ['url0402'] = "<LOC Unit_Description_0136>The Monkeylord is a land based juggernaut. It consumes massive amounts of power to operate its main Heavy Microwave Laser Generator, which it sweeps across any enemy to its front.",
   ['url0401'] = "<LOC Unit_Description_0137>The Scathis Rapid Fire Artillery uses a heat distribution system that allows it to rapidly fire the military's most potent artillery shells. The Energy cost is the only limit to the rate of fire.",
   ['anc_url111'] = "<LOC Unit_Description_1137>The VPRII,the second generation Viper armed with Loa Missiles the VPRII utilizes a rapid fire and reload system.",
   ['anc_url201'] = "<LOC Unit_Description_1138>The Argus is the upgrade to the Mole,adding stealth technology to compliment it's cloaking ability.",
   ['anc_url303'] = "<LOC Unit_Description_1139>Revolutionist,the next generation heavy siege assualt bot.Carring duel Disintigrater Pulse Lasers and duel Electron Bolters,the Revolutionist becomes a force to be reckoned with.",
   ['anc_url307'] = "<LOC Unit_Description_1140>Shadowrunner is a mobile cloaking field generator,keeping units within it's radius invisible to optical sensors.This has no effect on radar sensors however.",
   ['anc_url308'] = "<LOC Unit_Description_1141>Ghost,the advanced espionage intel unit.Moving virtualy unseen in and around enemy camps deploying land sensors.",
   ['anc_url403'] = "<LOC Unit_Description_1142>The assasin bot Phantom,with it's ElectronBolter and HeavyDisintegrator weapons and EMP meltdown which stuns enemies upon death.",
   ['anc_url404'] = "<LOC Unit_Description_1143>The Cybran Wraith,the fast attack siege assault tank.Made to lead the assault and crush the opposition with it's compliment of weaponry including it's devasataing Death Orb.",
   
   
   ##Air units
   ['ura0101'] = "<LOC Unit_Description_0138>The Cybran air scout is an older design and is pretty typical in its functionality. It has a great visual radius, high speed, no weapons and light armor.",
   ['ura0102'] = "<LOC Unit_Description_0139>The Prowler is a state-of-the-art air-superiority fighter. Its Autocannon sacrifices damage for a high rate of fire and accuracy, literally tearing its target apart with hundreds of rounds.",
   ['ura0103'] = "<LOC Unit_Description_0140>The Zeus packs a large punch, delivering a bomb that detonates just before impact, delivering a powerful area of effect explosion and exposing the area with a concentrated dose of radiation.",
   ['ura0107'] = "<LOC Unit_Description_0141>This small transport is designed to carry a very small task force of bots and/or tanks. It is very fast but lacks the cargo capacity, armor and weaponry of its heavier counterpart. ",
   ['ura0203'] = "<LOC Unit_Description_0142>The Renegade is a fast attack copter designed to provide ground support. The twin rocket tubes launch direct fire rockets at ground targets.",
   ['ura0204'] = "<LOC Unit_Description_0143>The Cormorant drops torpedoes that cause serious damage to naval vessels and structures. ",
   ['ura0302'] = "<LOC Unit_Description_0144>The Spook uses a sonic resonance scanner that is capable of bridging the gap between conventional radar and sonar. In addition, the Spook can be set to fly in stealth mode.",
   ['ura0104'] = "<LOC Unit_Description_0145>The Dragon Fly can easily carry a small squad of bots or vehicles. Its single Autocannon allows it to defend itself against air attacks while its EMP Cannon can stun targets for a short time.",
   ['ura0303'] = "<LOC Unit_Description_0146>The Gemini features a Nanite Missile system, which fires volleys of small missiles in spread that maximizes hit probability. It has more armor than the Prowler, but is still a relatively light unit.",
   ['ura0304'] = "<LOC Unit_Description_0147>The Revenant's payload, a proton bomb, does considerable initial damage that radiates outward. Additionally, the Revenant features a rear-mounted Flak Cannon and an onboard stealth field.",
   ['ura0401'] = "<LOC Unit_Description_0148>The Ripper delivers massive firepower as well as air projection power on the front lines. This gunship bristles with weaponry, including a pair of Heavy Iridium Rocket Racks.",
   ['anc_ura003'] = "<LOC Unit_Description_2146>The Lead Air Engineers prove that a simple design can be quite powerful.The Lead Engineer can build,repair or reclaim ,anywhere on the battlefield.",    
   ['anc_ura102'] = "<LOC Unit_Description_2147>The swarm fighter-Designed as a light fast attack fighter for early combat.",
   ['anc_ura103'] = "<LOC Unit_Description_2148>Darkstar was primarily designed as an early ground attack platform.",
   ['anc_ura205'] = "<LOC Unit_Description_2149>The Nighthawk is a multi-role strikefighter carring the standard anti-air Nanite Missiles and the latest Nanite air to ground Missiles delivering ground strikes with surgical precision.",
   ['anc_ura304'] = "<LOC Unit_Description_2150>Diviner,simply put,the Cybran answer to the Lancer.Unlike traditional strategic bombers,the Diviner drops duel Proton Bombs,while doing considerable initial damage which radiates outward.",
   ['anc_ura305'] = "<LOC Unit_Description_2151>The Stingray is a fast assult gunship.What it lacks in armor,in makes up for in it's abilities and firepower.Sporting radarstealth,cloak,and the latest Cybran Nano Regenerative Armor and packs duel MicrowaveLaser Generators.",
   ['anc_ura306'] = "<LOC Unit_Description_2152>Sporting heavier armor than it's T2 counterpart,the Griffen carriers a mass amount of ground forces.With it's heavier armor,Cybran Nano Armor and radarstealth,the Griffen can infiltrate even the toughest enemy beacheads.",
   ['anc_ura307'] = "<LOC Unit_Description_2153>The Raptor is the Cybrans premier air supremacy fighter.Firing a swarm of Nanite missiles and Partcle Cannon lasers.",
   ['anc_urs201'] = "<LOC Unit_Desciription_2154>The Intrepid Class Destroyer has the latest Cybran Nano Armor,increased weaponry and a faster walk time on land.",
   ['anc_urs202'] = "<LOC Unit_Desciription_2155>The Defender Class is utterly loaded with weaponry.Designed as a light alternative to the battleship.",
   ['anc_urs304'] = "<LOC Unit_Desciription_2156>The Defiater Class is an assault support ship.When paired up with a battleship they can become an unstoppable force.",
   ['anc_urs405'] = "<LOC Unit_Desciription_2157>Silent Running,the experimental stealth,strategic submarine.Armed with nanite torpedoes,long range cruise missiles and nuclear warheads.",
   ['anc_urb2101'] = "<LOC Unit_Desciription_2158>The Auto Gun MKII is a light gun tower utilizing stealth technology.",
   ['anc_urb3204'] = "<LOC Unit_Desciription_2159>The Quad Cannon Heavy Defence Battery.Powering four Particle Beam Lasers and protected by stealth and cloak,the Quad Cannon goes unseen.Until it is to late.",
   ['anc_urb4101'] = "<LOC Unit_Desciription_2160>Anubis.Powering up with three Microwave Laser Generators and protected by Cybran Nano Armor.The Anubis is the Advanced Point Defence  .",
   ['anc_urb1102'] = "<LOC Unit_Desciription_2161>Advanced Hydrocarbon Power Plant,capable of upgrading to a Tier2 Hydro Plant.",
   ['anc_urb1103'] = "<LOC Unit_Desciription_2162>Scout Deployed Land Sensor or SDLS,constructed only by Ghost.Once deployed it transforms itself into a stationary radar tower.",
   ['anc_urb2102'] = "<LOC Unit_Desciription_2163>The Tier2 Hydrocarbon Power Plant is capable of upgrading to a Tier3 Hydrocarbon Plant.",
   ['anc_urb3102'] = "<LOC Unit_Desciription_2164>The Tier3 Hydro Power Plant,producing 1,000 Energy Per Second.It is the very latest in Hydrocarbon technology.",
   ['anc_urb3203'] = "<LOC Unit_Desciription_2165>Taking their stealth and cloaking technologies even further,the Cybrans have combined a stealth field generator with a cloaking field generator.The result is the Illusion.",
   ['anc_urb5101'] = "<LOC Unit_Description_2166>In an effort to maintain better protection for vital structures,the Cybrans developed a larger variation of there current wall structures incorporating the latest nano-technology to self repair damaged wall structures.",
   ['anc_urs102'] = "<LOC Unit_Description_2167>The Septor Class Vessels were made to eventually replace the Trident Class Frigate.The Septor is a step up from the Trident Class with it's large arsonal of weaponry.",   
   ['anc_urs404'] = "<LOC Unit_Description_2167>Reports from Cybran Commanders of suffering heavy losses in sea battles,have led to the creation of the Krakken.Armed with multiple Proton Cannons,Anti-Air Auto-Cannons,Torpedo Launchers,Smartcharges,and a single Distruptor Cannon.The Krakken is prepared to own the seas.",
   ['anc_urb4205'] = "<LOC Unit_Description_2168>Addressing the need to keep up with Aeon Shield technology,the Cybrans incorporated their upgradeable shield ability into a single Multi-Shield Generator.",

   
   ##navel Units
   ['urs0103'] = "<LOC Unit_Description_0149>The Trident serves as a heavily armed mobile radar and sonar platform. Armed with a Proton Cannon and an AA Autocannon, it is capable of providing basic direct fire and AA support.",
   ['urs0203'] = "<LOC Unit_Description_0150>The 4th generation of a venerable design, the Sliver has seen service across the galaxy. It sports a Nanite Torpedo Launcher and a deck-mounted Heavy Laser for surface operations.",
   ['urs0202'] = "<LOC Unit_Description_0151>The Cybran cruiser can serve many roles, but it's primarily an anti-air and short-range rocket platform. This cruiser also offers aircraft repair and refueling capabilities.",
   ['urs0201'] = "<LOC Unit_Description_0152>A single Dual Proton Cannon makes up the Salem's primary direct fire capability. This destroyer deploys legs when it encounters land, enabling it to walk, albeit very slowly. ",
   ['urs0302'] = "<LOC Unit_Description_0153>The Galaxy Class Battleship is completely and utterly loaded with weaponry. Its primary role as a direct fire and bombardment vessel is covered by its six Proton Cannons.",
   ['urs0303'] = "<LOC Unit_Description_0154>To protect its aircraft, the Command Class supports a full compliment of light AA Autocannons, while a single 'Zapper' Anti-Missile Turret protects its cargo from incoming missiles.",
   ['urs0304'] = "<LOC Unit_Description_0155>A special internal construction bay allows the Plan B to build special warheads that are designed to decimate forces at a strategic level.",
   

   
  
   ['urb2101'] = "<LOC Unit_Description_0176>The standard ground defense for civilian and secondary military outposts, the T1 Point Defense features a Heavy Laser Autogun that provides ample defense without draining the local economy.",
   ['urb2104'] = "<LOC Unit_Description_0177>The Tracer employs the standard Cybran Anti-Air Autocannon for AA defense rather than a direct fire laser. When built over water, the Tracer is fitted with a flotation platform.",
   ['urb2109'] = "<LOC Unit_Description_0178>A re-engineered Gun Tower, the Autogun has been replaced with a Nanite Torpedo Tube and fitted with a flotation device. It fires the standard Cybran Nanite Torpedo.",
   ['urb5101'] = "<LOC Unit_Description_0179>Like the other factions, the Cybrans employ modular wall pieces to protect their structures from unwanted intrusion and direct weapons fire.",
   ['urb2301'] = "<LOC Unit_Description_0180>The upgrade to the standard Gun Tower, the Cerebus comes equipped with three vertically stacked Particle Cannons.",
   ['urb2204'] = "<LOC Unit_Description_0181>This sturdy tower features the same weapon as the 'Banger' mobile AA unit. The weapon damages electronics and will eventually cause a failure in the enemy systems, destroying the unit.",
   ['urb4201'] = "<LOC Unit_Description_0182>This anti-missile system has extremely fast targeting capability and is quick enough to detonate incoming missiles and rockets. When constructed over water, it is built on a flotation platform.",
   ['urb2205'] = "<LOC Unit_Description_0183>The Heavy Torpedo Launcher uses the same Nanite torpedoes as the T1 version, but fires multiple torpedoes in quick succession until the target is destroyed",
   ['urb4202'] = "<LOC Unit_Description_0184>The ED1 blocks incoming projectiles and Energy signatures. This shield generator can be upgraded 4 times, each time increasing the operating costs, radius and strength of the shield.",
   ['urb4202-ch'] = "<LOC Unit_Description_0306>This upgrade will increase the Shield's size and strength. However, the Shield's operating cost will also increase.",
   
   ['urb2304'] = "<LOC Unit_Description_0185>The Myrmidon relies on hitting fast and often with its eight Nanite Missile Systems, firing a continuous stream of missiles until its target is destroyed.",
   ['urb4302'] = "<LOC Unit_Description_0186>The Guardian is designed to disable incoming strategic missiles before the missile reaches its target. The Guardian must be ordered to construct its defensive missiles.",
   ['urb2303'] = "<LOC Unit_Description_0187>Firing a unique Molecular Resonance Shell, the Gunther is built on an extremely strong, stable platform to minimize vibration and recoil and thus allow the gun to fire quickly and efficiently.",
   ['urb2108'] = "<LOC Unit_Description_0188>This tactical missile launcher employs a 'Loa' Missile System. Five missiles can be stored in individual launchers. The unit must be ordered to construct its missiles.",
   ['urb5202'] = "<LOC Unit_Description_0189>The Air Staging Facility is a complete refueling and repair platform designed to extend the effective range of aircraft.",
   ['urb2302'] = "<LOC Unit_Description_0190>The biggest gun in the Cybran arsenal, the Disruptor has incredible range and firepower. The only Cybran unit that has greater range is the Strategic Missile Launcher.",
   ['urb2305'] = "<LOC Unit_Description_0191>An internal construction bay allows this missile launcher to build and store multiple warheads designed to decimate forces at a strategic level. The unit must be ordered to construct its missiles.",
   ['urb0304'] = "<LOC Unit_Description_0192>The Summoner calls a Support Commander to the field of battle.",
   
   ##engineers
   ['url0105'] = "<LOC Unit_Description_0193>The Engineer is a multi-purpose construction, repair, capture and reclamation unit. It is amphibious and can skim across the water's surface to construct naval facilities.",
   ['url0208'] = "<LOC Unit_Description_0194>This is the upgraded version of the T1 Engineer and is capable of building more complex structures. It is built at a T2 Factory",
   ['url0309'] = "<LOC Unit_Description_0195>This is the upgraded version of the T2 Engineer and is capable of building the most complex structures. This is the only Engineer that can build Experimental units. It is built at a T3 Factory.",
   
   ##Factories etc
   ['urb0101'] = "<LOC Unit_Description_0196>The Land Factory creates the initial mobile units necessary to wage a war. The factory is outfitted to create only land based units. The factory can be upgraded to T2 and can assist other factories. ",
   ['urb0102'] = "<LOC Unit_Description_0197>The Air Factory creates the initial air units necessary to wage a war. The factory is outfitted to create only air based units. The factory can be upgraded to T2 and can assist other factories. ",
   ['urb0103'] = "<LOC Unit_Description_0198>The Naval Factory creates the initial naval units necessary to wage a war. The factory is outfitted to create only naval units. The factory can be upgraded to T2 and can assist other factories. ",
   ['urb0201'] = "<LOC Unit_Description_0199>This is the upgrade to the T1 Land Factory. This factory can be upgraded to T3, which gives the factory access to advanced unit patterns. It can assist other factories. ",
   ['urb0202'] = "<LOC Unit_Description_0200>This is the upgrade to the T1 Air Factory. This factory can be upgraded to T3, which gives the factory access to advanced unit patterns. It can assist other factories.",
   ['urb0203'] = "<LOC Unit_Description_0201>This is the upgrade to the T1 Naval Factory. This factory can be upgraded to T3, which gives the factory access to advanced unit patterns. It can assist other factories.",
   ['urb0301'] = "<LOC Unit_Description_0202>This is the upgrade to the T2 Land Factory. This factory cannot be upgraded any further. It can assist other factories.",
   ['urb0302'] = "<LOC Unit_Description_0203>This is the upgrade to the T2 Air Factory. This factory cannot be upgraded any further. It can assist other factories.",
   ['urb0303'] = "<LOC Unit_Description_0204>This is the upgrade to the T2 Naval Factory. This factory cannot be upgraded any further. It can assist other factories.",
   
   
   ##Base stuff
   ['urb1101'] = "<LOC Unit_Description_0205>The Power Generator is a cheap, solid and stable source of Energy generation. Power Generators can be linked to other structures, giving the linked structure a small reduction in operating costs.",
   ['urb1102'] = "<LOC Unit_Description_0206>Deposits of hydrocarbon-containing natural resources remain a viable form of Energy to this day. The HCPP is much more efficient than a standard Power Generator.",
   ['urb1103'] = "<LOC Unit_Description_0207>Mass is a valuable resource in the Infinite War and is mined by Mass Extractors. The Mass Extractor can be upgraded to a more efficient version, the Mass Pump.",
   ['urb1104'] = "<LOC Unit_Description_0208>The Mass Fabricator is an ingenious system for converting pure Energy into usable Mass. The Energy costs are immense, so it is only viable when little or no Mass is available.",
   ['urb1106'] = "<LOC Unit_Description_0209>The Mass Storage Unit increases the maximum Mass capacity of a Commander's economy. Build adjacent to Extractors and Fabricators to receive a bonus.",
   ['urb1105'] = "<LOC Unit_Description_0210>The Energy Storage Unit increases the maximum Energy capacity of a Commander's economy. Build adjacent to Generators to receive a bonus.",
   ['urb1201'] = "<LOC Unit_Description_0211>The upgrade to the Power Generator, the T2's construction cost is high. Construction of structures next to a T2 Generator improves the operating efficiency of the adjacent structures.",
   ['urb1202'] = "<LOC Unit_Description_0212>The T2 Extractor is upgraded from the Mass Extractor or built by a T2 Engineer. This version is more costly to maintain, but results in much faster Mass collection.",
   ['urb1301'] = "<LOC Unit_Description_0213>The Ion Reactor is the best front-line power supply available. Construction of structures next to an Ion Reactor improves the operating efficiency of the adjacent structures.",
   ['urb1302'] = "<LOC Unit_Description_0214>The T3 Extractor is upgraded from the T2 Extractor or built by a T3 Engineer. This version is more costly to maintain, but results in much faster Mass collection.",
   ['urb1303'] = "<LOC Unit_Description_0215>The Mass Fabrication Facility produces a large amount of Mass at an exorbitant Energy cost. Only an infrastructure with a tremendous amount of Energy would be able to operate one of these facilities.",
   ['urb3101'] = "<LOC Unit_Description_0216>The base Cybran radar has limited range and armor, but is exceptionally cheap to build. This system can be upgraded.",
   ['urb3102'] = "<LOC Unit_Description_0217>The Cybran's sonar installation is very similar to the radar equivalent. Serving as a cheap, short-range detection mechanism, the base level Noah does its job well. This system can be upgraded.",
   ['urb3201'] = "<LOC Unit_Description_0218>The T2 Radar System is a long-range equivalent to the T1 system. This T2 Radar Installation can be upgraded from the T1 version and upgraded into the T3 Omni sensor.",
   ['urb3202'] = "<LOC Unit_Description_0219>This is a long-range equivalent to the T1 Sonar System. This T2 Sonar Installation can be upgraded from the T1 version and into a mobile variant.",
   ['urb4203'] = "<LOC Unit_Description_0220>With this field active, any units within its radius will not show up on radar. The Twilight does nothing to shield a unit from optical sensors, however. ",
   ['urs0305'] = "<LOC Unit_Description_0221>The T3 Sonar Platform is a mobile long-range sonar system. It comes with a stealth field generator that is capable of obscuring sonar signals in a modest radius.",
   ['urb3104'] = "<LOC Unit_Description_0222>The Omni Sensor Array is the ultimate in intelligence gathering. In addition to a very long-range, the Omni will also defeat Stealth Fields and other cloaking technology.",
   
   ##AEON UNITS
   
   
   #Commanders  
   
   ['ual0001'] = "<LOC Unit_Description_0305>The most important unit in the field, the ACU houses a Commander and is a combination barracks and command center. The ACU contains all the basic blueprints necessary to build an army from scratch in the field.",
   ['ual0001-aes'] = "<LOC Unit_Description_0156>Commanders looking to expand their ACU's building capacity will typically install this upgrade. This will increase the ACU's building speed.",
   ['ual0001-cd'] = "<LOC Unit_Description_0157>Chrono Dampener creates a Quantum Stasis Field around the ACU that immobilizes enemy units within a certain radius. This process consumes a lot of Energy, however.",
   ['ual0001-cba'] = "<LOC Unit_Description_0158>Beam Augmentation focuses the standard ACU Quantum Disruptor Beam through a series of special lenses, greatly enhancing the beam's cohesion and almost doubling its maximum range.",
   ['ual0001-ess'] = "<LOC Unit_Description_0159>This upgrade greatly expands the range of the standard on-board ACU sensor systems and is a popular choice with Commanders who are often active away from their main base.",
   ['ual0001-ees'] = "<LOC Unit_Description_0160>Replaces the Advanced Engineering Suite and further expands the number of schematics available to the Commander. It also further enhances the ACU's build speed.",
   ['ual0001-hsa'] = "<LOC Unit_Description_0161>When the Heat Sink Augmentation is installed, ACU can fire the Quantum Disruptor Beam to fire nearly twice as fast.",
   ['ual0001-ras'] = "<LOC Unit_Description_0162>Resource Allocation System enhances the amount of resources an ACU generates, and efficiency algorithms speed up the conversion process.",
   ['ual0001-eras'] = "<LOC Unit_Description_0163>The Advanced Resource Allocation System further streamlines resource allocation.",
   ['ual0001-ptsg'] = "<LOC Unit_Description_0164>When activated, the Personal Shield creates a personal shield around the ACU. The Personal Shield will dissipate after taking enough damage and will need to recharge before it can be activated again.",
   ['ual0001-phtsg'] = "<LOC Unit_Description_0165>When activated, a personal shield is created around the ACU. The shield will dissipate after taking a certain amount damage and must recharge before it can be reactivated.",
   ['ual0001-pqt'] = "<LOC Unit_Description_0166>The Personal Teleporter lets the Commander teleport almost instantly across a range of several miles. The Personal Teleporter requires considerable Energy to activate.",
  
   
   
   ## Support Commanders 
   
   ['ual0301'] = "<LOC Unit_Description_0167>This unit can continually rebuild and repair any unit or structure. The Sub-commander is summoned through a Quantum Gate.",
   ['ual0301-efm'] = "<LOC Unit_Description_0168>The Engineering Focus Module upgrade enables the SACU to build and repair at a much faster rate.",
   ['ual0301-epp'] = "<LOC Unit_Description_0169>The Resource Allocation System reduces the operating costs of the SACU.",
   ['ual0301-sp'] = "<LOC Unit_Description_0170>The Sub-commander may be ordered to sacrifice in order to add her SACU's Mass to a structure. However, a new Sub-commander will have to be summoned via a Quantum Gate.",
   ['ual0301-tsg'] = "<LOC Unit_Description_0171>When activated, the Personal Shield creates a personal shield around the SACU. After taking enough damage, it will need to recharge before it can be reactivated.",
   ['ual0301-htsg'] = "<LOC Unit_Description_0172>An upgrade to the Personal Shield, this shield enhances the strength of the Shield Generator.",
   ['ual0301-ss'] = "<LOC Unit_Description_0173>When the SACU is upgraded with a Stability Suppressant, its Reacton Cannon will cause a powerful area-of-effect 'wake' that damages any nearby enemy units.",
   ['ual0301-sic'] = "<LOC Unit_Description_0174>The System Integrity Compensator upgrade increases the rate at which the SACU regenerates damaged armor.",
   ['ual0301-pqt'] = "<LOC Unit_Description_0175>The Personal Teleporter lets the Support Commander teleport almost instantly across a range of several miles. The Personal Teleporter requires considerable Energy to activate.",
   
   
   ##land
   ['ual0101'] = "<LOC Unit_Description_0223>With fast speed and a capable weapon, the Spirit is a good scout with decent firepower.",
   ['ual0106'] = "<LOC Unit_Description_0224>These incredibly fast bots are designed for pure damage. The Short-Range Sonic Pulsar mounted on each arm fires fan-shaped, focused sound waves that permeate and disrupt solid matter.",
   ['ual0201'] = "<LOC Unit_Description_0225>The Aurora has extremely light armor, though it has excellent range and damage. Luckily for the other factions, the Aurora's Disruptor Cannon has a very slow rate of fire.",
   ['ual0103'] = "<LOC Unit_Description_0226>The Fervor makes up for its lack of accuracy by covering a target area with dozens of shells. These shells have a very small detonation radius, but deliver an incredible punch.",
   ['ual0104'] = "<LOC Unit_Description_0227>The Thistle sports a fast firing sonic pulse battery. This weapon is designed to disrupt the lighter armor found on aircraft and cause critical structural damage.",
   ['ual0202'] = "<LOC Unit_Description_0228>The Obsidian mounts a Quantum Cannon, a powerful, yet slow-firing weapon. All Obsidians feature a Tachyon Shield Generator which, when active, generates a shield around the unit.",
   ['ual0111'] = "<LOC Unit_Description_0229>Featuring a 'Serpentine' Tactical Missile Rack, the Seeker is effective out to medium ranges, but does relatively light damage, necessitating several shots to defeat a target.",
   ['ual0205'] = "<LOC Unit_Description_0230>The Ascendant is armed with a Temporal AA Fizz Launcher. This device creates a 'bubble' that damages the enemy on a quantum level, causing the target to tear itself apart.",
   ['ual0307'] = "<LOC Unit_Description_0231>The Asylum employs a combination of electromagnetic and kinetic generators to create a shield around a large area. It is generally used to provide additional protection for ground assaults.",
   ['ual0303'] = "<LOC Unit_Description_0232>The Harbinger features a High Intensity Laser as well as a simplified Reclamation and Repair system that allows the unit to reclaim matter in the field and repair itself.",
   ['ual0304'] = "<LOC Unit_Description_0233>The Aeon's mobile heavy artillery delivers incredible damage at extremely long ranges. The Sonance Feedback Shell detonates and starts a chain reaction in a small area of effect.",
   ['ual0401'] = "<LOC Unit_Description_0234>The Colossus initially carries a Phason Laser, which incinerates nearby units. In addition, the Colossus can pull smaller enemy units into its hands via a Tractor Beam and crush them.",
   ['ana_uaa003'] = "<LOC Unit_Description_3001>The Lead Air Engineers prove that a simple design can be quite powerful.The Lead Engineer can build,repair or reclaim ,anywhere on the battlefield.",    
   ['ana_uaa102'] = "<LOC Unit_Description_3002>The swarm fighter-Designed as a light fast attack fighter for early combat.",
   ['ana_uaa205'] = "<LOC Unit_Description_3003>The Inquistior is a dogfighter designed to fill the gap between interceptors and ASF's.",
   ['ana_uaa305'] = "<LOC Unit_Description_3004>The Hades Assault Gunship.Armed with four Pulse Lasers and two High Intensity Lasers.",
   ['ana_uaa306'] = "<LOC Unit_Description_3005>As an assault mass transport,the Aeon Auspicious Cloud air transport,carries up to 21 units to battle.",
   ['ana_uas201'] = "<LOC Unit_Description_3006>The Illuminate have taken sub hunting to a whole new level with the Colubia Class Hovering Destroyer.Completely untargetable by torpedos and armed with Harmonic Depth Charges,Chrono Torpedos and an Oblivian Cannon.", 
   ['ana_uas301'] = "<LOC Unit_Description_3007>The Abolisher,carrying long range cruise missiles,is a missile bombardment sub that can tear through some of the toughest tactical defences.",
   ['ana_ual406'] = "<LOC Unit_Description_3009>Quantum Tank The Sparkler,named after it's fireworks type display of deadly Fragmentation Shells.",
   ['ana_ual409'] = "<LOC Unit_Description_3010>Experimental Destroyer Bot Salvation destroys anything in it's path and reclaims what's left .",
   ['ana_uab1102'] = "<LOC Unit_Description_3011>Advanced Hydrocarbon Power Plant,capable of upgrading to a Tier2 Hydro Plant.",
   ['ana_uab2102'] = "<LOC Unit_Description_3012>The Tier2 Hydrocarbon Power Plant is capable of upgrading to a Tier3 Hydrocarbon Plant.",
   ['ana_uab3102'] = "<LOC Unit_Description_3013>The Tier3 Hydro Power Plant,producing 1,000 Energy Per Second.It is the very latest in Hydrocarbon technology.",
   ['ana_uab4101'] = "<LOC Unit_Description_3014>The Abyss Advanced Point Defence Tower delivers a potent energy blast,spreading outwards in a disperal pattern .",
   ['ana_uab1202'] = "<LOC Unit_Description_3015>Seeing an obvious need for early defences against raids,the Aeon built a smaller version of their Shield of Light,to provide instant protection for valuable structures in the early battles.",   
   ['ana_uas302'] = "<LOC Unit_Description_3016>With it's onboard sonar,the Shark hunts the waters for enemy subs.Armed with multiple torpedo launchers and anti-torpedo weaponry the Shark was made for sub hunting.",
   ['ana_uab3204'] = "<LOC Unit_Description_3017>With rapid fire High Intensity Laser Light Weapons and proteceted with a personal shield,Pulsar is a heavy defence battery that can tear through the toughest armor.",
   ['ana_uab3203'] = "<LOC Unit_Description_3018>A low altitude anti-air satellite,though not as powerful as sam launchers,Othalla still has an advantage of being untargetable by land units that do not possess anti-air.",
   ['ana_uab2101'] = "<LOC Unit_Description_3019>Taking full use of their teleporting technology,the Aeon have developed a point defence weapon that can teleport itself anywhere on the battlefield.",
   ['ana_uab5101'] = "<LOC Unit_Description_3020>Not having access to nan-technology or heavier armor,the Illuminate have incorporated their shielding technology as an integral part of they new Tech2 Shield Walls.",
   ['ana_uas302'] = "<LOC Unit_Description_3021>Armed with multiple Chronotorpedos and protected by it's own personal shield,the Shark is the perfect compliment to the Hovering Destroyer for sub hunting.",
   ['ana_ual308'] = "<LOC Unit_Description_3022>Further experiments with Seraphim technology has produced the Odyssey Advanced Spy,the Odyssey carries onboard radar,onboard omni-sensor,protected by it's own personalshield,able to capture enemy structures,armed with laser light weapons and can instantly teleport in and out of enemy bases.",
   ['ana_uaa206'] = "<LOC Unit_Description_3023>Cupid is the Aeons answer to the Cybrans Strike-Fighter.Armed with QuarkBombs,Anti-Missile Flares,and Anti-Air Missiles.",
   ['ana_uab4301'] = "<LOC Unit_Description_3024>Pushing ahead with their shielding advantage,the Aeon built the Blinding Aegis.Their largest and most powerful shield to date.",



   ##Air
   ['uaa0101'] = "<LOC Unit_Description_0235>In keeping with the Aeon philosophy of simple, single purpose units, the Mirage is little more than a highly guidable missile with an advanced optical sensor suite.",
   ['uaa0102'] = "<LOC Unit_Description_0236>This interceptor forgoes extra systems for focused firepower against air targets. The Conservator's Sonic Pulse Battery is ideally suited for dog fighting enemy aircraft.",
   ['uaa0103'] = "<LOC Unit_Description_0237>The Shimmer releases a single, highly explosive Chrono Bomb. A residual temporal field remains for a few moments after the bomb's detonation and briefly freezes enemy units.",
   ['uaa0107'] = "<LOC Unit_Description_0238>This small transport is designed to carry a very small task force of bots and/or tanks. It is very fast, but lacks the cargo capacity, armor and weapon fire of its heavier counterpart.",
   ['uaa0203'] = "<LOC Unit_Description_0239>This gunship has a Quad Barreled Light Laser mounted on its underside. This weapon does light damage but has an incredibly fast rate of fire.",
   ['uaa0204'] = "<LOC Unit_Description_0240>The Aeon torpedo bomber drops a payload of Harmonic Depth Charges, which home in on their target and explode, disrupting the integrity of the ship's hull and causing structural damage.",
   ['uaa0302'] = "<LOC Unit_Description_0241>The Aeon's top of the line mobile intelligence unit is the Seer. Though it lacks sonar capability, it has good flight range and large optical and radar coverage.",
   ['uaa0104'] = "<LOC Unit_Description_0242>The Aluminar is a mobile air transport. It is designed to carry a small task force of bots and/or tanks. It has much heavier armor than the Chariot and carries Sonic Pulse Batteries.",
   ['uaa0303'] = "<LOC Unit_Description_0243>The Corona is the first attempt to integrate Seraphim technology into an Aeon unit. The Corona's Quantum Displacement Autocannon fires a bursting shell, much like flak.",
   ['uaa0304'] = "<LOC Unit_Description_0244>Shockers drop a single Quark Bomb. These bombs have a small detonation radius and do considerable damage. The Shocker can also deploy a Decoy Flare that can distract enemy targeting computers.",
   ['uaa0310'] = "<LOC Unit_Description_0245>The CZAR's most fearsome weapon is the one large Quantum Beam Generator mounted in the center of the unit. If that wasn't enough, the CZAR can carry an entire wing of aircraft.",
   
   
   ##Navel
   ['uas0103'] = "<LOC Unit_Description_0246>The Beacon is the mainstay of the Aeon navy. Its radar and sonar capability make it a must for inclusion in naval battle groups. Also offers minor defense against torpedoes.",
   ['uas0203'] = "<LOC Unit_Description_0247>The Sylph is a focused ship hunter. It carries two of the standard Aeon Chrono Torpedoes and is equivalent in performance to the other faction's attack subs.",
   ['uas0102'] = "<LOC Unit_Description_0248>The Shard provides Anti-Air support for the Aeon fleet. It carries the standard Aeon Anti-Air Sonic Pulse Battery. The Shard sacrifices armor for additional speed.",
   ['uas0202'] = "<LOC Unit_Description_0249>Designed to provide excellent Anti-Air protection, the Infinity comes equipped with two Surface-to-Air 'Zealot' Missile Launchers and a Dual Barreled Quantum Cannon for direct fire support.", 
   ['uas0201'] = "<LOC Unit_Description_0250>Built for direct fire support and sub hunting, the Exodus carries an Oblivion Cannon, as well as a variety of anti-sub and anti-torpedo weapons.",
   ['uas0302'] = "<LOC Unit_Description_0251>The Omen carries three Oblivion Cannons, which despite their slow rate of fire, are still devastating weapons. Two \"Will-O-Wisp\" Anti-Missile Flares offer some protection against tactical missiles.",
   ['uas0303'] = "<LOC Unit_Description_0252>The Keefer can hold several squadrons of aircraft and refuel and repair any craft that lands. It has no offensive armaments, but does have a pair of 'Zealot' Surface-to-Air Missile Launchers.",
   ['uas0304'] = "<LOC Unit_Description_0253>The Silencer is a submersible missile platform. Its primary arsenal is an array of 'Serpentine' Tactical Missiles. The Silencer can refit two of its cruise missiles with a strategic warhead.",
   ['uas0401'] = "<LOC Unit_Description_0254>The Tempest can attack with Heavy Chrono Torpedo Launchers. Surfacing allows the unit access to a single Oblivion Cannons. It also has the ability to construct a light support fleet in the field.",
   
   
   ##Buildings
   ['uab2101'] = "<LOC Unit_Description_0255>The standard ground defense for civilian and secondary military outposts, the Erupter features a Graviton Projector that provides ample defense without draining the local economy.",
   ['uab2104'] = "<LOC Unit_Description_0256>The Seeker employs the standard Aeon anti-air Pulse Battery for AA defense rather than a direct fire weapon. When built over water, the Seeker is fitted with a flotation platform.",
   ['uab2109'] = "<LOC Unit_Description_0257>A cheap, effective naval defense, the Tide utilizes the standard Aeon Chrono Torpedo Tube housed in a lightly armored tower. It can only be built on water.",
   ['uab5101'] = "<LOC Unit_Description_0258>Like the other factions, the Aeon employ modular wall pieces to protect their structures from unwanted intrusion and direct weapons fire.",
   ['uab2301'] = "<LOC Unit_Description_0259>The Oblivion, named for the Oblivion Cannon it uses, is a heavily armored defensive tower. The Aeon Oblivion Cannon is a slow, but devastating weapon with area-of-effect damage.",
   ['uab2204'] = "<LOC Unit_Description_0260>Rather than using standard flak, the Aeon utilize a Temporal AA Fizz Launcher. This device creates a 'bubble' that damages the target on a quantum level, causing the target to tear itself apart.",
   ['uab4201'] = "<LOC Unit_Description_0261>The Volcano utilizes the \"Will-O-Wisp\" tactical missile flare which pulls incoming projectiles towards it where it safely detonates the incoming missile or rocket. It can be built on water.",
   ['uab2205'] = "<LOC Unit_Description_0262>An up-armored version of the T1 Torpedo Launcher, the T2 version is equipped with a Chrono Torpedo Pack Launcher.",
   ['uab4202'] = "<LOC Unit_Description_0263>The Shield of Light is the Aeon version of the shield. It employs a combination electromagnetic and kinetic generator to defeat incoming missiles and other ordinance.",
   ['uab2304'] = "<LOC Unit_Description_0264>Unlike other anti-aircraft systems, this weapon delivers a single 'Zealot' missile at its target. When constructed over water, this SAM launcher is built on a flotation platform.",
   ['uab4302'] = "<LOC Unit_Description_0265>The Patron is designed to destroy incoming strategic missiles before the missile reaches its target. This launcher can store 5 missiles. The Patron must be ordered to build its defensive missiles.",
   ['uab4301'] = "<LOC Unit_Description_0266>An upgrade to the 'Shield of Light', the Radiance can absorb more damage and has a larger radius of protection.",
   ['uab2303'] = "<LOC Unit_Description_0267>An emplaced artillery piece, the Miasma is named after its munition, the 'Miasma' Shell, which does incredible damage over time.",
   ['uab2108'] = "<LOC Unit_Description_0268>This weapon can construct and store up to eight 'Serpentine' missiles. These missiles do burst damage and have a decent sustained fire. The unit must be ordered to construct its missiles.",
   ['uab5202'] = "<LOC Unit_Description_0269>The Cradle is a complete refueling and repair platform that is designed to extend the effective range of aircraft.",
   ['uab2302'] = "<LOC Unit_Description_0270>The Aeon's highest tier artillery fires Sonance Feedback Shells which do incredible damage at extremely long ranges and with phenomenal accuracy, but at a reduced rate of fire.",
   ['uab2305'] = "<LOC Unit_Description_0271>This missile launcher can construct and store five Quantum Distortion Warheads. These warheads provide for overwhelming, long-range firepower. The unit must be ordered to construct its missiles.",
   ['uab0304'] = "<LOC Unit_Description_0272>The Portal allows a Sub-commander to be called in. The Sub-commander can help maintain and repair units and structures.",
   
   
   
   ##Engineers
   ['ual0105'] = "<LOC Unit_Description_0273>The Engineer is a construction, repair, capture and reclamation unit. It is amphibious and can create naval facilities. Sacrificing it during the construction process will add instant build value.",
   ['ual0208'] = "<LOC Unit_Description_0274>This is the upgraded version of the T1 Engineer and is capable of building more complex structures. It is built at a T2 Factory",
   ['ual0309'] = "<LOC Unit_Description_0275>This is the upgraded version of the T2 Engineer and is capable of building the most complex structures. This is the only Engineer that can build Experimental units. It is built at a T3 Factory.",
   
   
   
   ['uab0101'] = "<LOC Unit_Description_0276>The Land Factory creates the initial mobile units necessary to wage a war. The factory is outfitted to create only land based units. The factory can be upgraded to T2 and can assist other factories.",
   ['uab0102'] = "<LOC Unit_Description_0277>The Air Factory creates the initial air units necessary to wage a war. The factory is outfitted to create only air based units. The factory can be upgraded to T2 and can assist other factories.",
   ['uab0103'] = "<LOC Unit_Description_0278>The Naval Factory creates the initial naval units necessary to wage a war. The factory is outfitted to create only naval units. The factory can be upgraded to T2 and can assist other factories.",
   ['uab0201'] = "<LOC Unit_Description_0279>This is the upgrade to the T1 Land Factory. This factory can be upgraded to T3, which gives the factory access to advanced unit patterns. It can assist other factories. ",
   ['uab0202'] = "<LOC Unit_Description_0280>This is the upgrade to the T1 Air Factory. This factory can be upgraded to T3, which gives the factory access to advanced unit patterns. It can assist other factories.",
   ['uab0203'] = "<LOC Unit_Description_0281>This is the upgrade to the T1 Naval Factory. This factory can be upgraded to T3, which gives the factory access to advanced unit patterns. It can assist other factories.",
   ['uab0301'] = "<LOC Unit_Description_0282>This is the upgrade to the T2 Land Factory. This factory cannot be upgraded any further. It can assist other factories.",
   ['uab0302'] = "<LOC Unit_Description_0283>This is the upgrade to the T2 Air Factory. This factory cannot be upgraded any further. It can assist other factories.",
   ['uab0303'] = "<LOC Unit_Description_0284>TThis is the upgrade to the T2 Naval Factory. This factory cannot be upgraded any further. It can assist other factories.",
   ['uab1101'] = "<LOC Unit_Description_0285>The Power Generator is a cheap, solid and stable source of Energy generation. Power Generators can be linked to other structures, giving the linked structure a small reduction in operating costs.",
   ['uab1102'] = "<LOC Unit_Description_0286>Deposits of hydrocarbon-containing natural resources remain a viable form of Energy to this day. The HCPP is much more efficient than a standard Power Generator.",
   ['uab1105'] = "<LOC Unit_Description_0287>The Energy Storage Unit increases the maximum Energy capacity of a Commander's economy. Build adjacent to Generators to receive a bonus.",
   ['uab1103'] = "<LOC Unit_Description_0288>Mass is a valuable resource in the Infinite War and is mined by Mass Extractors. The Mass Extractor can be upgraded to a more efficient version, the Mass Pump.",
   ['uab1104'] = "<LOC Unit_Description_0289>The Mass Fabricator is an ingenious system for converting pure Energy into usable Mass. The Energy costs are immense, so it is only viable when little or no Mass is available.",
   ['uab1106'] = "<LOC Unit_Description_0290>The Mass Storage Unit increases the maximum mass capacity of a Commander's economy. Build adjacent to Extractors and Fabricators to receive a bonus.",
   ['uab1201'] = "<LOC Unit_Description_0291>The upgrade to the Power Generator, the T2's construction cost is high. Construction of structures next to a T2 Generator improves the operating efficiency of the adjacent structures.",
   ['uab1202'] = "<LOC Unit_Description_0292>The T2 Extractor is upgraded from the Mass Extractor or built by a T2 Engineer. This version is more costly to maintain, but results in much faster Mass collection.",
   ['uab1301'] = "<LOC Unit_Description_0293>The Quantum Reactor is the best front-line power supply available. Construction of structures next to a Quantum Reactor improves the operating efficiency of the adjacent structures.",
   ['uab1302'] = "<LOC Unit_Description_0294>The T3 Extractor is upgraded from the T2 Extractor or built by a T3 Engineer. This version is more costly to maintain, but results in much faster Mass collection.",
   ['uab1303'] = "<LOC Unit_Description_0295>The Mass Fabrication Facility produces a large amount of Mass at an exorbitant Energy cost. Only an infrastructure with a tremendous amount of Energy would be able to operate one of these facilities.",
   ['uab3101'] = "<LOC Unit_Description_0296>The base radar has a limited range and armor, but is exceptionally cheap to build. This system can be upgraded for longer ranges and other abilities.",
   ['uab3102'] = "<LOC Unit_Description_0297>The Aeon's sonar installation is very similar to the radar equivalent. This system can be upgraded for longer ranges and other abilities.", 
   ['uab3201'] = "<LOC Unit_Description_0298>The T2 Radar System is a long-range equivalent to the T1 system. This T2 Radar Installation can be upgraded from the T1 version and upgraded into the T3 Omni sensor.",
   ['uab3202'] = "<LOC Unit_Description_0299>This is a long-range equivalent to the T1 Sonar System. This T2 Sonar Installation can be upgraded from the T1 version and into a mobile variant.",
   ['uab4203'] = "<LOC Unit_Description_0300>The Stealth Field Generator covers a decent area with an advanced stealth field. This field masks the presence of any units in it from the radar, but has no effect on line-of-sight.",
   ['uas0305'] = "<LOC Unit_Description_0301>The Sonar Platform is a mobile equivalent to the long-range sonar system. It also houses a series of anti-torpedo launchers. This T3 Sonar Installation can be upgraded from the T2 version.",
   ['uab3104'] = "<LOC Unit_Description_0302>The Omni Sensor Array is the ultimate in intelligence gathering. In addition to a very long range, the Omni will also defeat Stealth Fields and other cloaking technology.", 

   # Patch Units
   ['dea0202'] = "<LOC Unit_Description_0307>Forgoing a bit of accuracy for improved armor and damage capacity, the Janus is the ideal mid-level bomber.",
   ['dra0202'] = "<LOC Unit_Description_0308>Equipped with an air-to-ground nano-missile, the Corsair is a surgical strike bomber. Rumors exist that Cybran scientists continue to work on a fighter/bomber variant.",
   ['daa0206'] = "<LOC Unit_Description_0309>The volatile and destructive nature of the Mercy's weapon system forced Aeon scientists to create a simple, expendable delivery system. As a result, the payload is attached to what is little more than a guided missile.",
}
