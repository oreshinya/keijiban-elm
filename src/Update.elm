module Update exposing (..)

import Model exposing (..)
import Route exposing (..)
import Msg exposing (..)
import Api exposing (..)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    UrlChange location ->
      let
        route = parseRoute location
      in
        ({ model | history = route :: model.history }
        , urlChangeCmd route
        )
    TopicsFromRemote (Ok topics) ->
      ({ model | topics = topics, getTopicsError = Nothing }
      , Cmd.none
      )
    TopicsFromRemote (Err _) ->
      ({ model | getTopicsError = Just "Failed to get topics."}
      , Cmd.none
      )
    CommentsFromRemote (Ok comments) ->
      ({ model | comments = comments, getCommentsError = Nothing }
      , Cmd.none
      )
    CommentsFromRemote (Err _) ->
      ({ model | getCommentsError = Just "Failed to get comments."}
      , Cmd.none
      )

urlChangeCmd : Maybe Route -> Cmd Msg
urlChangeCmd route =
  case route of
    Just (ShowTopic topicId) -> getComments topicId
    _ -> Cmd.none
