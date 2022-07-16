-----------------------------------------------
-- 文件名    :  TalentTab.lua
-- 创建人    :  linjiaqi
-- 创建时间  :  2011-02-25
-- 用途(模块):  天赋系统
-- 用途  	 :  共用函数和数据表格和Client端天赋操作
------------------------------------------------

-- 公共定义
TALENT_BEGIN_LEVEL 			= 16	-- 天赋从16级开始第一点
TALENT_ADD_LEVEL 			= 2		-- 天赋每两级加一点
TALENT_OPEN_SERIES_POINT	= 26	-- 一系满N点才能开另一系

-- 返回信息
ERR_TALENT_ERROR   					= 0;	-- 失败
ERR_TALENT_SUCCESS					= 1;	-- 成功
ERR_TALENT_LEVEL_LOWER 				= 2;	-- 等级不足
ERR_TALENT_NOT_ENOUGH_POINT			= 3;	-- 点数不足
ERR_TALENT_NOT_FIRST_FORCE 			= 4;	-- 错误的第一势力
ERR_TALENT_MAX_SKILL_LEVEL 			= 5;	-- 天赋已达最大等级
ERR_TALENT_MIN_SKILL_LEVEL 			= 6;	-- 天赋已达最小等级,既0点的时候还要减去
ERR_TALENT_NOT_ENOUGH_ADDUP_POINT	= 7;	-- 累计点数不足
ERR_TALENT_NOT_ENOUGH_SERIES_POINT	= 8;	-- 系点数不足
ERR_TALENT_NOT_ENOUGH_SKILL_POINT	= 9;	-- 直属技能点数不足

-- 势力ID对应
FORCE_SHAOLIN 	= 1;
FORCE_WANHUA 	= 2;
FORCE_TIANCE 	= 3;
FORCE_CHUNYANG 	= 4;
FORCE_QIXIU 	= 5;
FORCE_WUDU 	= 6;
FORCE_TANGMEN 	= 7;
FORCE_CANGJIAN 	= 8;
FORCE_GAIBANG	= 9;
FORCE_MINGJIAO 	= 10;


-- 天赋表
TALENT_TAB = {
	-- 少林天赋
	[FORCE_SHAOLIN] = {	
		[1] = {	-- A系
			{2549, 2559, 2556, 0}, -- 没有的技能必须用0表示占位!!!
			{2557, 2558, 2564, 2560}, 
			{2561, 2563, 2551, 2565}, 
			{2566, 2567, 2568, 2569}, 
			{2570, 2571, 0, 	0}, 
			{0, 2572,  0, 0},
		},
		[2] = {	-- B系
			{2573, 2574, 2575, 0}, -- 没有的技能必须用0表示占位!!!
			{2576, 2577, 2578, 2579}, 
			{2580, 2581, 2582, 2583}, 
			{2584, 2585, 2586, 2587}, 
			{2588, 2562, 0, 0}, 
			{0, 2589,  0, 0},
		},
	},
	
	-- 万花天赋
	[FORCE_WANHUA] = {	
		[1] = {	-- A系
			{2629, 2630, 2631, 0}, -- 没有的技能必须用0表示占位!!!
			{2632, 2633, 2634, 2635}, 
			{2636, 2637, 2638, 2639}, 
			{2640, 2641, 2642, 0}, 
			{2643, 2644, 0, 0}, 
			{0, 2645,  0, 0},
		},
		[2] = {	-- B系
			{2647, 2648, 2652, 0}, -- 没有的技能必须用0表示占位!!!
			{2650, 2651, 2649, 2653}, 
			{2654, 2655, 2656, 2657}, 
			{2658, 2659, 2660, 3789}, 
			{2661, 2662, 0, 0}, 
			{0, 2663,  0, 0},
		},
	},
	
	-- 天策天赋
	[FORCE_TIANCE] = {	
		[1] = {	-- A系
			{2595, 2596, 2597, 0}, -- 没有的技能必须用0表示占位!!!
			{2598, 2599, 2600, 2601}, 
			{2602, 2603, 2604, 2605}, 
			{2606, 2607, 2608, 0}, 
			{   0, 2609, 2610, 0}, 
			{0, 2611,  0, 0},
		},
		[2] = {	-- B系
			{2612, 2613, 2614, 0}, -- 没有的技能必须用0表示占位!!!
			{2615, 2616, 2617, 2618}, 
			{2619, 2620, 2621, 2622}, 
			{2623, 2624, 2625, 0}, 
			{2626, 2627, 0, 0}, 
			{0, 2628,  0, 0},
		},
	},
	
	-- 纯阳天赋
	[FORCE_CHUNYANG] = {	
		[1] = {	-- A系
			{2682, 2683, 0, 2684}, -- 没有的技能必须用0表示占位!!!
			{2685, 2686, 2687, 2688}, 
			{2689, 2690, 2691, 2692}, 
			{2693, 2694, 2695, 2696}, 
			{0, 2697, 2698, 0}, 
			{0, 0,  2699, 0},
		},
		[2] = {	-- B系
			{2665, 2666, 0, 2667}, -- 没有的技能必须用0表示占位!!!
			{2668, 2669, 2670, 2671}, 
			{2672, 2673, 2674, 2675}, 
			{4080, 2677, 2676, 2678}, 
			{0, 2679, 2680, 0}, 
			{0, 2681, 0, 0},

		},
	},
	
	-- 七秀天赋
	[FORCE_QIXIU] = {	
		[1] = {	-- A系
			{2700, 2701, 2702, 0}, -- 没有的技能必须用0表示占位!!!
			{2703, 2704, 2705, 2706}, 
			{2707, 2708, 2709, 2710}, 
			{2711, 2712, 2713, 0}, 
			{   0, 2714, 2715, 0}, 
			{0, 2716,  0, 0},
		},
		[2] = {	-- B系
			{2717, 2718, 2719, 0}, -- 没有的技能必须用0表示占位!!!
			{2720, 2721, 2722, 2723}, 
			{2724, 2725, 2726, 2727}, 
			{2728, 2729, 2730, 0}, 
			{2731, 2732, 0, 0}, 
			{0, 2733,  0, 0},
		},
	},

	-- 藏剑天赋
	[FORCE_CANGJIAN] = {	
		[1] = {	-- A系
			{2734, 2735, 2736, 0}, -- 没有的技能必须用0表示占位!!!
			{2737, 2738, 2739, 2740}, 
			{2741, 2742, 3417, 2743}, 
			{2745, 2744, 2748, 0}, 
			{2747, 2749, 2746, 0}, 
			{0, 2750,  0, 0},
		},
		[2] = {	-- B系
			{2751, 2752, 2753, 0}, -- 没有的技能必须用0表示占位!!!
			{2754, 2760, 2763, 2757}, 
			{2758, 2755, 2759, 2761}, 
			{2762, 2756, 2764, 0}, 
			{2765, 2766, 2767, 0}, 
			{0, 2768,  0, 0},
		},
	},

	-- 五毒天赋
	[FORCE_WUDU] = {	
		[1] = {	-- A系
			{2993, 0, 2935, 2936}, -- 没有的技能必须用0表示占位!!!
			{2937, 2938, 2939, 2940}, 
			{2941, 2218, 2942, 2943}, 
			{2945, 2946, 2944, 0}, 
			{0, 2947, 2948, 0}, 
			{0, 0,  2227, 0},
		},
		[2] = {	-- B系
			{2949, 2950, 0, 2951}, -- 没有的技能必须用0表示占位!!!
			{2952, 2953, 2954, 2955}, 
			{2956, 2957, 2958, 2959}, 
			{2960, 0, 2961, 2962}, 
			{0, 0, 2963, 2964}, 
			{0, 0,  2965, 0},
		},
	},

	-- 唐门天赋
	[FORCE_TANGMEN] = {	
		[1] = {	-- A系
			{3260, 3261, 3262, 0}, -- 没有的技能必须用0表示占位!!!
			{3263, 3264, 3265, 3266}, 
			{3267, 3101, 3268, 3269}, 
			{3270, 3271, 3272, 3492}, 
			{0, 3273, 3274, 0}, 
			{0, 3100,  0, 0},
		},
		[2] = {	-- B系
			{3275, 3276, 3277, 0}, -- 没有的技能必须用0表示占位!!!
			{3278, 3279, 3280, 3281}, 
			{3282, 3110, 3283, 3284}, 
			{3285, 3286, 3287, 0}, 
			{3288, 3289, 0, 0}, 
			{0, 3111,  0, 0},
		},
	},

	-- 明教天赋
	[FORCE_MINGJIAO] = {	
		[1] = {	-- A系
			{3986, 3987, 3988, 0}, -- 没有的技能必须用0表示占位!!!
			{3989, 3990, 3991, 3992}, 
			{3977, 3993, 3994, 3995}, 
			{3996, 3997, 3998, 3999}, 
			{4000, 4001, 0, 0}, 
			{0, 3978,  0, 0},
		},
		[2] = {	-- B系
			{4002, 4003, 4004, 0}, -- 没有的技能必须用0表示占位!!!
			{4005, 4009, 4007, 4008}, 
			{3983, 4013, 4010, 4011}, 
			{4012, 4006, 4014, 4015}, 
			{4016, 4017, 0, 0}, 
			{0, 3985,  0, 0},
		},
	},

};

-- 天赋下属技能映射表
TALENT_PREV_SKILL_MAPPING_TAB = {
	-- 少林天赋
	[FORCE_SHAOLIN] = {	
		[1] = {	-- A系
		},
		[2] = {	-- B系			
			[2582] = {2578},
			[2588] = {2584},
		},
	},
	
	-- 藏剑天赋
	[FORCE_CANGJIAN] = {	
		[1] = {	-- A系
			[2741] = {2737},
			[2744] = {2742},
		},
		[2] = {	-- B系			
			[2764] = {2759},
		},
	},

	-- 万花天赋
	[FORCE_WANHUA] = {	
		[1] = {	-- A系
			[2643] = {2640},
		},
		[2] = {	-- B系			
			[2658] = {2654},
		},
	},
	
	-- 七秀天赋
	[FORCE_QIXIU] = {	
		[1] = {	-- A系
			[2711] = {2707},
		},
		[2] = {	-- B系			
			[2728] = {2724},
		},
	},
	
	-- 天策天赋
	[FORCE_TIANCE] = {	
		[1] = {	-- A系
			[2607] = {2603},
			[2609] = {2607},
			[2608] = {2604},
			[2605] = {2601},
		},
		[2] = {	-- B系			
			[2626] = {2623},
		},
	},

	-- 纯阳天赋
	[FORCE_CHUNYANG] = {	
		[1] = {	-- A系
			[2693] = {2689},
			[2694] = {2690},
		},
		[2] = {	-- B系			
			[2677] = {2673},
		},
	},

	-- 五毒天赋
	[FORCE_WUDU] = {	
		[1] = {	-- A系
		},
		[2] = {	-- B系			
			[2960] = {2956},
		},
	},

	-- 唐门天赋
	[FORCE_TANGMEN] = {	
		[1] = {	-- A系
			[3269] = {3266},
			[3271] = {3101},
		},
		[2] = {	-- B系			
			[3286] = {3110},
		},
	},

	-- 明教天赋
	[FORCE_MINGJIAO] = {	
		[1] = {	-- A系
			[3996] = {3977},
			[3997] = {3993},
		},
		[2] = {	-- B系			
			[4013] = {4009},
		},
	},
};	

-- 天赋条件
TALENT_CONDITION_TAB = {
	-- 少林天赋
	[FORCE_SHAOLIN] = {	
		-- 条件包括: 需求不包括本层的前N-1层点数和, 需求玩家等级, 具体需求技能及点数,没有的也要占个坑!!!
		[2549] = {nAllPoint = 0, nNeedLevel = 16, PreviousTab = {} },
		[2551] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[2556] = {nAllPoint = 0, nNeedLevel = 16, PreviousTab = {} },
		[2557] = {nAllPoint = 5, nNeedLevel = 26, PreviousTab = {} },
		[2558] = {nAllPoint = 5, nNeedLevel = 26, PreviousTab = {} },
		[2559] = {nAllPoint = 0, nNeedLevel = 16, PreviousTab = {} },
		[2560] = {nAllPoint = 5, nNeedLevel = 26, PreviousTab = {} },
		[2561] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[2563] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[2564] = {nAllPoint = 5, nNeedLevel = 26, PreviousTab = {} },
		[2565] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[2566] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {} },
		[2567] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {} },
		[2568] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {} },
		[2569] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {} },
		[2570] = {nAllPoint = 20, nNeedLevel = 56, PreviousTab = {} },
		[2571] = {nAllPoint = 20, nNeedLevel = 56, PreviousTab = {} },
		[2572] = {nAllPoint = 25, nNeedLevel = 66, PreviousTab = {} },
		[2573] = {nAllPoint = 0, nNeedLevel = 16,  PreviousTab = {} },
		[2574] = {nAllPoint = 0, nNeedLevel = 16,  PreviousTab = {} },
		[2575] = {nAllPoint = 0, nNeedLevel = 16,  PreviousTab = {} },
		[2576] = {nAllPoint = 5, nNeedLevel = 26,  PreviousTab = {} },
		[2577] = {nAllPoint = 5, nNeedLevel = 26,  PreviousTab = {} },
		[2578] = {nAllPoint = 5, nNeedLevel = 26,  PreviousTab = {} },
		[2579] = {nAllPoint = 5, nNeedLevel = 26,  PreviousTab = {} },
		[2580] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[2581] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[2582] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {{2578, 1} } },
		[2583] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[2584] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {} },
		[2585] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {} },
		[2586] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {} },
		[2587] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {} },
		[2588] = {nAllPoint = 20, nNeedLevel = 56, PreviousTab = {{2584, 1} } },
		[2562] = {nAllPoint = 20, nNeedLevel = 56, PreviousTab = {} },
		[2589] = {nAllPoint = 25, nNeedLevel = 66, PreviousTab = {} },
	}, 
	
	-- 藏剑天赋
	[FORCE_CANGJIAN] = {	
		-- 条件包括: 需求不包括本层的前N-1层点数和, 需求玩家等级, 具体需求技能及点数,没有的也要占个坑!!!
		[2734] = {nAllPoint = 0, nNeedLevel = 16, PreviousTab = {} },
		[2735] = {nAllPoint = 0, nNeedLevel = 16, PreviousTab = {} },
		[2736] = {nAllPoint = 0, nNeedLevel = 16, PreviousTab = {} },
		[2737] = {nAllPoint = 5, nNeedLevel = 26, PreviousTab = {} },
		[2738] = {nAllPoint = 5, nNeedLevel = 26, PreviousTab = {} },
		[2739] = {nAllPoint = 5, nNeedLevel = 26, PreviousTab = {} },
		[2740] = {nAllPoint = 5, nNeedLevel = 26, PreviousTab = {} },
		[2741] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {{2737, 2}} },
		[2742] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[3417] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[2743] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },		
		[2745] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {} },
		[2744] = {nAllPoint = 15, nNeedLevel = 36, PreviousTab = {{2742, 1} } },
		[2748] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {} },
		[2747] = {nAllPoint = 20, nNeedLevel = 56, PreviousTab = {} },
		[2749] = {nAllPoint = 20, nNeedLevel = 56, PreviousTab = {} },
		[2746] = {nAllPoint = 20, nNeedLevel = 56, PreviousTab = {} },
		[2750] = {nAllPoint = 25, nNeedLevel = 66, PreviousTab = {} },
		[2751] = {nAllPoint = 0, nNeedLevel = 16,  PreviousTab = {} },
		[2752] = {nAllPoint = 0, nNeedLevel = 16,  PreviousTab = {} },
		[2753] = {nAllPoint = 0, nNeedLevel = 16,  PreviousTab = {} },
		[2754] = {nAllPoint = 5, nNeedLevel = 26,  PreviousTab = {} },
		[2760] = {nAllPoint = 5, nNeedLevel = 26,  PreviousTab = {} },
		[2763] = {nAllPoint = 5, nNeedLevel = 26,  PreviousTab = {} },
		[2757] = {nAllPoint = 5, nNeedLevel = 26,  PreviousTab = {} },
		[2758] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[2755] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[2759] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[2761] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[2762] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {} },
		[2756] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {} },
		[2764] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {{2759, 1} } },
		[2765] = {nAllPoint = 20, nNeedLevel = 56, PreviousTab = {} },
		[2766] = {nAllPoint = 20, nNeedLevel = 56, PreviousTab = {} },
		[2767] = {nAllPoint = 20, nNeedLevel = 56, PreviousTab = {} },
		[2768] = {nAllPoint = 25, nNeedLevel = 66, PreviousTab = {} },
	},   

	-- 万花天赋 	
	[FORCE_WANHUA] = {	
		-- 条件包括: 需求不包括本层的前N-1层点数和, 需求玩家等级, 具体需求技能及点数,没有的也要占个坑!!!
		[2629] = {nAllPoint = 0, nNeedLevel = 16, PreviousTab = {} },
		[2630] = {nAllPoint = 0, nNeedLevel = 16, PreviousTab = {} },
		[2631] = {nAllPoint = 0, nNeedLevel = 16, PreviousTab = {} },
		[2632] = {nAllPoint = 5, nNeedLevel = 26, PreviousTab = {} },
		[2633] = {nAllPoint = 5, nNeedLevel = 26, PreviousTab = {} },
		[2634] = {nAllPoint = 5, nNeedLevel = 26, PreviousTab = {} },
		[2635] = {nAllPoint = 5, nNeedLevel = 26, PreviousTab = {} },
		[2636] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[2637] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[2638] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[2639] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[2640] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {} },
		[2641] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {} },
		[2642] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {} },
		[2643] = {nAllPoint = 20, nNeedLevel = 56, PreviousTab = {{2640, 2} } },
		[2644] = {nAllPoint = 20, nNeedLevel = 56, PreviousTab = {} },
		[2645] = {nAllPoint = 25, nNeedLevel = 66, PreviousTab = {} },
		[2647] = {nAllPoint = 0, nNeedLevel = 16,  PreviousTab = {} },
		[2648] = {nAllPoint = 0, nNeedLevel = 16,  PreviousTab = {} },
		[2649] = {nAllPoint = 5, nNeedLevel = 26,  PreviousTab = {} },
		[2650] = {nAllPoint = 5, nNeedLevel = 26,  PreviousTab = {} },
		[2651] = {nAllPoint = 5, nNeedLevel = 26,  PreviousTab = {} },
		[2652] = {nAllPoint = 0, nNeedLevel = 16,  PreviousTab = {} },
		[2653] = {nAllPoint = 5, nNeedLevel = 26,  PreviousTab = {} },
		[2654] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[2655] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[2656] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[2657] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[2658] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {{2654, 1}} },
		[2659] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {} },
		[2660] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {} },
		[3789] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {} },
		[2661] = {nAllPoint = 20, nNeedLevel = 56, PreviousTab = {} },
		[2662] = {nAllPoint = 20, nNeedLevel = 56, PreviousTab = {} },
		[2663] = {nAllPoint = 25, nNeedLevel = 66, PreviousTab = {} },
	},  
	
	-- 天策天赋 	
	[FORCE_TIANCE] = {	
		-- 条件包括: 需求不包括本层的前N-1层点数和, 需求玩家等级, 具体需求技能及点数,没有的也要占个坑!!!
		[2595] = {nAllPoint = 0, nNeedLevel = 16, PreviousTab = {} },
		[2596] = {nAllPoint = 0, nNeedLevel = 16, PreviousTab = {} },
		[2597] = {nAllPoint = 0, nNeedLevel = 16, PreviousTab = {} },
		[2598] = {nAllPoint = 5, nNeedLevel = 26, PreviousTab = {} },
		[2599] = {nAllPoint = 5, nNeedLevel = 26, PreviousTab = {} },
		[2600] = {nAllPoint = 5, nNeedLevel = 26, PreviousTab = {} },
		[2601] = {nAllPoint = 5, nNeedLevel = 26, PreviousTab = {} },
		[2602] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[2603] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[2604] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[2605] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {{2601, 2}} },
		[2606] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {} },
		[2607] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {{2603, 1} } },
		[2608] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {{2604, 3} } },
		[2609] = {nAllPoint = 20, nNeedLevel = 56, PreviousTab = {{2607, 2} } },
		[2610] = {nAllPoint = 20, nNeedLevel = 56, PreviousTab = {} },
		[2611] = {nAllPoint = 25, nNeedLevel = 66, PreviousTab = {} },
		[2612] = {nAllPoint = 0, nNeedLevel = 16,  PreviousTab = {} },
		[2613] = {nAllPoint = 0, nNeedLevel = 16,  PreviousTab = {} },
		[2614] = {nAllPoint = 0, nNeedLevel = 16,  PreviousTab = {} },
		[2615] = {nAllPoint = 5, nNeedLevel = 26,  PreviousTab = {} },
		[2616] = {nAllPoint = 5, nNeedLevel = 26,  PreviousTab = {} },
		[2617] = {nAllPoint = 5, nNeedLevel = 26,  PreviousTab = {} },
		[2618] = {nAllPoint = 5, nNeedLevel = 26,  PreviousTab = {} },
		[2619] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[2620] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[2621] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[2622] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[2623] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {} },
		[2624] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {} },
		[2625] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {} },
		[2626] = {nAllPoint = 20, nNeedLevel = 56, PreviousTab = {{2623, 3}} },
		[2627] = {nAllPoint = 20, nNeedLevel = 56, PreviousTab = {} },
		[2628] = {nAllPoint = 25, nNeedLevel = 66, PreviousTab = {} },
	},                 

	-- 纯阳天赋
	[FORCE_CHUNYANG] = {	
		-- 条件包括: 需求不包括本层的前N-1层点数和, 需求玩家等级, 具体需求技能及点数,没有的也要占个坑!!!
		[2665] = {nAllPoint = 0, nNeedLevel = 16, PreviousTab = {} },
		[2666] = {nAllPoint = 0, nNeedLevel = 16, PreviousTab = {} },
		[2667] = {nAllPoint = 0, nNeedLevel = 16, PreviousTab = {} },
		[2668] = {nAllPoint = 5, nNeedLevel = 26, PreviousTab = {} },
		[2669] = {nAllPoint = 5, nNeedLevel = 26, PreviousTab = {} },
		[2670] = {nAllPoint = 5, nNeedLevel = 26, PreviousTab = {} },
		[2671] = {nAllPoint = 5, nNeedLevel = 26, PreviousTab = {} },
		[2672] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[2673] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[2674] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[2675] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[2676] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {} },
		[4080] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {} },
		[2677] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {{2673, 2} } },
		[2678] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {} },
		[2679] = {nAllPoint = 20, nNeedLevel = 56, PreviousTab = {} },
		[2680] = {nAllPoint = 20, nNeedLevel = 56, PreviousTab = {} },
		[2681] = {nAllPoint = 25, nNeedLevel = 66, PreviousTab = {} },
		[2682] = {nAllPoint = 0, nNeedLevel = 16, PreviousTab = {} },
		[2683] = {nAllPoint = 0, nNeedLevel = 16,  PreviousTab = {} },
		[2684] = {nAllPoint = 0, nNeedLevel = 16,  PreviousTab = {} },
		[2685] = {nAllPoint = 5, nNeedLevel = 26,  PreviousTab = {} },
		[2686] = {nAllPoint = 5, nNeedLevel = 26,  PreviousTab = {} },
		[2687] = {nAllPoint = 5, nNeedLevel = 26,  PreviousTab = {} },
		[2688] = {nAllPoint = 5, nNeedLevel = 26,  PreviousTab = {} },
		[2689] = {nAllPoint = 10, nNeedLevel = 36,  PreviousTab = {} },
		[2690] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[2691] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[2692] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[2693] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {{2689, 3} } },
		[2694] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {{2690, 1} } },
		[2695] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {} },
		[2696] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {} },
		[2697] = {nAllPoint = 20, nNeedLevel = 56, PreviousTab = {} },
		[2698] = {nAllPoint = 20, nNeedLevel = 56, PreviousTab = {} },
		[2699] = {nAllPoint = 25, nNeedLevel = 66, PreviousTab = {} },
	}, 

	-- 五毒天赋
	[FORCE_WUDU] = {	
		-- 条件包括: 需求不包括本层的前N-1层点数和, 需求玩家等级, 具体需求技能及点数,没有的也要占个坑!!!
		[2993] = {nAllPoint = 0, nNeedLevel = 16, PreviousTab = {} },
		[2935] = {nAllPoint = 0, nNeedLevel = 16, PreviousTab = {} },
		[2936] = {nAllPoint = 0, nNeedLevel = 16, PreviousTab = {} },
		[2937] = {nAllPoint = 5, nNeedLevel = 26, PreviousTab = {} },
		[2938] = {nAllPoint = 5, nNeedLevel = 26, PreviousTab = {} },
		[2939] = {nAllPoint = 5, nNeedLevel = 26, PreviousTab = {} },
		[2940] = {nAllPoint = 5, nNeedLevel = 26, PreviousTab = {} },
		[2941] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[2218] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[2942] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[2943] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[2944] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {} },
		[2945] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {} },
		[2946] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {} },
		[2947] = {nAllPoint = 20, nNeedLevel = 56, PreviousTab = {} },
		[2948] = {nAllPoint = 20, nNeedLevel = 56, PreviousTab = {} },
		[2227] = {nAllPoint = 25, nNeedLevel = 66, PreviousTab = {} },
		[2949] = {nAllPoint = 0, nNeedLevel = 16,  PreviousTab = {} },
		[2950] = {nAllPoint = 0, nNeedLevel = 16,  PreviousTab = {} },
		[2951] = {nAllPoint = 0, nNeedLevel = 16,  PreviousTab = {} },
		[2952] = {nAllPoint = 5, nNeedLevel = 26,  PreviousTab = {} },
		[2953] = {nAllPoint = 5, nNeedLevel = 26,  PreviousTab = {} },
		[2954] = {nAllPoint = 5, nNeedLevel = 26,  PreviousTab = {} },
		[2955] = {nAllPoint = 5, nNeedLevel = 26,  PreviousTab = {} },
		[2956] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[2957] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[2958] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[2959] = {nAllPoint = 10, nNeedLevel = 36,  PreviousTab = {} },
		[2960] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {{2956, 2}} },
		[2961] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {} },
		[2962] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {} },
		[2963] = {nAllPoint = 20, nNeedLevel = 56, PreviousTab = {} },
		[2964] = {nAllPoint = 20, nNeedLevel = 56, PreviousTab = {} },
		[2965] = {nAllPoint = 25, nNeedLevel = 66, PreviousTab = {} },
	}, 
	-- 七秀天赋 	
	[FORCE_QIXIU] = {	
		-- 条件包括: 需求不包括本层的前N-1层点数和, 需求玩家等级, 具体需求技能及点数,没有的也要占个坑!!!
		[2700] = {nAllPoint = 0, nNeedLevel = 16, PreviousTab = {} },
		[2701] = {nAllPoint = 0, nNeedLevel = 16, PreviousTab = {} },
		[2702] = {nAllPoint = 0, nNeedLevel = 16, PreviousTab = {} },
		[2703] = {nAllPoint = 5, nNeedLevel = 26, PreviousTab = {} },
		[2704] = {nAllPoint = 5, nNeedLevel = 26, PreviousTab = {} },
		[2705] = {nAllPoint = 5, nNeedLevel = 26, PreviousTab = {} },
		[2706] = {nAllPoint = 5, nNeedLevel = 26, PreviousTab = {} },
		[2707] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[2708] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[2709] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[2710] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[2711] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {{2707, 1} } },
		[2712] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {} },
		[2713] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {} },
		[2714] = {nAllPoint = 20, nNeedLevel = 56, PreviousTab = {} },
		[2715] = {nAllPoint = 20, nNeedLevel = 56, PreviousTab = {} },
		[2716] = {nAllPoint = 25, nNeedLevel = 66, PreviousTab = {} },
		[2717] = {nAllPoint = 0, nNeedLevel = 16,  PreviousTab = {} },
		[2718] = {nAllPoint = 0, nNeedLevel = 16,  PreviousTab = {} },
		[2719] = {nAllPoint = 0, nNeedLevel = 16,  PreviousTab = {} },
		[2720] = {nAllPoint = 5, nNeedLevel = 26,  PreviousTab = {} },
		[2721] = {nAllPoint = 5, nNeedLevel = 26,  PreviousTab = {} },
		[2722] = {nAllPoint = 5, nNeedLevel = 26,  PreviousTab = {} },
		[2723] = {nAllPoint = 5, nNeedLevel = 26,  PreviousTab = {} },
		[2724] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[2725] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[2726] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[2727] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[2728] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {{2724, 1}} },
		[2729] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {} },
		[2730] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {} },
		[2731] = {nAllPoint = 20, nNeedLevel = 56, PreviousTab = {} },
		[2732] = {nAllPoint = 20, nNeedLevel = 56, PreviousTab = {} },
		[2733] = {nAllPoint = 25, nNeedLevel = 66, PreviousTab = {} },
	}, 

	-- 唐门天赋 	
	[FORCE_TANGMEN] = {	
		-- 条件包括: 需求不包括本层的前N-1层点数和, 需求玩家等级, 具体需求技能及点数,没有的也要占个坑!!!
		[3260] = {nAllPoint = 0, nNeedLevel = 16, PreviousTab = {} },
		[3261] = {nAllPoint = 0, nNeedLevel = 16, PreviousTab = {} },
		[3262] = {nAllPoint = 0, nNeedLevel = 16, PreviousTab = {} },
		[3263] = {nAllPoint = 5, nNeedLevel = 26, PreviousTab = {} },
		[3264] = {nAllPoint = 5, nNeedLevel = 26, PreviousTab = {} },
		[3265] = {nAllPoint = 5, nNeedLevel = 26, PreviousTab = {} },
		[3266] = {nAllPoint = 5, nNeedLevel = 26, PreviousTab = {} },
		[3267] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[3101] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[3268] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[3269] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {{3266, 1} } },
		[3270] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {} },
		[3271] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {{3101, 1} } },
		[3272] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {} },
		[3492] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {} },
		[3273] = {nAllPoint = 20, nNeedLevel = 56, PreviousTab = {} },
		[3274] = {nAllPoint = 20, nNeedLevel = 56, PreviousTab = {} },
		[3100] = {nAllPoint = 25, nNeedLevel = 66, PreviousTab = {} },
		[3275] = {nAllPoint = 0, nNeedLevel = 16,  PreviousTab = {} },
		[3276] = {nAllPoint = 0, nNeedLevel = 16,  PreviousTab = {} },
		[3277] = {nAllPoint = 0, nNeedLevel = 16,  PreviousTab = {} },
		[3278] = {nAllPoint = 5, nNeedLevel = 26,  PreviousTab = {} },
		[3279] = {nAllPoint = 5, nNeedLevel = 26,  PreviousTab = {} },
		[3280] = {nAllPoint = 5, nNeedLevel = 26,  PreviousTab = {} },
		[3281] = {nAllPoint = 5, nNeedLevel = 26,  PreviousTab = {} },
		[3282] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[3110] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[3283] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[3284] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[3285] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {} },
		[3286] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {{3110, 1} } },
		[3287] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {} },
		[3288] = {nAllPoint = 20, nNeedLevel = 56, PreviousTab = {} },
		[3289] = {nAllPoint = 20, nNeedLevel = 56, PreviousTab = {} },
		[3111] = {nAllPoint = 25, nNeedLevel = 66, PreviousTab = {} },
	}, 

	-- 明教天赋 	
	[FORCE_MINGJIAO] = {	
		-- 条件包括: 需求不包括本层的前N-1层点数和, 需求玩家等级, 具体需求技能及点数,没有的也要占个坑!!!
		[3986] = {nAllPoint = 0, nNeedLevel = 16, PreviousTab = {} },
		[3987] = {nAllPoint = 0, nNeedLevel = 16, PreviousTab = {} },
		[3988] = {nAllPoint = 0, nNeedLevel = 16, PreviousTab = {} },
		[3989] = {nAllPoint = 5, nNeedLevel = 26, PreviousTab = {} },
		[3990] = {nAllPoint = 5, nNeedLevel = 26, PreviousTab = {} },
		[3991] = {nAllPoint = 5, nNeedLevel = 26, PreviousTab = {} },
		[3992] = {nAllPoint = 5, nNeedLevel = 26, PreviousTab = {} },
		[3977] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[3993] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[3994] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[3995] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[3996] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {{3977, 1} } },
		[3997] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {{3993, 3} } },
		[3998] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {} },
		[3999] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {} },
		[4000] = {nAllPoint = 20, nNeedLevel = 56, PreviousTab = {} },
		[4001] = {nAllPoint = 20, nNeedLevel = 56, PreviousTab = {} },
		[3978] = {nAllPoint = 25, nNeedLevel = 66, PreviousTab = {} },
		[4002] = {nAllPoint = 0, nNeedLevel = 16, PreviousTab = {} },
		[4003] = {nAllPoint = 0, nNeedLevel = 16, PreviousTab = {} },
		[4004] = {nAllPoint = 0, nNeedLevel = 16, PreviousTab = {} },
		[4005] = {nAllPoint = 5, nNeedLevel = 26, PreviousTab = {} },
		[4009] = {nAllPoint = 5, nNeedLevel = 26, PreviousTab = {} },
		[4007] = {nAllPoint = 5, nNeedLevel = 26, PreviousTab = {} },
		[4008] = {nAllPoint = 5, nNeedLevel = 26, PreviousTab = {} },
		[3983] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[4013] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {{4009, 3} } },
		[4010] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[4011] = {nAllPoint = 10, nNeedLevel = 36, PreviousTab = {} },
		[4012] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {} },
		[4006] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {} },
		[4014] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {} },
		[4015] = {nAllPoint = 15, nNeedLevel = 46, PreviousTab = {} },
		[4016] = {nAllPoint = 20, nNeedLevel = 56, PreviousTab = {} },
		[4017] = {nAllPoint = 20, nNeedLevel = 56, PreviousTab = {} },
		[3985] = {nAllPoint = 25, nNeedLevel = 66, PreviousTab = {} },
	}, 
};

-- 20130624 处理洗新奇穴BUG用
TALENT_NEW_TAB = {
	[FORCE_TIANCE] = {
		5652, 5656, 5657, 5658, 5659, 5660, 5661, 5662, 5663, 5664, 5665, 
		5666, 5667, 5668, 5669, 5670, 5671, 5672, 5673, 5674, 5675, 5676, 
		5677, 5678, 5679, 5680, 5681, 5682, 5683, 5684, 5685, 5686, 5687, 
		5688, 5689, 5690, 5691, 5692, 5693, 5694, 5695, 5696, 5697, 5698, 
		5699, 5700, 5701, 5702, 6869, 6511, 6512, 6513, 6514, 6515, 6517, 
		6518, 6522, 6523, 6524, 6527, 6528, 6530, 6780,6781, 6782, 6806,
		402, 441, 405, 482, 480, 2611, 2628, 2603, 411, 2628, 2620,
	},
	[FORCE_WANHUA] = {
		5751, 5752, 5753, 5754, 5755, 5756, 5757, 5758, 5759, 5760,
		5761, 5762, 5763, 5764, 5765, 5766, 5767, 5768, 5769, 5770,
		5771, 5772, 5773, 5774, 5775, 5776, 5777, 5778, 5779, 5780,
		5781, 5782, 5783, 5784, 5785, 5786, 5787, 5788, 5789, 5790,
		5791, 5792, 5793, 5794, 5795, 5796, 5797, 5798, 6679, 6681,
		6682, 6683, 6684, 6685, 6686, 6687, 6690, 6691, 6692, 6773,
		181, 134, 133, 183, 2663, 184, 2654, 143, 187, 188,
	},
	[FORCE_CHUNYANG] = {
		5799, 5800, 5801, 5802, 5803, 5804, 5805, 5806, 5807, 5808,
		5809, 5810, 5811, 5812, 5813, 5814, 5815, 5816, 5817, 5818,
		5819, 5820, 5821, 5822, 6456, 6460, 6466, 6467, 6469, 6471,
		6472, 6475, 6477, 6481, 6482, 6744, 6747, 6756, 6757, 6758,
		6914, 5823, 5824, 5825, 5826, 5827, 5828, 5829, 5830, 5831,
		5832, 5833, 5834, 5835, 5836, 5837, 5838, 5839, 5840, 5841,
		5842, 5843, 5844, 5845, 5846, 6772,6796, 6797, 6798, 6904,
		6905, 6906, 6908, 6910, 300, 314, 362, 310, 316, 356, 361, 357, 359, 370, 360,
	},
	[FORCE_QIXIU] = {
		5847, 5848, 5849, 5850, 5851, 5852, 5853, 5854, 5855, 5856, 5857,
		5858, 5859, 5860, 5861, 5862, 5863, 5864, 5865, 5866, 5867, 5868,
		5869, 5870, 6556, 6557, 6558, 6561, 6562, 6564, 6565, 6566, 6567,
		6569, 6571, 6572, 6575, 6779, 6847, 6848, 5871, 5872, 5873, 5874,
		5875, 5876, 5877, 5878, 5879, 5880, 5881, 5882, 5883, 5884, 5885,
		5886, 5887, 5888, 5889, 5890, 5891, 5892, 5893, 5894, 6907,
		564, 548, 563, 547, 571, 546, 573, 570, 567, 549, 566,
	},
	[FORCE_SHAOLIN] = {
		5895, 5896, 5897, 5898, 5899, 5900, 5901, 5902, 5903, 5904,
		5905, 5906, 5907, 5908, 5909, 5910, 5911, 5912, 5913, 5914,
		5915, 5916, 5917, 5918, 5919, 5920, 5921, 5922, 5923, 5924,
		5925, 5926, 5927, 5928, 5929, 5930, 5931, 5932, 5933, 5934,
		5935, 5936, 5937, 5938, 5939, 5940, 5941, 5942, 6577, 6578,
		6579, 6580, 6586, 6587, 6589, 6590, 6591, 6593, 6594, 6595,
		6596, 6783, 6788, 6789, 6790, 255, 239, 240, 247, 249, 254, 237, 259, 2589, 246, 248,
	},
	[FORCE_TANGMEN] = {
		3266, 5703, 5704, 5705, 5706, 
		5707, 5708, 5709, 5710, 5711, 5712, 5713, 5714, 5715, 5716, 
		5717, 5718, 5719, 5720, 5721, 5722, 5723, 5724, 5725, 5726, 
		6436, 6437, 6438, 6439, 6441, 6443, 6446, 6449, 6451, 6452, 
		6454, 6455, 6457, 6459, 6461, 6464, 6468, 6473, 6733, 6775, 
		6776, 6874, 6891, 3280, 3281, 3286, 3287, 3288, 5727, 5728, 
		5729, 5730, 5731, 5732, 5733, 5734, 5735, 5736, 5737, 5738, 
		5739, 5740, 5741, 5742, 5743, 5744, 5745, 5746, 5747, 5748, 
		5749, 5750, 6490, 6491, 6492, 6493, 6495, 6498, 6499, 6504, 
		6506, 6507, 6508, 6510, 6778, 6870, 6887, 6888, 6889, 6890, 
		3088, 3092, 3113, 3115, 3116, 3117, 3104, 3099, 3100,
	},
	[FORCE_CANGJIAN] = {
		5943, 5944, 5945, 
		5946, 5947, 5948, 5949, 5950, 5951, 5952, 5953, 5954, 5955, 5956, 5957, 
		5958, 5959, 5960, 5961, 5962, 5963, 5964, 5965, 5966, 6533, 6534, 6535, 
		6537, 6540, 6541, 6542, 6543, 6544, 6545, 6547, 6548, 6549, 6799, 6802,
		1665, 1610, 1647, 1940, 1655, 1667, 1651, 1663,
	},
	[FORCE_WUDU] = {
		2942, 2944, 2946, 2947, 2952, 2955, 2956, 2958, 2959, 2960,
		2961, 2963, 2964, 2965, 2966, 2967, 2968, 2969, 2970, 2971,
		2972, 6015, 6016, 6017, 6018, 6019, 6020, 6021, 6022, 6023,
		6024, 6025, 6026, 6027, 6028, 6029, 6030, 6031, 6032, 6033,
		6034, 6035, 6036, 6037, 6038, 6039, 6040, 6041, 6042, 6043,
		6044, 6045, 6046, 6047, 6048, 6049, 6050, 6051, 6052, 6053,
		6054, 6055, 6056, 6057, 6058, 6059, 6060, 6061, 6062, 6618,
		6619, 6620, 6622, 6623, 6624, 6625, 6627, 6628, 6629, 6630,
		6632, 6636, 6637, 6638, 6641, 6644, 6646, 6647, 6649, 6652,
		6658, 6659, 6660, 6661, 6663, 6664, 6666, 6668, 6669, 6670,
		6672, 6673, 6674, 6694, 6695, 6696, 6877, 6878, 6879, 6880,
		6881, 6882, 6883, 6884, 6885, 6886, 6892, 
		2222, 2225, 2221, 2224, 3702, 2220, 2217, 2227, 2234, 2965,
	},
	[FORCE_GAIBANG] = {
		6809, 6810, 6811, 6812, 6813, 6814, 6815, 6816, 6817, 6818,
		6819, 6820, 6821, 6822, 6823, 6824, 6825, 6826, 6827, 6828,
		6829, 6830, 6831, 6832, 6833, 6864, 6835, 6836, 6837, 6838,
		6839, 6840, 6841, 6842, 6843, 6844, 6845, 6846, 6855, 6857,
		6337, 5360, 5362, 5649, 5272,
	},
	[FORCE_MINGJIAO] = {
		3986, 3987, 3988, 3989, 
		3990, 3991, 3992, 3993, 3994, 3995, 3996, 3997, 3998, 3999, 
		4000, 4001, 4002, 4003, 4004, 4005, 4007, 4008, 4009, 4010, 
		4012, 4014, 4015, 5967, 5968, 5969, 5970, 5971, 5972, 5973, 
		5974, 5975, 5976, 5977, 5978, 5979, 5980, 5981, 5982, 5983, 
		5984, 5985, 5986, 5987, 5988, 5989, 5990, 6717, 6718, 6719, 
		6720, 6721, 6722, 6723, 6724, 6725, 6726, 6727, 6732, 6893, 
		4006, 4011, 4013, 4016, 4017, 5991, 5992, 5993, 5994, 5995, 
		5996, 5997, 5998, 5999, 6000, 6001, 6002, 6003, 6004, 6005, 
		6006, 6007, 6008, 6009, 6010, 6011, 6012, 6013, 6014, 6740, 
		6741, 6742, 6743, 6744, 6745, 6748, 6749, 6751, 6753, 6755, 
		6759, 6760, 6763, 6764, 6766, 6768, 6770, 6771, 6895, 6896, 
		6897, 6898, 6899, 3964, 3961, 3976, 3965, 3968, 3971, 3978, 3983, 3984
	},
};

-- 换算公式,获得当前最大天赋点
function GetMaxTalentPoint(nLevel)
	local nTalentPoint = 0
	if nLevel >= TALENT_BEGIN_LEVEL then
		nTalentPoint = math.floor((nLevel - TALENT_BEGIN_LEVEL) / TALENT_ADD_LEVEL) + 1
	end
	return nTalentPoint
end

-- 根据位置得到技能ID
function GetSkillID(dwForceID, nSeriesID, nRow, nColum)
	local dwSkillID = GetTabInfo(TALENT_TAB[dwForceID], nSeriesID, nRow, nColum)
	if not dwSkillID then
		return 0
	end	
	return dwSkillID
end

-- 根据技能ID得到位置
function GetPositionBySkillID(dwForceID, nSkillID)
	if not TALENT_TAB[dwForceID] then
		return 0, 0, 0
	end
	for nSeriesID = 1, #TALENT_TAB[dwForceID] do
		for nRow = 1, #TALENT_TAB[dwForceID][nSeriesID] do
			for nColum = 1, #TALENT_TAB[dwForceID][nSeriesID][nRow] do
				if TALENT_TAB[dwForceID][nSeriesID][nRow][nColum] == nSkillID then
					return nSeriesID, nRow, nColum
				end
			end
		end
	end
	
	return 0, 0, 0
end

-- 获得天赋条件
function GetTalentCondition(dwForceID, nSkillID)
	local tInfo = TALENT_CONDITION_TAB[dwForceID]
	if not tInfo then
		return nil
	end
	tInfo = TALENT_CONDITION_TAB[dwForceID][nSkillID]
	if not tInfo then
		return nil
	end
	return tInfo
end

-- 统计玩家天赋分段信息,既每系点数和前N-1层点数
function StatisticsTalentSubsectionInfo(TalentPointTab)
	if not TalentPointTab then
		return nil
	end
	
	local TalentSubsectionInfo = {}
	for nSeriesID = 1, #TalentPointTab do
		local nSeriesPoint = 0
		local nPreviousNRowPoint = 0
		TalentSubsectionInfo[nSeriesID] = {}
		for nRow = 1, #TalentPointTab[nSeriesID] do
			local nCurrentRowPoint = 0
			TalentSubsectionInfo[nSeriesID][nRow] = nPreviousNRowPoint -- N层时记录前N-1层的点数总和
			for nColum = 1, #TalentPointTab[nSeriesID][nRow] do			
				nSeriesPoint = nSeriesPoint + TalentPointTab[nSeriesID][nRow][nColum]
				nPreviousNRowPoint = nPreviousNRowPoint + TalentPointTab[nSeriesID][nRow][nColum]
			end
		end
		TalentSubsectionInfo[nSeriesID].nTotal = nSeriesPoint
	end
	return TalentSubsectionInfo
end

-- 根据已学技能统计玩家天赋信息,既总点数/用了几点/剩余几点/天赋点的全部情况/天赋点前N-1层以及每系情况
function StatisticsTalentInfo(player)
	if not player or not TALENT_TAB[player.dwForceID] or player.nLevel < TALENT_BEGIN_LEVEL then
		return 0, 0, 0, nil, nil
	end
	
	local TalentPointTab = {}
	local nMaxTalentPoint = GetMaxTalentPoint(player.nLevel)
	local nUsedTalentPoint = 0
	for nSeriesID = 1, #TALENT_TAB[player.dwForceID] do
		TalentPointTab[nSeriesID] = {}
		for nRow = 1, #TALENT_TAB[player.dwForceID][nSeriesID] do
			TalentPointTab[nSeriesID][nRow] = {}
			for nColum = 1, #TALENT_TAB[player.dwForceID][nSeriesID][nRow] do
				local nSkillID = TALENT_TAB[player.dwForceID][nSeriesID][nRow][nColum]
				if nSkillID >= 0 then
					local nLevel = player.GetSkillLevel(nSkillID)
					nUsedTalentPoint = nUsedTalentPoint + nLevel
					TalentPointTab[nSeriesID][nRow][nColum] = nLevel
				else
					TalentPointTab[nSeriesID][nRow][nColum] = 0
				end
			end
		end
	end
	
	local TalentSubsectionInfo = StatisticsTalentSubsectionInfo(TalentPointTab)
	
	return nMaxTalentPoint, nUsedTalentPoint, nMaxTalentPoint - nUsedTalentPoint, TalentPointTab, TalentSubsectionInfo
end

-- 解包函数
function GetTabInfo(tInfo, i, j, k)
	local TempInfo = nil	
	if not tInfo then
		return nil
	end	
	TempInfo = tInfo[i]
	if not TempInfo then
		return nil
	end	
	TempInfo = tInfo[i][j]
	if not TempInfo then
		return nil
	end	
	TempInfo = tInfo[i][j][k]
	if not TempInfo then
		return nil
	end		
	return TempInfo
end