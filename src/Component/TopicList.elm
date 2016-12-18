module Component.TopicList exposing (view)

import Html exposing (Html, div, h1, text)
import Msg exposing (..)

view : Html Msg
view = div [] [ h1 [] [ text "TopicList" ] ]
