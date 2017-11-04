module DOM.SVG.Elements 
  ( svg
  , rect
  )
  where

import DOM.SVG.Indexed as I
import Halogen.HTML.Core (ElemName(ElemName), HTML, Namespace(Namespace))
import Halogen.HTML.Elements (elementNS, Node)
import Halogen.HTML.Properties (IProp)

ns :: String
ns = "http://www.w3.org/2000/svg"

element :: forall r p i. ElemName -> Array (IProp r i) -> Array (HTML p i) -> HTML p i
element = elementNS (Namespace ns)

svg :: forall p i. Node I.SVG p i
svg = element (ElemName "svg")

rect :: forall p i. Node I.Rect p i
rect = element (ElemName "rect")
