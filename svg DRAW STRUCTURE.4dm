//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Method : svg DRAW STRUCTURE
  // Created 20/04/09 by Vincent de Lachaux
  // ----------------------------------------------------
  // Modified by Vincent de Lachaux (21/04/09)
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)
C_TEXT:C284($2)

C_BOOLEAN:C305($Boo_regular;$Boo_trashed)
C_LONGINT:C283($Lon_i;$Lon_j;$Lon_maxHeight;$Lon_maxWidth;$Lon_parameters;$Lon_type)
C_LONGINT:C283($Lon_x)
C_PICTURE:C286($Pic_buffer)
C_REAL:C285($Num_destinationHeight;$Num_destinationMiddle;$Num_destinationWidth;$Num_destinationX;$Num_destinationY;$Num_height)
C_REAL:C285($Num_left;$Num_middle;$Num_middleOffset;$Num_offsetX;$Num_sourceHeight;$Num_sourceMiddle)
C_REAL:C285($Num_sourceWidth;$Num_sourceX;$Num_sourceY;$Num_top;$Num_viaPointX;$Num_width)
C_REAL:C285($Num_X1;$Num_X2;$Num_y1;$Num_y2)
C_TEXT:C284($Dom_arrow;$Dom_buffer;$Dom_circle;$Dom_color;$Dom_coordinates;$Dom_defs)
C_TEXT:C284($Dom_destination;$Dom_field_extra;$Dom_fieldName;$Dom_fieldRect;$Dom_fieldType;$Dom_marker)
C_TEXT:C284($Dom_relation;$Dom_root;$Dom_shadow;$Dom_source;$Dom_svg;$Dom_table_extra)
C_TEXT:C284($Dom_table_ref;$Dom_tableGroup;$Dom_tableName;$Dom_tableRect;$Dom_x;$Txt_attributeName)
C_TEXT:C284($Txt_attributeValue;$Txt_blue;$Txt_color;$Txt_data;$Txt_destinationUUID;$Txt_fieldColor)
C_TEXT:C284($Txt_fieldName;$Txt_fieldUID;$Txt_fontStyle;$Txt_fontWeight;$Txt_green;$Txt_kind)
C_TEXT:C284($Txt_path;$Txt_pictureFormat;$Txt_red;$Txt_sourceUUID;$Txt_tableColor;$Txt_tableName)
C_TEXT:C284($Txt_tableUID;$Txt_tableUUID)

ARRAY TEXT:C222($tDom_fields;0)
ARRAY TEXT:C222($tDom_relatedFields;0)
ARRAY TEXT:C222($tDom_relations;0)
ARRAY TEXT:C222($tDom_tables;0)

If (False:C215)
	C_TEXT:C284(svg DRAW STRUCTURE ;$1)
	C_TEXT:C284(svg DRAW STRUCTURE ;$2)
End if 

If (False:C215)
	C_TEXT:C284(svg_drawStructure)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If ($Lon_parameters>=2)
	
	$Txt_pictureFormat:=$2
	
Else 
	
	$Txt_pictureFormat:=".svg"
	
End if 

ARRAY TEXT:C222($tTxt_types;18)
$tTxt_types{1}:="B"
$tTxt_types{3}:="16"
$tTxt_types{4}:="32"
$tTxt_types{5}:="64"
$tTxt_types{6}:="0.5"
$tTxt_types{7}:="F"
$tTxt_types{8}:="D"
$tTxt_types{9}:="H"
$tTxt_types{10}:="T"
$tTxt_types{12}:="I"
$tTxt_types{14}:=".T"
$tTxt_types{18}:="X"

  // ----------------------------------------------------

$Lon_maxWidth:=0
$Lon_maxHeight:=0

If ($Lon_parameters>=1)
	
	$Txt_path:=$1
	
	If (Test path name:C476($Txt_path)=Is a document:K24:1)
		
		$Dom_root:=DOM Parse XML source:C719($Txt_path)
		
		If (OK=1)
			
			$Dom_svg:=DOM Create XML Ref:C861("svg";"http://www.w3.org/2000/svg")
			
			If (OK=1)
				
				DOM SET XML ATTRIBUTE:C866($Dom_svg;"font-family";"Lucida grande,segoie,sans")
				DOM SET XML ATTRIBUTE:C866($Dom_svg;"font-size";"12")
				DOM SET XML ATTRIBUTE:C866($Dom_svg;"font-weight";"bold")
				DOM SET XML ATTRIBUTE:C866($Dom_svg;"xmlns:xlink";"http://www.w3.org/1999/xlink")
				
				$Dom_defs:=DOM Create XML element:C865($Dom_svg;"defs")
				
				$Dom_marker:=DOM Create XML element:C865($Dom_defs;"marker";"id";"relation_N";"refX";3;"refY";3;"markerWidth";6;"markerHeight";6)
				$Dom_circle:=DOM Create XML element:C865($Dom_marker;"circle";"cx";3;"cy";3;"r";1.8;"stroke";"black";"fill";"white";"stroke-width";0.5)
				
				$Dom_marker:=DOM Create XML element:C865($Dom_defs;"marker";"id";"relation_1";"refX";4;"refY";3;"markerWidth";6;"markerHeight";6;"orient";"auto")
				$Dom_arrow:=DOM Create XML element:C865($Dom_marker;"polygon";"fill";"white";"stroke";"black";"stroke-width";0.5;"points";"1,1 1,5 5,3")
				
				$Dom_shadow:=DOM Create XML element:C865($Dom_marker;"filter";"id";"Shadow")
				$Dom_buffer:=DOM Create XML element:C865($Dom_shadow;"feGaussianBlur";"stdDeviation";4;"in";"SourceAlpha";"result";"_Blur")
				$Dom_buffer:=DOM Create XML element:C865($Dom_shadow;"feOffset";"dx";4;"dy";4;"in";"_Blur";"result";"_Offset")
				$Dom_buffer:=DOM Create XML element:C865($Dom_shadow;"feBlend";"in";"SourceGraphic";"in2";"_Offset";"mode";"normal")
				
				$tDom_tables{0}:=DOM Find XML element:C864($Dom_root;"/base/table";$tDom_tables)
				
				If (OK=1)
					
					For ($Lon_i;1;Size of array:C274($tDom_tables);1)
						
						$Boo_trashed:=False:C215
						
						$Dom_table_extra:=DOM Find XML element:C864($tDom_tables{$Lon_i};"/table/table_extra")
						
						If (OK=1)
							
							For ($Lon_x;1;DOM Count XML attributes:C727($Dom_table_extra);1)
								
								DOM GET XML ATTRIBUTE BY INDEX:C729($Dom_table_extra;$Lon_x;$Txt_attributeName;$Txt_attributeValue)
								
								If ($Txt_attributeName="trashed")
									
									$Boo_trashed:=($Txt_attributeValue="true")
									
									$Lon_x:=MAXLONG:K35:2-1
									
								End if 
								
							End for 
							
						End if 
						
						If (Not:C34($Boo_trashed))
							
							DOM GET XML ATTRIBUTE BY NAME:C728($tDom_tables{$Lon_i};"uuid";$Txt_tableUID)
							
							$Dom_tableGroup:=DOM Create XML element:C865($Dom_svg;"g";"id";$Txt_tableUID;"filter";"url(#Shadow)")
							
							DOM GET XML ATTRIBUTE BY NAME:C728($tDom_tables{$Lon_i};"name";$Txt_tableName)
							
							$Dom_color:=DOM Find XML element:C864($tDom_tables{$Lon_i};"/table/table_extra/editor_table_info/color")
							
							DOM GET XML ATTRIBUTE BY NAME:C728($Dom_color;"red";$Txt_red)
							DOM GET XML ATTRIBUTE BY NAME:C728($Dom_color;"green";$Txt_green)
							DOM GET XML ATTRIBUTE BY NAME:C728($Dom_color;"blue";$Txt_blue)
							
							Case of 
								: ($Txt_red="0") & ($Txt_green="0") & ($Txt_blue="0")
									$Txt_tableColor:="dimgray"
								: ($Txt_red="255") & ($Txt_green="255") & ($Txt_blue="255")
									$Txt_tableColor:="gainsboro"
								Else 
									$Txt_tableColor:="rgb("+$Txt_red+","+$Txt_green+","+$Txt_blue+")"
							End case 
							
							$Dom_coordinates:=DOM Find XML element:C864($tDom_tables{$Lon_i};"/table/table_extra/editor_table_info/coordinates")
							
							DOM GET XML ATTRIBUTE BY NAME:C728($Dom_coordinates;"left";$Num_left)
							DOM GET XML ATTRIBUTE BY NAME:C728($Dom_coordinates;"top";$Num_top)
							DOM GET XML ATTRIBUTE BY NAME:C728($Dom_coordinates;"width";$Num_width)
							DOM GET XML ATTRIBUTE BY NAME:C728($Dom_coordinates;"height";$Num_height)
							
							If (($Num_left+$Num_width)>$Lon_maxWidth)
								$Lon_maxWidth:=$Num_left+$Num_width
							End if 
							
							If (($Num_top+$Num_height)>$Lon_maxHeight)
								$Lon_maxHeight:=$Num_top+$Num_height
							End if 
							
							$Dom_tableRect:=DOM Create XML element:C865($Dom_tableGroup;"rect";"x";$Num_left;"y";$Num_top;"width";$Num_width;"height";25;"rx";5;"ry";5;"stroke";"black";"fill";$Txt_tableColor)
							
							$Dom_tableName:=DOM Create XML element:C865($Dom_tableGroup;"text";"x";$Num_left+($Num_width/2);"y";$Num_top+15;"text-anchor";"middle")
							DOM SET XML ELEMENT VALUE:C868($Dom_tableName;$Txt_tableName)
							
							$Num_top:=$Num_top+20
							
							$tDom_fields{0}:=DOM Find XML element:C864($tDom_tables{$Lon_i};"/table/field";$tDom_fields)
							
							For ($Lon_j;1;Size of array:C274($tDom_fields);1)
								
								DOM GET XML ATTRIBUTE BY NAME:C728($tDom_fields{$Lon_j};"uuid";$Txt_fieldUID)
								
								$Txt_fontStyle:="normal"
								$Dom_field_extra:=DOM Find XML element:C864($tDom_fields{$Lon_j};"/field/field_extra")
								If (OK=1)
									
									For ($Lon_x;1;DOM Count XML attributes:C727($Dom_field_extra);1)
										
										DOM GET XML ATTRIBUTE BY INDEX:C729($Dom_field_extra;$Lon_x;$Txt_attributeName;$Txt_attributeValue)
										
										If ($Txt_attributeName="visible")
											
											If ($Txt_attributeValue="false")
												
												$Txt_fontStyle:="italic"
												
											End if 
											
											$Lon_x:=MAXLONG:K35:2-1
											
										End if 
										
									End for 
									
								End if 
								
								$Dom_field_extra:=DOM Find XML element:C864($tDom_fields{$Lon_j};"/field/index_ref")
								
								If (OK=1)
									
									$Txt_fontWeight:="bold"
									
								Else 
									
									$Txt_fontWeight:="normal"
									
								End if 
								
								$Dom_color:=DOM Find XML element:C864($tDom_fields{$Lon_j};"/field/field_extra/editor_field_info/color")
								
								If (OK=1)
									
									DOM GET XML ATTRIBUTE BY NAME:C728($Dom_color;"red";$Txt_red)
									DOM GET XML ATTRIBUTE BY NAME:C728($Dom_color;"green";$Txt_green)
									DOM GET XML ATTRIBUTE BY NAME:C728($Dom_color;"blue";$Txt_blue)
									
									If ($Txt_red="255") & ($Txt_green="255") & ($Txt_blue="255")
										
										$Txt_fieldColor:="black"
										
									Else 
										
										$Txt_fieldColor:="rgb("+$Txt_red+","+$Txt_green+","+$Txt_blue+")"
										
									End if 
									
								Else 
									
									$Txt_fieldColor:="black"
									
								End if 
								
								$Dom_fieldRect:=DOM Create XML element:C865($Dom_tableGroup;"rect";"x";$Num_left;"y";$Num_top;"width";$Num_width;"height";20;"stroke";"black";"fill";$Txt_tableColor;"id";$Txt_fieldUID)
								$Dom_fieldRect:=DOM Create XML element:C865($Dom_tableGroup;"rect";"x";$Num_left;"y";$Num_top;"width";$Num_width;"height";20;"stroke";"none";"fill";"white";"fill-opacity";0.3)
								
								$Num_top:=$Num_top+15
								
								DOM GET XML ATTRIBUTE BY NAME:C728($tDom_fields{$Lon_j};"name";$Txt_fieldName)
								$Dom_fieldName:=DOM Create XML element:C865($Dom_tableGroup;"text";"x";$Num_left+8;"y";$Num_top;"fill";$Txt_fieldColor;"text-anchor";"start";"font-style";$Txt_fontStyle;"font-weight";$Txt_fontWeight)
								DOM SET XML ELEMENT VALUE:C868($Dom_fieldName;$Txt_fieldName)
								
								DOM GET XML ATTRIBUTE BY NAME:C728($tDom_fields{$Lon_j};"type";$Lon_type)
								$Dom_fieldType:=DOM Create XML element:C865($Dom_tableGroup;"text";"x";$Num_left+$Num_width-7;"y";$Num_top;"text-anchor";"end")
								DOM SET XML ELEMENT VALUE:C868($Dom_fieldType;$tTxt_types{$Lon_type})
								
								$Num_top:=$Num_top+5
								
							End for 
							
						End if 
						
					End for 
					
					$tDom_relations{0}:=DOM Find XML element:C864($Dom_root;"/base/relation";$tDom_relations)
					
					For ($Lon_i;1;Size of array:C274($tDom_relations);1)
						
						$tDom_relatedFields{0}:=DOM Find XML element:C864($tDom_relations{$Lon_i};"/relation/related_field";$tDom_relatedFields)
						
						If (Size of array:C274($tDom_relatedFields)>=2)
							
							For ($Lon_x;1;2;1)
								
								DOM GET XML ATTRIBUTE BY NAME:C728($tDom_relatedFields{$Lon_x};"kind";$Txt_kind)
								
								If ($Txt_kind="source")
									
									$Dom_source:=DOM Find XML element:C864($tDom_relatedFields{$Lon_x};"/related_field/field_ref")
									
								Else 
									
									$Dom_destination:=DOM Find XML element:C864($tDom_relatedFields{$Lon_x};"/related_field/field_ref")
									
								End if 
								
							End for 
							
							$Dom_table_ref:=DOM Find XML element:C864($Dom_source;"/field_ref/table_ref")
							DOM GET XML ATTRIBUTE BY NAME:C728($Dom_table_ref;"uuid";$Txt_tableUUID)
							$Dom_x:=DOM Find XML element by ID:C1010($Dom_svg;$Txt_tableUUID)
							
							If (OK=1)
								
								$Dom_table_ref:=DOM Find XML element:C864($Dom_destination;"/field_ref/table_ref")
								DOM GET XML ATTRIBUTE BY NAME:C728($Dom_table_ref;"uuid";$Txt_tableUUID)
								$Dom_x:=DOM Find XML element by ID:C1010($Dom_svg;$Txt_tableUUID)
								
								If (OK=1)
									
									DOM GET XML ATTRIBUTE BY NAME:C728($Dom_source;"uuid";$Txt_sourceUUID)
									DOM GET XML ATTRIBUTE BY NAME:C728($Dom_destination;"uuid";$Txt_destinationUUID)
									
									$Dom_source:=DOM Find XML element by ID:C1010($Dom_svg;$Txt_sourceUUID)
									$Dom_destination:=DOM Find XML element by ID:C1010($Dom_svg;$Txt_destinationUUID)
									
									DOM GET XML ATTRIBUTE BY NAME:C728($Dom_source;"x";$Num_sourceX)
									DOM GET XML ATTRIBUTE BY NAME:C728($Dom_source;"y";$Num_sourceY)
									DOM GET XML ATTRIBUTE BY NAME:C728($Dom_source;"width";$Num_sourceWidth)
									DOM GET XML ATTRIBUTE BY NAME:C728($Dom_source;"height";$Num_sourceHeight)
									
									DOM GET XML ATTRIBUTE BY NAME:C728($Dom_destination;"x";$Num_destinationX)
									DOM GET XML ATTRIBUTE BY NAME:C728($Dom_destination;"y";$Num_destinationY)
									DOM GET XML ATTRIBUTE BY NAME:C728($Dom_destination;"width";$Num_destinationWidth)
									DOM GET XML ATTRIBUTE BY NAME:C728($Dom_destination;"height";$Num_destinationHeight)
									
									$Dom_color:=DOM Find XML element:C864($tDom_relations{$Lon_i};"/relation/relation_extra/editor_relation_info/color")
									
									If (OK=1)
										
										DOM GET XML ATTRIBUTE BY NAME:C728($Dom_color;"red";$Txt_red)
										DOM GET XML ATTRIBUTE BY NAME:C728($Dom_color;"green";$Txt_green)
										DOM GET XML ATTRIBUTE BY NAME:C728($Dom_color;"blue";$Txt_blue)
										
										If ($Txt_red="255") & ($Txt_green="255") & ($Txt_blue="255")
											$Txt_color:="black"
										Else 
											$Txt_color:="rgb("+$Txt_red+","+$Txt_green+","+$Txt_blue+")"
										End if 
										
									End if 
									
									$Num_sourceMiddle:=($Num_sourceX+$Num_sourceWidth)/2
									$Num_destinationMiddle:=($Num_destinationX+$Num_destinationWidth)/2
									$Num_middleOffset:=$Num_destinationMiddle-$Num_sourceMiddle
									
									If ($Num_sourceX<$Num_destinationX)
										$Num_offsetX:=$Num_destinationX-$Num_sourceX
									Else 
										$Num_offsetX:=$Num_sourceX-$Num_destinationX
									End if 
									
									$Boo_regular:=(Abs:C99($Num_middleOffset)>80)
									
									If (($Num_destinationX-$Num_sourceX)>$Num_sourceWidth)
										
										If ($Boo_regular)
											
											$Num_X1:=$Num_sourceX+$Num_sourceWidth
											
										Else 
											
											$Num_X1:=$Num_sourceX
											
										End if 
										
										$Num_X2:=$Num_destinationX
										
									Else 
										
										$Num_X1:=$Num_sourceX
										
										If ($Boo_regular)
											
											$Num_X2:=$Num_destinationX+$Num_destinationWidth
											
										Else 
											
											$Num_X2:=$Num_destinationX
											
										End if 
										
									End if 
									
									$Num_y1:=$Num_sourceY+($Num_sourceHeight/2)
									$Num_y2:=$Num_destinationY+($Num_destinationHeight/2)
									
									If ($Boo_regular)
										
										$Num_middle:=($Num_X2-$Num_X1)/2
										$Num_viaPointX:=$Num_X1+$Num_middle
										
									Else 
										
										If ($Num_X2>($Num_X1+$Num_sourceWidth))
											
											$Num_viaPointX:=$Num_X2-Abs:C99($Num_middleOffset)-50
											
										Else 
											
											$Num_viaPointX:=$Num_X1-Abs:C99($Num_middleOffset)
											
										End if 
										
									End if 
									
									$Txt_data:=String:C10($Num_X1;"&xml")+","+String:C10($Num_y1;"&xml")+" "
									$Txt_data:=$Txt_data+String:C10($Num_viaPointX;"&xml")+","+String:C10($Num_y1;"&xml")+" "
									$Txt_data:=$Txt_data+String:C10($Num_viaPointX;"&xml")+","+String:C10($Num_y2;"&xml")+" "
									$Txt_data:=$Txt_data+String:C10($Num_X2;"&xml")+","+String:C10($Num_y2;"&xml")
									
									$Dom_relation:=DOM Create XML element:C865($Dom_svg;"polyline";"fill";"none";"stroke";$Txt_color;"stroke-width";3;"points";$Txt_data;"filter";"url(#Shadow)")
									DOM SET XML ATTRIBUTE:C866($Dom_relation;"marker-start";"url(#relation_N)";"marker-end";"url(#relation_1)";"stroke-linejoin";"round")
									
								End if 
							End if 
							
						End if 
						
					End for 
					
					DOM SET XML ATTRIBUTE:C866($Dom_svg;"width";$Lon_maxWidth+10;"height";$Lon_maxHeight+10)
					
					$Txt_path:=Replace string:C233($Txt_path;".xml";$Txt_pictureFormat)
					
					If ($Txt_pictureFormat=".svg")
						
						DOM EXPORT TO FILE:C862($Dom_svg;$Txt_path)
						
					Else 
						
						SVG EXPORT TO PICTURE:C1017($Dom_svg;$Pic_buffer)
						CONVERT PICTURE:C1002($Pic_buffer;$Txt_pictureFormat)
						WRITE PICTURE FILE:C680($Txt_path;$Pic_buffer;$Txt_pictureFormat)
						
					End if 
					
					OPEN URL:C673($Txt_path)
					
					DOM CLOSE XML:C722($Dom_svg)
					
				End if 
				
				DOM CLOSE XML:C722($Dom_root)
				
			Else 
				
				TRACE:C157
				
			End if 
			
		Else 
			
			TRACE:C157
			
		End if 
		
	Else 
		
		TRACE:C157
		
	End if 
	
Else 
	
	TRACE:C157
	
End if 