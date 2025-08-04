::mods_hookExactClass("skills/actives/web_skill", function(o)
{
	o.m.IsRestrained <- false;
	o.m.IsSpent <- false;

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Send a web of silk out to ensnare an opponent, rooting them in place halving their damage, defenses and initiative. Does no damage.";
	}

	o.getTooltip <- function ()
	{
		local tooltip = [
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
			}
		];
		if (this.m.Cooldown != 0)
		{
			tooltip.extend([
				{
					id = 6,
					type = "text",
					text = "Has " + this.m.Cooldown + " turns left."
				}
			]);
		}
		return tooltip;
	}

	local isUsable = o.isUsable;
	o.isUsable = function ()
	{
		return isUsable() && !this.m.IsSpent;
	}

	local onUse = o.onUse;
	o.onUse <- function( _user, _targetTile )
	{
		if (this.m.IsRestrained)
		{
			this.m.IsSpent = true;
			local skill = ::Legends.Actives.get(this, ::Legends.Active.SpiderBite);
			skill.setSpent(true);
		}
		return onUse(_user, _targetTile);
	}

	o.onTurnStart <- function()
	{
		this.m.IsSpent = false;
	}

	o.setRestrained <- function( _f )
	{
		this.m.IsRestrained = _f;
	}

	o.setSpent <- function( _f )
	{
		this.m.IsSpent = _f;
	}
});
