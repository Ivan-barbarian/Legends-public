::mods_hookExactClass("items/weapons/oriental/qatal_dagger", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Value = 750;
		this.m.Variant = this.Math.rand(0, 2);
		this.updateVariant();
	}

	o.updateVariant <- function() {
		if (this.m.Variant == 0) {
			return;
		}
		this.m.Icon = "weapons/melee/qatal_dagger_01_" + this.m.Variant + "_70x70.png";
		this.m.IconLarge = "weapons/melee/qatal_dagger_01_" + this.m.Variant + ".png";
		this.m.ArmamentIcon = "icon_qatal_dagger_01_" + this.m.Variant;
	}

	o.addSkill <- function( _skill )
	{
		if (_skill.getID() == "actives.deathblow")
		{
			_skill = ::new("scripts/skills/actives/deathblow_skill"); // replace strike with scythe cleave
			_skill.m.DeathblowBonus = true;
		}

		weapon.addSkill(_skill);
	}
});
