::mods_hookExactClass("skills/actives/perfect_focus", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Icon = "skills/perfectfocus_square.png";
		this.m.IconDisabled = "skills/perfectfocus_square_bw.png";
		this.m.Overlay = "perfectfocus_active";
		this.m.Order = this.Const.SkillOrder.BeforeLast;
		this.m.ActionPointCost = 0;
		this.m.FatigueCost = 30;
	}

	o.getTooltip = function()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 3,
				type = "text",
				text = this.getCostString()
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Adds a stacking [color=%effect%]Perfect Focus[/color] which increases your Action Points by [color=%positive%]3[/color]"
			}
		];
		return ret;
	}

	o.isUsable = function () {
		return this.skill.isUsable();
	}

	o.onUse = function ( _user, _targetTile ) {
		::Legends.Effects.grant(this, ::Legends.Effect.LegendPerfectFocus);
	}
});
