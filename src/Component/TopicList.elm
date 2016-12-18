module Component.TopicList exposing (view)

import Html exposing (Html, div, h1, ul, li, span, text)
import Msg exposing (..)
import Model exposing (..)

view : Model -> Html Msg
view model = div []
  [ h1 [] [ text "TopicList" ]
  , ul [] <| List.map topicView model.topics
  , errorView model.getTopicsError
  ]

topicView : Topic -> Html Msg
topicView t = li [] [ text t.name ]

errorView : Maybe String -> Html Msg
errorView a =
  case a of
    Just txt -> span [] [ text txt ]
    Nothing -> span [] []
