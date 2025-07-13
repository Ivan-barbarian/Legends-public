::mods_hookExactClass("items/weapons/oriental/swordlance", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.WeaponType = this.Const.Items.WeaponType.Cleaver | this.Const.Items.WeaponType.Polearm;
		this.m.Value = 1700;
		this.m.Variant = this.Math.rand(0, 2);
		this.updateVariant();
	}

	o.updateVariant <- function() {
		if (this.m.Variant == 0) {
			return;
		}
		this.m.Icon = "weapons/melee/swordlance_01_" + this.m.Variant + "_70x70.png";
		this.m.IconLarge = "weapons/melee/swordlance_01_" + this.m.Variant + ".png";
		this.m.ArmamentIcon = "swordlance_01_" + this.m.Variant;
	}

	o.addSkill <- function( _skill )
	{
		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.Strike))
		{
			::Legends.Actives.grant(this.weapon, ::Legends.Active.LegendScytheCleave, function (_skill)
			{
				_skill = this.new("scripts/skills/actives/legend_scythe_cleave_skill"); // replace strike with scythe cleave
				_skill.m.Icon = "skills/active_200.png";
				_skill.m.IconDisabled = "skills/active_200_sw.png";
				_skill.m.Overlay = "active_200";
			}.bindenv(this));
			return;
		}

		weapon.addSkill(_skill);
	}
});
