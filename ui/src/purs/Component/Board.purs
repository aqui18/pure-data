module Component.Board where

import Prelude

import DOM.SVG.Attributes (height, viewBox, width, Color (RGB), fill)
import DOM.SVG.Elements (svg, rect)
import Data.Maybe (Maybe(..))
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Events as HE
import Halogen.HTML.Properties as HP


data Cursor = Cursor 
  { x :: Int
  , y :: Int
  }

type State = Cursor

data Query a
  = MoveCursor Int Int a
  
component :: forall m. H.Component HH.HTML Query Unit Void m
component =
  H.component
    { initialState: const initialState
    , render
    , eval
    , receiver: const Nothing
    }
    where
          initialState :: State
          initialState = Cursor { x:0, y:0 }

          render :: State -> H.ComponentHTML Query
          render state = svg [viewBox 0.0 0.0 120.0 120.0] [
            rect [width 10.0, height 20.0, fill (Just (RGB 255 0 0))] []
          ]
 
          eval :: Query ~> H.ComponentDSL State Query Void m
          eval = case _ of 
                      MoveCursor x y next -> do
                         pure next

