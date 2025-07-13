::mods_hookExactClass("items/weapons/warbrand", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Value = 1700;
		this.m.Variant = this.Math.rand(0, 2);
		this.updateVariant();
	}

	o.updateVariant <- function() {
		if (this.m.Variant == 0) {
			return;
		}
		this.m.Icon = "weapons/melee/warbrand_01_" + this.m.Variant + "_70x70.png";
		this.m.IconLarge = "weapons/melee/warbrand_01_" + this.m.Variant + ".png";
		this.m.ArmamentIcon = "icon_scythe_01_" + this.m.Variant;
	}

	o.addSkill <- function( _skill )
	{
		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.Slash))
			_skill.m.IsGreatSlash = true;

		this.weapon.addSkill(_skill);
	}
});
