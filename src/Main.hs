-- | Haskell language pragma
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

-- | Haskell module declaration
module Main where

-- | Miso framework import
import Miso
import Miso.String

import qualified Friendly as F

-- | Type synonym for an application model
data Model = M
  { width  :: Int
  , string :: String
  }
  deriving (Eq, Show)

-- | Sum type for application events
data Action
  = NoOp
  | InputChanged MisoString
  deriving (Show, Eq)

-- | Entry point for a miso application
main :: IO ()
main = startApp App {..}
  where
    initialAction = NoOp -- initial action to be executed on application load
    model  = M 90 ""              -- initial model
    update = updateModel          -- update function
    view   = viewModel            -- view function
    events = defaultEvents        -- default delegated events
    subs   = []                   -- empty subscription list
    mountPoint = Nothing          -- mount point for application (Nothing defaults to 'body')
    logLevel = Off                -- used during prerendering to see if the VDOM and DOM are in sync (only used with `miso` function)

formatStr = F.semiJson opts . fromMisoString
  where
    opts = F.Options 80

-- | Updates model, optionally introduces side effects
updateModel :: Action -> Model -> Effect Action Model
updateModel NoOp m = noEff m
updateModel (InputChanged s) m = noEff ( m { string = formatStr s } )

-- | Constructs a virtual DOM from a model
viewModel :: Model -> View Action
viewModel m = div_ [] [
   h1_ [] [ "Paste something" ]
 , div_ [] [ p_ [] [ "Formatted by "
                   , a_ [ href_ "https://github.com/edsko/friendly" ] [ "friendly" ]
                   , " "
                   , small_ [] [ a_ [ href_ "https://github.com/silky/friendly-web"] [ "(source for this site)" ] ]
                   , "."
                   ] 
           ]
 , textarea_ [ onChange InputChanged , cols_ "100", rows_ "20" ] []
 , pre_ [] [ text . ms . string $ m ]
 ]
