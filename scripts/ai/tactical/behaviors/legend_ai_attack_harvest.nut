this.legend_ai_attack_harvest <- this.inherit("scripts/ai/tactical/behaviors/ai_attack_swing", {
	m = {
		PossibleSkills = [
			::Legends.Actives.getID(::Legends.Active.LegendHarvest),
		]
	},

	function create() {
		this.m.ID = this.Const.AI.Behavior.ID.Harvest;
        this.m.Order = this.Const.AI.Behavior.Order.Swing;
        this.behavior.create();
	}

	function getBestTarget(_entity, _skill, _targets) {
		local ourTile = _entity.getTile();
		local bestTarget;
		local bestScore = 0.0;
		local bestCombinedValue = 0.0;

		foreach (target in _targets) {
			if (_skill.onVerifyTarget(_entity.getTile(), target.getTile())) {
				local score = 1.0;
				local combinedValue = this.queryTargetValue(_entity, target, _skill);
				local dir = ourTile.getDirectionTo(target.getTile());
				local dir_left = dir - 1 >= 0 ? dir - 1 : this.Const.Direction.COUNT - 1;

				if (ourTile.hasNextTile(dir_left)) {
					local tile = ourTile.getNextTile(dir_left);

					if (this.Math.abs(tile.Level - ourTile.Level) <= 1 && tile.IsOccupiedByActor) {
						if (tile.getEntity().isAlliedWith(_entity)) {
							combinedValue = combinedValue - (1.0 - this.getProperties().TargetPriorityHittingAlliesMult) * tile.getEntity().getCurrentProperties().TargetAttractionMult;
						} else {
							combinedValue = combinedValue + this.queryTargetValue(_entity, tile.getEntity(), _skill);
							score = score + 1.0;
						}
					}
				}

				if (score < this.m.MinTargets) {
					continue;
				}

				if (score > bestScore || score == bestScore && combinedValue > bestCombinedValue) {
					bestTarget = target;
					bestCombinedValue = combinedValue;
					bestScore = score;
				}
			}
		}

		local score = this.Math.maxf(0.0, bestCombinedValue / 2.0);
		return {
			Target = bestTarget,
			Score = score
		};
	}
});
