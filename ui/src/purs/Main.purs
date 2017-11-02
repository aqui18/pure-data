module Main where

import Prelude
import Control.Monad.Eff.Console (CONSOLE)
import Control.Monad.Eff (Eff)

import Internal.App as A
import Internal.App (APP)

main :: forall e. Eff (app :: APP, app :: APP, console :: CONSOLE | e) Unit
main = do
  app <- A.app

  A.listen app A.Ready (\_ -> do _ <- A.createWindow "index.html" 800 600
                                 pure unit)

