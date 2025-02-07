local PANEL = {}

function PANEL:Init()

	//self:ShowCloseButton( false )
	self:SetKeyboardInputEnabled( false )
	//self:SetDraggable( true ) 
	self.FuncList = {}
	
	self.Stashable = false
	self.StashStyle = "Take"
	self.PriceScale = 1
	
end

function PANEL:SetPriceScale( scale )

	self.PriceScale = scale

end

function PANEL:SetStashable( bool, style )

	self.Stashable = bool
	self.StashStyle = style

end

function PANEL:Think()

end

function PANEL:OnMousePressed()

    self:MouseCapture( true )
	
	if ( self.NextClick or 0 ) > CurTime() then
		
		if self.StashStyle == "Buy" then
			
			if LocalPlayer():GetNWInt( "Cash", 0 ) >= self.ItemTable.Price then
			
				RunConsoleCommand( "inv_buy", self.ID, 1 )
				GAMEMODE:AddToCart( self.ItemTable, 1 )
				//SaleScreen:AddItems( self.ID, 1 )
				
			end
			
		end
		
	else
		
		GAMEMODE:SetItemToPreview( self.ID, self.StashStyle, self.PriceScale, self:GetCount() )
		
		self.NextClick = CurTime() + 0.3
	
	end
	
end

function PANEL:OnMouseReleased( mc )

	self.Dragging = nil
	self:MouseCapture( false )
	
	if mc != MOUSE_RIGHT then return end

	self:MouseMenu()

end

function PANEL:MouseMenu()

	local menu = vgui.Create( "DMenu", self )
	menu:AddOption( translate.Get( "rd_ui_shop_cancel" ) )
	
	if self.Stashable then
	
		if self.StashStyle == "Take" then
		
			menu:AddOption( translate.Get( "rd_ui_shop_take" ), function() RunConsoleCommand( "inv_take", self.ID, 1 ) end )
			
			if self:GetCount() > 1 then
			
				if self:GetCount() > 3 then
			
					local submenu = menu:AddSubMenu( translate.Get( "rd_ui_shop_take_multiple" ) )
				
					for k,v in pairs{ 3, 5, 10, 20 } do
			
						if self:GetCount() > v then
					
							submenu:AddOption( translate.Format( "rd_ui_shop_take_x", v ), function() RunConsoleCommand( "inv_take", self.ID, v ) end )
					
						end
				
					end
				
				end
			
				menu:AddOption( translate.Get( "rd_ui_shop_take_all" ), function() RunConsoleCommand( "inv_take", self.ID, self:GetCount() ) end )
				
			end
			
			menu:Open()
			return
			
		elseif self.StashStyle == "Buy" then
		
			menu:AddOption( translate.Get( "rd_ui_shop_buy" ), function() if LocalPlayer():GetNWInt( "Cash", 0 ) >= self.ItemTable.Price then
			
				RunConsoleCommand( "inv_buy", self.ID, 1 )
				GAMEMODE:AddToCart( self.ItemTable, 1 )
				//SaleScreen:AddItems( self.ID, 1 )
				
			end end )
			
			local submenu = menu:AddSubMenu( translate.Get( "rd_ui_shop_buy_multiple" ) )
				
			for k,v in pairs{ 3, 5, 10, 20 } do
				
				submenu:AddOption( translate.Format( "rd_ui_shop_context_buy_x", v ), function() if LocalPlayer():GetNWInt( "Cash", 0 ) >= self.ItemTable.Price * v then
			
					RunConsoleCommand( "inv_buy", self.ID, v )
					GAMEMODE:AddToCart( self.ItemTable, v )
					//SaleScreen:AddItems( self.ID, 1 )
				
				end end )
				
			end
			
			menu:Open()
			return
		
		elseif self.StashStyle == "Sell" then
		
			if !self.NotSellable then
		
				menu:AddOption( translate.Get( "rd_ui_shop_sell" ), function() RunConsoleCommand( "inv_sell", self.ID, 1 ) end )
				
				if self:GetCount() > 1 then
				
					if self:GetCount() > 3 then
				
						local submenu = menu:AddSubMenu( translate.Get( "rd_ui_shop_sell_multiple" ) )
				
						for k,v in pairs{ 3, 5, 10, 20 } do
					
							if self:GetCount() > v then
					
								submenu:AddOption( translate.Format( "rd_ui_shop_sell_x", v ), function() RunConsoleCommand( "inv_sell", self.ID, v ) end )
					
							end
				
						end
					
					end
				
					menu:AddOption( translate.Get( "rd_ui_shop_sell_all" ), function() RunConsoleCommand( "inv_sell", self.ID, self:GetCount() ) end )
					
				end
				
			end
		
		else
		
			menu:AddOption( translate.Get( "rd_ui_shop_stash" ), function() RunConsoleCommand( "inv_store", self.ID, 1 ) end )		
			
			if self:GetCount() > 1 then
			
				if self:GetCount() > 3 then
			
					local submenu = menu:AddSubMenu( translate.Get( "rd_ui_shop_stash_multiple" ) )
				
					for k,v in pairs{ 3, 5, 10, 20 } do
				
						if self:GetCount() > v then
					
							submenu:AddOption( translate.Format( "rd_ui_shop_stash_x", v ), function() RunConsoleCommand( "inv_store", self.ID, v ) end )
					
						end
				
					end
			
				end
			
				menu:AddOption( translate.Get( "rd_ui_shop_stash_all" ), function() RunConsoleCommand( "inv_store", self.ID, self:GetCount() ) end )
				
			end
		
		end
	
	end
	
	if not self.IsWeapon then
	
		menu:AddOption( translate.Get( "rd_ui_shop_drop" ), function() RunConsoleCommand( "inv_drop", self.ID, 1 ) end )
		
	end
	
	if self:GetCount() > 1 and not self.IsWeapon then
	
		if self:GetCount() > 3 then
	
			local submenu = menu:AddSubMenu( translate.Get( "rd_ui_shop_drop_multiple" ) )
				
			for k,v in pairs{ 3, 5, 10, 20 } do
				
				if self:GetCount() > v then
					
					submenu:AddOption( translate.Format( "rd_ui_shop_drop_x", v ), function() RunConsoleCommand( "inv_drop", self.ID, v ) end )
					
				end
				
			end
		
		end
	
		menu:AddOption( translate.Get( "rd_ui_shop_drop_all" ), function() RunConsoleCommand( "inv_drop", self.ID, self:GetCount() ) end )
		
	end
	
	for k,v in pairs( self.FuncList ) do
	
		menu:AddOption( v( 0, 0, true ), function() RunConsoleCommand( "inv_action", self.ID, k ) end )
		
	end
	
	menu:Open()

end

function PANEL:SetCount( num )

	self.ItemCount = num
	
	if num > 1 then
	
		self:SetTitle( tostring( num ) )
		
	else
	
		self:SetTitle( "" )
	
	end

end

function PANEL:GetCount()

	return self.ItemCount or 0
	
end

function PANEL:AddCount( num )

	self:SetCount( self:GetCount() + num )

end

function PANEL:GetID()

	return self.ID or 0
	
end

function PANEL:IsStackable()

	return self.Stackable

end

function PANEL:SetItemTable( tbl )

	self:SetModel( tbl.Model, tbl.CamPos, tbl.CamOrigin )
	self.FuncList = tbl.Functions
	self.ID = tbl.ID
	self.IsWeapon = tbl.Weapon
	self.Stackable = tbl.Stackable
	self.PanelModel = tbl.Model
	self.ItemTable = tbl
	self.ItemTable.Price = tbl.Price or 0
	
	if tbl.Sellable != nil and tbl.Sellable == false then
	
		self.NotSellable = true
		
	end

end

function PANEL:SetModel( model, campos, origin )

	self.ModelPanel = vgui.Create( "GoodModelPanel", self )
	self.ModelPanel:SetModel( model )
	self.ModelPanel.LayoutEntity = function( ent ) end
	self.ModelPanel:SetCamPos( Vector(20,10,5) )
	self.ModelPanel:SetLookAt( Vector(0,0,0) )
	self.ModelPanel.OnMousePressed = function( mc ) self:OnMousePressed( mc ) end
	self.ModelPanel.OnMouseReleased = function( mc ) self:OnMouseReleased( mc ) end
	
	if CamPosOverride then
	
		campos = CamPosOverride
	
	end
	
	if CamOrigOverride then
	
		origin = CamOrigOverride
	
	end
	
	if campos then
	
		self.ModelPanel:SetCamPos( campos )
		self.ModelPos = campos
		
	end
	
	if origin then
	
		self.ModelPanel:SetLookAt( origin )
		self.ModelOrigin = origin
		
	end

end

function PANEL:SetSizeOverride( size )

	self.SizeOverride = size

end

function PANEL:PerformLayout()
	
	if self.ModelPanel then
	
		self.ModelPanel:SetPos( self:GetPadding(), self:GetPadding() )
		
		if self.SizeOverride then
		
			self.ModelPanel:SetSize( self.SizeOverride - 2, self.SizeOverride - 2 )
	
		else
		
			self.ModelPanel:SetSize( 62, 62 )
		
		end
	
	end

	self:SizeToContents()
	
	if self.SizeOverride then
	
		self:SetSize( self.SizeOverride, self.SizeOverride )
	
	else
	
		self:SetSize( 64, 64 )
		
	end
	
end

function PANEL:Paint()

	if ( self.ItemCount or 1 ) > 1 then

		draw.SimpleText( self.ItemCount, "ItemDisplayFont", self:GetWide() / 8, self:GetTall() / 8, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

	end

	//if self.SizeOverride then
	
	draw.RoundedBox( 0, 3, 3, self:GetWide() - 6, self:GetTall() - 6, Color( 80, 80, 80, 50 ) )
	
	if self.StashStyle == "Buy" then
	
		if LocalPlayer():GetNWInt( "Cash", 0 ) >= self.ItemTable.Price then
		
			surface.SetDrawColor( 100, 200, 100, 200 )
		
		else
		
			surface.SetDrawColor( 200, 100, 100, 200 )
		
		end
	
	else
	
		surface.SetDrawColor( 200, 200, 200, 200 )
	
	end
	
	
	surface.DrawOutlinedRect( 3, 3, self:GetWide() - 6, self:GetTall() - 6 )


end

derma.DefineControl( "ItemPanel", "A HUD Element with a model in the middle", PANEL, "PanelBase" )
