import Lake
open Lake DSL

-- Replace «ProjectName» with your project name (must match directory name)
-- and update the package name accordingly
package «ProjectName» where
  -- Disable auto-implicit to enforce explicit type annotations everywhere
  moreServerArgs := #["-DautoImplicit=false"]

-- Uncomment to add an external dependency:
-- require somedep from git
--   "https://github.com/user/repo" @ "main"

@[default_target]
lean_lib «ProjectName» where
  -- globs := #[.submodules `ProjectName]
  -- ↑ Uncomment to auto-discover all .lean files in ProjectName/
  --   (Lake will compile them without listing in the root file)
  --   Leave commented to use explicit imports in ProjectName.lean
