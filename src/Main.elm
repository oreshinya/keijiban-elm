import Html exposing (Html)
import Navigation

import Route exposing (..)
import Msg exposing (..)
import Component.NotFound as NotFound
import Component.TopicList as TopicList
import Component.TopicDetail as TopicDetail

-- Model
type alias Model = { history : List (Maybe Route) }

initialModel : Navigation.Location -> Model
initialModel location = { history = [ parseRoute location ] }

first : List (Maybe Route) -> Maybe Route
first history =
  case history of
    route::_ -> route
    [] -> Nothing

-- Update
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    UrlChange location ->
      ({ model | history = parseRoute location :: model.history }, Cmd.none)

-- View
view : Model -> Html Msg
view model =
  case (first model.history) of
    Just IndexTopic -> TopicList.view
    Just (ShowTopic id) -> TopicDetail.view
    Nothing -> NotFound.view

-- Initializer
init : Navigation.Location -> (Model, Cmd Msg)
init location = (initialModel location, Cmd.none)

main = Navigation.program UrlChange
  { init = init
  , view = view
  , update = update
  , subscriptions = (\_ -> Sub.none)
  }
