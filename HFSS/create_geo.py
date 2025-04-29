# ----------------------------------------------
# Script Recorded by Ansys Electronics Desktop Version 2021.2.0
# 16:39:34  Apr 29, 2025
# ----------------------------------------------
import ScriptEnv
ScriptEnv.Initialize("Ansoft.ElectronicsDesktop")
oDesktop.RestoreWindow()
oProject = oDesktop.SetActiveProject("surface_imp")
oDesign = oProject.SetActiveDesign("HFSSDesign2")
oEditor = oDesign.SetActiveEditor("3D Modeler")

for n in range(5, 11):
	oEditor.Copy(
		[
			"NAME:Selections",
			"Selections:="		, "Unit1"
		])
	oEditor.Paste()
	oDesign.ChangeProperty(
		[
			"NAME:AllTabs",
			[
				"NAME:LocalVariableTab",
				[
					"NAME:PropServers", 
					"LocalVariables"
				],
				[
					"NAME:NewProps",
					[
						"NAME:finger_depth" + str(n),
						"PropType:="		, "VariableProp",
						"UserDef:="		, True,
						"Value:="		, "1mm"
					]
				]
			]
		])
	oEditor.ChangeProperty(
		[
			"NAME:AllTabs",
			[
				"NAME:Geometry3DCmdTab",
				[
					"NAME:PropServers", 
					"Unit" + str(n) + ":CreateBox:1"
				],
				[
					"NAME:ChangedProps",
					[
						"NAME:Position",
						"X:="			, "0mm",
						"Y:="			, "a/20-(mt+finger_depth" + str(n) + ")/2",
						"Z:="			, "depth+copp_t"
					],
					[
						"NAME:YSize",
						"Value:="		, "finger_depth" + str(n) + ""
					]
				]
			]
		])
	oEditor.ChangeProperty(
		[
			"NAME:AllTabs",
			[
				"NAME:Geometry3DCmdTab",
				[
					"NAME:PropServers", 
					"Box" + str(3*n + 3) + ":CreateBox:1"
				],
				[
					"NAME:ChangedProps",
					[
						"NAME:YSize",
						"Value:="		, "finger_depth" + str(n) + ""
					],
					[
						"NAME:Position",
						"X:="			, "finger_width+mt",
						"Y:="			, "a/20-(-mt+finger_depth" + str(n) + ")/2",
						"Z:="			, "copp_t+depth"
					]
				]
			]
		])
	oEditor.ChangeProperty(
		[
			"NAME:AllTabs",
			[
				"NAME:Geometry3DCmdTab",
				[
					"NAME:PropServers", 
					"Box" + str(3*n + 2) + ":CreateBox:1"
				],
				[
					"NAME:ChangedProps",
					[
						"NAME:YSize",
						"Value:="		, "-(a/20-(mt+finger_depth" + str(n) + ")/2)"
					]
				]
			]
		])
	oEditor.ChangeProperty(
		[
			"NAME:AllTabs",
			[
				"NAME:Geometry3DCmdTab",
				[
					"NAME:PropServers", 
					"Box" + str(3*n + 1) + ":CreateBox:1"
				],
				[
					"NAME:ChangedProps",
					[
						"NAME:YSize",
						"Value:="		, "a/20-(mt+finger_depth" + str(n) + ")/2"
					]
				]
			]
		])
	oEditor.Move(
		[
			"NAME:Selections",
			"Selections:="		, "Unit" + str(n) + "",
			"NewPartsModelFlag:="	, "Model"
		], 
		[
			"NAME:TranslateParameters",
			"TranslateVectorX:="	, "0mm",
			"TranslateVectorY:="	, "2.5395mm",
			"TranslateVectorZ:="	, "0mm"
		])
	oEditor.ChangeProperty(
		[
			"NAME:AllTabs",
			[
				"NAME:Geometry3DCmdTab",
				[
					"NAME:PropServers", 
					"Unit" + str(n) + ":Move:1"
				],
				[
					"NAME:ChangedProps",
					[
						"NAME:Move Vector",
						"X:="			, "0mm",
						"Y:="			,  str(n-1) + "*a/10",
						"Z:="			, "0mm"
					]
				]
			]
		])
