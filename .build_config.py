# Local build configuration
# If you want to make changes to the config without generating a diff, run:
#   git update-index --skip-worktree .build_config.py

# Repository directory name (if different from 'Legends-public')
REPO_DIR = "Legends-public"

# Battle Brothers data directory (set to None for auto-detection).
# Auto-detection will look in the following locations:
# Windows: "c:\Steam\steamapps\common\Battle Brothers\data"
# Others: "~/.local/share/Steam/steamapps/common/Battle Brothers/data"
BB_DIR = None

# Build output directory
BUILD_DIR = "./build"
