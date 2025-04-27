# Export sweep of gap size
import ScriptEnv
ScriptEnv.Initialize("Ansoft.ElectronicsDesktop")
oDesktop.RestoreWindow()
oProject = oDesktop.SetActiveProject("surface_imp")
oDesign = oProject.SetActiveDesign("HFSSDesign1")
oModule = oDesign.GetModule("Solutions")
for gap_size in range(50, 2540, 50):
	oModule.ExportNetworkData("a=\'28.25mm\' copp_t=\'17.5um\' deembed=\'20mm\' depth=\'2.54mm\' gap=\'" + str(gap_size) + "um\' length=\'10mm\' rad_bound=\'22.557500000000001mm\'", ["Setup1:LastAdaptive"], 3, "C:/Users/Edward/ecen5164-leaky-wave-antenna/sim_data/gap_sweep/surface_imp_gap_" + str(gap_size) + "um.s1p", 
		["All"], False, 50, "S", -1, 0, 15, True, True, False)