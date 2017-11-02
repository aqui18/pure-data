module Index where

import Prelude
import Control.Monad.Eff.Console (CONSOLE, log)
import Control.Monad.Eff (Eff)
import Halogen.Aff as HA
import Halogen.VDom.Driver (runUI)
import Component.Button as B


main :: Eff (HA.HalogenEffects ()) Unit
main = HA.runHalogenAff do
  body <- HA.awaitBody
  runUI B.myButton unit body



