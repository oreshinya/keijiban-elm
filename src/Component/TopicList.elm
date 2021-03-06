module Component.TopicList exposing (view)

import Html exposing (Html, form, input, div, h1, ul, li, a, button, text)
import Html.Attributes exposing (href, value)
import Html.Events exposing (onSubmit, onInput)
import Msg exposing (..)
import Model exposing (..)

view : Model -> Html Msg
view model = div []
  [ h1 [] [ text "TopicList" ]
  , form [ onSubmit PostTopic ]
    [ input [ value model.topicName, onInput TopicNameChange ] []
    , errorView model.postTopicError
    , button [] [ text "Create" ]
    ]
  , ul [] <| List.map topicView model.topics
  , errorView model.getTopicsError
  ]

topicView : Topic -> Html Msg
topicView t = li [] [ a [ href <| String.concat ["#topics/", toString t.id] ] [ text t.name ] ]

errorView : Maybe String -> Html Msg
errorView a =
  case a of
    Just txt -> div [] [ text txt ]
    Nothing -> div [] []
