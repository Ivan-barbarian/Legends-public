::mods_hookExactClass("ai/tactical/agents/kraken_tentacle_agent", function (o) {
	o.m.UpdateAllies <- true;
	o.m.LastTile <- 0;

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.IsUpdatingAlliesBeforeEvaluation = false;
	}
	
	o.onTurnStarted <- function () {
		this.agent.onTurnStarted();
		this.m.UpdateAllies = true;
		this.m.LastTile = this.m.Actor.getTile().ID;
	}

	o.onTurnResumed <- function () {
		this.agent.onTurnResumed();
		this.m.UpdateAllies = true;
		this.m.LastTile = this.m.Actor.getTile().ID;
	}


	o.think <- function (_evaluateOnly = false) {
		if (this.m.Actor.isPlacedOnMap()) {
            local currentTileID = this.m.Actor.getTile().ID;
            if (currentTileID != this.m.LastTile) {
                this.m.UpdateAllies = true;
                this.m.LastTile = currentTileID;
            }
        }

		if (this.m.IsEvaluating && this.m.NextEvaluationTime <= this.Time.getVirtualTime()) {
			if (this.m.UpdateAllies || this.m.KnownAllies.len() == 0) {
				this.compileKnownAllies();
				this.m.UpdateAllies = false;
			}
		}
		this.agent.think(_evaluateOnly);
	}
});