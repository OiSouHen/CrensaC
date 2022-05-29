-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local localPeds = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PEDLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local pedList = {
	{ -- PackSend
		distance = 25,
		coords = { 1175.0,2708.21,38.08,172.92 },
		model = "a_m_y_business_02",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- PackSend
		distance = 25,
		coords = { -2961.15,482.92,15.69,85.04 },
		model = "a_m_y_business_02",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- PackSend
		distance = 25,
		coords = { -1211.96,-331.97,37.78,22.68 },
		model = "a_m_y_business_02",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- PackSend
		distance = 25,
		coords = { -351.37,-51.25,49.03,340.16 },
		model = "a_m_y_business_02",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- PackSend
		distance = 25,
		coords = { 313.76,-280.45,54.16,340.16 },
		model = "a_m_y_business_02",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- PackSend
		distance = 25,
		coords = { 149.44,-1042.06,29.37,340.16 },
		model = "a_m_y_business_02",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Empacotador
		distance = 100,
		coords = { -610.87,-1089.48,25.86,269.3 },
		model = "ig_cletus",
		anim = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},
	{ -- Empacotador
		distance = 100,
		coords = { -1181.8,-888.09,19.97,121.89 },
		model = "ig_cletus",
		anim = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},
	{ -- Empacotador
		distance = 100,
		coords = { 825.87,-828.52,26.34,178.59 },
		model = "ig_cletus",
		anim = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},
	{ -- Caminhoneiro
		distance = 100,
		coords = { 1239.87,-3257.2,7.09,274.97 },
		model = "s_m_m_trucker_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ballas
		distance = 100,
		coords = { 95.58,-1985.56,20.44,317.49 },
		model = "ig_g",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Families
		distance = 100,
		coords = { -31.47,-1434.84,31.49,0.0 },
		model = "ig_g",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Vagos
		distance = 100,
		coords = { 347.45,-2069.06,20.89,320.32 },
		model = "ig_g",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Aztecas
		distance = 100,
		coords = { 512.29,-1803.52,28.51,246.62 },
		model = "ig_g",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Bloods
		distance = 100,
		coords = { 230.55,-1753.35,28.98,232.45 },
		model = "ig_g",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Roupa de Mergulho
		distance = 20,
		coords = { 1520.56,3780.08,34.46,274.97 },
		model = "a_f_y_beach_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Cassino
		distance = 25,
		coords = { 1112.05,228.11,-49.64,144.57 },
		model = "s_f_y_casino_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Concessionária
		distance = 100,
		coords = { 1224.78,2728.01,38.0,178.59 },
		model = "ig_ramp_hic",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- TowDriver
		distance = 30,
		coords = { -193.23,-1162.39,23.67,274.97 },
		model = "g_m_m_armboss_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Coveiro
		distance = 100,
		coords = { -1745.92,-204.83,57.39,320.32 },
		model = "g_m_m_armboss_01",
		anim = { "timetable@trevor@smoking_meth@base","base" }
	},
	{ -- Leiteiro
		distance = 100,
		coords = { 2440.58,4736.35,34.29,317.50 },
		model = "a_c_cow"
	},
	{ -- Leiteiro
		distance = 100,
		coords = { 2432.5,4744.58,34.31,317.50 },
		model = "a_c_cow"
	},
	{ -- Leiteiro
		distance = 100,
		coords = { 2424.47,4752.37,34.31,317.50 },
		model = "a_c_cow"
	},
	{ -- Leiteiro
		distance = 100,
		coords = { 2416.28,4760.8,34.31,317.50 },
		model = "a_c_cow"
	},
	{ -- Leiteiro
		distance = 100,
		coords = { 2408.6,4768.88,34.31,317.50 },
		model = "a_c_cow"
	},
	{ -- Leiteiro
		distance = 100,
		coords = { 2400.32,4777.48,34.53,317.50 },
		model = "a_c_cow"
	},
	{ -- Leiteiro
		distance = 100,
		coords = { 2432.46,4802.66,34.83,137.50 },
		model = "a_c_cow"
	},
	{ -- Leiteiro
		distance = 100,
		coords = { 2440.62,4794.22,34.66,137.50 },
		model = "a_c_cow"
	},
	{ -- Leiteiro
		distance = 100,
		coords = { 2448.65,4786.57,34.64,137.50 },
		model = "a_c_cow"
	},
	{ -- Leiteiro
		distance = 100,
		coords = { 2456.88,4778.08,34.49,137.50 },
		model = "a_c_cow"
	},
	{ -- Leiteiro
		distance = 100,
		coords = { 2464.53,4770.04,34.37,137.50 },
		model = "a_c_cow"
	},
	{ -- Leiteiro
		distance = 100,
		coords = { 2473.38,4760.98,34.31,137.50 },
		model = "a_c_cow"
	},
	{ -- Leiteiro
		distance = 100,
		coords = { 2495.03,4762.77,34.37,137.50 },
		model = "a_c_cow"
	},
	{ -- Leiteiro
		distance = 100,
		coords = { 2503.13,4754.08,34.31,137.50 },
		model = "a_c_cow"
	},
	{ -- Leiteiro
		distance = 100,
		coords = { 2511.34,4746.04,34.31,137.50 },
		model = "a_c_cow"
	},
	{ -- Leiteiro
		distance = 100,
		coords = { 2519.56,4737.35,34.29,137.50 },
		model = "a_c_cow"
	},
	{ -- Salary
		distance = 30,
		coords = { 257.39,228.04,106.27,158.75 },
		model = "s_f_y_airhostess_01"
	},
	{ -- Salary
		distance = 30,
		coords = { 259.59,227.25,106.27,158.75 },
		model = "s_f_y_airhostess_01"
	},
	{ -- Salary
		distance = 30,
		coords = { 262.09,226.33,106.27,155.91 },
		model = "s_f_y_airhostess_01"
	},
	{ -- Salary
		distance = 30,
		coords = { 264.31,225.55,106.27,155.91 },
		model = "s_f_y_airhostess_01"
	},
	{ -- Salary
		distance = 30,
		coords = { 266.77,224.64,106.27,155.91 },
		model = "s_f_y_airhostess_01"
	},
	{ -- Salary
		distance = 30,
		coords = { 268.99,223.82,106.27,153.08 },
		model = "s_f_y_airhostess_01"
	},
	{ -- Salary
		distance = 30,
		coords = { 264.86,212.19,106.27,343.0 },
		model = "s_f_y_airhostess_01"
	},
	{ -- Salary
		distance = 30,
		coords = { 262.63,213.02,106.27,337.33 },
		model = "s_f_y_airhostess_01"
	},
	{ -- Salary
		distance = 30,
		coords = { 260.14,213.92,106.27,340.16 },
		model = "s_f_y_airhostess_01"
	},
	{ -- Salary
		distance = 30,
		coords = { 257.94,214.7,106.27,340.16 },
		model = "s_f_y_airhostess_01"
	},
	{ -- Salary
		distance = 30,
		coords = { 255.45,215.62,106.27,343.0 },
		model = "s_f_y_airhostess_01"
	},
	{ -- Salary
		distance = 30,
		coords = { 253.23,216.44,106.27,337.33 },
		model = "s_f_y_airhostess_01"
	},
	{ -- Salary
		distance = 30,
		coords = { -110.72,6469.84,31.63,226.78 },
		model = "s_f_y_airhostess_01"
	},
	{ -- Salary
		distance = 30,
		coords = { -108.98,6471.57,31.63,223.94 },
		model = "s_f_y_airhostess_01"
	},
	{ -- Prefeitura
		distance = 30,
		coords = { -544.78,-185.86,52.2,300.48 },
		model = "ig_barry",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Prefeitura
		distance = 30,
		coords = { -551.1,-191.07,38.22,221.11 },
		model = "ig_barry",
		anim = { "anim@heists@prison_heistig1_p1_guard_checks_bus","loop" }
	},
	{ -- Prefeitura
		distance = 30,
		coords = { -553.3,-192.34,38.22,206.93 },
		model = "ig_barry",
		anim = { "anim@heists@prison_heistig1_p1_guard_checks_bus","loop" }
	},
	{ -- Black Market
		distance = 20,
		coords = { 2431.86,4967.66,42.34,133.23 },
		model = "g_m_y_ballaeast_01",
		anim = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},
	{ -- Black Market
		distance = 20,
		coords = { 2431.09,4970.72,42.34,42.52 },
		model = "g_f_y_ballas_01",
		anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }
	},
	{ -- Black Market
		distance = 20,
		coords = { 2436.08,4965.39,42.34,226.78 },
		model = "g_f_y_ballas_01",
		anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }
	},
	{ -- Black Market
		distance = 20,
		coords = { 2434.4,4963.8,42.34,229.61 },
		model = "g_f_y_ballas_01",
		anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }
	},
	{ -- Black Market
		distance = 20,
		coords = { 2432.44,4964.06,42.34,178.59 },
		model = "g_f_y_ballas_01",
		anim = { "amb@world_human_bum_wash@male@high@base","base" }
	},
	{ -- Black Market
		distance = 20,
		coords = { 2431.57,4965.22,42.34,124.73 },
		model = "g_f_y_ballas_01",
		anim = { "amb@world_human_bum_wash@male@high@base","base" }
	},
	{ -- Black Market
		distance = 20,
		coords = { 2428.67,4969.51,42.34,133.23 },
		model = "g_f_y_ballas_01",
		anim = { "anim@amb@business@coc@coc_packing_hi@","full_cycle_v1_pressoperator" }
	},
	{ -- Black Market
		distance = 20,
		coords = { 2437.05,4967.61,42.34,317.49 },
		model = "g_f_y_ballas_01",
		anim = { "anim@amb@business@coc@coc_packing_hi@","full_cycle_v1_pressoperator" }
	},
	{ -- Black Market
		distance = 20,
		coords = { 2433.09,4971.51,42.34,320.32 },
		model = "g_f_y_ballas_01",
		anim = { "anim@amb@business@coc@coc_packing_hi@","full_cycle_v1_pressoperator" }
	},
	{ -- Black Market
		distance = 20,
		coords = { 2432.67,4970.29,42.34,226.78 },
		model = "g_f_y_ballas_01",
		anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }
	},
	{ -- Black Market
		distance = 20,
		coords = { 2435.28,4969.27,42.34,317.49 },
		model = "g_f_y_ballas_01",
		anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }
	},
	{ -- Taxi
		distance = 50,
		coords = { -1039.34,-2730.8,20.2,235.28 },
		model = "a_m_y_stlat_01",
		anim = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},
	{ -- Weeds
		distance = 100,
		coords = { -1174.54,-1571.4,4.35,124.73 },
		model = "g_f_y_ballas_01",
		anim = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},
	{ -- Ilegal
		distance = 100,
		coords = { 301.4,-195.29,61.57,158.75 },
		model = "g_f_y_ballas_01",
		anim = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},
	{ -- Ilegal
		distance = 100,
		coords = { 169.28,-1536.23,29.25,311.82 },
		model = "g_f_y_ballas_01",
		anim = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},
	{ -- Ilegal
		distance = 100,
		coords = { 487.56,-1456.11,29.28,272.13 },
		model = "g_f_y_ballas_01",
		anim = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},
	{ -- Ilegal
		distance = 100,
		coords = { 154.66,-1472.9,29.35,325.99 },
		model = "g_f_y_ballas_01",
		anim = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},
	{ -- Ilegal
		distance = 100,
		coords = { 389.69,-942.1,29.42,175.75 },
		model = "g_f_y_ballas_01",
		anim = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},
	{ -- Ilegal
		distance = 100,
		coords = { 475.1,3555.28,33.23,263.63 },
		model = "g_f_y_ballas_01",
		anim = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},
	{ -- Ilegal
		distance = 100,
		coords = { 112.41,3373.68,35.25,59.53 },
		model = "g_m_y_ballaeast_01",
		anim = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},
	{ -- Ilegal
		distance = 100,
		coords = { 2013.95,4990.88,41.21,133.23 },
		model = "g_m_y_ballasout_01",
		anim = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},
	{ -- Ilegal
		distance = 100,
		coords = { 186.9,6374.75,32.33,206.93 },
		model = "g_m_y_famca_01",
		anim = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},
	{ -- Ilegal
		distance = 100,
		coords = { -653.2,-1502.18,5.24,201.26 },
		model = "g_m_y_famdnf_01",
		anim = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},
	{ -- Police
		distance = 100,
		coords = { 392.56,-1632.1,29.28,28.35 },
		model = "s_f_y_cop_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Police
		distance = 100,
		coords = { 381.17,-1634.05,29.28,343.0 },
		model = "s_f_y_cop_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Police
		distance = 100,
		coords = { 382.12,-1617.63,29.28,232.45 },
		model = "s_f_y_cop_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Police
		distance = 100,
		coords = { 377.58,791.66,187.64,130.4 },
		model = "s_f_y_cop_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Police
		distance = 100,
		coords = { -479.48,6011.12,31.29,175.75 },
		model = "s_f_y_cop_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Police
		distance = 100,
		coords = { -459.37,6016.01,31.49,42.52 },
		model = "s_f_y_cop_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Police
		distance = 100,
		coords = { 463.15,-982.33,43.69,87.88 },
		model = "s_f_y_cop_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Police
		distance = 100,
		coords = { 443.49,-974.47,25.7,181.42 },
		model = "s_f_y_cop_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Police
		distance = 100,
		coords = { 1844.42,3707.33,33.97,255.12 },
		model = "s_f_y_cop_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Police
		distance = 100,
		coords = { 1839.35,3691.23,33.97,269.3 },
		model = "s_f_y_cop_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Paramedic
		distance = 100,
		coords = { -271.7,6321.75,32.42,0.0 },
		model = "s_m_m_paramedic_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Paramedic
		distance = 100,
		coords = { -253.92,6339.42,32.42,5.67 },
		model = "s_m_m_paramedic_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Paramedic
		distance = 100,
		coords = { 338.19,-586.91,74.16,252.29 },
		model = "s_m_m_paramedic_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Paramedic
		distance = 100,
		coords = { 340.08,-576.19,28.8,73.71 },
		model = "s_m_m_paramedic_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 15,
		coords = { 24.9,-1346.8,29.49,269.3 },
		model = "mp_m_shopkeep_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 15,
		coords = { 2556.74,381.24,108.61,357.17 },
		model = "mp_m_shopkeep_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 15,
		coords = { 1164.82,-323.65,69.2,96.38 },
		model = "mp_m_shopkeep_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 15,
		coords = { -706.15,-914.53,19.21,85.04 },
		model = "mp_m_shopkeep_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 15,
		coords = { -47.38,-1758.68,29.42,42.52 },
		model = "mp_m_shopkeep_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 15,
		coords = { 373.1,326.81,103.56,257.96 },
		model = "mp_m_shopkeep_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 15,
		coords = { -3242.75,1000.46,12.82,354.34 },
		model = "mp_m_shopkeep_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 15,
		coords = { 1728.47,6415.46,35.03,240.95 },
		model = "mp_m_shopkeep_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 15,
		coords = { 1960.2,3740.68,32.33,297.64 },
		model = "mp_m_shopkeep_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 15,
		coords = { 2677.8,3280.04,55.23,331.66 },
		model = "mp_m_shopkeep_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 15,
		coords = { 1697.31,4923.49,42.06,325.99 },
		model = "mp_m_shopkeep_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 15,
		coords = { -1819.52,793.48,138.08,127.56 },
		model = "mp_m_shopkeep_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 15,
		coords = { 1391.69,3605.97,34.98,198.43 },
		model = "mp_m_shopkeep_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 15,
		coords = { -2966.41,391.55,15.05,85.04 },
		model = "mp_m_shopkeep_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 15,
		coords = { -3039.54,584.79,7.9,14.18 },
		model = "mp_m_shopkeep_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 15,
		coords = { 1134.33,-983.11,46.4,274.97 },
		model = "mp_m_shopkeep_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 15,
		coords = { 1165.28,2710.77,38.15,175.75 },
		model = "mp_m_shopkeep_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 15,
		coords = { -1486.72,-377.55,40.15,130.4 },
		model = "mp_m_shopkeep_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 15,
		coords = { -1221.45,-907.92,12.32,31.19 },
		model = "mp_m_shopkeep_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 15,
		coords = { 161.2,6641.66,31.69,223.94 },
		model = "mp_m_shopkeep_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 15,
		coords = { -160.62,6320.93,31.58,311.82 },
		model = "mp_m_shopkeep_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 15,
		coords = { 548.7,2670.73,42.16,96.38 },
		model = "mp_m_shopkeep_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		distance = 15,
		coords = { 1696.88,3758.39,34.69,133.23 },
		model = "ig_dale",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		distance = 15,
		coords = { 248.17,-51.78,69.94,340.16 },
		model = "ig_dale",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		distance = 15,
		coords = { 841.18,-1030.12,28.19,266.46 },
		model = "ig_dale",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		distance = 15,
		coords = { -327.07,6082.22,31.46,130.4 },
		model = "ig_dale",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		distance = 15,
		coords = { -659.18,-938.47,21.82,85.04 },
		model = "ig_dale",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		distance = 15,
		coords = { -1309.43,-394.56,36.7,343.0 },
		model = "ig_dale",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		distance = 15,
		coords = { -1113.41,2698.19,18.55,127.56 },
		model = "ig_dale",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		distance = 15,
		coords = { 2564.83,297.46,108.73,269.3 },
		model = "ig_dale",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		distance = 15,
		coords = { -3168.32,1087.46,20.84,150.24 },
		model = "ig_dale",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		distance = 15,
		coords = { 16.91,-1107.56,29.79,158.75 },
		model = "ig_dale",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		distance = 15,
		coords = { 814.84,-2155.14,29.62,357.17 },
		model = "ig_dale",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Life Invader
		distance = 20,
		coords = { -1083.15,-245.88,37.76,209.77 },
		model = "ig_barry",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Pharmacy Store
		distance = 30,
		coords = { -172.89,6381.32,31.48,223.94 },
		model = "u_m_y_baygor",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Pharmacy Store
		distance = 30,
		coords = { 1690.07,3581.68,35.62,212.6 },
		model = "u_m_y_baygor",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Pharmacy Store
		distance = 15,
		coords = { 326.5,-1074.43,29.47,0.0 },
		model = "u_m_y_baygor",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Pharmacy Store
		distance = 15,
		coords = { 114.39,-4.85,67.82,204.1 },
		model = "u_m_y_baygor",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Mercado Central
		distance = 50,
		coords = { 46.65,-1749.7,29.62,51.03 },
		model = "ig_cletus",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Mercado Central
		distance = 50,
		coords = { 2747.31,3473.07,55.67,249.45 },
		model = "ig_cletus",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Recycling Sell
		distance = 50,
		coords = { -428.54,-1728.29,19.78,70.87 },
		model = "s_m_y_garbage",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Recycling Sell
		distance = 50,
		coords = { 180.07,2793.29,45.65,283.47 },
		model = "s_m_y_garbage",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Recycling Sell
		distance = 50,
		coords = { -195.42,6264.62,31.49,42.52 },
		model = "s_m_y_garbage",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Jewelry
		distance = 15,
		coords = { -628.79,-238.7,38.05,311.82 },
		model = "cs_gurk",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Oxy Store
		distance = 30,
		coords = { -1636.74,-1092.17,13.08,320.32 },
		model = "a_f_y_epsilon_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Transporter
		distance = 20,
		coords = { 264.74,219.99,101.67,343.0 },
		model = "ig_casey",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Lenhador
		distance = 50,
		coords = { 2433.45,5013.46,46.99,314.65 },
		model = "a_m_o_ktown_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Garagem The Boat House
		distance = 50,
		coords = { 1509.64,3788.7,33.51,266.46 },
		model = "a_f_y_beach_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Motorista
		distance = 30,
		coords = { 452.97,-607.75,28.59,266.46 },
		model = "u_m_m_edtoh",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Lixeiro
		distance = 50,
		coords = { 82.98,-1553.55,29.59,51.03 },
		model = "s_m_y_garbage",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Lixeiro
		distance = 50,
		coords = { 287.77,2843.9,44.7,121.89 },
		model = "s_m_y_garbage",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Lixeiro
		distance = 50,
		coords = { -413.97,6171.58,31.48,320.32 },
		model = "s_m_y_garbage",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 20,
		coords = { -1127.26,-1439.35,5.22,303.31 },
		model = "a_f_y_epsilon_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 20,
		coords = { 78.26,-1388.91,29.37,178.59 },
		model = "a_f_y_epsilon_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 20,
		coords = { -706.73,-151.38,37.41,116.23 },
		model = "a_f_y_epsilon_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 20,
		coords = { -166.69,-301.55,39.73,249.45 },
		model = "a_f_y_epsilon_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 20,
		coords = { -817.5,-1074.03,11.32,119.06 },
		model = "a_f_y_epsilon_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 20,
		coords = { -1197.33,-778.98,17.32,31.19 },
		model = "a_f_y_epsilon_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 20,
		coords = { -1447.84,-240.03,49.81,45.36 },
		model = "a_f_y_epsilon_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 20,
		coords = { -0.07,6511.8,31.88,311.82 },
		model = "a_f_y_epsilon_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 20,
		coords = { 1691.6,4818.47,42.06,2.84 },
		model = "a_f_y_epsilon_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 20,
		coords = { 123.21,-212.34,54.56,255.12 },
		model = "a_f_y_epsilon_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 20,
		coords = { 621.24,2753.37,42.09,90.71 },
		model = "a_f_y_epsilon_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 20,
		coords = { 1200.68,2707.35,38.22,85.04 },
		model = "a_f_y_epsilon_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 20,
		coords = { -3172.39,1055.31,20.86,246.62 },
		model = "a_f_y_epsilon_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 20,
		coords = { -1096.53,2711.1,19.11,127.56 },
		model = "a_f_y_epsilon_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 20,
		coords = { 422.7,-810.25,29.49,357.17 },
		model = "a_f_y_epsilon_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Tatuagem
		distance = 10,
		coords = { 1324.38,-1650.09,52.27,127.56 },
		model = "a_f_y_hippie_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Tatuagem
		distance = 10,
		coords = { -1152.27,-1423.81,4.95,124.73 },
		model = "a_f_y_hippie_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Tatuagem
		distance = 10,
		coords = { 319.84,180.89,103.58,246.62 },
		model = "a_f_y_hippie_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Tatuagem
		distance = 10,
		coords = { -3170.41,1073.06,20.83,334.49 },
		model = "a_f_y_hippie_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Tatuagem
		distance = 10,
		coords = { 1862.58,3748.52,33.03,28.35 },
		model = "a_f_y_hippie_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Tatuagem
		distance = 10,
		coords = { -292.02,6199.72,31.49,223.94 },
		model = "a_f_y_hippie_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Taxista
		distance = 30,
		coords = { 894.9,-179.15,74.7,240.95 },
		model = "a_m_y_stlat_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Taxista
		distance = 30,
		coords = { 1696.19,4785.25,42.02,93.55 },
		model = "a_m_y_stlat_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Caçador
		distance = 10,
		coords = { -679.13,5839.52,17.32,226.78 },
		model = "ig_hunter",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Caçador
		distance = 30,
		coords = { -695.56,5802.12,17.32,65.2 },
		model = "a_m_o_ktown_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Pescador
		distance = 30,
		coords = { -1816.64,-1193.73,14.31,334.49 },
		model = "a_f_y_eastsa_03",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADPEDLIST
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)

		for k,v in pairs(pedList) do
			local distance = #(coords - vec3(v["coords"][1],v["coords"][2],v["coords"][3]))
			if distance <= v["distance"] then
				if localPeds[k] == nil and LocalPlayer["state"]["Route"] < 900000 then
					local mHash = GetHashKey(v["model"])

					RequestModel(mHash)
					while not HasModelLoaded(mHash) do
						Wait(1)
					end

					if HasModelLoaded(mHash) then
						localPeds[k] = CreatePed(4,v["model"],v["coords"][1],v["coords"][2],v["coords"][3] - 1,v["coords"][4],false,false)
						SetPedArmour(localPeds[k],100)
						SetEntityInvincible(localPeds[k],true)
						FreezeEntityPosition(localPeds[k],true)
						SetBlockingOfNonTemporaryEvents(localPeds[k],true)

						if v["model"] == "s_f_y_casino_01" then
							SetPedDefaultComponentVariation(localPeds[k])
							SetPedComponentVariation(localPeds[k],0,3,0,0)
							SetPedComponentVariation(localPeds[k],1,0,0,0)
							SetPedComponentVariation(localPeds[k],2,3,0,0)
							SetPedComponentVariation(localPeds[k],3,0,1,0)
							SetPedComponentVariation(localPeds[k],4,1,0,0)
							SetPedComponentVariation(localPeds[k],6,1,0,0)
							SetPedComponentVariation(localPeds[k],7,1,0,0)
							SetPedComponentVariation(localPeds[k],8,0,0,0)
							SetPedComponentVariation(localPeds[k],10,0,0,0)
							SetPedComponentVariation(localPeds[k],11,0,0,0)
							SetPedPropIndex(localPeds[k],1,0,0,false)
						end

						SetModelAsNoLongerNeeded(mHash)

						if v["anim"] ~= nil then
							RequestAnimDict(v["anim"][1])
							while not HasAnimDictLoaded(v["anim"][1]) do
								Wait(1)
							end

							TaskPlayAnim(localPeds[k],v["anim"][1],v["anim"][2],8.0,8.0,-1,1,0,0,0,0)
						end
					end
				end
			else
				if localPeds[k] then
					DeleteEntity(localPeds[k])
					localPeds[k] = nil
				end
			end
		end

		Wait(1000)
	end
end)