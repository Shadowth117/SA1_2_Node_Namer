/*
	Sonic Adventure 1/2 Node Namer
*/
ClearListener()

rollout bonImport "SA1/SA2 Node Namer"
(
--------------------
-- User Interface --
--------------------
group "About"
(
	Label lab2 "By Shadowth117"
)
group "Import"
(
	button importButton "Import..."
)
group "Export"
(
	button exportButton "Export..."
)

fn SkelImport aqnFile =
(
	nodeNames = #()
	
	-- Read file
	f = openFile aqnFile mode:"rt" 
	while not eof f do
	(
		append nodeNames (readLine f)
	)
	close f

	i = 1
	--Adjust bones
	for o in objects do
	(
		if(o.parent != undefined or o.children.count > 0) then
		(
			o.name = nodeNames[i]
		)
		i += 1
	)
	
)

fn SkelExport bonFile =
(
	f = openFile bonFile mode:"wt"
	i = 1
	--Adjust bones
	for o in objects do
	(
		if(o.parent != undefined or o.children.count > 0) then
		(
			o.name = nodeNames[i]
		)
		i += 1
	)
	close f
)

on importButton pressed do
(
	local objFileName = undefined
	-- Open up a dialog box
	objFileName = getOpenFileName caption:"Export Adventure Node List .txt" \
				types:"Adventure Node List txt (*.txt)|*.txt|All Files (*.*)|*.*|"
	if (objFileName != undefined) then
	(
		ClearListener()
		print (filenameFromPath objFileName)
		SkelImport objFileName
	)
	
	-- Redraw max viewports
	max views redraw
)

on ExportButton pressed do
(
	-- Open up a dialog box
	local objFileName = getSaveFileName "Export Adventure Node List .txt" \
			types:"Adventure Node List txt (*.txt)|*.txt|All Files (*.*)|*.*|"

	--Export the Animation 
	if (objFileName != undefined) then
	(
		SkelExport objFileName
	)
)

)
createDialog bonImport 180 150