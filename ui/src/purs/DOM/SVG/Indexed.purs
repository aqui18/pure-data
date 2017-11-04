module DOM.SVG.Indexed 
  ( SVG
  , Rect
  )
  where

import DOM.HTML.Indexed (Interactive)

type SVG = Interactive (viewBox :: String)
type Rect = Interactive 
  ( x :: Number
  , y :: Number
  , width :: Number
  , height :: Number
  , stroke :: String
  , fill :: String
  , transform :: String
  )

