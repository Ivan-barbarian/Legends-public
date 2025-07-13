::mods_hookExactClass("items/weapons/longsword", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Name = "Greatsword";
		this.m.Description = "A long two-handed greatsword as good for crushing as for cutting, it has a good balance between the lighter longsword and heavier zweihander.";
		this.m.Value = 2300;
		this.m.ConditionMax = 64.0;
		this.m.ChanceToHitHead = 10;
		this.m.Variant = this.Math.rand(0, 1);
		this.updateVariant();
	}

	o.updateVariant <- function() {
		if (this.m.Variant == 0) {
			return;
		}
		this.m.Icon = "weapons/melee/sword_two_hand_01_" + this.m.Variant + "_70x70.png";
		this.m.IconLarge = "weapons/melee/sword_two_hand_01_" + this.m.Variant + ".png";
		this.m.ArmamentIcon = "icon_sword_two_handed_01_" + this.m.Variant;
	}

});
