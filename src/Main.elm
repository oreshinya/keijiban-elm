import Html exposing (Html)
import Navigation

import Model exposing (..)
import Update exposing (..)
import Route exposing (..)
import Msg exposing (..)
import Api exposing (..)
import Component.NotFound as NotFound
import Component.TopicList as TopicList
import Component.TopicDetail as TopicDetail

-- View
view : Model -> Html Msg
view model =
  case (first model.history) of
    Just IndexTopic -> TopicList.view model
    Just (ShowTopic id) -> TopicDetail.view id model
    Nothing -> NotFound.view

init : Navigation.Location -> (Model, Cmd Msg)
init location =
  (initialModel location
  , Cmd.batch
    [ getTopics
    , urlChangeCmd <| parseRoute location
    ]
  )

main = Navigation.program UrlChange
  { init = init
  , view = view
  , update = update
  , subscriptions = (\_ -> Sub.none)
  }
