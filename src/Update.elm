module Update exposing (..)

import Model exposing (..)
import Route exposing (..)
import Msg exposing (..)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    UrlChange location ->
      ({ model | history = parseRoute location :: model.history }
      , Cmd.none
      )
    TopicsFromRemote (Ok topics) ->
      ({ model | topics = topics, getTopicsError = Nothing }
      , Cmd.none
      )
    TopicsFromRemote (Err _) ->
      ({ model | getTopicsError = Just "Failed to get topics."}
      , Cmd.none
      )
