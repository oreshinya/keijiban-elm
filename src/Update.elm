module Update exposing (..)

import Http

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
    TopicNameChange name ->
      ({ model | topicName = name }, Cmd.none)
    PostTopic ->
      ({ model | postTopicError = Nothing }, postTopic model.topicName)
    PostTopicResult (Ok topic) ->
      ({ model | topics = topic :: model.topics, topicName = "" }
      , Cmd.none
      )
    PostTopicResult (Err e) ->
      case e of
        Http.BadStatus { body } ->
          ({ model | postTopicError = Just body }, Cmd.none)
        _ ->
          (model, Cmd.none)
    CommentBodyChange body ->
      ({ model | commentBody = body }, Cmd.none)
    PostComment topicId ->
      ({ model | postCommentError = Nothing }, postComment topicId model.commentBody)
    PostCommentResult (Ok comment) ->
      ({ model | comments = model.comments ++ [ comment ], commentBody = "" }, Cmd.none)
    PostCommentResult (Err e) ->
      case e of
        Http.BadStatus { body } ->
          ({ model | postCommentError = Just body }, Cmd.none)
        _ ->
          (model, Cmd.none)

urlChangeCmd : Maybe Route -> Cmd Msg
urlChangeCmd route =
  case route of
    Just (ShowTopic topicId) -> getComments topicId
    _ -> Cmd.none
