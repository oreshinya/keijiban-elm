module Component.NotFound exposing (view)

import Html exposing (Html, div, h1, a, text)
import Html.Attributes exposing (href)
import Html.CssHelpers
import Style
import Msg exposing (..)

{ class } = Html.CssHelpers.withNamespace "keijiban-elm"

view : Html Msg
view = div []
  [ h1 [] [ text "404 Not Found" ]
  , a [ class [ Style.Link ], href "#" ] [ text "Back to top" ]
  ]
