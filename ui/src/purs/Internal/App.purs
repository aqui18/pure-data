module Internal.App 
  ( createWindow
  , app
  , APP
  , App
  , Window
  , listen
  , class Listener
  , WindowEvent (..)
  , AppEvent (..)
  ) where

import Prelude

import Control.Monad.Eff (Eff, kind Effect)
import Data.Function.Uncurried (Fn3, runFn3)

foreign import data APP :: Effect
foreign import data App :: Type
foreign import data Window :: Type

data WindowEvent 
  = Closed 

data AppEvent 
  = Ready
  | WindowAllClosed
  | Activate

class Listener a b where 
  listen :: forall eff. a -> b -> (Unit -> Eff eff Unit) -> Eff (app :: APP | eff) Unit

instance listenApp :: Listener App AppEvent where
  listen a Ready fn = runFn3 foreign_listen a "ready" fn
  listen a WindowAllClosed fn = runFn3 foreign_listen a "window-all-closed" fn
  listen a Activate fn = runFn3 foreign_listen a "activate" fn

instance listenWindow :: Listener Window WindowEvent where
  listen w Closed fn = runFn3 foreign_listen w "closed" fn

foreign import foreign_createWindow :: forall eff. Fn3 String Int Int (Eff (app :: APP | eff) Window)
foreign import foreign_listen :: forall a eff. Fn3 a String (Unit -> Eff eff Unit)  (Eff (app :: APP | eff) Unit)
foreign import foreign_app :: forall eff. Eff (app :: APP | eff) App

app :: forall eff. Eff (app :: APP | eff) App
app = foreign_app

createWindow :: forall eff. String -> Int -> Int -> Eff (app :: APP | eff) Window
createWindow file width height = runFn3 foreign_createWindow file width height

