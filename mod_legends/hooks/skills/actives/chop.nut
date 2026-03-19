::mods_hookExactClass("skills/actives/chop", function(o)
{
	o.m.IsHack <- false;
	o.m.ApplicableSkills <- [
		::Legends.Effect.LegendGrappled,
		::Legends.Effect.LegendTackled,
		::Legends.Effect.Stunned,
	];

	o.setItem <- function (_item) {
		if (this.m.IsHack) {
			this.m.Name = "Hack";
			this.m.Description = "A powerful hacking attack that bears full force on any target.";
			this.m.KilledString = "Hacked up";
			this.m.ActionPointCost = 15;
			this.m.DirectDamageMult = 0.4;
			this.m.ChanceDecapitate = 50;
			this.m.ChanceDisembowel = 50;
		}
		this.skill.setItem(_item);
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function () {
		local tooltip = getTooltip();
		if (this.m.IsHack) {
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/chance_to_hit_head.png",
				text = "[color=%positive%]+25%[/color] Chance To Hit Head"
			});
		}
		return tooltip;
	}

	local onAnySkillUsed = o.onAnySkillUsed;
	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties ) {
		if (_skill == this && this.m.IsHack)
			_properties.HitChance[this.Const.BodyPart.Head] += 25;
		onAnySkillUsed( _skill, _targetEntity, _properties );
	}
});
