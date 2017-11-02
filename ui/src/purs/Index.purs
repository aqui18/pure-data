module Index where

import Prelude
import Control.Monad.Eff.Console (CONSOLE, log)
import Control.Monad.Eff (Eff)

ui :: forall e. Eff (console :: CONSOLE | e) Unit
ui = log "hello"
