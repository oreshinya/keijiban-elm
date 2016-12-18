module Component.TopicDetail exposing (view)

import Html exposing (Html, div, h1, ul, li, span, text)
import Msg exposing (..)
import Model exposing (..)
import List.Extra exposing (find)

view : Int -> Model -> Html Msg
view topicId model = div []
  [ h1 [] [ text <| topicTitle <| topic topicId model ]
  , ul [] <| List.map commentView model.comments
  , errorView model.getTopicsError
  ]

topic : Int -> Model -> Maybe Topic
topic topicId model = find (\t -> t.id == topicId) model.topics

topicTitle : Maybe Topic -> String
topicTitle m =
  case m of
    Just t -> t.name
    Nothing -> ""

commentView : Comment -> Html Msg
commentView c = li [] [ text c.body ]

errorView : Maybe String -> Html Msg
errorView a =
  case a of
    Just txt -> span [] [ text txt ]
    Nothing -> span [] []
