::mods_hookExactClass("skills/actives/reload_handgonne_skill", function(o)
{
	local onAfterUpdate = o.onAfterUpdate;
	o.onAfterUpdate = function ( _properties )
	{
		onAfterUpdate(_properties);
		this.m.ActionPointCost = 9;
		if (_properties.IsSpecializedInCrossbows)
			this.m.ActionPointCost -= 3; 
	}
});
