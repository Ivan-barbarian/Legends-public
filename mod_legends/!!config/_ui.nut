if (!("bold" in ::Const.UI)) {
	::Const.UI.bold <- function(_text) {
		return "[b]" + _text + "[/b]";
	};
}
