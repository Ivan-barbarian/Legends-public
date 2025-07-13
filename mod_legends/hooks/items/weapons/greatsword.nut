::mods_hookExactClass("items/weapons/greatsword", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Name = "Zweihander";
		this.m.Description = "A massive two-handed blade as good for carving swathes through the enemy as for battering them into submission."; //Let's get this working
		this.m.Variant = this.Math.rand(0, 2);
		this.updateVariant();
	}

	o.updateVariant <- function() {
		if (this.m.Variant == 0) {
			return;
		}
		this.m.Icon = "weapons/melee/sword_two_hand_02_" + this.m.Variant + "_70x70.png";
		this.m.IconLarge = "weapons/melee/sword_two_hand_02_" + this.m.Variant + ".png";
		this.m.ArmamentIcon = "icon_sword_two_handed_02_" + this.m.Variant;
	}

});
