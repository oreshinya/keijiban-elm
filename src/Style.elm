module Style exposing (..)

import Css exposing (..)
import Css.Namespace exposing (namespace)

type CssClass = Link

styles = (stylesheet << namespace "keijiban-elm")
  [ (.) Link
    [ textDecoration none
    , hover [ textDecoration underline ]
    ]
  ]
