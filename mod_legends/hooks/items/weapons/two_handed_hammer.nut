::mods_hookExactClass("items/weapons/two_handed_hammer", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Value = 3000;
		this.setVariant(this.Math.rand(0, 2));
	}

	o.addSkill <- function( _skill )
	{
		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.SplitShield))
		{
			::Legends.Actives.grant(this.weapon, ::Legends.Active.SplitShield, function (_skill)
			{
				_skill.setFatigueCost(_skill.getFatigueCostRaw() + 5);
				_skill.m.IsHammer = true;
			}.bindenv(this));
			return;
		}

		weapon.addSkill(_skill);
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/hammer_two_handed_01" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/hammer_two_handed_01" + v + ".png";
		this.m.ArmamentIcon = "icon_hammer_01" + v;
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendObliterate);
	}

});
