module Component.Board where

import Prelude

import Debug.Trace
import Control.Monad.Aff (Aff)
import Control.Monad.Aff.AVar (AVAR)
import DOM.SVG.Attributes (height, viewBox, width, Color (RGB), fill)
import DOM.SVG.Elements (svg, rect)
import Data.Maybe (Maybe(..))
import DOM (DOM)
import DOM.Event.Types (EventType (..), Event) as E
import DOM.Event.EventTarget (addEventListener, eventListener) as E
import DOM.HTML.Window (document) as DOM
import DOM.Node.Types (documentToEventTarget) as DOM
import DOM.HTML (window) as DOM
import DOM.HTML.Types (htmlDocumentToDocument) as DOM
import Halogen.Query.EventSource as ES
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
  = Init a
  | HandleKey E.Event (H.SubscribeStatus -> a)

-- click and drag
-- zoom in and out

type Effects eff = (dom :: DOM, avar :: AVAR | eff)
type DSL eff = H.ComponentDSL State Query Void (Aff (Effects eff))
  
component :: forall eff. H.Component HH.HTML Query Unit Void (Aff (Effects eff))
component =
  H.lifecycleComponent
    { initialState: const initialState
    , render
    , eval
    , initializer: Just (H.action Init)
    , finalizer: Nothing
    , receiver: const Nothing
    }
    where
          initialState :: State
          initialState = Cursor { x:0, y:0 }

          render :: State -> H.ComponentHTML Query
          render state = svg [viewBox 0.0 0.0 120.0 120.0] [
            rect [width 10.0, height 20.0, fill (Just (RGB 255 0 0))] []
          ]
 
          eval :: Query ~> DSL eff
          eval (Init next) = do
             let t = E.EventType "keypress"
                 req = Just <<< H.request <<< HandleKey

             document <- H.liftEff $ DOM.window >>= DOM.document <#> DOM.htmlDocumentToDocument 
             H.subscribe $ ES.eventSource (\f -> E.addEventListener t (E.eventListener f) true (DOM.documentToEventTarget document)) req
             pure next

          eval (HandleKey e reply) = do
             traceAnyA e
             pure (reply H.Listening)

