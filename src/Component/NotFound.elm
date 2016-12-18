module Component.NotFound exposing (view)

import Html exposing (Html, div, h1, a, text)
import Html.Attributes exposing (href)
import Msg exposing (..)

view : Html Msg
view = div []
  [ h1 [] [ text "404 Not Found" ]
  , a [ href "#" ] [ text "Back to top" ]
  ]
