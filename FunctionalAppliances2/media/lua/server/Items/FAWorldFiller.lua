local overlayMap = {}
overlayMap.VERSION = 1
-- Small Cork Boards
overlayMap["location_business_office_generic_01_7"] = {{ name = "other", tiles = {"papernotices_01_9"} }}
overlayMap["location_business_office_generic_01_15"] = {{ name = "other", tiles = {"papernotices_01_8"} }}

-- large Cork Boards
overlayMap["location_business_office_generic_01_36"] = {{ name = "other", tiles = {"papernotices_01_4"} }}
overlayMap["location_business_office_generic_01_37"] = {{ name = "other", tiles = {"papernotices_01_5"} }}
overlayMap["location_business_office_generic_01_38"] = {{ name = "other", tiles = {"papernotices_01_6"} }}
overlayMap["location_business_office_generic_01_39"] = {{ name = "other", tiles = {"papernotices_01_7"} }}

-- peg Boards
overlayMap["location_business_machinery_01_24"] = {{ name = "other", tiles = {"overlay_peg_board_01_4", "overlay_peg_board_01_0"} }}
overlayMap["location_business_machinery_01_25"] = {{ name = "other", tiles = {"overlay_peg_board_01_5", "overlay_peg_board_01_1"} }}
overlayMap["location_business_machinery_01_26"] = {{ name = "other", tiles = {"overlay_peg_board_01_6", "overlay_peg_board_01_2"} }}
overlayMap["location_business_machinery_01_27"] = {{ name = "other", tiles = {"overlay_peg_board_01_7", "overlay_peg_board_01_3"} }}

if not TILEZED then
	getContainerOverlays():addOverlays(overlayMap)
end

return overlayMap